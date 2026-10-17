.PHONY: generate assets clean install rebuild language run run-prod analyze help \
	build-apk build-apk-dev build-aab build-ios build-ios-dev \
	build-windows build-windows-dev build-windows-run installer-windows

# Variables
# Through FVM, so every target uses the Flutter the project pins in .fvmrc -
# the bare `flutter` on PATH is an old 3.13 that cannot build this project.
FLUTTER := fvm flutter
DART := fvm dart

# Which server a build talks to (see AppConfig.appEnv and .env.dev/.env.prod).
# Releases default to the live server; `make run` and the *-dev targets use
# the test server.
PROD := --dart-define=APP_ENV=prod
DEV := --dart-define=APP_ENV=dev

# The Windows installer pipeline (FVM Flutter build + Inno Setup), see the
# script's own header for what it does.
WINDOWS_BUILD := powershell -NoProfile -ExecutionPolicy Bypass -File scripts/build_windows.ps1

# Generate assets and code
generate:
	@echo "=> Generating assets and code..."
	@$(DART) run build_runner build --delete-conflicting-outputs
	@echo "=> Generation complete!"

# Generate assets
assets:
	@echo "=> Generating Flutter assets..."
	@$(FLUTTER) pub run flutter_gen
	@echo "=> Assets generation complete!"

# Clean
clean:
	@echo "=> Cleaning..."
	@$(DART) run build_runner clean
	@$(FLUTTER) clean
	@echo "=> Clean complete!"

# Install dependencies
install:
	@echo "=> Installing dependencies..."
	@$(FLUTTER) pub get
	@echo "=> Dependencies installed!"

# Generate the localization classes from lib/l10n/*.arb
language:
	@echo "=> Generating language keys..."
	@$(FLUTTER) gen-l10n

# ── Run ──────────────────────────────────────────────────────────────────
# Run against the dev server
run:
	@echo "=> Running app (DEV server)..."
	@$(FLUTTER) run $(DEV)

# Run against the live server - careful, real data
run-prod:
	@echo "=> Running app (PROD server)..."
	@$(FLUTTER) run $(PROD)

# ── Android ──────────────────────────────────────────────────────────────
build-apk:
	@echo "=> Building APK (PROD)..."
	@$(FLUTTER) build apk --release $(PROD)
	@echo "=> APK built: build/app/outputs/flutter-apk/app-release.apk"

build-apk-dev:
	@echo "=> Building APK (DEV)..."
	@$(FLUTTER) build apk --release $(DEV)
	@echo "=> APK built: build/app/outputs/flutter-apk/app-release.apk"

# App bundle for Google Play
build-aab:
	@echo "=> Building app bundle (PROD)..."
	@$(FLUTTER) build appbundle --release $(PROD)
	@echo "=> Bundle built: build/app/outputs/bundle/release/app-release.aab"

# ── iOS ──────────────────────────────────────────────────────────────────
build-ios:
	@echo "=> Building iOS (PROD)..."
	@$(FLUTTER) build ios --release $(PROD)
	@echo "=> iOS built!"

build-ios-dev:
	@echo "=> Building iOS (DEV)..."
	@$(FLUTTER) build ios --release $(DEV)
	@echo "=> iOS built!"

# ── Windows ──────────────────────────────────────────────────────────────
# App + installer -> dist/Denta-Setup-<version>.exe
build-windows:
	@echo "=> Building Windows app and installer (PROD)..."
	@$(WINDOWS_BUILD) -Env prod

# "Denta Dev" app + installer -> dist/Denta-Setup-<version>-dev.exe
build-windows-dev:
	@echo "=> Building Windows app and installer (DEV)..."
	@$(WINDOWS_BUILD) -Env dev

# Same as build-windows, then open the installer
build-windows-run:
	@$(WINDOWS_BUILD) -Env prod -Run

# Repack the PROD installer from the last Windows build (no Flutter build)
installer-windows:
	@echo "=> Repacking Windows installer..."
	@$(WINDOWS_BUILD) -Env prod -SkipBuild

# Analyze code
analyze:
	@echo "=> Analyzing code..."
	@$(FLUTTER) analyze
	@echo "=> Analysis complete!"

# Full rebuild
rebuild: clean install generate
	@echo "=> Full rebuild complete!"

# Help
help:
	@echo "=> Available commands"
	@echo ""
	@echo "  Code generation:"
	@echo "    make generate          - Generate code (build_runner)"
	@echo "    make language          - Generate localizations"
	@echo ""
	@echo "  Maintenance:"
	@echo "    make clean             - Clean generated files"
	@echo "    make install           - Install dependencies"
	@echo "    make rebuild           - Full clean rebuild"
	@echo ""
	@echo "  Development:"
	@echo "    make run               - Run the app on the DEV server"
	@echo "    make run-prod          - Run the app on the PROD server (real data!)"
	@echo "    make analyze           - Analyze code"
	@echo ""
	@echo "  Release builds (PROD server):"
	@echo "    make build-apk         - Android APK"
	@echo "    make build-aab         - Android app bundle (Google Play)"
	@echo "    make build-ios         - iOS app"
	@echo "    make build-windows     - Windows app + installer (dist/)"
	@echo "    make build-windows-run - Same, then open the installer"
	@echo "    make installer-windows - Repack the installer from the last build"
	@echo ""
	@echo "  Test builds (DEV server):"
	@echo "    make build-apk-dev     - Android APK"
	@echo "    make build-ios-dev     - iOS app"
	@echo "    make build-windows-dev - 'Denta Dev' Windows app + installer"
	@echo ""
	@echo "  Info:"
	@echo "    make help              - Show this help message"
