import 'dart:async';

import 'package:dental_clinic_app/core/config/app_config.dart';
import 'package:dental_clinic_app/core/resources/routes_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/services/subscription_guard/subscription_guard.dart';
import 'package:dental_clinic_app/services/subscription_guard/subscription_guard_helper.dart';
import 'package:injectable/injectable.dart';

/// The one place the app reacts to a 402.
///
/// The interceptor has already updated the cached mode by the time a notice
/// lands here, so all that is left is telling the user: the server's
/// sentence, and one way out - the subscription screen.
///
/// A locked clinic (billing only, or no subscription) gets no dialog: the
/// root swaps to the lock screen on the mode change, and that screen says
/// the same thing. Without this rule every tab's first request would each
/// raise its own dialog on the way in.
@lazySingleton
class PaymentRequiredHandler {
  PaymentRequiredHandler(this._guard);

  final SubscriptionGuard _guard;
  StreamSubscription<PaymentRequiredNotice>? _subscription;
  bool _dialogOpen = false;

  void start() {
    _subscription ??= _guard.notices.listen(_onNotice);
  }

  Future<void> _onNotice(PaymentRequiredNotice notice) async {
    SubscriptionGuardHelper.refreshAccess();

    if (!AppConfig.billingEnabled) return;
    if (notice.mode.isLocked || _dialogOpen) return;

    final context = rootNavigatorKey.currentContext;
    if (context == null || !context.mounted) return;
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return;

    _dialogOpen = true;
    try {
      await SubscriptionGuardHelper.showSubscriptionDialog(
        context,
        title: l10n.subscriptionRequiredTitle,
        message: notice.message.isEmpty
            ? l10n.subscriptionInactiveMessage
            : notice.message,
      );
    } finally {
      _dialogOpen = false;
    }
  }
}
