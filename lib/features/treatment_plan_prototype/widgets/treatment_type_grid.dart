import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/prototype_models.dart';

class TreatmentTypeGrid extends StatelessWidget {
  final List<TreatmentTypeInfo> types;
  final ValueChanged<TreatmentTypeInfo> onSelect;
  final Set<String>? selectedIds;

  const TreatmentTypeGrid({
    super.key,
    required this.types,
    required this.onSelect,
    this.selectedIds,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10.h,
        crossAxisSpacing: 10.w,
        childAspectRatio: 1.0,
      ),
      itemCount: types.length,
      itemBuilder: (context, index) {
        final type = types[index];
        final isSelected = selectedIds?.contains(type.id) ?? false;

        return GestureDetector(
          onTap: () => onSelect(type),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: isSelected
                  ? ColorManager.primary.withValues(alpha: 0.1)
                  : ColorManager.gray50,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isSelected
                    ? ColorManager.primary
                    : ColorManager.borderLight,
                width: isSelected ? 1.5 : 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? ColorManager.primary.withValues(alpha: 0.15)
                        : ColorManager.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    type.icon,
                    size: 20.w,
                    color: isSelected
                        ? ColorManager.primary
                        : ColorManager.textSecondary,
                  ),
                ),
                SizedBox(height: 6.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Text(
                    type.nameEn,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: isSelected
                          ? ColorManager.primary
                          : ColorManager.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
