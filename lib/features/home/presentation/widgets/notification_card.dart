import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/home/domain/entities/notification_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// One notification, as a Denta list card: 14px radius, 1px hairline, and the
/// unread state carried by a 3px start border plus a tinted icon tile in the
/// same hue - the same convention the treatment rows use for status.
///
/// The bell tile itself reads the same on every row - an outlined bell in
/// the light blue off the primary ramp, on a neutral grey disc. Unread is
/// carried by the 3px start strip, the tinted card border and the heavier
/// title, so the tile does not have to shout it a fourth time.
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
    final family = FontHelper.fontFamily(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final unread = !notification.isRead;
    final body = notification.body;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: unread
              ? ColorManager.primary.withValues(alpha: isDark ? 0.45 : 0.30)
              : c.borderLight,
        ),
      ),
      // A non-uniform BoxBorder cannot take a borderRadius, so the status edge
      // is painted as a clipped strip over the card instead of as a border.
      child: Stack(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              onLongPress: onLongPress,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(13.w, 12.h, 12.w, 12.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 34.w,
                      height: 34.w,
                      decoration: BoxDecoration(
                        // Grey disc rather than a blue tint: the bell is the
                        // one blue thing in the tile, so the background stays
                        // out of its way.
                        color: c.textSubtle.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.notifications_none_rounded,
                        size: 18.w,
                        color: ColorManager.primaryLight,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            notification.title,
                            style: TextStyle(
                              fontSize: 12.5.sp,
                              height: 1.3,
                              fontWeight:
                                  unread ? FontWeight.w600 : FontWeight.w500,
                              fontFamily: family,
                              color:
                                  unread ? c.textPrimary : c.textSecondary,
                            ),
                          ),
                          // `body` is documented as nullable - announcements
                          // are often title-only, and an empty Text would
                          // leave a dead gap.
                          if (body != null && body.isNotEmpty) ...[
                            SizedBox(height: 4.h),
                            Text(
                              body,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11.5.sp,
                                height: 1.4,
                                fontFamily: family,
                                color: c.textSecondary,
                              ),
                            ),
                          ],
                          SizedBox(height: 6.h),
                          Text(
                            timeAgo,
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontFamily: family,
                              color: c.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (unread)
            PositionedDirectional(
              start: 0,
              top: 0,
              bottom: 0,
              width: 3.w,
              child: const ColoredBox(color: ColorManager.primary),
            ),
        ],
      ),
    );
  }
}
