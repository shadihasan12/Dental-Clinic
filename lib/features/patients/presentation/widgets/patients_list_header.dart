import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/custom_widgets/denta_form.dart';

/// Title, the one number the screen is about, the New button, and search.
///
/// The count sits next to the title as a tinted pill rather than a second
/// line, so the header keeps to two rows and the list starts higher.
class PatientsListHeader extends StatelessWidget {
  const PatientsListHeader({
    super.key,
    required this.patientCount,
    required this.searchController,
    required this.onAddTap,
    required this.onSearchChanged,
    this.showCount = true,
  });

  final int patientCount;
  final TextEditingController searchController;
  final VoidCallback onAddTap;
  final ValueChanged<String> onSearchChanged;

  /// Hidden while the list is loading or failed - a "0 total" would be a
  /// claim the screen cannot make yet.
  final bool showCount;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  l10n.patients,
                  style: TextStyle(
                    fontFamily: family,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: c.textPrimary,
                  ),
                ),
                if (showCount) ...[
                  SizedBox(width: 6.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      '$patientCount',
                      style: TextStyle(
                        fontFamily: family,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                        color: ColorManager.primaryDarker,
                      ),
                    ),
                  ),
                ],
                const Spacer(),
                _NewButton(label: l10n.newButton, onTap: onAddTap),
              ],
            ),

            SizedBox(height: 12.h),

            // Search: grey field with a hairline. The light-theme inputBg is
            // gray50, the same value as the page behind it, so the field
            // would read as an outline floating on nothing - gray100 gives
            // it an actual surface.
            Container(
              decoration: BoxDecoration(
                color: isDark ? c.inputBg : ColorManager.gray100,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: c.borderLight),
              ),
              child: TextField(
                controller: searchController,
                onChanged: onSearchChanged,
                style: TextStyle(
                  fontFamily: family,
                  fontSize: 12.5.sp,
                  color: c.textPrimary,
                ),
                decoration: bareInputDecoration().copyWith(
                  hintText: '${l10n.search} ${l10n.patients.toLowerCase()}...',
                  hintStyle: TextStyle(
                    fontFamily: family,
                    fontSize: 12.5.sp,
                    color: c.textSubtle,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 18.w,
                    color: c.textSubtle,
                  ),
                  prefixIconConstraints: BoxConstraints(
                    minWidth: 38.w,
                    minHeight: 38.w,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.h,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Rectangular primary button. A round `+` gave the action no name; the word
/// carries it, and the shape matches every other primary button in the app.
class _NewButton extends StatelessWidget {
  const _NewButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorManager.primary,
      borderRadius: BorderRadius.circular(11.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(11.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 9.h),
          // Icon and label are centred on the row's cross axis; the label
          // carries no `height` override, because shrinking its line box
          // pushes the glyphs off the icon's centre - visibly so in Cairo.
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.add, size: 16.w, color: ColorManager.white),
              SizedBox(width: 5.w),
              Text(
                label,
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
