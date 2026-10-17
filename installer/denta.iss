; Inno Setup script for the Denta Windows installer.
;
; Not meant to be compiled by hand: scripts\build_windows.ps1 builds the
; Flutter release first and passes the version and paths in with /D. Opened
; on its own in the Inno Setup IDE it still compiles, from the defaults below.

#ifndef AppVersion
  #define AppVersion "0.0.0"
#endif
#ifndef SourceDir
  #define SourceDir "..\build\windows\x64\runner\Release"
#endif
#ifndef RuntimeDir
  #define RuntimeDir "..\build\installer\runtime"
#endif
#ifndef OutputDir
  #define OutputDir "..\dist"
#endif

#define AppName "Denta"
#define AppExe "dental_clinic_app.exe"
#define AppPublisher "Runbit"

[Setup]
; Never change AppId: it is how a new installer recognises - and upgrades -
; the copy already installed instead of adding a second one.
AppId={{D21A175F-08F5-4CA7-B96E-0B5EA0185654}
AppName={#AppName}
AppVersion={#AppVersion}
AppVerName={#AppName} {#AppVersion}
AppPublisher={#AppPublisher}
VersionInfoVersion={#AppVersion}
DefaultDirName={autopf}\{#AppName}
DefaultGroupName={#AppName}
DisableProgramGroupPage=yes
UninstallDisplayIcon={app}\{#AppExe}
UninstallDisplayName={#AppName}
SetupIconFile=..\windows\runner\resources\app_icon.ico
OutputDir={#OutputDir}
OutputBaseFilename=Denta-Setup-{#AppVersion}
Compression=lzma2/max
SolidCompression=yes
WizardStyle=modern
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64
; Lets a user without admin rights install for themselves only.
PrivilegesRequired=admin
PrivilegesRequiredOverridesAllowed=dialog
; Closes a running copy before replacing its files on an upgrade.
CloseApplications=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"

[Files]
; The whole Flutter release folder: the exe, flutter_windows.dll, the
; plugins' DLLs and data\ (assets, fonts, .env, ICU data).
Source: "{#SourceDir}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; The Visual C++ runtime, next to the exe. A Flutter app will not start
; without it, and a freshly installed Windows often does not have it -
; the "VCRUNTIME140.dll was not found" error on a new laptop.
Source: "{#RuntimeDir}\*.dll"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\{#AppName}"; Filename: "{app}\{#AppExe}"
Name: "{group}\{cm:UninstallProgram,{#AppName}}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#AppName}"; Filename: "{app}\{#AppExe}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#AppExe}"; Description: "{cm:LaunchProgram,{#AppName}}"; Flags: nowait postinstall skipifsilent
