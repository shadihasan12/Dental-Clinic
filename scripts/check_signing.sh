#!/usr/bin/env bash
#
# Reports whether this Mac can build and sign Denta for TestFlight.
#
# Answers, in order:
#   1. Is there an Apple Distribution certificate?     (App Store builds)
#   2. Are there provisioning profiles for the app?    (dev + store)
#   3. Do those profiles carry the APNs entitlement?   (push works at all)
#   4. Are the App Store Connect API credentials set?  (upload)
#
# Read-only. Usage: ./scripts/check_signing.sh
set -uo pipefail

cd "$(dirname "$0")/.." || exit 1

BUNDLE=$(grep -o 'PRODUCT_BUNDLE_IDENTIFIER = [^;]*;' ios/Runner.xcodeproj/project.pbxproj \
         | sed 's/PRODUCT_BUNDLE_IDENTIFIER = //; s/;//' | grep -v RunnerTests | sort -u | head -1)
TEAM=$(grep -o 'DEVELOPMENT_TEAM = [^;]*;' ios/Runner.xcodeproj/project.pbxproj \
       | sed 's/DEVELOPMENT_TEAM = //; s/;//' | sort -u | head -1)
PROFILE_DIR="$HOME/Library/Developer/Xcode/UserData/Provisioning Profiles"

fail=0
pass() { printf '  \033[32m✓\033[0m %s\n' "$1"; }
warn() { printf '  \033[33m!\033[0m %s\n' "$1"; }
bad()  { printf '  \033[31m✗\033[0m %s\n' "$1"; fail=1; }

echo "Signing readiness for $BUNDLE (team $TEAM)"
echo

# ── 1. Certificates ─────────────────────────────────────────────────────────
echo "Certificates"
dist=$(security find-identity -v -p codesigning 2>/dev/null | grep -c "Apple Distribution")
dev=$(security find-identity -v -p codesigning 2>/dev/null | grep -c "Apple Development")

if [ "$dist" -gt 0 ]; then
  pass "Apple Distribution present ($dist)"
else
  bad "No Apple Distribution certificate — App Store builds cannot be signed"
  warn "  Xcode > Settings > Accounts > [team] > Manage Certificates > + > Apple Distribution"
fi
[ "$dev" -gt 0 ] && pass "Apple Development present ($dev)" \
                || warn "No Apple Development certificate (only needed to run on a device)"
echo

# ── 2 & 3. Provisioning profiles ────────────────────────────────────────────
echo "Provisioning profiles for $BUNDLE"
found_dev=0; found_store=0

shopt -s nullglob
for f in "$PROFILE_DIR"/*.mobileprovision; do
  x=$(security cms -D -i "$f" 2>/dev/null) || continue
  appid=$(printf '%s' "$x" | plutil -extract Entitlements.application-identifier raw -o - - 2>/dev/null)
  case "$appid" in
    *".$BUNDLE") ;;
    *) continue ;;
  esac

  aps=$(printf '%s' "$x" | plutil -extract Entitlements.aps-environment raw -o - - 2>/dev/null)
  name=$(printf '%s' "$x" | plutil -extract Name raw -o - - 2>/dev/null)
  exp=$(printf '%s' "$x" | plutil -extract ExpirationDate raw -o - - 2>/dev/null)

  case "$aps" in
    development) found_dev=1;   pass "$name — aps=development (expires $exp)" ;;
    production)  found_store=1; pass "$name — aps=production (expires $exp)" ;;
    "")          bad "$name — no aps-environment: push will NOT work with this profile"
                 warn "  The App ID is missing the Push Notifications capability." ;;
    *)           warn "$name — unexpected aps-environment '$aps'" ;;
  esac
done
shopt -u nullglob

[ "$found_dev" -eq 1 ]   || bad "No development profile — cannot run on a device from Xcode"
[ "$found_store" -eq 1 ] || bad "No distribution profile — cannot upload to TestFlight"

if [ "$found_dev" -eq 0 ] && [ "$found_store" -eq 0 ]; then
  warn "  Open ios/Runner.xcworkspace, select the Runner target, and let"
  warn "  automatic signing generate them. Build once in Release to get the store profile."
fi
echo

# ── 4. Upload credentials ───────────────────────────────────────────────────
echo "App Store Connect API credentials"
for v in ASC_ISSUER_ID ASC_KEY_ID ASC_KEY_PATH; do
  if [ -n "${!v:-}" ]; then pass "$v is set"; else bad "$v is not set"; fi
done

if [ -n "${ASC_KEY_PATH:-}" ]; then
  if [ -f "${ASC_KEY_PATH/#\~/$HOME}" ]; then
    pass "key file exists at $ASC_KEY_PATH"
  else
    bad "ASC_KEY_PATH points at a missing file: $ASC_KEY_PATH"
  fi
fi
echo

if [ "$fail" -eq 0 ]; then
  printf '\033[32mReady to run: cd ios && bundle exec fastlane beta\033[0m\n'
else
  printf '\033[31mNot ready — see above. Details in docs/ios-testflight-runbook.md\033[0m\n'
fi
exit "$fail"
