import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/theme/theme_bloc.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';

void showThemeSettingsDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: ColorManager.of(context).cardBg,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
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
                    l10n.appearance,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontFamily: fontFamily,
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

          // Theme options
            _ThemeOption(
              icon: Icons.light_mode_outlined,
              title: l10n.lightMode,
              isSelected: currentMode == ThemeMode.light,
              onTap: () {
                getIt<ThemeBloc>()
                    .add(const ChangeThemeEvent(ThemeMode.light));
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
                getIt<ThemeBloc>()
                    .add(const ChangeThemeEvent(ThemeMode.system));
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 8.h),
          ],
        ),
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
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorManager.primary.withValues(alpha: 0.08)
              : c.cardBg,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? ColorManager.primary : c.borderLight,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            IconTile(icon: icon, tone: isSelected ? null : c.textSecondary),
            SizedBox(width: 11.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 12.5.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color:
                      isSelected ? ColorManager.primaryDarker : c.textPrimary,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                size: 18.w,
                color: ColorManager.primaryDarker,
              ),
          ],
        ),
      ),
    );
  }
}
