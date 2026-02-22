import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> showCupertinoPickerSheet({
  required BuildContext context,
  required String cancelLabel,
  required String doneLabel,
  VoidCallback? onDone,
  required Widget picker,
}) {
  return showCupertinoModalPopup<void>(
    context: context,
    builder: (ctx) => Container(
      height: 300.h,
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: Column(
        children: [
          SizedBox(height: 8.h),
          Center(
            child: Container(
              width: 36.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: ColorManager.borderLight,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoButton(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                onPressed: () => Navigator.pop(ctx),
                child: Text(
                  cancelLabel,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: ColorManager.textSecondary,
                  ),
                ),
              ),
              CupertinoButton(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                onPressed: () {
                  onDone?.call();
                  Navigator.pop(ctx);
                },
                child: Text(
                  doneLabel,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.primary,
                  ),
                ),
              ),
            ],
          ),
          Expanded(child: picker),
        ],
      ),
    ),
  );
}
