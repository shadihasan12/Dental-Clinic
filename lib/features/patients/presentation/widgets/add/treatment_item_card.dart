import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/patients/data/models/core_treatment.dart';
import 'package:dental_clinic_app/features/patients/data/models/tooth.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:intl/intl.dart';

class TreatmentItemCard extends StatelessWidget {
  final TreatmentItem item;
  final int index;
  final List<Tooth> teeth;
  final List<CoreTreatment> coreTreatments;
  final VoidCallback? onTap;

  const TreatmentItemCard({
    super.key,
    required this.item,
    required this.index,
    required this.teeth,
    required this.coreTreatments,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
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
                  // Title row
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${l10n.treatment} #${index + 1}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: FontHelper.fontFamily(context),
                            fontWeight: FontWeight.w600,
                            color: ColorManager.textPrimary,
                          ),
                        ),
                      ),
                      if (item.completedAt != null) // Or created_at
                        Text(
                          DateFormat('MMM d').format(item.completedAt!),
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontFamily: FontHelper.fontFamily(context),
                            color: ColorManager.textSecondary,
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
                      fontFamily: FontHelper.fontFamily(context),
                      color: ColorManager.textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Treatment types
                  if (item.treatmentTypes.isNotEmpty) ...[
                    SizedBox(height: 10.h),
                    Wrap(
                      spacing: 4.w,
                      runSpacing: 4.h,
                      children: item.treatmentTypes
                          .map((id) => _buildTag(context, _treatmentDisplayName(id)))
                          .toList(),
                    ),
                    SizedBox(height: 10.h),
                  ],

                  // Selected teeth
                  if (item.selectedTeeth.isNotEmpty) ...[
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(
                          Icons.call_to_action_sharp, // TODO : Replace with the correct icon
                          size: 14.w,
                          color: ColorManager.textTertiary,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${l10n.teeth}: ${_teethDisplayText()}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: FontHelper.fontFamily(context),
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
                        Icon(
                          Icons.attach_file,
                          size: 14.w,
                          color: ColorManager.textTertiary,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${item.attachments.length} attachment(s)',
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontFamily: FontHelper.fontFamily(context),
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

  String _treatmentDisplayName(String id) {
    try {
      return coreTreatments.firstWhere((t) => t.id == id).displayName;
    } catch (_) {
      return id;
    }
  }

  String _teethDisplayText() {
    return item.selectedTeeth.map((id) {
      try {
        return teeth.firstWhere((t) => t.id == id).universalCode;
      } catch (_) {
        return id;
      }
    }).join(', ');
  }

  Widget _buildTag(BuildContext context, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: ColorManager.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.sp,
          fontFamily: FontHelper.fontFamily(context),
          fontWeight: FontWeight.w500,
          color: ColorManager.primary,
        ),
      ),
    );
  }
}