import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/theme/theme_bloc.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';

void showThemeSettingsDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    builder: (context) => const ThemeSettingsModal(),
  );
}

class ThemeSettingsModal extends StatelessWidget {
  const ThemeSettingsModal({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final fontFamily = FontHelper.fontFamily(context);
    final c = ColorManager.of(context);
    final currentMode = getIt<ThemeBloc>().state.themeMode;

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
                l10n.appearance,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.w600,
                  color: c.textPrimary,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Theme options
          _ThemeOption(
            icon: Icons.light_mode_outlined,
            title: l10n.lightMode,
            isSelected: currentMode == ThemeMode.light,
            onTap: () {
              getIt<ThemeBloc>().add(const ChangeThemeEvent(ThemeMode.light));
              Navigator.pop(context);
            },
          ),
          SizedBox(height: 8.h),
          _ThemeOption(
            icon: Icons.dark_mode_outlined,
            title: l10n.darkMode,
            isSelected: currentMode == ThemeMode.dark,
            onTap: () {
              getIt<ThemeBloc>().add(const ChangeThemeEvent(ThemeMode.dark));
              Navigator.pop(context);
            },
          ),
          SizedBox(height: 8.h),
          _ThemeOption(
            icon: Icons.settings_brightness_outlined,
            title: l10n.systemDefault,
            isSelected: currentMode == ThemeMode.system,
            onTap: () {
              getIt<ThemeBloc>().add(const ChangeThemeEvent(ThemeMode.system));
              Navigator.pop(context);
            },
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final fontFamily = FontHelper.fontFamily(context);
    final c = ColorManager.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorManager.primary.withValues(alpha: 0.1)
              : c.cardBgSecondary,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? ColorManager.primary : c.borderLight,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 22.w,
              color: isSelected ? ColorManager.primary : c.textSecondary,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 15.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? ColorManager.primary : c.textPrimary,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                size: 22.w,
                color: ColorManager.primary,
              ),
          ],
        ),
      ),
    );
  }
}
