# Denta

Dental clinic management app — Flutter, targeting Android, iOS and Windows.

## Getting started

```bash
flutter pub get
flutter run
```

Code generation, after any `@freezed` / `@injectable` change:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Localisation, after editing `lib/l10n/app_en.arb` or `lib/l10n/app_ar.arb`:

```bash
flutter gen-l10n
```

Never edit `lib/generated_localizations/` by hand — it is regenerated.

## Architecture

Clean Architecture, one folder per feature under `lib/features/<feature>/`:

```
data/         endpoints, models, data_sources, repositories (impl)
domain/       entities, repositories (abstract), use_cases
presentation/ bloc, pages, widgets
```

- **State**: `flutter_bloc` + `freezed` for events and states
- **Errors**: `Either<NetworkExceptions, T>` from `dartz`
- **DI**: `get_it` + `injectable` — annotate and regenerate, do not hand-edit
  `lib/injection.config.dart`
- **Routing**: `go_router`, all routes top-level in
  `lib/core/resources/routes_manager.dart`

> Use `context.push` / `pushReplacement` for anything the user should be able to
> back out of. `context.go` (and `router.go`) **replace the whole stack**, which
> leaves the destination with nothing to pop — reserve them for sign-in, sign-out
> and onboarding transitions.

## Design system

Colours live in `lib/core/resources/color_manager.dart`. Gradients, buttons,
headers and the shareable statistics card all derive from the primary ramp, so
retuning the brand means editing five constants and nothing else.

Use `ColorManager.of(context)` for theme-aware colours in widgets; the static
members are for theme definitions and other non-context call sites.

### Primary — Denta blue

The ramp takes the hue of the logo blue and softens it for large UI surfaces.
The logo artwork itself keeps the vivid original (`#199ED9`); the ramp below is
for the interface.

| Token | Hex | H / S / L | Used for |
| --- | --- | --- | --- |
| `primary` | `#62B4DA` | 199 / 62% / 62% | Buttons, active states, accents |
| `primaryDark` | `#3DA2D1` | 199 / 62% / 53% | Gradient mid-stop, pressed states |
| `primaryDarker` | `#2D90BE` | 199 / 62% / 46% | Gradient end-stop, primary-coloured text on white |
| `primaryLight` | `#8BC8E4` | 199 / 62% / 72% | Light fills, chips |
| `primaryLighter` | `#A8D6EB` | 199 / 63% / 79% | Subtle backgrounds |

Opacity helpers: `primary5`, `primary10`, `primary20`, `primary30`.

**Contrast:** white on `primary` is 2.32:1 — below the 4.5:1 AA threshold for
small text. Keep white-on-primary to buttons and headings at 18px or above, and
use `primaryDarker` when primary-coloured text sits on a white ground.

### Semantic

| Token | Hex | Meaning |
| --- | --- | --- |
| `success` | `#16A34A` | Confirmed, paid, completed |
| `warning` | `#EA580C` | Pending, needs attention |
| `error` | `#DC2626` | Failed, invalid |
| `info` | `#2563EB` | Informational, dentist role badge |
| `destructive` | `#D4183D` | Delete and other irreversible actions |
| `secondary` | `#26A69A` | Secretary / receptionist role badge |

Each of `success` / `warning` / `error` / `info` also has `…Light`,
`…Background` and `…Border` variants.

> `info` (221°) and `primary` (199°) are only 22° apart and similarly
> saturated. They are used side by side as role badges on the clinic users
> page — check that screen when retuning either.

### Neutrals

| Token | Hex | | Token | Hex |
| --- | --- | --- | --- | --- |
| `gray50` | `#F9FAFB` | | `gray300` | `#D1D5DB` |
| `gray100` | `#F3F4F6` | | `gray500` | `#6B7280` |
| `gray200` | `#E5E7EB` | | `gray700` | `#374151` |
| | | | `gray900` | `#111827` |

`gray50` is the scaffold background; `gray900` is primary text.

### Other design tokens

- **Typography** — `FontHelper.fontFamily(context)` returns Geist for LTR and
  Cairo for Arabic. Sizes and weights via `FontSizesManager` /
  `FontWeightManager`.
- **Radii** — `BorderRadiusManager.lg / xl / xxl`.
- **Gradients** — `GradientManager.primaryHeader`, `.primaryButton`.
- **Shared widgets** — `CustomCard` for cards, `PageHeader(title, onBack, actions)`
  for page headers.

### Adding a colour

Add it to `ColorManager` rather than writing a literal `Color(0xFF…)` in a
widget. Two exceptions exist today — default parameter values in
`app_confirmation_dialog.dart` and `app_loading_dialog.dart` must stay
compile-time constants, so they hold literal copies of `primary` and need
updating alongside it.

## Branding

- App name: **Denta** — set in the Android manifest label, iOS
  `CFBundleDisplayName`, `AppConstants.appName`, both ARB files, the web
  manifest, and the Windows/macOS/Linux runners.
- Icons are generated from the logo masters; the notification small icon is a
  white-on-transparent silhouette, since Android keeps only the alpha channel
  and renders a full-colour icon as a featureless blob.
- Brand blue in artwork: `#199ED9`.

## Platforms

Android and iOS are the primary targets. Windows is supported, with one
notable difference: `firebase_messaging` has no Windows implementation, so
push notifications are gated behind `NotificationService.supportsPush`
(Android and iOS only) and desktop uses a different transport.

See [DESKTOP_PARITY.md](DESKTOP_PARITY.md) for the state of the
`platform/desktop` branch relative to `dev`.
