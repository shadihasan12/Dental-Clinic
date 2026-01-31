import 'package:dental_clinic_app/features/clinic/presentation/widgets/action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';

/// A reusable confirmation dialog with success icon and Yes/No options
class AppConfirmationDialog extends StatelessWidget {
  const AppConfirmationDialog({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon = Icons.check_circle,
    this.iconColor = const Color(0xFF70B2B2),
    this.iconBackgroundColor = const Color(0xFFE8F5F5),
    this.yesText = 'Yes',
    this.noText = 'No',
    this.onYesPressed,
    this.onNoPressed,
    this.barrierDismissible = false,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String yesText;
  final String noText;
  final VoidCallback? onYesPressed;
  final VoidCallback? onNoPressed;
  final bool barrierDismissible;

  /// Show the confirmation dialog
  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String subtitle,
    IconData icon = Icons.check_circle,
    Color iconColor = const Color(0xFF70B2B2),
    Color iconBackgroundColor = const Color(0xFFE8F5F5),
    String yesText = 'Yes',
    String noText = 'No',
    VoidCallback? onYesPressed,
    VoidCallback? onNoPressed,
    bool barrierDismissible = false,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AppConfirmationDialog(
        title: title,
        subtitle: subtitle,
        icon: icon,
        iconColor: iconColor,
        iconBackgroundColor: iconBackgroundColor,
        yesText: yesText,
        noText: noText,
        onYesPressed: onYesPressed,
        onNoPressed: onNoPressed,
        barrierDismissible: barrierDismissible,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.spaceBetween,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 36.sp),
          ),
          SizedBox(height: 16.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.sp,
              fontFamily: FontFamily.geist,
              fontWeight: FontWeight.w600,
              color: ColorManager.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: FontFamily.geist,
              color: ColorManager.textSecondary,
            ),
          ),
        ],
      ),
      actions: [
        ActionButton(
          text: noText,
          onPressed: onNoPressed ?? () => Navigator.pop(context, false),
          filled: false,
          fillColor: ColorManager.white,
          textColor: ColorManager.textPrimary,
        ),
        SizedBox(height: 11.w),
        ActionButton(
          text: yesText,
          onPressed: onYesPressed ?? () => Navigator.pop(context, true),
          fillColor: ColorManager.primary,
          filled: true,
          textColor: ColorManager.white,
        ),
      ],
    );
  }
}
