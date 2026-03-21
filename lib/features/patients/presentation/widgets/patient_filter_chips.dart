import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';

/// Horizontal filter chip list for patient filtering
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
      height: 36.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = selectedFilter == filter;
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: FilterChip(
              label: filter,
              isSelected: isSelected,
              onTap: () => onFilterSelected(filter),
            ),
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? ColorManager.primary : ColorManager.of(context).cardBg,
          borderRadius: BorderRadius.circular(20.r),
          border: isSelected ? null : Border.all(color: ColorManager.of(context).divider),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontFamily: FontHelper.fontFamily(context),
            color: isSelected ? ColorManager.white : ColorManager.of(context).textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
