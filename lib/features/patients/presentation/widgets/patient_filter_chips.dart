import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';

/// Horizontal filter rail. Switchable chips are the 20r shape; the selected
/// one is a primary tint with a primary hairline rather than a solid fill,
/// so it never outweighs the New button beside it.
class PatientFilterChips extends StatelessWidget {
  const PatientFilterChips({
    super.key,
    required this.filters,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  final List<String> filters;
  final String selectedFilter;
  final ValueChanged<String> onFilterSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, i) => SizedBox(width: 6.w),
        itemBuilder: (context, index) {
          final filter = filters[index];
          return FilterChip(
            label: filter,
            isSelected: selectedFilter == filter,
            onTap: () => onFilterSelected(filter),
          );
        },
      ),
    );
  }
}

/// Individual filter chip button
class FilterChip extends StatelessWidget {
  const FilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final radius = BorderRadius.circular(20.r);

    return Material(
      color: isSelected
          ? ColorManager.primary.withValues(alpha: 0.12)
          : c.cardBg,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(
              color: isSelected ? ColorManager.primary : c.borderLight,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11.5.sp,
              fontFamily: FontHelper.fontFamily(context),
              color: isSelected
                  ? ColorManager.primaryDarker
                  : c.textSecondary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
