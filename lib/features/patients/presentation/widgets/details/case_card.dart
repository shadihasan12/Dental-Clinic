import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';

class CaseCard extends StatelessWidget {
  final String id;
  final String title;
  final String startDate;
  final String? endDate;
  final String status;
  final double totalCost;
  final double paidAmount;
  final double pendingAmount;
  final int totalTreatments;
  final VoidCallback? onViewMore;

  const CaseCard({
    super.key,
    required this.id,
    required this.title,
    required this.startDate,
    this.endDate,
    required this.status,
    required this.totalCost,
    required this.paidAmount,
    required this.pendingAmount,
    this.totalTreatments = 0,
    this.onViewMore,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: 12.h),
          _buildPaymentInfo(),
          SizedBox(height: 12.h),
          // Treatments count
          Row(
            children: [
              Icon(Icons.medical_services_outlined, size: 16.w, color: ColorManager.textSecondary),
              SizedBox(width: 6.w),
              Text(
                '$totalTreatments treatment(s)',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: FontFamily.geist,
                  color: ColorManager.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          _buildViewMoreButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: FontFamily.geist,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.textPrimary,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Started: $startDate${endDate != null ? '\nEnded: $endDate' : ''}',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: FontFamily.geist,
                  color: ColorManager.textSecondary,
                ),
              ),
            ],
          ),
        ),
        StatusBadge(
          label: status,
          type: _getStatusType(status),
        ),
      ],
    );
  }

  Widget _buildPaymentInfo() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorManager.gray50,
        borderRadius: BorderRadiusManager.lg,
      ),
      child: Column(
        children: [
          _PaymentRow(label: 'Total Cost', value: '\$${totalCost.toStringAsFixed(0)}'),
          SizedBox(height: 8.h),
          _PaymentRow(label: 'Paid', value: '\$${paidAmount.toStringAsFixed(0)}', valueColor: ColorManager.success),
          if (pendingAmount > 0) ...[
            SizedBox(height: 8.h),
            _PaymentRow(label: 'Pending', value: '\$${pendingAmount.toStringAsFixed(0)}', valueColor: ColorManager.warning),
          ],
        ],
      ),
    );
  }

  Widget _buildViewMoreButton() {
    return GestureDetector(
      onTap: onViewMore,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: ColorManager.primary,
          borderRadius: BorderRadiusManager.lg,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'View Details',
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontFamily.geist,
                fontWeight: FontWeight.w500,
                color: ColorManager.white,
              ),
            ),
            SizedBox(width: 6.w),
            Icon(Icons.arrow_forward, size: 16.w, color: ColorManager.white),
          ],
        ),
      ),
    );
  }

  StatusType _getStatusType(String status) {
    switch (status) {
      case 'Done':
        return StatusType.completed;
      case 'In Progress':
        return StatusType.success;
      default:
        return StatusType.pending;
    }
  }
}

class _PaymentRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _PaymentRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyleManager.bodyMedium.copyWith(
            color: ColorManager.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyleManager.bodyMedium.copyWith(
            color: valueColor ?? ColorManager.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}