import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/add/treatment_detail_popup.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/add/treatment_item_card.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/payment/payment_history_popup.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/payment/record_payment_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:intl/intl.dart';

class CaseOverviewWidget extends StatelessWidget {
  final DentalCase dentalCase;
  final bool isReadOnly;
  final VoidCallback? onPaymentRecorded;
  final VoidCallback? onMarkAsFinished;

  const CaseOverviewWidget({
    super.key,
    required this.dentalCase,
    this.isReadOnly = false,
    this.onPaymentRecorded,
    this.onMarkAsFinished,
  });

  void _showRecordPaymentPopup(BuildContext context) {
    RecordPaymentPopup.show(
      context,
      patientName: dentalCase.patientName,
      caseTitle: dentalCase.title,
      totalCost: dentalCase.totalCost,
      paidAmount: dentalCase.paidAmount,
      onSave: (payment) {
        onPaymentRecorded?.call();
      },
    );
  }

  void _showPaymentHistoryPopup(BuildContext context) {
    PaymentHistoryPopup.show(
      context,
      caseTitle: dentalCase.title,
      payments: [
        PaymentRecord(
          id: '1',
          amount: 100,
          method: PaymentMethod.cash,
          date: DateTime.now(),
          note: 'Payment',
        ),
        PaymentRecord(
          id: '2',
          amount: 200,
          method: PaymentMethod.cash,
          date: DateTime.now(),
          note: 'Payment',
        ),
      ],
      totalCost: dentalCase.totalCost,
      paidAmount: dentalCase.paidAmount,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Scrollable content
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Case title (for history view)
                if (isReadOnly) ...[
                  Text(
                    dentalCase.title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: FontFamily.geist,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.textPrimary,
                    ),
                  ),
                  SizedBox(height: 12.h),
                ],

                // Case info card
                _buildCaseInfoCard(context),

                SizedBox(height: 16.h),

                // Action buttons (only for in-progress)
                if (!isReadOnly) ...[
                  _buildActionButtons(context),
                  SizedBox(height: 16.h),
                ],

                // Treatments section
                _buildTreatmentsSection(context),

                // Extra space for bottom button
                if (!isReadOnly) SizedBox(height: 80.h),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => context.pushNamed(
              AppRoutesNames.addTreatment,
              extra: {'dentalCase': dentalCase, 'isInitial': false},
            ),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadiusManager.lg,
                border: Border.all(color: ColorManager.primary),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_circle,
                    size: 18.w,
                    color: ColorManager.primary,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    'Add Treatment',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: FontFamily.geist,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: GestureDetector(
            onTap: () => _showRecordPaymentPopup(context),
            child: Container(
             padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadiusManager.lg,
                border: Border.all(color: ColorManager.primary),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.payments_outlined,
                    size: 18.w,
                    color: ColorManager.primary,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    'Add Payment',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: FontFamily.geist,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCaseInfoCard(BuildContext context) {
    return CustomCard(
      child: Column(
        children: [
          // Stats row
          Row(
            children: [
              _buildStatItem(
                'Total',
                '\$${dentalCase.totalCost.toStringAsFixed(0)}',
                ColorManager.textPrimary,
              ),
              _buildStatItem(
                'Paid',
                '\$${dentalCase.paidAmount.toStringAsFixed(0)}',
                ColorManager.success,
              ),
              _buildStatItem(
                'Pending',
                '\$${dentalCase.pendingAmount.toStringAsFixed(0)}',
                ColorManager.warning,
              ),
            ],
          ),

          SizedBox(height: 8.h),

          // View payments link
          GestureDetector(
            onTap: () => _showPaymentHistoryPopup(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.receipt_long_outlined,
                  size: 14.w,
                  color: ColorManager.primary,
                ),
                SizedBox(width: 4.w),
                Text(
                  'View Payment History',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: FontFamily.geist,
                    fontWeight: FontWeight.w500,
                    color: ColorManager.primary,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 12.h),
          Divider(color: ColorManager.gray200),
          SizedBox(height: 12.h),

          // Date rows
          _buildInfoRow(
            'Started',
            DateFormat('MMM d, yyyy').format(dentalCase.startDate),
          ),
          // Status row
          _buildStatusRow(),
          // Total visits row
          _buildInfoRow('Total Visits', '${dentalCase.treatmentItems.length}'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color valueColor) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18.sp,
              fontFamily: FontFamily.geist,
              fontWeight: FontWeight.w700,
              color: valueColor,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontFamily: FontFamily.geist,
              color: ColorManager.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow() {
    final isInProgress = dentalCase.status.toLowerCase() == 'in progress';

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Status',
            style: TextStyle(
              fontSize: 13.sp,
              fontFamily: FontFamily.geist,
              color: ColorManager.textSecondary,
            ),
          ),
          GestureDetector(
            onTap: (!isReadOnly && isInProgress) ? onMarkAsFinished : null,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: isInProgress
                    ? ColorManager.warning.withValues(alpha: 0.1)
                    : ColorManager.success.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    dentalCase.status,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: FontFamily.geist,
                      fontWeight: FontWeight.w600,
                      color: isInProgress
                          ? ColorManager.warning
                          : ColorManager.success,
                    ),
                  ),
                  if (!isReadOnly && isInProgress) ...[
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.check_circle_outline,
                      size: 14.w,
                      color: ColorManager.warning,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value, {
    VoidCallback? onAction,
    String? actionText,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13.sp,
              fontFamily: FontFamily.geist,
              color: ColorManager.textSecondary,
            ),
          ),
          Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: FontFamily.geist,
                  fontWeight: FontWeight.w500,
                  color: ColorManager.textPrimary,
                ),
              ),
              if (onAction != null) ...[
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: onAction,
                  child: Text(
                    actionText ?? 'Change',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: FontFamily.geist,
                      fontWeight: FontWeight.w500,
                      color: ColorManager.primary,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTreatmentsSection(BuildContext context) {
    final treatments = isReadOnly
        ? dentalCase.treatmentItems
        : dentalCase.pendingTreatments.take(2).toList();

    final sectionTitle = isReadOnly ? 'Treatments' : 'Previous Treatments';
    final showSeeAll = !isReadOnly && dentalCase.pendingTreatments.length > 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sectionTitle,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: FontFamily.geist,
                fontWeight: FontWeight.w600,
                color: ColorManager.textPrimary,
              ),
            ),
            if (showSeeAll)
              GestureDetector(
                onTap: () {
                  // TODO: Navigate to see all pending
                },
                child: Text(
                  'See all (${dentalCase.pendingTreatments.length})',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontFamily: FontFamily.geist,
                    fontWeight: FontWeight.w500,
                    color: ColorManager.primary,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 12.h),
        if (treatments.isEmpty)
          _buildEmptyTreatments()
        else
          ...treatments.asMap().entries.map((entry) {
            final item = entry.value;
            final index = entry.key;
            return Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: TreatmentItemCard(
                item: item,
                index: index,
                onTap: () => TreatmentDetailPopup.show(context, item, index),
              ),
            );
          }),
      ],
    );
  }

  Widget _buildEmptyTreatments() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: ColorManager.gray50,
        borderRadius: BorderRadiusManager.lg,
      ),
      child: Center(
        child: Text(
          isReadOnly ? 'No treatments recorded' : 'All treatments completed!',
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: FontFamily.geist,
            color: ColorManager.textSecondary,
          ),
        ),
      ),
    );
  }
}
