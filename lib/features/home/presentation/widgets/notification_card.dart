import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/home/domain/entities/notification_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationCard extends StatelessWidget {
  final NotificationEntity notification;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final String timeAgo;

  const NotificationCard({
    super.key,
    required this.notification,
    required this.onTap,
    required this.timeAgo,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final iconColor = _colorForCategory(notification.category);
    final body = notification.body;

    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        color: notification.isRead ? c.cardBg : ColorManager.primary5,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                _iconForCategory(notification.category),
                size: 20.w,
                color: iconColor,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: FontHelper.fontFamily(context),
                            fontWeight: notification.isRead
                                ? FontWeight.w500
                                : FontWeight.w600,
                            color: c.textPrimary,
                          ),
                        ),
                      ),
                      if (!notification.isRead)
                        Container(
                          width: 8.w,
                          height: 8.w,
                          decoration: const BoxDecoration(
                            color: ColorManager.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  // `body` is documented as nullable — announcements are often
                  // title-only, and an empty Text would leave a dead gap.
                  if (body != null && body.isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    Text(
                      body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        color: c.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ],
                  SizedBox(height: 6.h),
                  Text(
                    timeAgo,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      color: c.textSubtle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Categories are server-defined and new ones ship without an app update, so
  /// both of these fall through to a neutral default rather than switching
  /// exhaustively over an enum.
  IconData _iconForCategory(String category) {
    switch (category) {
      case NotificationCategories.appointmentReminder:
        return Icons.calendar_today_rounded;
      case NotificationCategories.paymentReminder:
        return Icons.payment_rounded;
      case NotificationCategories.clinicInvitation:
        return Icons.group_add_rounded;
      case NotificationCategories.announcement:
        return Icons.campaign_rounded;
      default:
        return Icons.notifications_rounded;
    }
  }

  Color _colorForCategory(String category) {
    switch (category) {
      case NotificationCategories.appointmentReminder:
        return ColorManager.info;
      case NotificationCategories.paymentReminder:
        return ColorManager.warning;
      case NotificationCategories.clinicInvitation:
        return ColorManager.success;
      case NotificationCategories.announcement:
        return ColorManager.purple;
      default:
        return ColorManager.primary;
    }
  }
}
