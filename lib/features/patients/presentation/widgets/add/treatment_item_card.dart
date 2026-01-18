import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:intl/intl.dart';

class TreatmentItemCard extends StatelessWidget {
  final TreatmentItem item;
  final int index;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onToggleDone;
  final bool showCheckbox;

  const TreatmentItemCard({
    super.key,
    required this.item,
    required this.index,
    this.onTap,
    this.onToggleDone,
    this.showCheckbox = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: item.isDone 
              ? ColorManager.success.withValues(alpha: 0.05)
              : ColorManager.white,
          borderRadius: BorderRadiusManager.lg,
          border: Border.all(
            color: item.isDone ? ColorManager.success : ColorManager.gray200,
          ),
        ),
        child: Row(
          children: [
            // Checkbox or number indicator
            if (showCheckbox)
              _buildCheckbox()
            else
              _buildNumberIndicator(),
            
            SizedBox(width: 12.w),
            
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title row
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Treatment #${index + 1}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: FontFamily.geist,
                            fontWeight: FontWeight.w600,
                            color: ColorManager.textPrimary,
                            decoration: item.isDone 
                                ? TextDecoration.lineThrough 
                                : null,
                          ),
                        ),
                      ),
                      if (item.isDone && item.completedAt != null)
                        Text(
                          DateFormat('MMM d').format(item.completedAt!),
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontFamily: FontFamily.geist,
                            color: ColorManager.success,
                          ),
                        ),
                    ],
                  ),
                  
                  SizedBox(height: 4.h),
                  
                  // Description
                  Text(
                    item.description,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: FontFamily.geist,
                      color: ColorManager.textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  // Treatment types
                  if (item.treatmentTypes.isNotEmpty) ...[
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 4.w,
                      runSpacing: 4.h,
                      children: item.treatmentTypes.map((type) => _buildTag(type.label)).toList(),
                    ),
                  ],
                  
                  // Selected teeth
                  if (item.selectedTeeth.isNotEmpty) ...[
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(Icons.document_scanner_outlined, size: 14.w, color: ColorManager.textTertiary),
                        SizedBox(width: 4.w),
                        Text(
                          'Teeth: ${item.selectedTeeth.join(", ")}',
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontFamily: FontFamily.geist,
                            color: ColorManager.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ],
                  
                  // Attachments indicator
                  if (item.attachments.isNotEmpty) ...[
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(Icons.attach_file, size: 14.w, color: ColorManager.textTertiary),
                        SizedBox(width: 4.w),
                        Text(
                          '${item.attachments.length} attachment(s)',
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontFamily: FontFamily.geist,
                            color: ColorManager.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            
            // Arrow indicator
            Icon(
              Icons.chevron_right,
              size: 20.w,
              color: ColorManager.textTertiary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckbox() {
    return GestureDetector(
      onTap: () => onToggleDone?.call(!item.isDone),
      child: Container(
        width: 24.w,
        height: 24.w,
        decoration: BoxDecoration(
          color: item.isDone ? ColorManager.success : ColorManager.white,
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(
            color: item.isDone ? ColorManager.success : ColorManager.gray300,
            width: 2,
          ),
        ),
        child: item.isDone
            ? Icon(Icons.check, size: 16.w, color: ColorManager.white)
            : null,
      ),
    );
  }

  Widget _buildNumberIndicator() {
    return Container(
      width: 28.w,
      height: 28.w,
      decoration: BoxDecoration(
        color: item.isDone ? ColorManager.success : ColorManager.primary,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '${index + 1}',
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: FontFamily.geist,
            fontWeight: FontWeight.w600,
            color: ColorManager.white,
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: ColorManager.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.sp,
          fontFamily: FontFamily.geist,
          fontWeight: FontWeight.w500,
          color: ColorManager.primary,
        ),
      ),
    );
  }
}