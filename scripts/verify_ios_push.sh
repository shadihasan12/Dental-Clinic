#!/usr/bin/env bash
#
# Checks that every piece iOS push depends on agrees with every other piece.
#
# The bundle identifier is duplicated across four files, and Firebase silently
# degrades rather than failing loudly when they disagree: pushes just never
# arrive. This catches that before a build reaches TestFlight.
#
# Usage:  ./scripts/verify_ios_push.sh
# Exit:   0 = consistent, 1 = at least one problem
set -uo pipefail

cd "$(dirname "$0")/.." || exit 1

PBXPROJ="ios/Runner.xcodeproj/project.pbxproj"
GSI="ios/Runner/GoogleService-Info.plist"
FOPTS="lib/core/services/notifications/firebase_options.dart"
INFO="ios/Runner/Info.plist"

fail=0
pass() { printf '  \033[32m✓\033[0m %s\n' "$1"; }
warn() { printf '  \033[33m!\033[0m %s\n' "$1"; }
bad()  { printf '  \033[31m✗\033[0m %s\n' "$1"; fail=1; }

# Read one key out of a plist, on stdout, without touching the file.
#
# `plutil -extract KEY FMT FILE` with no -o REWRITES FILE IN PLACE with the
# extracted value — it will happily reduce an Info.plist to a bare array. The
# explicit `-o -` is what makes this a read. Never call plutil -extract
# directly in this script.
plist_get() {
  local key="$1" fmt="$2" file="$3"
  [ -f "$file" ] || return 1
  plutil -extract "$key" "$fmt" -o - "$file" 2>/dev/null
}

echo "iOS push configuration check"
echo

# ── Firebase project agreement ──────────────────────────────────────────────
# Read rather than hardcode: the project can be swapped with flutterfire, and a
# stale hardcoded name here would send you chasing the wrong console.
echo "Firebase project"
ios_proj=$(plist_get PROJECT_ID raw "$GSI")
and_proj=$(sed -n 's/.*"project_id": "\([^"]*\)".*/\1/p' android/app/google-services.json 2>/dev/null | sort -u | head -1)
dart_proj=$(grep -A8 'FirebaseOptions ios = ' "$FOPTS" 2>/dev/null \
            | sed -n "s/.*projectId: '\([^']*\)'.*/\1/p" | head -1)

PROJECT_ID="${ios_proj:-${and_proj:-${dart_proj:-UNKNOWN}}}"

if [ -n "$ios_proj" ] && [ "$ios_proj" = "$and_proj" ] && [ "$ios_proj" = "$dart_proj" ]; then
  pass "iOS/Android/Dart agree: $PROJECT_ID"
else
  bad "Firebase project differs across configs"
  warn "  GoogleService-Info.plist: ${ios_proj:-<missing>}"
  warn "  google-services.json:     ${and_proj:-<missing>}"
  warn "  firebase_options.dart:    ${dart_proj:-<missing>}"
  warn "  One flutterfire run should rewrite all three — see the command below."
fi

# main.dart calls Firebase.initializeApp on every platform, so a block still
# pointing at an abandoned project is a live failure there, not dead config.
stale=$(grep -oE "projectId: '[^']*'" "$FOPTS" 2>/dev/null \
        | sed "s/projectId: '//; s/'//" | sort -u | grep -v "^$PROJECT_ID$")
if [ -n "$stale" ]; then
  bad "firebase_options.dart still references other project(s): $(echo "$stale" | tr '\n' ' ')"
  for s in $stale; do
    blocks=$(awk -v p="$s" '
      /static const FirebaseOptions/ { name=$4 }
      $0 ~ "projectId: ." p "." { print name }' "$FOPTS" | tr '\n' ' ')
    warn "  $s used by: ${blocks:-unknown}"
  done
  warn "  main.dart initializes Firebase on ALL platforms — these will break"
  warn "  if that project is deleted. Register those platforms in $PROJECT_ID."
else
  pass "every platform block points at $PROJECT_ID"
fi
echo

# ── Bundle identifier agreement ─────────────────────────────────────────────
echo "Bundle identifier"
pbx_ids=$(grep -o 'PRODUCT_BUNDLE_IDENTIFIER = [^;]*;' "$PBXPROJ" \
          | sed 's/PRODUCT_BUNDLE_IDENTIFIER = //; s/;//' \
          | grep -v RunnerTests | sort -u)
pbx_count=$(echo "$pbx_ids" | grep -c .)

if [ "$pbx_count" -ne 1 ]; then
  bad "Runner configurations disagree: $(echo "$pbx_ids" | tr '\n' ' ')"
  BUNDLE=""
else
  BUNDLE="$pbx_ids"
  pass "Xcode project: $BUNDLE"
  case "$BUNDLE" in
    com.example.*) bad "com.example.* cannot be registered with Apple" ;;
  esac
fi

if [ -f "$GSI" ]; then
  gsi_id=$(plist_get BUNDLE_ID raw "$GSI")
  if [ "$gsi_id" = "$BUNDLE" ]; then
    pass "GoogleService-Info.plist: $gsi_id"
  else
    bad "GoogleService-Info.plist says '$gsi_id', project says '$BUNDLE'"
    warn "  Register an iOS app for '$BUNDLE' in Firebase, then replace this file"
  fi
else
  bad "$GSI missing"
fi

if [ -f "$FOPTS" ]; then
  dart_id=$(grep -A8 'FirebaseOptions ios = ' "$FOPTS" \
            | sed -n "s/.*iosBundleId: '\([^']*\)'.*/\1/p" | head -1)
  if [ "$dart_id" = "$BUNDLE" ]; then
    pass "firebase_options.dart: $dart_id"
  else
    bad "firebase_options.dart says '$dart_id', project says '$BUNDLE'"
  fi
fi

# One command fixes every Firebase-side mismatch above. Printed with the
# identifiers this repo actually uses so it can be pasted as-is.
if [ "$fail" -ne 0 ]; then
  echo
  warn "Regenerate all Firebase config with:"
  warn "  flutterfire configure --project=$PROJECT_ID \\"
  warn "      --out=$FOPTS \\"
  warn "      --ios-bundle-id=$BUNDLE \\"
  warn "      --android-package-name=$BUNDLE"
  warn "  (swap --project if you are moving to a different Firebase project)"
fi
echo

# ── Entitlements ────────────────────────────────────────────────────────────
echo "APNs entitlements"
for pair in "Runner/Runner.entitlements:development" \
            "Runner/RunnerRelease.entitlements:production"; do
  f="ios/${pair%%:*}"; want="${pair##*:}"
  if [ ! -f "$f" ]; then
    bad "$f missing — without aps-environment iOS never issues an APNs token"
    continue
  fi
  got=$(plist_get aps-environment raw "$f")
  if [ "$got" = "$want" ]; then
    pass "$(basename "$f"): aps-environment=$got"
  else
    bad "$(basename "$f"): aps-environment='$got', expected '$want'"
  fi
done

# Release must point at the production variant or TestFlight push dies silently.
rel_ent=$(awk '/[^A-Za-z]Release \*\/ = \{/,/name = Release;/' "$PBXPROJ" \
          | grep -o 'CODE_SIGN_ENTITLEMENTS = [^;]*;' | head -1)
case "$rel_ent" in
  *RunnerRelease.entitlements*) pass "Release configuration uses RunnerRelease.entitlements" ;;
  "")  bad "Release configuration has no CODE_SIGN_ENTITLEMENTS" ;;
  *)   bad "Release configuration uses ${rel_ent} (expected RunnerRelease.entitlements)" ;;
esac
echo

# ── Info.plist background modes ─────────────────────────────────────────────
echo "Background modes"
modes=$(plist_get UIBackgroundModes json "$INFO")
case "$modes" in
  *remote-notification*) pass "remote-notification present" ;;
  *) bad "UIBackgroundModes is missing remote-notification (data pushes cannot wake the app)" ;;
esac
echo

# ── CocoaPods ───────────────────────────────────────────────────────────────
echo "CocoaPods"
if grep -q "FirebaseMessaging" ios/Podfile.lock 2>/dev/null; then
  pass "FirebaseMessaging present in Podfile.lock"
else
  bad "FirebaseMessaging absent from Podfile.lock — run: cd ios && pod install"
fi

if grep -qE "^platform :ios, '1[5-9]" ios/Podfile; then
  pass "Podfile platform >= iOS 15 (required by Firebase 12.x)"
else
  bad "Podfile must declare platform :ios, '15.0' or higher"
fi
echo

# ── Android ─────────────────────────────────────────────────────────────────
# Same failure mode, louder: the Google Services Gradle plugin hard-fails the
# build when applicationId is absent from google-services.json.
echo "Android"
GRADLE="android/app/build.gradle.kts"
GSJ="android/app/google-services.json"

app_id=$(sed -n 's/.*applicationId *= *"\([^"]*\)".*/\1/p' "$GRADLE" | head -1)
ns=$(sed -n 's/.*namespace *= *"\([^"]*\)".*/\1/p' "$GRADLE" | head -1)

if [ -n "$app_id" ]; then
  pass "applicationId: $app_id"
else
  bad "could not read applicationId from $GRADLE"
fi

if [ "$ns" = "$app_id" ]; then
  pass "namespace matches applicationId"
else
  warn "namespace '$ns' differs from applicationId '$app_id' (legal, but usually unintended)"
fi

if [ -f "$GSJ" ]; then
  if grep -q "\"package_name\": \"$app_id\"" "$GSJ"; then
    pass "google-services.json has a client for $app_id"
  else
    have=$(sed -n 's/.*"package_name": "\([^"]*\)".*/\1/p' "$GSJ" | sort -u | tr '\n' ' ')
    bad "google-services.json has no client for '$app_id' (it lists: $have)"
    warn "  Gradle will fail: No matching client found for package name '$app_id'"
    warn "  Add an Android app for '$app_id' in Firebase and replace $GSJ"
  fi
else
  bad "$GSJ missing"
fi

# The Kotlin package must live at a path mirroring its package declaration.
main_act=$(find android/app/src/main/kotlin -name MainActivity.kt 2>/dev/null | head -1)
if [ -n "$main_act" ]; then
  decl=$(sed -n 's/^package *\([A-Za-z0-9_.]*\).*/\1/p' "$main_act" | head -1)
  expected_dir="android/app/src/main/kotlin/$(echo "$ns" | tr '.' '/')"
  if [ "$decl" = "$ns" ] && [ "$(dirname "$main_act")" = "$expected_dir" ]; then
    pass "MainActivity.kt package and directory match the namespace"
  else
    bad "MainActivity.kt: package '$decl' at $(dirname "$main_act"); expected '$ns' at $expected_dir"
  fi
else
  bad "MainActivity.kt not found"
fi
echo

if [ "$fail" -eq 0 ]; then
  printf '\033[32mAll checks passed.\033[0m\n'
else
  printf '\033[31mProblems found — see above.\033[0m\n'
fi
exit "$fail"
