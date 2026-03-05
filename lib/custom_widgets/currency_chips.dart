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
  });

  final List<CurrencyEntity> currencies;
  final CurrencyEntity? selectedCurrency;
  final ValueChanged<CurrencyEntity> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      children: currencies.map((c) {
        final isSelected = selectedCurrency?.id == c.id;
        return GestureDetector(
          onTap: () => onSelected(c),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isSelected
                  ? ColorManager.primary.withValues(alpha: 0.12)
                  : Colors.grey.shade50,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: isSelected
                    ? ColorManager.primary
                    : Colors.grey.shade200,
              ),
            ),
            child: Text(
              c.currencyCode,
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 13.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? ColorManager.primary : Colors.black54,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
