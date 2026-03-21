import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? fillColor;
  final bool filled;
  final Color? textColor;
  
  const ActionButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.fillColor,
    this.textColor,
    required this.filled,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: fillColor ?? ColorManager.of(context).cardBg,
          border: !filled ? Border.all(color: ColorManager.of(context).borderLight, width: 1) : null,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: FontHelper.fontFamily(context),
              fontWeight: FontWeight.w600,
              color: textColor ?? ColorManager.black,
            ),
          ),
        ),
      ),
    );
  }
}
