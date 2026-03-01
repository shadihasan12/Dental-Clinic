import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/home/domain/entities/notification_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationCard extends StatelessWidget {
  final NotificationEntity notification;
  final VoidCallback onTap;
  final String timeAgo;

  const NotificationCard({
    super.key,
    required this.notification,
    required this.onTap,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    final icon = _iconForType(notification.type);
    final iconColor = _colorForType(notification.type);

    return InkWell(
      onTap: onTap,
      child: Container(
        color: notification.isRead ? Colors.white : ColorManager.primary5,
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
              child: Icon(icon, size: 20.w, color: iconColor),
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
                            color: ColorManager.textPrimary,
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
                  SizedBox(height: 4.h),
                  Text(
                    notification.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      color: ColorManager.textSecondary,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    timeAgo,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      color: ColorManager.textSubtle,
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

  IconData _iconForType(NotificationType type) {
    switch (type) {
      case NotificationType.appointment:
        return Icons.calendar_today_rounded;
      case NotificationType.payment:
        return Icons.payment_rounded;
      case NotificationType.patient:
        return Icons.person_add_rounded;
      case NotificationType.report:
        return Icons.bar_chart_rounded;
      case NotificationType.treatment:
        return Icons.medical_services_rounded;
      case NotificationType.cancellation:
        return Icons.cancel_rounded;
    }
  }

  Color _colorForType(NotificationType type) {
    switch (type) {
      case NotificationType.appointment:
        return ColorManager.info;
      case NotificationType.payment:
        return ColorManager.primary;
      case NotificationType.patient:
        return ColorManager.success;
      case NotificationType.report:
        return ColorManager.purple;
      case NotificationType.treatment:
        return ColorManager.warning;
      case NotificationType.cancellation:
        return ColorManager.error;
    }
  }
}
