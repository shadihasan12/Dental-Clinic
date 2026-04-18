import 'package:dental_clinic_app/core/localization/language_bloc.dart';
import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/custom_widgets/language_switch_widget.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';

void showLanguageSettingsDialog(BuildContext context) {
  if (Responsive.isDesktop(context)) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: ColorManager.of(context).cardBg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: const LanguageSettingsModal(isDesktop: true),
        ),
      ),
    );
    return;
  }
  showModalBottomSheet(
    context: context,
    backgroundColor: ColorManager.of(context).cardBg,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    builder: (context) => const LanguageSettingsModal(),
  );
}

class LanguageSettingsModal extends StatelessWidget {
  const LanguageSettingsModal({super.key, this.isDesktop = false});

  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);

    return Container(
      padding: EdgeInsets.all(isDesktop ? 20 : 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  l10n.language,
                  style: TextStyle(
                    fontSize: isDesktop ? 18 : 18.sp,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.w600,
                    color: c.textPrimary,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close, color: c.textSecondary),
              ),
            ],
          ),
          SizedBox(height: isDesktop ? 18 : 24.h),

          // Language switch
          if (isDesktop)
            _DesktopLanguageSwitch(
              onLanguageChanged: (language) {
                Future.delayed(const Duration(milliseconds: 500), () {
                  if (context.mounted) Navigator.pop(context);
                });
              },
            )
          else
            LanguageSwitchWidget(
              onLanguageChanged: (language) {
                Future.delayed(const Duration(milliseconds: 500), () {
                  if (context.mounted) Navigator.pop(context);
                });
              },
            ),

          SizedBox(height: isDesktop ? 16 : 24.h),

          // Info text
          Container(
            padding: EdgeInsets.all(isDesktop ? 12 : 12),
            decoration: BoxDecoration(
              color: c.cardBgSecondary,
              borderRadius: BorderRadius.circular(isDesktop ? 8 : 8.r),
            ),
            child: Text(
              l10n.appLanguageWillChangeImmediately,
              style: TextStyle(
                fontSize: isDesktop ? 12 : 12.sp,
                fontFamily: fontFamily,
                color: c.textSecondary,
              ),
            ),
          ),
          SizedBox(height: isDesktop ? 8 : 24.h),
        ],
      ),
    );
  }
}

/// Desktop version of the language switch with raw pixel sizing.
class _DesktopLanguageSwitch extends StatelessWidget {
  const _DesktopLanguageSwitch({required this.onLanguageChanged});

  final void Function(String)? onLanguageChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      bloc: getIt<LanguageBloc>(),
      builder: (context, state) {
        final currentLocale = state.locale.languageCode;
        return Row(
          children: [
            Expanded(
              child: _button(
                context: context,
                language: 'en',
                label: AppLocalizations.of(context)!.english,
                isSelected: currentLocale == 'en',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _button(
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

  Widget _button({
    required BuildContext context,
    required String language,
    required String label,
    required bool isSelected,
  }) {
    final c = ColorManager.of(context);
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          getIt<LanguageBloc>().add(ChangeLanguageEvent(language));
          onLanguageChanged?.call(language);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? ColorManager.primary : c.cardBgSecondary,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? ColorManager.primary : c.border,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? ColorManager.white : c.textPrimary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            fontSize: 14,
            fontFamily:
                language == 'ar' ? FontFamily.cairo : FontFamily.geist,
          ),
        ),
      ),
    );
  }
}
