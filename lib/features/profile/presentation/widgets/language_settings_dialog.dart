import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/language_switch_widget.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';

void showLanguageSettingsDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    builder: (context) => LanguageSettingsModal(),
  );
}

class LanguageSettingsModal extends StatelessWidget {
  const LanguageSettingsModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.language,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: FontWeight.w600,
                  color: ColorManager.textPrimary,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Language switch
          LanguageSwitchWidget(
            onLanguageChanged: (language) {
              Future.delayed(const Duration(milliseconds: 500), () {
                if (context.mounted) {
                  Navigator.pop(context);
                }
              });
            },
          ),
          SizedBox(height: 24.h),

          // Info text
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ColorManager.gray50,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              AppLocalizations.of(context)!.appLanguageWillChangeImmediately,
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: FontHelper.fontFamily(context),
                color: ColorManager.textSecondary,
              ),
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
