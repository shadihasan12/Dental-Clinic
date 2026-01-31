import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';

/// A reusable loading dialog with customizable message
class AppLoadingDialog extends StatelessWidget {
  const AppLoadingDialog({
    super.key,
    this.message = 'Loading...',
    this.indicatorColor = const Color(0xFF70B2B2),
  });

  final String message;
  final Color indicatorColor;

  /// Show the loading dialog
  static void show({
    required BuildContext context,
    String message = 'Loading...',
    Color indicatorColor = const Color(0xFF70B2B2),
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AppLoadingDialog(
        message: message,
        indicatorColor: indicatorColor,
      ),
    );
  }

  /// Dismiss the loading dialog
  static void dismiss(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
              ),
              SizedBox(height: 16.h),
              Text(
                message,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: FontFamily.geist,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
