import 'package:dental_clinic_app/core/resources/resources.dart';
import 'package:dental_clinic_app/features/patients/data/models/core_treatment.dart';
import 'package:dental_clinic_app/features/patients/data/models/payment.dart';
import 'package:dental_clinic_app/features/patients/data/models/tooth.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_plan_models.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/confirm_delete_dialog.dart';
import 'edit_costs_sheet.dart';
import 'plan_summary_header.dart';
import 'treatment_details_sheet.dart';
import 'treatment_plan_card.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/payment/payment_history_popup.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/payment/record_payment_popup.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CaseOverviewWidget extends StatefulWidget {
  final DentalCase dentalCase;
  final List<Tooth> teeth;
  final List<CoreTreatment> coreTreatments;
  final bool isReadOnly;
  final Future<void> Function(double amount, String? notes)? onPaymentRecorded;
  final VoidCallback? onMarkAsFinished;
  final Future<List<Payment>> Function()? onLoadPayments;
  final VoidCallback? onAddTreatment;
  final void Function(PlannedTreatment treatment)? onMarkTreatmentFinished;
  final void Function(PlannedTreatment treatment, List<VisitNote> notes)?
      onNotesUpdated;
  final void Function(PlannedTreatment treatment)? onRemoveTreatment;
  final Future<void> Function(double totalCost, String? totalCostCurrencyId,
      double labFees, String? labFeesCurrencyId)? onEditCosts;

  const CaseOverviewWidget({
    super.key,
    required this.dentalCase,
    required this.teeth,
    required this.coreTreatments,
    this.isReadOnly = false,
    this.onPaymentRecorded,
    this.onMarkAsFinished,
    this.onLoadPayments,
    this.onAddTreatment,
    this.onMarkTreatmentFinished,
    this.onNotesUpdated,
    this.onRemoveTreatment,
    this.onEditCosts,
  });

  @override
  State<CaseOverviewWidget> createState() => _CaseOverviewWidgetState();
}

class _CaseOverviewWidgetState extends State<CaseOverviewWidget> {
  late List<PlannedTreatment> _planned;

  @override
  void initState() {
    super.initState();
    _planned = _mapToPlannedTreatments();
  }

  @override
  void didUpdateWidget(covariant CaseOverviewWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.dentalCase != widget.dentalCase) {
      _planned = _mapToPlannedTreatments();
    }
  }

  /// Maps API [TreatmentItem] list → prototype [PlannedTreatment] list
  List<PlannedTreatment> _mapToPlannedTreatments() {
    final result = <PlannedTreatment>[];

    for (final item in widget.dentalCase.treatmentItems) {
      final toothCodes = item.selectedTeeth.map((id) {
        final match = widget.teeth.where((t) => t.id == id);
        return match.isNotEmpty ? match.first.universalCode : null;
      }).whereType<String>().toList();

      for (final typeId in item.treatmentTypes) {
        final ct = widget.coreTreatments.where((t) => t.id == typeId);
        final typeInfo = ct.isNotEmpty
            ? TreatmentTypeInfo(
                id: ct.first.id,
                name: ct.first.name,
                icon: Icons.medical_services_outlined,
                categoryId: ct.first.category.id,
                categoryName: ct.first.category.name,
              )
            : TreatmentTypeInfo(
                id: typeId,
                name: typeId,
                icon: Icons.medical_services_outlined,
                categoryId: '',
                categoryName: '',
              );

        final visitNotes = item.notes.map((n) {
          final dateStr = n['date'] ?? '';
          final date = dateStr.isNotEmpty
              ? DateTime.tryParse(dateStr) ?? DateTime.now()
              : DateTime.now();
          return VisitNote(date: date, text: n['note'] ?? '');
        }).toList();

        result.add(PlannedTreatment(
          id: '${item.id}_$typeId',
          type: typeInfo,
          toothNumber: toothCodes.isNotEmpty ? toothCodes.join(', ') : null,
          status: item.isDone
              ? TreatmentPlanStatus.completed
              : TreatmentPlanStatus.planned,
          notes: item.description,
          visitNotes: visitNotes,
        ));
      }
    }

    return result;
  }

  TreatmentPlan _buildTreatmentPlan() {
    return TreatmentPlan(
      id: widget.dentalCase.id,
      patientName: widget.dentalCase.patientName,
      treatments: _planned,
      createdAt: widget.dentalCase.startDate,
      totalCost: widget.dentalCase.totalCost,
      labFees: widget.dentalCase.labFees,
      paid: widget.dentalCase.paidAmount,
    );
  }

  void _showRecordPaymentPopup(BuildContext context) {
    RecordPaymentPopup.show(
      context,
      patientName: widget.dentalCase.patientName,
      caseTitle: widget.dentalCase.title,
      totalCost: widget.dentalCase.totalCost,
      paidAmount: widget.dentalCase.paidAmount,
      onSave: (amount, notes) async {
        await widget.onPaymentRecorded?.call(amount, notes);
      },
    );
  }

  void _showPaymentHistoryPopup(BuildContext context) {
    PaymentHistoryPopup.show(
      context,
      caseTitle: widget.dentalCase.title,
      onLoadPayments: widget.onLoadPayments ?? () async => [],
      totalCost: widget.dentalCase.totalCost,
      paidAmount: widget.dentalCase.paidAmount,
    );
  }

  void _toggleTreatmentStatus(PlannedTreatment treatment) {
    setState(() {
      if (treatment.status == TreatmentPlanStatus.completed) {
        treatment.status = TreatmentPlanStatus.planned;
        treatment.completedDate = null;
      } else {
        treatment.status = TreatmentPlanStatus.completed;
        treatment.completedDate = DateTime.now();
      }
    });
    widget.onMarkTreatmentFinished?.call(treatment);
  }

  void _showEditCostsSheet(BuildContext context) {
    EditCostsSheet.show(
      context,
      initialTotalCost: widget.dentalCase.totalCost,
      initialLabFees: widget.dentalCase.labFees,
      initialTotalCostCurrencyId: widget.dentalCase.totalCostCurrencyId,
      initialLabFeesCurrencyId: widget.dentalCase.labFeesCurrencyId,
      onSave: (totalCost, totalCostCurrencyId, labFees, labFeesCurrencyId) async {
        await widget.onEditCosts?.call(
          totalCost, totalCostCurrencyId, labFees, labFeesCurrencyId,
        );
      },
    );
  }

  void _showTreatmentDetailsSheet(PlannedTreatment treatment) {
    TreatmentDetailsSheet.show(
      context,
      treatment: treatment,
      teeth: widget.teeth,
      onToggleStatus: (t) => _toggleTreatmentStatus(t),
      onNotesUpdated: (t, updatedNotes) {
        setState(() {
          t.visitNotes
            ..clear()
            ..addAll(updatedNotes);
        });
        widget.onNotesUpdated?.call(t, updatedNotes);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final plan = _buildTreatmentPlan();

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Plan summary header
                PlanSummaryHeader(
                  plan: plan,
                  onTap: (!widget.isReadOnly && widget.onEditCosts != null)
                      ? () => _showEditCostsSheet(context)
                      : null,
                  onViewPaymentHistory: () => _showPaymentHistoryPopup(context),
                ),

                SizedBox(height: 12.h),

                // Action buttons (only for in-progress)
                if (!widget.isReadOnly) ...[
                  _buildActionButtons(context),
                  SizedBox(height: 16.h),
                ],

                // Treatments section
                _buildTreatmentsSection(context),

                if (!widget.isReadOnly) SizedBox(height: 16.h),
              ],
            ),
          ),
        ),

        // Sticky "Mark Case as Finished" button at bottom
        if (!widget.isReadOnly && widget.onMarkAsFinished != null)
          Container(
            padding: EdgeInsets.fromLTRB(
              16.w,
              12.h,
              16.w,
              MediaQuery.of(context).viewPadding.bottom + 12.h,
            ),
            decoration: BoxDecoration(
              color: ColorManager.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: GestureDetector(
              onTap: widget.onMarkAsFinished,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadiusManager.lg,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle_outline, size: 18.w, color: ColorManager.white),
                    SizedBox(width: 8.w),
                    Text(
                      AppLocalizations.of(context)!.markAsFinished,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        fontWeight: FontWeight.w600,
                        color: ColorManager.white,
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

  // ── Action buttons ───────────────────────────────────

  Widget _buildActionButtons(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: widget.onAddTreatment,
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
    final sectionTitle = widget.isReadOnly ? l10n.treatments : l10n.previousTreatments;

    // Sort: planned/inProgress first, completed last
    final sorted = <PlannedTreatment>[
      ..._planned.where((t) => t.status != TreatmentPlanStatus.completed),
      ..._planned.where((t) => t.status == TreatmentPlanStatus.completed),
    ];

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
            if (sorted.isNotEmpty)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: ColorManager.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  '${sorted.length}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w600,
                    color: ColorManager.primary,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 12.h),
        if (sorted.isEmpty)
          _buildEmptyTreatments(context)
        else
          ...sorted.map((t) => Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: (!widget.isReadOnly && widget.onRemoveTreatment != null)
                    ? Dismissible(
                        key: ValueKey(t.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20.w),
                          decoration: BoxDecoration(
                            color: ColorManager.errorLight,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            Icons.delete_outline,
                            color: ColorManager.white,
                            size: 22.w,
                          ),
                        ),
                        confirmDismiss: (_) => ConfirmDeleteDialog.show(context),
                        onDismissed: (_) {
                          final removed = t;
                          setState(() {
                            _planned.removeWhere((p) => p.id == removed.id);
                          });
                          widget.onRemoveTreatment?.call(removed);
                        },
                        child: TreatmentPlanCard(
                          treatment: t,
                          onTap: () => _showTreatmentDetailsSheet(t),
                          onAddNote: (treatment, note) {
                            setState(() {
                              treatment.visitNotes.add(VisitNote(
                                date: DateTime.now(),
                                text: note,
                              ));
                            });
                            widget.onNotesUpdated
                                ?.call(treatment, treatment.visitNotes);
                          },
                        ),
                      )
                    : TreatmentPlanCard(
                        treatment: t,
                        onTap: () => _showTreatmentDetailsSheet(t),
                        readOnly: widget.isReadOnly,
                        onAddNote: widget.isReadOnly
                            ? null
                            : (treatment, note) {
                                setState(() {
                                  treatment.visitNotes.add(VisitNote(
                                    date: DateTime.now(),
                                    text: note,
                                  ));
                                });
                                widget.onNotesUpdated
                                    ?.call(treatment, treatment.visitNotes);
                              },
                      ),
              )),
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
          widget.isReadOnly ? l10n.noTreatmentsRecorded : l10n.allTreatmentsCompleted,
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
