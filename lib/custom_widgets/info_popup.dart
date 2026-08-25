import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// An action-less informational dialog: icon, title, body. Square with
/// rounded corners, white background. Used for things like "subscription
/// limit reached" where there's no decision to make — the user dismisses
/// by tapping outside or the back button.
class InfoPopup extends StatelessWidget {
  const InfoPopup({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    this.iconColor,
    this.iconBackgroundColor,
  });

  final IconData icon;
  final String title;
  final String body;
  final Color? iconColor;
  final Color? iconBackgroundColor;

  static Future<void> show({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String body,
    Color? iconColor,
    Color? iconBackgroundColor,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (_) => InfoPopup(
        icon: icon,
        title: title,
        body: body,
        iconColor: iconColor,
        iconBackgroundColor: iconBackgroundColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fg = iconColor ?? ColorManager.primary;
    final bg = iconBackgroundColor ?? fg.withValues(alpha: 0.1);
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 32.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
              child: Icon(icon, size: 32.sp, color: fg),
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w600,
                color: const Color(0xFF111111),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              body,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
                color: const Color(0xFF555555),
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
