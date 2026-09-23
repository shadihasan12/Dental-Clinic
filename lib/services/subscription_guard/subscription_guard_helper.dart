import 'package:dental_clinic_app/core/config/app_config.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/services/permissions/clinic_permissions_bloc.dart';
import 'package:dental_clinic_app/services/permissions/permission_slugs.dart';
import 'package:dental_clinic_app/services/subscription_guard/subscription_guard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SubscriptionGuardHelper {
  SubscriptionGuardHelper._();

  static DateTime? _lastRefresh;

  /// Whether this user may open the subscription and payment screens in the
  /// active clinic. Built from the permissions list rather than `is_owner`:
  /// every billing endpoint sits behind a feature granted to the ADMIN role,
  /// and a dentist or secretary gets 403 on all of them.
  static bool get canManageBilling {
    if (!AppConfig.billingEnabled) return false;
    final permissions = getIt<ClinicPermissionsBloc>();
    return PermissionSlugs.billing.any(permissions.hasFeature);
  }

  /// Re-reads the permissions, which carry the access mode in `meta`.
  ///
  /// Called on resume, after a payment is reported and on every 402. The
  /// throttle stops a burst of 402s - a dashboard firing several requests at
  /// once - from turning into a burst of permission calls.
  static void refreshAccess({bool force = false}) {
    final now = DateTime.now();
    if (!force &&
        _lastRefresh != null &&
        now.difference(_lastRefresh!) < const Duration(seconds: 10)) {
      return;
    }
    _lastRefresh = now;
    getIt<ClinicPermissionsBloc>().add(const ClinicPermissionsEvent.refresh());
  }

  /// Returns `true` if the action may proceed; `false` if the user should
  /// be blocked. When the action is blocked this also surfaces a dialog
  /// telling the user their subscription has expired and offering to take
  /// them to the subscription screen.
  ///
  /// The server's 402 is the safety net; this is the design - a user in a
  /// read-only clinic is told before they fill a form in, not after.
  static Future<bool> requireActive(BuildContext context) async {
    // No billing in this build means nothing to expire - blocking an action
    // behind a subscription the user was never offered would strand them.
    if (!AppConfig.billingEnabled) return true;

    final guard = getIt<SubscriptionGuard>();
    if (guard.isActive) return true;
    final l10n = AppLocalizations.of(context)!;
    await showSubscriptionDialog(
      context,
      title: l10n.subscriptionExpiredTitle,
      message: l10n.subscriptionExpiredBlocksAction,
    );
    return false;
  }

  /// The one dialog both the pre-check above and the 402 handler show.
  ///
  /// The "go to subscription" action is only offered to someone who can open
  /// that screen; everyone else is told to ask the clinic's admin.
  static Future<void> showSubscriptionDialog(
    BuildContext context, {
    required String title,
    required String message,
  }) async {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);
    final canPay = canManageBilling;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: c.cardBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          icon: Icon(Icons.lock_clock_rounded,
              color: ColorManager.warning, size: 36.w),
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.sp,
              fontFamily: fontFamily,
              fontWeight: FontWeight.w700,
              color: c.textPrimary,
            ),
          ),
          content: Text(
            canPay ? message : '$message\n\n${l10n.subscriptionAskAdmin}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.sp,
              fontFamily: fontFamily,
              color: c.textSecondary,
              height: 1.4,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                canPay ? l10n.notNow : l10n.ok,
                style: TextStyle(
                  fontFamily: fontFamily,
                  color: c.textSecondary,
                ),
              ),
            ),
            if (canPay)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  context.pushNamed(AppRoutesNames.billing);
                },
                child: Text(
                  l10n.goToSubscription,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
