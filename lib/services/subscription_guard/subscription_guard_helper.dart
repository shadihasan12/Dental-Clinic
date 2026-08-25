import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/services/subscription_guard/subscription_guard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SubscriptionGuardHelper {
  SubscriptionGuardHelper._();

  /// Returns `true` if the action may proceed; `false` if the user should
  /// be blocked. When the action is blocked this also surfaces a dialog
  /// telling the user their subscription has expired and offering to take
  /// them to billing.
  static Future<bool> requireActive(BuildContext context) async {
    final guard = getIt<SubscriptionGuard>();
    if (guard.isActive) return true;
    await _showExpiredDialog(context);
    return false;
  }

  static Future<void> _showExpiredDialog(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);

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
            l10n.subscriptionExpiredTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.sp,
              fontFamily: fontFamily,
              fontWeight: FontWeight.w700,
              color: c.textPrimary,
            ),
          ),
          content: Text(
            l10n.subscriptionExpiredBlocksAction,
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
                l10n.notNow,
                style: TextStyle(
                  fontFamily: fontFamily,
                  color: c.textSecondary,
                ),
              ),
            ),
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
                l10n.renewNow,
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
