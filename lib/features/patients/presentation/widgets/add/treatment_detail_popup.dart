import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/add/tooth_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:intl/intl.dart';

class TreatmentDetailPopup extends StatelessWidget {
  final TreatmentItem item;
  final int index;

  const TreatmentDetailPopup({
    super.key,
    required this.item,
    required this.index,
  });

  static Future<void> show(BuildContext context, TreatmentItem item, int index) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => TreatmentDetailPopup(item: item, index: index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.85),
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
                  
                  // Status badge
                  _buildStatusBadge(),
                  
                  SizedBox(height: 16.h),
                  
                  // Description
                  _buildSection('Description', item.description),
                  
                  // Treatment types
                  if (item.treatmentTypes.isNotEmpty) ...[
                    SizedBox(height: 16.h),
                    _buildTreatmentTypes(),
                  ],
                  
                  // Teeth
                  if (item.selectedTeeth.isNotEmpty) ...[
                    SizedBox(height: 16.h),
                    _buildTeethSection(),
                  ],
                  
                  // Attachments
                  if (item.attachments.isNotEmpty) ...[
                    SizedBox(height: 16.h),
                    _buildAttachments(),
                  ],
                  
                  // Dates
                  SizedBox(height: 16.h),
                  _buildDates(),
                  
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
                fontFamily: FontFamily.geist,
                fontWeight: FontWeight.w700,
                color: item.isDone ? ColorManager.success : ColorManager.primary,
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
                'Treatment #${index + 1}',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: FontFamily.geist,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.textPrimary,
                ),
              ),
              Text(
                'Created ${DateFormat('MMM d, yyyy').format(item.createdAt)}',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: FontFamily.geist,
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

  Widget _buildStatusBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: item.isDone 
            ? ColorManager.success.withValues(alpha: 0.1)
            : ColorManager.warning.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            item.isDone ? Icons.check_circle : Icons.schedule,
            size: 16.w,
            color: item.isDone ? ColorManager.success : ColorManager.warning,
          ),
          SizedBox(width: 6.w),
          Text(
            item.isDone ? 'Completed' : 'Pending',
            style: TextStyle(
              fontSize: 12.sp,
              fontFamily: FontFamily.geist,
              fontWeight: FontWeight.w600,
              color: item.isDone ? ColorManager.success : ColorManager.warning,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: FontFamily.geist,
            fontWeight: FontWeight.w500,
            color: ColorManager.textSecondary,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          content,
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: FontFamily.geist,
            color: ColorManager.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildTreatmentTypes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Treatment Types',
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: FontFamily.geist,
            fontWeight: FontWeight.w500,
            color: ColorManager.textSecondary,
          ),
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: item.treatmentTypes.map((type) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: ColorManager.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(type.icon, size: 16.w, color: ColorManager.primary),
                  SizedBox(width: 6.w),
                  Text(
                    type.label,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: FontFamily.geist,
                      fontWeight: FontWeight.w500,
                      color: ColorManager.primary,
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

  Widget _buildTeethSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Treated Teeth',
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: FontFamily.geist,
            fontWeight: FontWeight.w500,
            color: ColorManager.textSecondary,
          ),
        ),
        SizedBox(height: 8.h),
        ToothChart(
          selectedTeeth: item.selectedTeeth,
          enabled: false,
        ),
      ],
    );
  }

  Widget _buildAttachments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Attachments',
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: FontFamily.geist,
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
                  Icon(Icons.insert_drive_file, size: 16.w, color: ColorManager.textSecondary),
                  SizedBox(width: 6.w),
                  Text(
                    attachment,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: FontFamily.geist,
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

  Widget _buildDates() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorManager.gray50,
        borderRadius: BorderRadiusManager.lg,
      ),
      child: Column(
        children: [
          _buildDateRow('Created', item.createdAt),
          if (item.completedAt != null) ...[
            SizedBox(height: 8.h),
            _buildDateRow('Completed', item.completedAt!),
          ],
        ],
      ),
    );
  }

  Widget _buildDateRow(String label, DateTime date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: FontFamily.geist,
            color: ColorManager.textSecondary,
          ),
        ),
        Text(
          DateFormat('MMM d, yyyy • h:mm a').format(date),
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: FontFamily.geist,
            fontWeight: FontWeight.w500,
            color: ColorManager.textPrimary,
          ),
        ),
      ],
    );
  }
}