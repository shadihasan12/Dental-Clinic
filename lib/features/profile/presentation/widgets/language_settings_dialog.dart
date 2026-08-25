import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/language_switch_widget.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';

void showLanguageSettingsDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: ColorManager.of(context).cardBg,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
    ),
    builder: (context) => LanguageSettingsModal(),
  );
}

class LanguageSettingsModal extends StatelessWidget {
  const LanguageSettingsModal({super.key});

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 14.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 40x4 grab handle, then the title row with an x on the trailing
            // side - the sheet shape every other sheet in the app uses.
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: c.borderLight,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 14.h),
            Row(
              children: [
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.language,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      fontWeight: FontWeight.w700,
                      color: c.textPrimary,
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Icon(
                      Icons.close,
                      size: 20.w,
                      color: c.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            LanguageSwitchWidget(
              onLanguageChanged: (language) {
                Future.delayed(const Duration(milliseconds: 500), () {
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                });
              },
            ),
            SizedBox(height: 14.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 9.h),
              decoration: BoxDecoration(
                color: c.cardBgSecondary,
                borderRadius: BorderRadius.circular(11.r),
                border: Border.all(color: c.borderLight),
              ),
              child: Text(
                AppLocalizations.of(context)!.appLanguageWillChangeImmediately,
                style: TextStyle(
                  fontSize: 11.sp,
                  height: 1.45,
                  fontFamily: FontHelper.fontFamily(context),
                  color: c.textTertiary,
                ),
              ),
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}
