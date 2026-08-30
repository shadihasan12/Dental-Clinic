# iOS Push + TestFlight Runbook

Everything in the repository is already configured. What remains are the steps
that require signing into Apple and Firebase as you.

Bundle identifier for this app: **`tech.runbit.dentas`**
Apple Developer Team ID: **`ZGRHSS85G3`**
Firebase project: **`tech-runbit-denta`**

Two read-only scripts tell you where you stand at any point:

```bash
./scripts/verify_ios_push.sh   # bundle IDs, entitlements, Firebase config
./scripts/check_signing.sh     # certificates, profiles, upload credentials
```

Neither modifies a single file.

---

## 0. Rotate the Apple ID password — do this first

The password for `alshofi1971@gmail.com` was pasted into a chat transcript, so
it must be considered compromised.

1. <https://appleid.apple.com> → Sign-In and Security → Change Password.
2. Confirm two-factor authentication is **on**.

Nothing below needs that password. Automation uses an API key instead, which is
both safer and the only thing that works unattended — 2FA makes password-based
uploads stall forever waiting for a 6-digit code.

---

## 1. About the bundle ID you cannot delete

You created an App Store Connect record under `com.runbit.denta` by mistake,
deleted it, and now cannot remove the identifier.

**You do not need to remove it.** Once a bundle ID has been attached to an App
Store Connect record, Apple reserves it permanently — deleting the app does not
release it, and Developer Support will almost always decline to free it. Treat
`com.runbit.denta` as permanently spent.

That costs you nothing, because bundle IDs are independent. Registering
`tech.runbit.dentas` does not require freeing the old one. Leave the orphan in
the list and ignore it.

---

## 2. Register the App ID with Push Notifications

<https://developer.apple.com/account/resources/identifiers/list>

1. **+** → App IDs → App.
2. Description: `Denta`. Bundle ID: **Explicit** → `tech.runbit.dentas`.
3. In the Capabilities list, tick **Push Notifications**.
4. Continue → Register.

If you registered the App ID earlier without Push Notifications, open it and
tick the box now. Adding a capability invalidates existing provisioning
profiles; Xcode regenerates them automatically on the next build.

---

## 3. Create the APNs Auth Key (`.p8`)

This is what lets Firebase talk to Apple's push servers on your behalf.

<https://developer.apple.com/account/resources/authkeys/list>

1. **+** → name it `Denta APNs` → tick **Apple Push Notifications service (APNs)**.
2. Continue → Register → **Download**.
3. You get `AuthKey_XXXXXXXXXX.p8`. **It downloads exactly once and can never be
   re-downloaded.** Store it in a password manager, not in this repository.
4. Note the **Key ID** (the 10 characters in the filename).

One APNs key covers both the sandbox and production gateways, and all your
apps. You do not need a separate key per environment.

---

## 4. Connect Firebase to APNs

<https://console.firebase.google.com/project/tech-runbit-denta/settings/cloudmessaging>

### 4a. Add the iOS app

The Firebase project currently has an iOS app registered under
`com.example.dentalClinicApp`, which no longer matches what the project builds.

1. Project Settings → General → **Add app** → iOS.
2. Bundle ID: `tech.runbit.dentas`. Nickname: `Denta iOS`.
3. Download the new **`GoogleService-Info.plist`**.
4. Replace the file in the repo:
   ```bash
   cp ~/Downloads/GoogleService-Info.plist ios/Runner/GoogleService-Info.plist
   ```
5. Regenerate the Dart options so they match:
   ```bash
   dart pub global activate flutterfire_cli   # first time only
   flutterfire configure --project=tech-runbit-denta \
       --out=lib/core/services/notifications/firebase_options.dart
   ```
6. Confirm: `./scripts/verify_ios_push.sh` should now show three green ticks
   under "Bundle identifier".

You can delete the old `com.example.dentalClinicApp` iOS app from Firebase
afterwards — unlike Apple bundle IDs, Firebase app registrations are freely
removable.

### 4b. Upload the APNs key

Still in Project Settings → **Cloud Messaging** → Apple app configuration:

1. Under **APNs Authentication Key**, click **Upload**.
2. Select the `.p8` from step 3.
3. Key ID: the 10 characters from the filename.
4. Team ID: `ZGRHSS85G3`.

**Without this upload, every push silently fails.** FCM accepts the send and
reports success, but Apple never delivers it. This is the single most common
cause of "notifications work on Android but not iOS".

---

## 5. Create the App Store Connect record

<https://appstoreconnect.apple.com/apps>

1. **+** → New App → iOS.
2. Name: `Denta`. Primary language, and SKU (any internal string, e.g. `denta-ios`).
3. Bundle ID: select **`tech.runbit.dentas`** from the dropdown.

   If it is not listed, step 2 did not complete — the dropdown only shows
   registered App IDs.

Once created, note the numeric **Apple ID** shown on the App Information page.

---

## 6. Create the App Store Connect API key

This is the credential that replaces the password for uploads.

<https://appstoreconnect.apple.com/access/integrations/api>

1. Team Keys tab → **+**.
2. Name: `Denta CI`. Access: **App Manager**.
3. Generate → **Download API Key**. Again, this downloads only once.
4. Record three values:
   - **Issuer ID** — the UUID above the key list
   - **Key ID** — the 10-character column on your key's row
   - the downloaded `AuthKey_XXXXXXXXXX.p8`

Put the `.p8` somewhere outside the repo, e.g.:

```bash
mkdir -p ~/.appstoreconnect/private_keys
mv ~/Downloads/AuthKey_*.p8 ~/.appstoreconnect/private_keys/
```

Then export the three values in your shell (`~/.zshrc`):

```bash
export ASC_ISSUER_ID="00000000-0000-0000-0000-000000000000"
export ASC_KEY_ID="XXXXXXXXXX"
export ASC_KEY_PATH="$HOME/.appstoreconnect/private_keys/AuthKey_XXXXXXXXXX.p8"
```

`ios/.gitignore` already blocks `*.p8`, but keeping it out of the working tree
entirely is safer.

---

## 7. Connect Xcode to App Store Connect (signing & provisioning)

### How the pieces actually relate

Four separate systems are involved, and they are linked only by the **bundle
identifier** — there is no direct integration between any two of them:

```text
                    tech.runbit.dentas
                  (the only shared key)
                            │
   ┌────────────────────────┼────────────────────────┐
   │                        │                        │
Apple Developer      App Store Connect           Firebase
   Portal                                       (tech-runbit-denta)

• App ID +           • App record              • iOS app registration
  capabilities       • TestFlight / review     • APNs .p8 + Key ID + Team ID
• Certificates       • API keys (upload)       • sends pushes via Apple
• Provisioning
  profiles
• APNs .p8 key ──────────────────────────────────────┘
  (issued here, pasted into Firebase)
```

Two consequences worth internalising:

- **App Store Connect has nothing to do with push notifications.** Its only job
  is distribution. Push is Developer Portal → Firebase.
- **Firebase never talks to App Store Connect.** Firebase talks to *Apple's APNs
  servers*, authenticated by the `.p8` key from the Developer Portal.

### Current state on this machine

- `Apple Distribution` certificates: **0** — App Store builds cannot be signed
- Provisioning profiles for team `ZGRHSS85G3`: **0** — the account has never
  been added to Xcode here

Both are fixed below.

### 7a. Add the account to Xcode

1. **Xcode → Settings → Accounts → `+` → Apple ID**.
2. Sign in as `alshofi1971@gmail.com` (use the new password from step 0).
3. Select the team whose ID is `ZGRHSS85G3` in the list on the right.

If the team does not appear, the account lacks a role on it. The Account Holder
must invite you at <https://appstoreconnect.apple.com/access/users> with at
least the **App Manager** role.

### 7b. Create the Apple Distribution certificate

Still in Accounts, with the team selected:

1. **Manage Certificates…**
2. **`+`** (bottom left) → **Apple Distribution**.
3. Wait for it to appear in the list.

Verify from the terminal:

```bash
security find-identity -v -p codesigning | grep "Apple Distribution"
```

One line should come back. `Apple Development` certificates cannot sign an App
Store build — this is the certificate TestFlight requires.

> A team may hold only a limited number of distribution certificates. If the
> `+` menu greys out **Apple Distribution**, the team is at its limit —
> revoke a disused one at
> <https://developer.apple.com/account/resources/certificates/list>.
> Revoking breaks any build signed with it that has not yet shipped.

### 7c. Let Xcode generate the provisioning profiles

1. Open the **workspace**, not the project:

   ```bash
   open ios/Runner.xcworkspace
   ```

   Opening `Runner.xcodeproj` instead omits the CocoaPods targets and the build
   fails on missing Firebase headers.

2. Select the **Runner** target → **Signing & Capabilities**.
3. Confirm:
   - **Automatically manage signing** — ticked
   - **Team** — the `ZGRHSS85G3` team
   - **Bundle Identifier** — `tech.runbit.dentas`
   - **Push Notifications** appears in the capabilities list

   Push Notifications is already declared in the project file, so it should be
   present without you adding it. If it is missing, add it with **+ Capability**
   — and treat that as a sign the project file did not load cleanly.

4. Switch the scheme to **Release** (Product → Scheme → Edit Scheme → Run →
   Build Configuration → Release) so Xcode provisions the *distribution*
   profile, not just the development one.

Xcode now registers the App ID if needed, requests the profiles, and installs
them. The warning triangle in Signing & Capabilities should clear within a few
seconds.

Verify both profiles exist:

```bash
for f in ~/Library/Developer/Xcode/UserData/Provisioning\ Profiles/*.mobileprovision; do
  x=$(security cms -D -i "$f" 2>/dev/null)
  id=$(echo "$x" | plutil -extract Entitlements.application-identifier raw -o - - 2>/dev/null)
  case "$id" in *tech.runbit.dentas)
    aps=$(echo "$x" | plutil -extract Entitlements.aps-environment raw -o - - 2>/dev/null)
    echo "$id  aps=${aps:-MISSING}" ;;
  esac
done
```

You want **two** lines — one `aps=development`, one `aps=production`. That
mirrors what `com.skew.hollo.ai` already has on this machine.

`aps=MISSING` means the App ID lacks the Push Notifications capability: go back
to step 2, tick it, then in Xcode hit **Signing & Capabilities → Team →**
reselect the team to force a profile refresh.

### 7d. Why the API key is still needed

Steps 7a–7c authorise *this Mac* to build and sign. They do not authorise
uploading. The App Store Connect API key from step 6 is what lets
`fastlane beta` upload without a 2FA prompt. Both halves are required.

---

## 8. Ship it

```bash
cd ios
bundle install          # first time only — installs fastlane locally
bundle exec fastlane doctor   # verifies credentials without building
bundle exec fastlane beta     # builds, signs, uploads to TestFlight
```

`doctor` authenticates the API key and prints the latest TestFlight build
number. Run it first — it fails in seconds if a credential is wrong, instead of
after a ten-minute build.

`beta` derives the next build number from what TestFlight already has, so
repeated runs cannot collide.

---

## 9. Verify push actually works

TestFlight builds use the **production** APNs gateway. A build that receives
notifications from Xcode but not from TestFlight almost always means the
Release configuration is signed with the sandbox entitlement — the repo now
guards against this (`RunnerRelease.entitlements` carries
`aps-environment: production`), and `verify_ios_push.sh` checks it.

To test end to end:

1. Install the TestFlight build on a real device. **Push does not work on the
   iOS Simulator** — it never receives an APNs token.
2. Accept the notification permission prompt.
3. Run the app with the Xcode console attached and look for `[FCM] token: …`.
   If instead you see the "no APNs token after 9600ms" warning, push
   registration failed — see the troubleshooting table.
4. Copy that token into Firebase Console → Cloud Messaging → **Send test
   message** → paste the token.

---

## Troubleshooting

| Symptom | Cause |
|---|---|
| `[FCM] no APNs token after 9600ms` on a real device | App ID missing the Push Notifications capability (step 2), or the profile predates it |
| Same warning on Simulator | Expected. Simulators never get APNs tokens. Use a device. |
| Token arrives, test message reports success, nothing appears | APNs key not uploaded to Firebase (step 4b) |
| Works from Xcode, dead in TestFlight | Sandbox vs production entitlement mismatch |
| `No signing certificate "iOS Distribution" found` | Step 7 not done |
| Upload rejected as duplicate build | Build number did not increase — `fastlane beta` handles this automatically |
| Bundle ID missing from the App Store Connect dropdown | App ID not registered, or registered as a wildcard rather than explicit |

---

## 10. Android — one Firebase step still required

Android has been renamed from `com.example.dental_clinic_app` to
`tech.runbit.dentas`. Three of the four changes are done in the repo:

- `namespace` and `applicationId` in `android/app/build.gradle.kts`
- the package directory, now `android/app/src/main/kotlin/tech/runbit/dentas/`
- the `package` declaration in `MainActivity.kt`

`AndroidManifest.xml` needed no edit — it refers to `.MainActivity` relative to
the namespace.

**The Android build fails until you do the fourth.** `android/app/google-services.json`
still lists `com.example.dental_clinic_app`, and the Google Services Gradle
plugin hard-fails on a mismatch:

```text
No matching client found for package name 'tech.runbit.dentas'
```

To fix:

1. <https://console.firebase.google.com/project/tech-runbit-denta/settings/general>
2. **Add app** → Android → package name `tech.runbit.dentas`.
3. Download the new `google-services.json` and replace it:
   ```bash
   cp ~/Downloads/google-services.json android/app/google-services.json
   ```
4. Rebuild: `flutter build apk --debug`

> **If Denta is already published on Google Play** under
> `com.example.dental_clinic_app`, stop and reconsider. Play keys a listing on
> its `applicationId`; changing it publishes a *separate* app rather than an
> update, existing installs never receive it, and the change cannot be undone.
> Reverting the three repo changes above is the way back.
