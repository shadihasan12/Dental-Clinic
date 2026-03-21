import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/patients/data/models/tooth.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_plan_models.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/add/tooth_chart.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/manage_notes_sheet.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TreatmentDetailsSheet extends StatefulWidget {
  final PlannedTreatment treatment;
  final List<Tooth> teeth;

  /// Called when the status toggle button is pressed (mark done / undo).
  final void Function(PlannedTreatment treatment)? onToggleStatus;

  /// Called when notes are updated via ManageNotesSheet.
  final void Function(PlannedTreatment treatment, List<VisitNote> notes)?
      onNotesUpdated;

  const TreatmentDetailsSheet({
    super.key,
    required this.treatment,
    required this.teeth,
    this.onToggleStatus,
    this.onNotesUpdated,
  });

  static void show(
    BuildContext context, {
    required PlannedTreatment treatment,
    required List<Tooth> teeth,
    void Function(PlannedTreatment treatment)? onToggleStatus,
    void Function(PlannedTreatment treatment, List<VisitNote> notes)?
        onNotesUpdated,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => TreatmentDetailsSheet(
        treatment: treatment,
        teeth: teeth,
        onToggleStatus: onToggleStatus,
        onNotesUpdated: onNotesUpdated,
      ),
    );
  }

  @override
  State<TreatmentDetailsSheet> createState() => _TreatmentDetailsSheetState();
}

class _TreatmentDetailsSheetState extends State<TreatmentDetailsSheet> {
  List<String> _toothCodesToIds(String? toothNumber) {
    if (toothNumber == null) return [];
    final codes = toothNumber.split(', ');
    return codes
        .map((code) {
          final match = widget.teeth.where((t) => t.universalCode == code);
          return match.isNotEmpty ? match.first.id : null;
        })
        .whereType<String>()
        .toList();
  }

  Color _statusColor(PlannedTreatment t) {
    return switch (t.status) {
      TreatmentPlanStatus.completed => ColorManager.success,
      TreatmentPlanStatus.inProgress => ColorManager.warning,
      TreatmentPlanStatus.planned => ColorManager.primary,
    };
  }

  String _statusLabel(BuildContext context, PlannedTreatment t) {
    final l10n = AppLocalizations.of(context)!;
    return switch (t.status) {
      TreatmentPlanStatus.completed => l10n.done,
      TreatmentPlanStatus.inProgress => l10n.inProgress,
      TreatmentPlanStatus.planned => l10n.planned,
    };
  }

  void _openManageNotes() {
    Navigator.pop(context); // close details sheet first
    ManageNotesSheet.show(
      context,
      treatmentName: widget.treatment.type.name,
      initialNotes: widget.treatment.visitNotes,
      onSave: (updatedNotes) {
        widget.onNotesUpdated?.call(widget.treatment, updatedNotes);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final treatment = widget.treatment;
    final isCompleted = treatment.status == TreatmentPlanStatus.completed;
    final color = _statusColor(treatment);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.75,
      ),
      decoration: BoxDecoration(
        color: ColorManager.of(context).cardBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Scrollable content ─────────────────────────────
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle
                  Center(
                    child: Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: ColorManager.of(context).border,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Header: icon + name + status
                  Row(
                    children: [
                      Container(
                        width: 44.w,
                        height: 44.w,
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          treatment.type.icon,
                          size: 22.w,
                          color: color,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              treatment.type.name,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: FontHelper.fontFamily(context),
                                fontWeight: FontWeight.w600,
                                color: ColorManager.of(context).textPrimary,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              treatment.type.categoryName,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontFamily: FontHelper.fontFamily(context),
                                color: ColorManager.of(context).textTertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          _statusLabel(context, treatment),
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontFamily: FontHelper.fontFamily(context),
                            fontWeight: FontWeight.w500,
                            color: color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  // Info rows
                  if (treatment.toothNumber != null)
                    _infoRow(
                        icon: Icons.location_on_outlined,
                        label: AppLocalizations.of(context)!.tooth,
                        value: treatment.toothNumber!),
                  if (!treatment.isToothSpecific)
                    _infoRow(
                        icon: Icons.category_outlined,
                        label: AppLocalizations.of(context)!.type,
                        value: AppLocalizations.of(context)!.generalTreatment),
                  if (isCompleted && treatment.completedDate != null)
                    _infoRow(
                        icon: Icons.check_circle_outline,
                        label: AppLocalizations.of(context)!.completed,
                        value:
                            '${treatment.completedDate!.day}/${treatment.completedDate!.month}/${treatment.completedDate!.year}'),
                  if (treatment.notes.isNotEmpty)
                    _infoRow(
                        icon: Icons.notes_outlined,
                        label: AppLocalizations.of(context)!.notes,
                        value: treatment.notes),

                  // Tooth chart
                  if (treatment.isToothSpecific) ...[
                    SizedBox(height: 8.h),
                    ToothChart(
                      teeth: widget.teeth,
                      selectedTeeth: _toothCodesToIds(treatment.toothNumber),
                      enabled: false,
                      aspectRatio: 1.2,
                    ),
                  ],

                  // Visit notes
                  if (treatment.visitNotes.isNotEmpty) ...[
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.visitNotes,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: FontHelper.fontFamily(context),
                            fontWeight: FontWeight.w600,
                            color: ColorManager.of(context).textPrimary,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: ColorManager.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            '${treatment.visitNotes.length}',
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontFamily: FontHelper.fontFamily(context),
                              fontWeight: FontWeight.w500,
                              color: ColorManager.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    ...treatment.visitNotes.map((note) => Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: ColorManager.of(context).cardBgSecondary,
                              borderRadius: BorderRadius.circular(10.r),
                              border:
                                  Border.all(color: ColorManager.of(context).borderLight),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.event_note,
                                        size: 14.w,
                                        color: ColorManager.primary),
                                    SizedBox(width: 6.w),
                                    Text(
                                      '${note.date.day}/${note.date.month}/${note.date.year}',
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        fontFamily:
                                            FontHelper.fontFamily(context),
                                        fontWeight: FontWeight.w500,
                                        color: ColorManager.primary,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  note.text,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontFamily: FontHelper.fontFamily(context),
                                    color: ColorManager.of(context).textPrimary,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ],
                ],
              ),
            ),
          ),

          // ── Sticky action buttons (always above keyboard) ───
          Padding(
            padding: EdgeInsets.fromLTRB(
              20.w,
              8.h,
              20.w,
              (bottomInset > 0 ? bottomInset : bottomPadding) + 16.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Manage Notes button
                if (widget.onNotesUpdated != null) ...[
                  GestureDetector(
                    onTap: _openManageNotes,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: ColorManager.of(context).cardBg,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: ColorManager.primary),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit_note_rounded,
                              size: 18.w, color: ColorManager.primary),
                          SizedBox(width: 6.w),
                          Text(
                            AppLocalizations.of(context)!.manageNotes,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: FontHelper.fontFamily(context),
                              fontWeight: FontWeight.w600,
                              color: ColorManager.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                ],

                // Mark Finished / Undo button
                if (widget.onToggleStatus != null)
                  GestureDetector(
                    onTap: () {
                      widget.onToggleStatus?.call(treatment);
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? ColorManager.warning
                            : ColorManager.success,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isCompleted
                                ? Icons.undo_rounded
                                : Icons.check_circle_outline,
                            size: 16.w,
                            color: ColorManager.white,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            isCompleted
                                ? AppLocalizations.of(context)!.undoFinished
                                : AppLocalizations.of(context)!.markFinished,
                            textAlign: TextAlign.center,
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(
      {required IconData icon, required String label, required String value}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16.w, color: ColorManager.of(context).textTertiary),
          SizedBox(width: 8.w),
          Text('$label: ',
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: FontHelper.fontFamily(context),
                color: ColorManager.of(context).textTertiary,
              )),
          Expanded(
            child: Text(value,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: FontWeight.w500,
                  color: ColorManager.of(context).textPrimary,
                )),
          ),
        ],
      ),
    );
  }
}
