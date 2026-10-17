.PHONY: generate watch clean install build run test format analyze help build-windows build-windows-run installer-windows

# Variables
FLUTTER := flutter
DART := dart
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

# Build APK
build-apk:
	@echo "=> Building APK..."
	@$(FLUTTER) build apk --release
	@echo "=> APK built!"

# Build iOS
build-ios:
	@echo "=> Building iOS..."
	@$(FLUTTER) build ios --release
	@echo "=> iOS built!"

# Build Windows app + installer -> dist/Denta-Setup-<version>.exe
build-windows:
	@echo "=> Building Windows app and installer..."
	@$(WINDOWS_BUILD)

# Same, then open the installer
build-windows-run:
	@$(WINDOWS_BUILD) -Run

# Repack the installer from the last Windows build (no Flutter build)
installer-windows:
	@echo "=> Repacking Windows installer..."
	@$(WINDOWS_BUILD) -SkipBuild

# Run app
run:
	@echo "=> Running app..."
	@$(FLUTTER) run

# Analyze code
analyze:
	@echo "=> Analyzing code..."
	@$(FLUTTER) analyze
	@echo "=> Analysis complete!"

# Full rebuild
rebuild: clean install generate
	@echo "=> Full rebuild complete!"


language: generate language keys
	@echo "=> Generating language keys..."
	@$(FLUTTER) gen-l10n
# Help
help:
	@echo "=> Available commands"
	@echo ""
	@echo "  Asset Generation:"
	@echo "    make generate     - Generate assets and code"
	@echo ""
	@echo "  Maintenance:"
	@echo "    make clean        - Clean generated files"
	@echo "    make install      - Install dependencies"
	@echo "    make rebuild      - Full clean rebuild"
	@echo ""
	@echo "  Development:"
	@echo "    make run          - Run the app"
	@echo "    make analyze      - Analyze code"
	@echo ""
	@echo "  Build:"
	@echo "    make build-apk    - Build Android APK"
	@echo "    make build-ios    - Build iOS app"
	@echo "    make build-windows     - Build Windows app + installer (dist/)"
	@echo "    make build-windows-run - Same, then open the installer"
	@echo "    make installer-windows - Repack the installer from the last build"
	@echo ""
	@echo "  Info:"
	@echo "    make help         - Show this help message"