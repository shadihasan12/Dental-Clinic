import 'package:dental_clinic_app/core/resources/resources.dart';
import 'package:dental_clinic_app/features/patients/data/models/core_treatment.dart';
import 'package:dental_clinic_app/features/patients/data/models/payment.dart';
import 'package:dental_clinic_app/features/patients/data/models/tooth.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/add/treatment_detail_popup.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/add/treatment_item_card.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/payment/payment_history_popup.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/payment/record_payment_popup.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:intl/intl.dart';

class CaseOverviewWidget extends StatelessWidget {
  final DentalCase dentalCase;
  final List<Tooth> teeth;
  final List<CoreTreatment> coreTreatments;
  final bool isReadOnly;
  final Future<void> Function(double amount, String? notes)? onPaymentRecorded;
  final VoidCallback? onMarkAsFinished;
  final Future<List<Payment>> Function()? onLoadPayments;

  const CaseOverviewWidget({
    super.key,
    required this.dentalCase,
    required this.teeth,
    required this.coreTreatments,
    this.isReadOnly = false,
    this.onPaymentRecorded,
    this.onMarkAsFinished,
    this.onLoadPayments,
  });

  void _showRecordPaymentPopup(BuildContext context) {
    RecordPaymentPopup.show(
      context,
      patientName: dentalCase.patientName,
      caseTitle: dentalCase.title,
      totalCost: dentalCase.totalCost,
      paidAmount: dentalCase.paidAmount,
      onSave: (amount, notes) async {
        await onPaymentRecorded?.call(amount, notes);
      },
    );
  }

  void _showPaymentHistoryPopup(BuildContext context) {
    PaymentHistoryPopup.show(
      context,
      caseTitle: dentalCase.title,
      onLoadPayments: onLoadPayments ?? () async => [],
      totalCost: dentalCase.totalCost,
      paidAmount: dentalCase.paidAmount,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Unified case card
                _buildCaseCard(context),

                SizedBox(height: 12.h),

                // Action buttons (only for in-progress)
                if (!isReadOnly) ...[
                  _buildActionButtons(context),
                  SizedBox(height: 16.h),
                ],

                // Treatments section
                _buildTreatmentsSection(context),

                if (!isReadOnly) SizedBox(height: 80.h),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── Unified case card ────────────────────────────────

  Widget _buildCaseCard(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isInProgress = dentalCase.status.toUpperCase() != 'COMPLETED';
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Title + status badge ──
          Row(
            children: [
              Expanded(
                child: Text(
                  dentalCase.title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w600,
                    color: ColorManager.textPrimary,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isInProgress
                      ? ColorManager.warning.withValues(alpha: 0.1)
                      : ColorManager.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  isInProgress ? l10n.inProgress : l10n.completed,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w600,
                    color: isInProgress
                        ? ColorManager.warning
                        : ColorManager.success,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),

          // ── Case detail rows ──
          _buildInfoRow(
            icon: Icons.calendar_today_outlined,
            label: l10n.startedLabel,
            value: DateFormat('MMM d, yyyy').format(dentalCase.startDate),
          ),
          _buildInfoRow(
            icon: Icons.event_note_outlined,
            label: l10n.totalVisitsLabel,
            value: '${dentalCase.treatmentItems.length}',
          ),
          // Mark as finished row (only in-progress, non-read-only)
          if (!isReadOnly && isInProgress)
            _buildActionRow(
              icon: Icons.check_circle_outline,
              label: l10n.markAsFinished,
              onTap: onMarkAsFinished,
              showDivider: false,
            )
          else
            // End date for completed cases
            if (dentalCase.endDate != null)
              _buildInfoRow(
                icon: Icons.event_available_outlined,
                label: l10n.completed,
                value: DateFormat('MMM d, yyyy').format(dentalCase.endDate!),
                showDivider: false,
              ),

          SizedBox(height: 4.h),
          Divider(color: ColorManager.borderLight),
          SizedBox(height: 8.h),

          // ── Payment section ──
          Row(
            children: [
              _buildStatItem(
                context,
                l10n.totalLabel,
                '\$${dentalCase.totalCost.toStringAsFixed(0)}',
                ColorManager.textPrimary,
              ),
              _buildStatItem(
                context,
                l10n.paidLabel,
                '\$${dentalCase.paidAmount.toStringAsFixed(0)}',
                ColorManager.success,
              ),
              _buildStatItem(
                context,
                l10n.pendingLabel,
                '\$${dentalCase.pendingAmount.toStringAsFixed(0)}',
                ColorManager.warning,
              ),
            ],
          ),

          SizedBox(height: 10.h),

          // View payment history
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
                  l10n.viewPaymentHistory,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w500,
                    color: ColorManager.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Row helpers ──────────────────────────────────────

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    bool showDivider = true,
  }) {
    return Container(
      decoration: showDivider
          ? BoxDecoration(
              border: Border(
                bottom: BorderSide(color: ColorManager.borderLight, width: 1),
              ),
            )
          : null,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          Icon(icon, size: 18.w, color: ColorManager.textTertiary),
          SizedBox(width: 12.w),
          Builder(builder: (context) {
            return Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w400,
                color: ColorManager.textTertiary,
              ),
            );
          }),
          const Spacer(),
          Builder(builder: (context) {
            return Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w400,
                color: ColorManager.textPrimary,
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildActionRow({
    required IconData icon,
    required String label,
    VoidCallback? onTap,
    bool showDivider = true,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: showDivider
            ? BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: ColorManager.borderLight, width: 1),
                ),
              )
            : null,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            Icon(icon, size: 18.w, color: ColorManager.success),
            SizedBox(width: 12.w),
            Builder(builder: (context) {
              return Text(
                label,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: FontWeight.w500,
                  color: ColorManager.success,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String label,
    String value,
    Color valueColor,
  ) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18.sp,
              fontFamily: FontHelper.fontFamily(context),
              fontWeight: FontWeight.w700,
              color: valueColor,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontFamily: FontHelper.fontFamily(context),
              color: ColorManager.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // ── Action buttons ───────────────────────────────────

  Widget _buildActionButtons(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => context.pushNamed(
              AppRoutesNames.addTreatment,
              extra: {
                'patientId': dentalCase.patientId,
                'isInitial': false,
                'caseId': dentalCase.id,
              },
            ),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 13.h),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadiusManager.lg,
                border: Border.all(color: ColorManager.primary),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_circle_outline, size: 18.w, color: ColorManager.primary),
                  SizedBox(width: 6.w),
                  Text(
                    l10n.addTreatmentButton,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: FontHelper.fontFamily(context),
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
              padding: EdgeInsets.symmetric(vertical: 13.h),
               decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadiusManager.lg,
                border: Border.all(color: ColorManager.primary),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.payments_outlined, size: 18.w, color: ColorManager.primary),
                  SizedBox(width: 6.w),
                  Text(
                    l10n.addPaymentButton,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: FontHelper.fontFamily(context),
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

  // ── Treatments section ───────────────────────────────

  Widget _buildTreatmentsSection(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final treatments = isReadOnly
        ? dentalCase.treatmentItems
        : dentalCase.pendingTreatments.take(2).toList();

    final sectionTitle = isReadOnly ? l10n.treatments : l10n.previousTreatments;
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
                fontFamily: FontHelper.fontFamily(context),
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
                  '${l10n.seeAll} (${dentalCase.pendingTreatments.length})',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w500,
                    color: ColorManager.primary,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 12.h),
        if (treatments.isEmpty)
          _buildEmptyTreatments(context)
        else
          ...treatments.asMap().entries.map((entry) {
            final item = entry.value;
            final index = entry.key;
            return Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: TreatmentItemCard(
                item: item,
                index: index,
                teeth: teeth,
                coreTreatments: coreTreatments,
                onTap: () => TreatmentDetailPopup.show(
                  context,
                  item,
                  index,
                  teeth: teeth,
                  coreTreatments: coreTreatments,
                ),
              ),
            );
          }),
      ],
    );
  }

  Widget _buildEmptyTreatments(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: ColorManager.gray50,
        borderRadius: BorderRadiusManager.lg,
      ),
      child: Center(
        child: Text(
          isReadOnly ? l10n.noTreatmentsRecorded : l10n.allTreatmentsCompleted,
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: FontHelper.fontFamily(context),
            color: ColorManager.textSecondary,
          ),
        ),
      ),
    );
  }
}