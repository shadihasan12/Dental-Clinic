import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_type.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Individual clinic or medical center, side by side. Used at signup, where
/// the backend requires it, and in the clinic's settings, where it can be
/// changed later.
class ClinicTypeSelector extends StatelessWidget {
  const ClinicTypeSelector({
    super.key,
    required this.value,
    required this.onChanged,
    this.errorText,
  });

  final ClinicType? value;
  final ValueChanged<ClinicType> onChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);

    Widget option(ClinicType type, IconData icon, String label) {
      final selected = value == type;
      return Expanded(
        child: Material(
          color: selected
              ? ColorManager.primary.withValues(alpha: 0.10)
              : c.cardBg,
          borderRadius: BorderRadius.circular(12.r),
          child: InkWell(
            borderRadius: BorderRadius.circular(12.r),
            onTap: () => onChanged(type),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: selected ? ColorManager.primary : c.border,
                  width: selected ? 1.5 : 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: 20.w,
                    color: selected ? ColorManager.primaryDarker : c.textTertiary,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontFamily: family,
                        fontSize: 12.5.sp,
                        fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                        color: selected ? ColorManager.primaryDarker : c.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.clinicTypeLabel,
          style: TextStyle(
            fontFamily: family,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: c.textSecondary,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            option(
              ClinicType.individual,
              Icons.person_outline_rounded,
              l10n.clinicTypeIndividual,
            ),
            SizedBox(width: 8.w),
            option(
              ClinicType.center,
              Icons.apartment_rounded,
              l10n.clinicTypeCenter,
            ),
          ],
        ),
        if (errorText != null) ...[
          SizedBox(height: 5.h),
          Text(
            errorText!,
            style: TextStyle(
              fontFamily: family,
              fontSize: 11.sp,
              color: ColorManager.error,
            ),
          ),
        ],
      ],
    );
  }
}
