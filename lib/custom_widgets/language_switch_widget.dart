import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/localization/language_bloc.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';

class LanguageSwitchWidget extends StatelessWidget {
  final void Function(String)? onLanguageChanged;

  const LanguageSwitchWidget({
    super.key,
    this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      bloc: getIt<LanguageBloc>(),
      builder: (context, state) {
        final currentLocale = state.locale.languageCode;

        return Row(
          children: [
            Expanded(
              child: _buildLanguageButton(
                context: context,
                language: 'en',
                label: AppLocalizations.of(context)!.english,
                isSelected: currentLocale == 'en',
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildLanguageButton(
                context: context,
                language: 'ar',
                label: AppLocalizations.of(context)!.arabic,
                isSelected: currentLocale == 'ar',
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLanguageButton({
    required BuildContext context,
    required String language,
    required String label,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          getIt<LanguageBloc>().add(ChangeLanguageEvent(language));
          onLanguageChanged?.call(language);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorManager.primary
              : ColorManager.of(context).cardBgSecondary,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected
                ? ColorManager.primary
                : ColorManager.of(context).border,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected
                ? ColorManager.white
                : ColorManager.of(context).textPrimary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            fontSize: 14.sp,
            fontFamily: language == 'ar'
                ? FontFamily.cairo
                : FontFamily.geist,
          ),
        ),
      ),
    );
  }
}
