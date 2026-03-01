import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/patients/data/models/core_treatment.dart';
import 'package:dental_clinic_app/features/patients/data/models/tooth.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/add/tooth_chart.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:intl/intl.dart';

class TreatmentDetailPopup extends StatelessWidget {
  final TreatmentItem item;
  final int index;
  final List<Tooth> teeth;
  final List<CoreTreatment> coreTreatments;

  const TreatmentDetailPopup({
    super.key,
    required this.item,
    required this.index,
    required this.teeth,
    required this.coreTreatments,
  });

  static Future<void> show(
    BuildContext context,
    TreatmentItem item,
    int index, {
    required List<Tooth> teeth,
    required List<CoreTreatment> coreTreatments,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => TreatmentDetailPopup(
        item: item,
        index: index,
        teeth: teeth,
        coreTreatments: coreTreatments,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: ColorManager.gray300,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          // Content
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  _buildHeader(context),

                  SizedBox(height: 20.h),

                  // Description
                  if (item.description.isNotEmpty) ...[
                    _buildSection(context, AppLocalizations.of(context)!.description, item.description),
                  ],

                  // Treatment types
                  if (item.treatmentTypes.isNotEmpty) ...[
                    SizedBox(height: 16.h),
                    _buildTreatmentTypes(context),
                  ],

                  // Teeth
                  if (item.selectedTeeth.isNotEmpty) ...[
                    SizedBox(height: 16.h),
                    _buildTeethSection(context),
                  ],

                  // Attachments
                  if (item.attachments.isNotEmpty) ...[
                    SizedBox(height: 16.h),
                    _buildAttachments(context),
                  ],

                  // Dates
                  SizedBox(height: 16.h),
                  _buildDates(context),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            color: item.isDone
                ? ColorManager.success.withValues(alpha: 0.1)
                : ColorManager.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '${index + 1}',
              style: TextStyle(
                fontSize: 20.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w700,
                color: item.isDone
                    ? ColorManager.success
                    : ColorManager.primary,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${AppLocalizations.of(context)!.treatment} ${index + 1}',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: FontWeight.w600,
                  color: ColorManager.textPrimary,
                ),
              ),
              Text(
                '${AppLocalizations.of(context)!.created} ${DateFormat('MMM d, yyyy').format(item.createdAt)}',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  color: ColorManager.textSecondary,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.close, color: ColorManager.textSecondary),
        ),
      ],
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: FontHelper.fontFamily(context),
            fontWeight: FontWeight.w500,
            color: ColorManager.textSecondary,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          content,
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: FontHelper.fontFamily(context),
            color: ColorManager.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildTreatmentTypes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.treatmentTypes,
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: FontHelper.fontFamily(context),
            fontWeight: FontWeight.w500,
            color: ColorManager.textSecondary,
          ),
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: item.treatmentTypes.map((id) {
            String displayName;
            try {
              displayName = coreTreatments.firstWhere((t) => t.id == id).displayName;
            } catch (_) {
              displayName = id;
            }
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: ColorManager.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                displayName,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: FontWeight.w500,
                  color: ColorManager.primary,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTeethSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.treatedTeeth,
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: FontHelper.fontFamily(context),
            fontWeight: FontWeight.w500,
            color: ColorManager.textSecondary,
          ),
        ),
        SizedBox(height: 8.h),
        ToothChart(
          teeth: teeth,
          selectedTeeth: item.selectedTeeth,
          enabled: false,
          aspectRatio: 1.1,
        ),
      ],
    );
  }

  Widget _buildAttachments(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.attachments,
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: FontHelper.fontFamily(context),
            fontWeight: FontWeight.w500,
            color: ColorManager.textSecondary,
          ),
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: item.attachments.map((attachment) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: ColorManager.gray100,
                borderRadius: BorderRadiusManager.lg,
                border: Border.all(color: ColorManager.gray200),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.insert_drive_file,
                    size: 16.w,
                    color: ColorManager.textSecondary,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    attachment,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      color: ColorManager.textSecondary,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDates(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorManager.gray50,
        borderRadius: BorderRadiusManager.lg,
      ),
      child: Column(
        children: [
          _buildDateRow(context, AppLocalizations.of(context)!.created, item.createdAt),
          if (item.completedAt != null) ...[
            SizedBox(height: 8.h),
            _buildDateRow(context, AppLocalizations.of(context)!.completed, item.completedAt!),
          ],
        ],
      ),
    );
  }

  Widget _buildDateRow(BuildContext context, String label, DateTime date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: FontHelper.fontFamily(context),
            color: ColorManager.textSecondary,
          ),
        ),
        Text(
          DateFormat('MMM d, yyyy • h:mm a').format(date),
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: FontHelper.fontFamily(context),
            fontWeight: FontWeight.w500,
            color: ColorManager.textPrimary,
          ),
        ),
      ],
    );
  }
}
