<#
.SYNOPSIS
  Builds the Denta Windows release and packs it into an installer, in one go.

.DESCRIPTION
  1. flutter pub get + flutter build windows --release, with the project's FVM
     Flutter (.fvmrc) - never the `flutter` on PATH, which on this machine is
     an old 3.13 that cannot build the project.
  2. Copies the Visual C++ runtime DLLs next to the app, so it starts on a
     laptop that has never had them installed.
  3. Signs the app and the installer, when a code-signing certificate is
     given (see -CertPath / -CertThumbprint). Without one it skips signing.
  4. Compiles installer\denta.iss with Inno Setup into dist\Denta-Setup-<version>.exe,
     the version taken from pubspec.yaml.

.EXAMPLE
  .\scripts\build_windows.ps1
  .\scripts\build_windows.ps1 -Run
  .\scripts\build_windows.ps1 -SkipBuild
  .\scripts\build_windows.ps1 -CertPath C:\certs\denta.pfx -CertPassword (Read-Host -AsSecureString)
  .\scripts\build_windows.ps1 -CertThumbprint 0123456789ABCDEF...
#>
[CmdletBinding()]
param(
  # Reuse the last Flutter build and only repack the installer.
  [switch]$SkipBuild,
  # Start the installer once it is built.
  [switch]$Run,
  # A .pfx code-signing certificate and its password...
  [string]$CertPath,
  [SecureString]$CertPassword,
  # ...or one already installed in the Windows certificate store (or on a
  # USB token), picked by its thumbprint.
  [string]$CertThumbprint,
  [string]$TimestampUrl = 'http://timestamp.digicert.com'
)

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
Set-Location $root

function Step($text) { Write-Host "`n==> $text" -ForegroundColor Cyan }

function Invoke-Native {
  param([string]$File, [string[]]$Arguments)
  & $File @Arguments
  if ($LASTEXITCODE -ne 0) {
    throw "$File failed with exit code $LASTEXITCODE"
  }
}

# ── Flutter: the version the project pins ─────────────────────────────────
function Get-Flutter {
  $fvmrc = Join-Path $root '.fvmrc'
  if (Test-Path $fvmrc) {
    $version = (Get-Content $fvmrc -Raw | ConvertFrom-Json).flutter
    $candidate = Join-Path $env:USERPROFILE "fvm\versions\$version\bin\flutter.bat"
    if (Test-Path $candidate) { return $candidate }
    throw "Flutter $version (from .fvmrc) is not installed. Run: fvm install $version"
  }
  throw 'No .fvmrc found - cannot tell which Flutter to build with.'
}

# ── Version from pubspec.yaml: "1.0.2+1" -> 1.0.2 ──────────────────────────
function Get-AppVersion {
  $line = Select-String -Path (Join-Path $root 'pubspec.yaml') -Pattern '^version:\s*([0-9]+\.[0-9]+\.[0-9]+)' |
    Select-Object -First 1
  if ($null -eq $line) { throw 'No version: line in pubspec.yaml' }
  return $line.Matches[0].Groups[1].Value
}

function Get-InnoCompiler {
  $paths = @(
    "${env:ProgramFiles(x86)}\Inno Setup 6\ISCC.exe",
    "$env:ProgramFiles\Inno Setup 6\ISCC.exe"
  )
  foreach ($p in $paths) { if (Test-Path $p) { return $p } }
  $cmd = Get-Command iscc.exe -ErrorAction SilentlyContinue
  if ($null -ne $cmd) { return $cmd.Source }
  throw 'Inno Setup 6 not found. Install it from https://jrsoftware.org/isdl.php'
}

function Get-SignTool {
  $kits = "${env:ProgramFiles(x86)}\Windows Kits\10\bin"
  $tool = Get-ChildItem -Path $kits -Filter signtool.exe -Recurse -ErrorAction SilentlyContinue |
    Where-Object { $_.FullName -match '\\x64\\' } |
    Sort-Object FullName -Descending |
    Select-Object -First 1
  if ($null -eq $tool) { throw 'signtool.exe not found - install the Windows SDK.' }
  return $tool.FullName
}

$signing = ($CertPath -ne '') -or ($CertThumbprint -ne '')

function Sign-File([string]$file) {
  if (-not $signing) { return }
  $signTool = Get-SignTool
  $arguments = @('sign', '/fd', 'SHA256', '/tr', $TimestampUrl, '/td', 'SHA256')
  if ($CertThumbprint -ne '') {
    $arguments += @('/sha1', $CertThumbprint)
  } else {
    $arguments += @('/f', $CertPath)
    if ($null -ne $CertPassword) {
      $plain = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
        [Runtime.InteropServices.Marshal]::SecureStringToBSTR($CertPassword))
      $arguments += @('/p', $plain)
    }
  }
  $arguments += $file
  Write-Host "    signing $(Split-Path -Leaf $file)"
  Invoke-Native $signTool $arguments
}

$version = Get-AppVersion
$releaseDir = Join-Path $root 'build\windows\x64\runner\Release'
$runtimeDir = Join-Path $root 'build\installer\runtime'
$distDir = Join-Path $root 'dist'

Write-Host "Denta $version" -ForegroundColor Green

if (-not $SkipBuild) {
  $flutter = Get-Flutter
  Step "flutter pub get ($flutter)"
  Invoke-Native $flutter @('pub', 'get')

  Step 'flutter build windows --release'
  Invoke-Native $flutter @('build', 'windows', '--release')
}

if (-not (Test-Path (Join-Path $releaseDir 'dental_clinic_app.exe'))) {
  throw "No release build in $releaseDir - run without -SkipBuild."
}

Step 'Collecting the Visual C++ runtime'
New-Item -ItemType Directory -Force -Path $runtimeDir | Out-Null
# The app is 64-bit, so its runtime must be too. A 32-bit PowerShell - which
# is what a 32-bit `make` starts - sees SysWOW64 when it asks for System32,
# and would bundle the 32-bit DLLs; Sysnative is the real 64-bit folder there.
$systemDir = "$env:WINDIR\System32"
if (-not [Environment]::Is64BitProcess -and [Environment]::Is64BitOperatingSystem) {
  $systemDir = "$env:WINDIR\Sysnative"
}
foreach ($dll in @('msvcp140.dll', 'vcruntime140.dll', 'vcruntime140_1.dll')) {
  $source = Join-Path $systemDir $dll
  if (-not (Test-Path $source)) {
    throw "$dll not found in System32 - install the Visual C++ 2015-2022 x64 redistributable on this machine."
  }
  Copy-Item $source $runtimeDir -Force
}

if ($signing) {
  Step 'Signing the app'
  Sign-File (Join-Path $releaseDir 'dental_clinic_app.exe')
} else {
  Write-Host "`n(no certificate given - skipping code signing)" -ForegroundColor Yellow
}

Step 'Building the installer (Inno Setup)'
New-Item -ItemType Directory -Force -Path $distDir | Out-Null
$iscc = Get-InnoCompiler
Invoke-Native $iscc @(
  "/DAppVersion=$version",
  "/DSourceDir=$releaseDir",
  "/DRuntimeDir=$runtimeDir",
  "/DOutputDir=$distDir",
  (Join-Path $root 'installer\denta.iss')
)

$setup = Join-Path $distDir "Denta-Setup-$version.exe"
if ($signing) {
  Step 'Signing the installer'
  Sign-File $setup
}

Write-Host "`nDone: $setup" -ForegroundColor Green

if ($Run) {
  Step 'Starting the installer'
  Start-Process $setup
}
