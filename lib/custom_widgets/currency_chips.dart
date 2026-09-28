import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/services/currency/currency_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurrencyChips extends StatelessWidget {
  const CurrencyChips({
    super.key,
    required this.currencies,
    required this.selectedCurrency,
    required this.onSelected,
    this.onPrimary = false,
  });

  final List<CurrencyEntity> currencies;
  final CurrencyEntity? selectedCurrency;
  final ValueChanged<CurrencyEntity> onSelected;

  /// Drawn on a primary-coloured surface: the selected chip turns white so
  /// it still stands out, where a primary tint would vanish into the blue.
  final bool onPrimary;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      children: currencies.map((c) {
        final isSelected = selectedCurrency?.id == c.id;
        final theme = ColorManager.of(context);
        final Color fill;
        final Color border;
        final Color text;
        if (onPrimary) {
          fill = isSelected
              ? ColorManager.white
              : ColorManager.white.withValues(alpha: 0.14);
          border = isSelected
              ? ColorManager.white
              : ColorManager.white.withValues(alpha: 0.35);
          text = isSelected ? ColorManager.primaryDarker : ColorManager.white;
        } else {
          fill = isSelected
              ? ColorManager.primary.withValues(alpha: 0.12)
              : theme.inputBg;
          border = isSelected ? ColorManager.primary : theme.borderLight;
          text = isSelected ? ColorManager.primary : theme.textSecondary;
        }
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => onSelected(c),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: fill,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: border),
              ),
              child: Text(
                c.currencyCode,
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 13.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: text,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
