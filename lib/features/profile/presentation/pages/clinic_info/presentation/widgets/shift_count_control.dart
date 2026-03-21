import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShiftCountControl extends StatelessWidget {
  const ShiftCountControl({
    super.key,
    required this.count,
    required this.canDecrement,
    required this.canIncrement,
    required this.onDecrement,
    required this.onIncrement,
  });

  final int count;
  final bool canDecrement;
  final bool canIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Container(
      height: 32.h,
      decoration: BoxDecoration(
        color: c.cardBgSecondary,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: c.borderLight),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: canDecrement ? onDecrement : null,
            child: Container(
              width: 32.w,
              height: 32.h,
              alignment: Alignment.center,
              child: Icon(
                Icons.remove,
                size: 16.w,
                color: canDecrement
                    ? c.textPrimary
                    : c.textTertiary,
              ),
            ),
          ),
          Container(width: 1, height: 18.h, color: c.borderLight),
          SizedBox(
            width: 32.w,
            child: Text(
              '$count',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w600,
                color: c.textPrimary,
              ),
            ),
          ),
          Container(width: 1, height: 18.h, color: c.borderLight),
          GestureDetector(
            onTap: canIncrement ? onIncrement : null,
            child: Container(
              width: 32.w,
              height: 32.h,
              alignment: Alignment.center,
              child: Icon(
                Icons.add,
                size: 16.w,
                color: canIncrement
                    ? ColorManager.primary
                    : c.textTertiary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
