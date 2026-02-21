import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:intl/intl.dart';

class CaseHistoryCard extends StatelessWidget {
  final DentalCase dentalCase;
  final VoidCallback? onTap;

  const CaseHistoryCard({
    super.key,
    required this.dentalCase,
    this.onTap,
  });

  Color get _statusColor {
    switch (dentalCase.status.toLowerCase()) {
      case 'completed':
      case 'done':
        return ColorManager.success;
      case 'in progress':
        return ColorManager.warning;
      case 'cancelled':
        return ColorManager.error;
      default:
        return ColorManager.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadiusManager.lg,
          border: Border.all(color: ColorManager.gray200),
        ),
        child: Row(
          children: [
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    dentalCase.title,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontFamily: FontFamily.geist,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.textPrimary,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  // Date and visits row
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 14.w,
                        color: ColorManager.textTertiary,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        DateFormat('MMM d, yyyy').format(dentalCase.startDate),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: FontFamily.geist,
                          color: ColorManager.textSecondary,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Icon(
                        Icons.medical_services_outlined,
                        size: 14.w,
                        color: ColorManager.textTertiary,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${dentalCase.treatmentItems.length} ${l10n.visits}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: FontFamily.geist,
                          color: ColorManager.textSecondary,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8.h),

                  // Status badge
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: _statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      dentalCase.status,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontFamily: FontFamily.geist,
                        fontWeight: FontWeight.w600,
                        color: _statusColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Arrow
            Icon(
              Icons.chevron_right,
              size: 24.w,
              color: ColorManager.textTertiary,
            ),
          ],
        ),
      ),
    );
  }
}