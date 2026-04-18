import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/core/theme/theme_bloc.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';

void showThemeSettingsDialog(BuildContext context) {
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
          child: const ThemeSettingsModal(isDesktop: true),
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
    builder: (context) => const ThemeSettingsModal(),
  );
}

class ThemeSettingsModal extends StatelessWidget {
  const ThemeSettingsModal({super.key, this.isDesktop = false});

  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final fontFamily = FontHelper.fontFamily(context);
    final c = ColorManager.of(context);
    final currentMode = getIt<ThemeBloc>().state.themeMode;

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
                  l10n.appearance,
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

          // Theme options
          _ThemeOption(
            icon: Icons.light_mode_outlined,
            title: l10n.lightMode,
            isSelected: currentMode == ThemeMode.light,
            isDesktop: isDesktop,
            onTap: () {
              getIt<ThemeBloc>().add(const ChangeThemeEvent(ThemeMode.light));
              Navigator.pop(context);
            },
          ),
          SizedBox(height: isDesktop ? 10 : 8.h),
          _ThemeOption(
            icon: Icons.dark_mode_outlined,
            title: l10n.darkMode,
            isSelected: currentMode == ThemeMode.dark,
            isDesktop: isDesktop,
            onTap: () {
              getIt<ThemeBloc>().add(const ChangeThemeEvent(ThemeMode.dark));
              Navigator.pop(context);
            },
          ),
          SizedBox(height: isDesktop ? 10 : 8.h),
          _ThemeOption(
            icon: Icons.settings_brightness_outlined,
            title: l10n.systemDefault,
            isSelected: currentMode == ThemeMode.system,
            isDesktop: isDesktop,
            onTap: () {
              getIt<ThemeBloc>().add(const ChangeThemeEvent(ThemeMode.system));
              Navigator.pop(context);
            },
          ),
          SizedBox(height: isDesktop ? 8 : 24.h),
        ],
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final bool isDesktop;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.isDesktop = false,
  });

  @override
  Widget build(BuildContext context) {
    final fontFamily = FontHelper.fontFamily(context);
    final c = ColorManager.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(isDesktop ? 12 : 12.r),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 16 : 16.w,
            vertical: isDesktop ? 14 : 14.h,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? ColorManager.primary.withValues(alpha: 0.1)
                : c.cardBgSecondary,
            borderRadius: BorderRadius.circular(isDesktop ? 12 : 12.r),
            border: Border.all(
              color: isSelected ? ColorManager.primary : c.borderLight,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: isDesktop ? 22 : 22.w,
                color: isSelected ? ColorManager.primary : c.textSecondary,
              ),
              SizedBox(width: isDesktop ? 12 : 12.w),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: isDesktop ? 15 : 15.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? ColorManager.primary : c.textPrimary,
                  ),
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  size: isDesktop ? 22 : 22.w,
                  color: ColorManager.primary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
