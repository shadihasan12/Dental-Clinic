import 'package:flutter/widgets.dart';

import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations_en.dart';

/// `context.l10n` — the translations for the active locale.
///
/// `AppLocalizations.of` is nullable because the delegate may not be above the
/// calling widget. Rather than asserting with `!` at every call site, this
/// falls back to the English bundle: a widget used outside a `Localizations`
/// scope then renders English instead of throwing. `main.dart` registers
/// `AppLocalizations.delegate` above the router, so in the running app the
/// fallback is unreachable.
extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n =>
      AppLocalizations.of(this) ?? AppLocalizationsEn();
}
