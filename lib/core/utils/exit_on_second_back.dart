import 'package:dental_clinic_app/custom_widgets/app_snackbar.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// "Press back again to exit", for the screens the app opens on.
///
/// The first back (button or edge swipe) only says how to leave; a second
/// one within [window] closes the app. Without it a single stray swipe from
/// the screen edge - easy to make while scrolling - quit the app.
///
/// Android only in effect: iOS has no system back at the root, and
/// [SystemNavigator.pop] is ignored there.
class ExitOnSecondBack {
  static const Duration window = Duration(seconds: 2);

  DateTime? _lastBack;

  void onBack(BuildContext context) {
    final now = DateTime.now();
    final last = _lastBack;
    if (last != null && now.difference(last) <= window) {
      _lastBack = null;
      AppSnackbar.dismiss();
      SystemNavigator.pop();
      return;
    }
    _lastBack = now;
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return;
    AppSnackbar.showInfo(context, title: l10n.pressBackAgainToExit);
  }
}
