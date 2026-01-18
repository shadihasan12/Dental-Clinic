import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';

/// Interactive tooth chart for selecting teeth
/// Uses standard dental numbering (1-32 for adults)
class ToothChart extends StatelessWidget {
  final List<int> selectedTeeth;
  final ValueChanged<List<int>>? onSelectionChanged;
  final bool enabled;

  const ToothChart({
    super.key,
    this.selectedTeeth = const [],
    this.onSelectionChanged,
    this.enabled = true,
  });

  // Upper jaw: 1-16 (right to left from patient's perspective)
  // Lower jaw: 17-32 (left to right from patient's perspective)
  static const upperTeeth = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16];
  static const lowerTeeth = [32, 31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17];

  void _toggleTooth(int toothNumber) {
    if (!enabled || onSelectionChanged == null) return;
    
    final newSelection = List<int>.from(selectedTeeth);
    if (newSelection.contains(toothNumber)) {
      newSelection.remove(toothNumber);
    } else {
      newSelection.add(toothNumber);
    }
    onSelectionChanged!(newSelection);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.gray50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.gray200),
      ),
      child: Column(
        children: [
          // Label
          Text(
            'Select Teeth',
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: FontFamily.geist,
              fontWeight: FontWeight.w500,
              color: ColorManager.textPrimary,
            ),
          ),
          SizedBox(height: 12.h),
          
          // Upper jaw label
          Text(
            'Upper Jaw',
            style: TextStyle(
              fontSize: 10.sp,
              fontFamily: FontFamily.geist,
              color: ColorManager.textSecondary,
            ),
          ),
          SizedBox(height: 4.h),
          
          // Upper teeth row
          _buildTeethRow(upperTeeth),
          
          SizedBox(height: 8.h),
          
          // Divider representing gum line
          Container(
            height: 2.h,
            margin: EdgeInsets.symmetric(horizontal: 8.w),
            decoration: BoxDecoration(
              color: ColorManager.gray300,
              borderRadius: BorderRadius.circular(1.r),
            ),
          ),
          
          SizedBox(height: 8.h),
          
          // Lower teeth row
          _buildTeethRow(lowerTeeth),
          
          SizedBox(height: 4.h),
          
          // Lower jaw label
          Text(
            'Lower Jaw',
            style: TextStyle(
              fontSize: 10.sp,
              fontFamily: FontFamily.geist,
              color: ColorManager.textSecondary,
            ),
          ),
          
          if (selectedTeeth.isNotEmpty) ...[
            SizedBox(height: 12.h),
            _buildSelectedTeethInfo(),
          ],
        ],
      ),
    );
  }

  Widget _buildTeethRow(List<int> teeth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: teeth.map((toothNum) => _buildTooth(toothNum)).toList(),
    );
  }

  Widget _buildTooth(int toothNumber) {
    final isSelected = selectedTeeth.contains(toothNumber);
    
    return GestureDetector(
      onTap: () => _toggleTooth(toothNumber),
      child: Container(
        width: 18.w,
        height: 24.h,
        margin: EdgeInsets.symmetric(horizontal: 1.w),
        decoration: BoxDecoration(
          color: isSelected ? ColorManager.primary : ColorManager.white,
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(
            color: isSelected ? ColorManager.primary : ColorManager.gray300,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            toothNumber.toString(),
            style: TextStyle(
              fontSize: 8.sp,
              fontFamily: FontFamily.geist,
              fontWeight: FontWeight.w500,
              color: isSelected ? ColorManager.white : ColorManager.textSecondary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedTeethInfo() {
    final sortedTeeth = List<int>.from(selectedTeeth)..sort();
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: ColorManager.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle,
            size: 16.w,
            color: ColorManager.primary,
          ),
          SizedBox(width: 8.w),
          Flexible(
            child: Text(
              'Selected: ${sortedTeeth.join(", ")}',
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: FontFamily.geist,
                fontWeight: FontWeight.w500,
                color: ColorManager.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}