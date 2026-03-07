import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/prototype_models.dart';

class TreatmentPlanCard extends StatelessWidget {
  final PlannedTreatment treatment;
  final bool showCheckbox;
  final bool removeBorder;
  final ValueChanged<bool?>? onStatusChanged;
  final VoidCallback? onTap;

  const TreatmentPlanCard({
    super.key,
    required this.treatment,
    this.showCheckbox = false,
    this.removeBorder = false,
    this.onStatusChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = treatment.status == TreatmentPlanStatus.completed;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: removeBorder
            ? null
            : BoxDecoration(
                color: isCompleted
                    ? ColorManager.success.withValues(alpha: 0.04)
                    : ColorManager.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: isCompleted
                      ? ColorManager.success.withValues(alpha: 0.2)
                      : ColorManager.borderLight,
                ),
              ),
        child: Row(
          children: [
            // Status indicator or checkbox
            if (showCheckbox)
              GestureDetector(
                onTap: () => onStatusChanged?.call(!isCompleted),
                child: Container(
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted
                        ? ColorManager.success
                        : Colors.transparent,
                    border: Border.all(
                      color: isCompleted
                          ? ColorManager.success
                          : ColorManager.borderLight,
                      width: 2,
                    ),
                  ),
                  child: isCompleted
                      ? Icon(Icons.check, size: 14.w, color: Colors.white)
                      : null,
                ),
              )
            else
              Container(
                width: 6.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: _statusColor,
                  borderRadius: BorderRadius.circular(3.r),
                ),
              ),
            SizedBox(width: 12.w),

            // Treatment icon
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: _statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                treatment.type.icon,
                size: 20.w,
                color: _statusColor,
              ),
            ),
            SizedBox(width: 12.w),

            // Treatment details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    treatment.type.nameEn,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      fontWeight: FontWeight.w500,
                      color: isCompleted
                          ? ColorManager.textTertiary
                          : ColorManager.textPrimary,
                      decoration:
                          isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  if (treatment.toothNumber != null)
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 12.w,
                          color: ColorManager.textTertiary,
                        ),
                        SizedBox(width: 3.w),
                        Text(
                          'Tooth ${treatment.toothNumber}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: FontHelper.fontFamily(context),
                            color: ColorManager.textTertiary,
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Text(
                          'General',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: FontHelper.fontFamily(context),
                            color: ColorManager.textTertiary,
                          ),
                        ),
                        if (treatment.visitNotes.isNotEmpty) ...[
                          SizedBox(width: 6.w),
                          Icon(
                            Icons.sticky_note_2_outlined,
                            size: 12.w,
                            color: ColorManager.primary,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            '${treatment.visitNotes.length}',
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontFamily: FontHelper.fontFamily(context),
                              fontWeight: FontWeight.w500,
                              color: ColorManager.primary,
                            ),
                          ),
                        ],
                      ],
                    ),
                ],
              ),
            ),

            _buildStatusBadge(context),
          ],
        ),
      ),
    );
  }

  Color get _statusColor {
    switch (treatment.status) {
      case TreatmentPlanStatus.completed:
        return ColorManager.success;
      case TreatmentPlanStatus.inProgress:
        return ColorManager.warning;
      case TreatmentPlanStatus.planned:
        return ColorManager.primary;
    }
  }

  Widget _buildStatusBadge(BuildContext context) {
    final label = switch (treatment.status) {
      TreatmentPlanStatus.completed => 'Done',
      TreatmentPlanStatus.inProgress => 'In Progress',
      TreatmentPlanStatus.planned => 'Planned',
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: _statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.sp,
          fontFamily: FontHelper.fontFamily(context),
          fontWeight: FontWeight.w500,
          color: _statusColor,
        ),
      ),
    );
  }
}
