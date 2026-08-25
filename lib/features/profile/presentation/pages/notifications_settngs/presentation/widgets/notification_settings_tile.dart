import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// One notification category, as a Denta list card.
///
/// On/off is the status this row carries, so it is drawn the way the style
/// draws status everywhere else: a 3px strip on the leading edge plus an
/// icon tile in the same hue. A category that is off drops to grey on both
/// counts, which leaves the coloured rows as an at-a-glance answer to "what
/// will actually reach me".
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

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final description = subtitle;
    final tone = value ? iconColor : c.textSubtle;

    return AppCard(
      padding: EdgeInsetsDirectional.fromSTEB(13.w, 11.h, 10.w, 11.h),
      statusTone: value ? iconColor : null,
      child: Row(
        children: [
          IconTile(icon: icon, tone: tone),
          SizedBox(width: 11.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.5.sp,
                    fontFamily: family,
                    fontWeight: FontWeight.w600,
                    color: value ? c.textPrimary : c.textSecondary,
                  ),
                ),
                if (description != null && description.isNotEmpty) ...[
                  SizedBox(height: 2.h),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 11.sp,
                      height: 1.4,
                      fontFamily: family,
                      color: c.textTertiary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(width: 10.w),
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
    );
  }
}
