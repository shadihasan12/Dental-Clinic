import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/clinic/presentation/widgets/action_button.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';

/// A reusable confirmation dialog with success icon and Yes/No options
class AppConfirmationDialog extends StatelessWidget {
  const AppConfirmationDialog({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon = Icons.check_circle,
    this.iconColor = const Color(0xFF70B2B2),
    this.iconBackgroundColor = const Color(0xFFE8F5F5),
    required this.yesText,
    required this.noText,
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
    String? yesText,
    String? noText,
    VoidCallback? onYesPressed,
    VoidCallback? onNoPressed,
    bool barrierDismissible = false,
  }) {
    final l10n = AppLocalizations.of(context);
    return showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AppConfirmationDialog(
        title: title,
        subtitle: subtitle,
        icon: icon,
        iconColor: iconColor,
        iconBackgroundColor: iconBackgroundColor,
        yesText: yesText ?? l10n!.yes,
        noText: noText ?? l10n!.no,
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
              fontFamily: FontHelper.fontFamily(context),
              fontWeight: FontWeight.w600,
              color: ColorManager.of(context).textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: FontHelper.fontFamily(context),
              color: ColorManager.of(context).textSecondary,
            ),
          ),
        ],
      ),
      actions: [
        ActionButton(
          text: noText,
          onPressed: onNoPressed ?? () => Navigator.pop(context, false),
          filled: false,
          fillColor: ColorManager.of(context).cardBg,
          textColor: ColorManager.of(context).textPrimary,
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
