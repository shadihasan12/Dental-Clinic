import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/routes_manager.dart';
import 'package:dental_clinic_app/core/services/notifications/notification_service.dart';
import 'package:dental_clinic_app/core/storage/token_storage.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/custom_widgets/app_snackbar.dart';

/// Single place that ends a session and puts the user back on the login page.
///
/// Two callers today: the explicit "Logout" action, and [AuthInterceptor] when
/// the backend answers 401 and the token cannot be refreshed. Both must wipe
/// the *same* set of local state — leaving a stale token or a cached profile
/// behind is what makes the app sit on a signed-in-looking screen while every
/// request comes back `Unauthenticated`.
@lazySingleton
class SessionManager {
  SessionManager(this._tokenStorage, this._userStorage);

  final TokenStorage _tokenStorage;
  final UserStorage _userStorage;

  /// Guards against a burst of parallel 401s (a dashboard fires several
  /// requests at once) each kicking off its own wipe + navigation.
  bool _isEndingSession = false;

  /// Clears the stored session and sends the user to the login page.
  ///
  /// [expired] distinguishes a forced sign-out (token rejected by the server)
  /// from a user-initiated logout; only the former shows the
  /// "session expired" notice.
  Future<void> endSession({bool expired = false}) async {
    if (_isEndingSession) return;
    _isEndingSession = true;

    try {
      // Order matters, same as the manual logout flow: drop the auth token
      // first so the FCM token-refresh handler can't re-register this device
      // against the account we are signing out of.
      await _tokenStorage.clearAuthData();
      await _userStorage.clear();

      // Best-effort — a dead push token must never block the redirect.
      try {
        await getIt<NotificationService>().onLogout();
      } catch (_) {/* ignore */}

      _redirectToLogin(expired: expired);
    } finally {
      _isEndingSession = false;
    }
  }

  void _redirectToLogin({required bool expired}) {
    // Navigation may be requested from an interceptor mid-frame, so defer it.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = rootNavigatorKey.currentContext;
      if (context == null) return;

      final router = GoRouter.of(context);
      final location = router.routerDelegate.currentConfiguration.uri.path;
      // Already out — don't stack another login page on top of itself.
      if (location == '/login' || location == '/onboarding') return;

      router.goNamed(AppRoutesNames.login);

      if (expired) _showExpiredNotice();
    });
  }

  void _showExpiredNotice() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = rootNavigatorKey.currentContext;
      if (context == null) return;

      final l10n = AppLocalizations.of(context);
      if (l10n == null) return;

      AppSnackbar.showError(context, title: l10n.sessionExpiredMessage);
    });
  }
}
