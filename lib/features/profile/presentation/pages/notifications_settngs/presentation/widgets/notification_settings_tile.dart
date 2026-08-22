import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationSettingsTile extends StatelessWidget {
  const NotificationSettingsTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
    this.isPending = false,
    this.showDivider = false,
  });

  final IconData icon;
  final Color iconColor;
  final String title;

  /// The server's `description`, which may be absent entirely.
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  /// True while this category's PATCH is in flight — the switch is inert so a
  /// second tap can't race the first.
  final bool isPending;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final description = subtitle;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Row(
            children: [
              // Icon container
              Container(
                width: 38.w,
                height: 38.w,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadiusManager.lg,
                ),
                child: Icon(icon, size: 20.w, color: iconColor),
              ),
              SizedBox(width: 14.w),

              // Title + optional description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        fontWeight: FontWeight.w500,
                        color: c.textPrimary,
                      ),
                    ),
                    if (description != null && description.isNotEmpty) ...[
                      SizedBox(height: 2.h),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: FontHelper.fontFamily(context),
                          color: c.textTertiary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(width: 12.w),

              // Switch
              Opacity(
                opacity: isPending ? 0.5 : 1,
                child: Switch(
                  value: value,
                  onChanged: isPending ? null : onChanged,
                  activeThumbColor: ColorManager.white,
                  activeTrackColor: ColorManager.primary,
                  inactiveThumbColor: ColorManager.white,
                  inactiveTrackColor: c.divider,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            indent: 68.w,
            endIndent: 16.w,
            color: c.borderLight,
          ),
      ],
    );
  }
}
