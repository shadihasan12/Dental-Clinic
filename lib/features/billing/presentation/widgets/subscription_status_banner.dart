import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/user_subscription_entity.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Banner shown above billing pages and inside the read-only-mode dialog.
/// Three flavours:
/// - active & near expiry → warning ("expires in N days, renew now")
/// - expired              → error   ("subscription expired, app is read-only")
/// - active & healthy     → returns SizedBox.shrink (caller should hide it)
class SubscriptionStatusBanner extends StatelessWidget {
  const SubscriptionStatusBanner({
    super.key,
    required this.subscription,
    this.onAction,
  });

  final UserSubscriptionEntity? subscription;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final sub = subscription;
    if (sub == null) return const SizedBox.shrink();

    final l10n = AppLocalizations.of(context)!;
    final fontFamily = FontHelper.fontFamily(context);

    if (!sub.isValid) {
      return _Banner(
        color: ColorManager.error,
        background: ColorManager.errorBackground,
        icon: Icons.error_outline,
        title: l10n.subscriptionExpiredTitle,
        message: l10n.subscriptionExpiredMessage,
        actionLabel: l10n.renewNow,
        onAction: onAction,
        fontFamily: fontFamily,
      );
    }
    if (sub.isNearExpiry) {
      return _Banner(
        color: ColorManager.warning,
        background: ColorManager.warningBackground,
        icon: Icons.schedule_rounded,
        title: l10n.subscriptionExpiresSoonTitle,
        message: l10n.subscriptionExpiresInDays(sub.daysUntilRenewal),
        actionLabel: l10n.renewNow,
        onAction: onAction,
        fontFamily: fontFamily,
      );
    }
    return const SizedBox.shrink();
  }
}

class _Banner extends StatelessWidget {
  const _Banner({
    required this.color,
    required this.background,
    required this.icon,
    required this.title,
    required this.message,
    required this.fontFamily,
    this.actionLabel,
    this.onAction,
  });

  final Color color;
  final Color background;
  final IconData icon;
  final String title;
  final String message;
  final String fontFamily;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20.w),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: fontFamily,
                    color: color,
                    height: 1.4,
                  ),
                ),
                if (actionLabel != null && onAction != null) ...[
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: onAction,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        actionLabel!,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: fontFamily,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
