# App Review 1.0.3 (2) — working notes

The text to send is in `app-review-notes-1.0.3.txt`, which holds nothing but
the message: paste the whole file into App Review Information → Notes, and as
the reply in the thread for submission d98f7127-2ed5-4745-94bb-482d6d0d3d77.
It is 3,976 bytes and that field takes 4,000, so adding to it will not fit.

This file is for us, not for Apple.

## Before sending

1. **The recording has to be re-made.** The one sent on 2 October opens with
   account creation — the feature this build removes — so sending it with
   these notes contradicts them. Re-record on a clean install starting from
   the sign-in screen with the demo credentials, and replace the file in the
   Drive folder (the link in the notes is unchanged).
2. **Sign in once with the demo account on a clean install.** Registration is
   gone, so this login is the only way into the app; confirm it reaches the
   home screen and does not stop at the verification-code screen, which needs
   a code from that mailbox.
3. **Check the Terms page.** It says access requires a subscription whose
   plans are "described in the app", which is no longer true of the iOS build
   and reads oddly next to these notes.
4. **The Pricing section on https://denta.runbit.tech** is the likeliest
   thing to be raised next, since the 1 October rejection was about
   subscriptions sold outside the app. Consider keeping pricing off the pages
   reachable from the app's links.

## What changed in the code (1.0.3 build 2, not for Apple)

- `AppConfig.selfSignupEnabled` — false on iOS and macOS, true on Android and
  web. Mirrors the existing `AppConfig.billingEnabled` flag.
- `LoginPage` hides the "Don't have an account? Sign up" row when it is off.
- `RoutesManager` redirects `/email-entry`, `/register`, `/choose-plan`,
  `/choose-clinic-name` and `/create-clinic` to `/login` when it is off, so a
  deep link or a stale route cannot reach a registration screen either.
- `test/self_signup_gate_test.dart` pins the per-platform answer.
- `pubspec.yaml` bumped to `1.0.3+2`.

Email verification (`/verify-email-entry`, `/email-verification`) and
`/setup-working-hours` are deliberately still reachable: the first is how an
existing user with an unverified email signs in, and the second is where
RootPage sends a clinic owner who has not set a schedule yet. Neither creates
an account.
