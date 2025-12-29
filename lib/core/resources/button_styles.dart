import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'color_manager.dart';

/// Centralized button styles for consistent UI
class ButtonStyles {
  ButtonStyles._();

  /// Primary elevated button style
  static ButtonStyle primary = ElevatedButton.styleFrom(
    backgroundColor: ColorManager.primary,
    foregroundColor: ColorManager.white,
    elevation: 0,
    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.r),
    ),
    textStyle: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
    ),
  );

  /// Secondary outlined button style
  static ButtonStyle secondary = OutlinedButton.styleFrom(
    foregroundColor: ColorManager.primary,
    side: const BorderSide(color: ColorManager.primary, width: 1.5),
    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.r),
    ),
    textStyle: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
    ),
  );

  /// Text button style
  static ButtonStyle text = TextButton.styleFrom(
    foregroundColor: ColorManager.primary,
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    textStyle: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
    ),
  );

  /// Large primary button (for main CTAs)
  static ButtonStyle primaryLarge = ElevatedButton.styleFrom(
    backgroundColor: ColorManager.primary,
    foregroundColor: ColorManager.white,
    elevation: 0,
    minimumSize: Size(double.infinity, 56.h),
    padding: EdgeInsets.symmetric(horizontal: 24.w),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.r),
    ),
    textStyle: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
    ),
  );

  /// Danger/destructive button style
  static ButtonStyle danger = ElevatedButton.styleFrom(
    backgroundColor: ColorManager.error,
    foregroundColor: ColorManager.white,
    elevation: 0,
    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.r),
    ),
    textStyle: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
    ),
  );

  /// Success button style
  static ButtonStyle success = ElevatedButton.styleFrom(
    backgroundColor: ColorManager.success,
    foregroundColor: ColorManager.white,
    elevation: 0,
    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.r),
    ),
    textStyle: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
    ),
  );
}
