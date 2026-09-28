import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/custom_widgets/adaptive_sheet.dart';
import 'package:dental_clinic_app/core/widgets/english_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> showCupertinoPickerSheet({
  required BuildContext context,
  required String cancelLabel,
  required String doneLabel,
  VoidCallback? onDone,
  required Widget picker,
}) {
  // Every wheel this sheet shows is a date or a time, and those stay in
  // English digits app-wide - see [EnglishPicker].
  final englishPicker = EnglishPicker(child: picker);
  final c = ColorManager.of(context);
  // Resolved here, from the caller's context, and not inside the sheet: the
  // buttons carry the app's language (Cairo under Arabic) while only the
  // wheel below them is forced to English, and CupertinoButton's default
  // text style would otherwise fall back to the platform face.
  final fontFamily = FontHelper.fontFamily(context);
  Widget sheet(BuildContext ctx) => Container(
      height: 300.h,
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: Column(
        children: [
          SizedBox(height: 8.h),
          Center(
            child: HideInDialog(child: Container(
              width: 36.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: c.borderLight,
                borderRadius: BorderRadius.circular(2.r),
              ),
            )),
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
                    fontFamily: fontFamily,
                    color: c.textSecondary,
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
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.primary,
                  ),
                ),
              ),
            ],
          ),
          Expanded(child: englishPicker),
        ],
      ),
    );

  // A wheel pinned to the bottom of a desktop window reads as a phone port;
  // there it opens as a small centred dialog with the same contents.
  if (Responsive.isDesktop(context)) {
    return showAppSheet<void>(
      context: context,
      dialogMaxWidth: 400,
      builder: sheet,
    );
  }
  return showCupertinoModalPopup<void>(context: context, builder: sheet);
}
