import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_plan_models.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/patient_detail_states.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/custom_widgets/denta_form.dart';

/// The plan for the active case.
///
/// Completion is a single tap on a 44dp check in the row; expanding is only
/// for notes. That split is deliberate - recording work done mid-appointment
/// is the most frequent action on this screen and should never cost a sheet.
class TreatmentsSection extends StatefulWidget {
  const TreatmentsSection({
    super.key,
    required this.treatments,
    required this.onToggleDone,
    required this.onAddNote,
    required this.onRemove,
    required this.onAddTreatment,
    this.onFinishCase,
    this.outstandingLabel,
  });

  final List<PlannedTreatment> treatments;
  final ValueChanged<PlannedTreatment> onToggleDone;
  final void Function(PlannedTreatment treatment, String note) onAddNote;
  final ValueChanged<PlannedTreatment> onRemove;
  final VoidCallback onAddTreatment;
  final VoidCallback? onFinishCase;

  /// Shown on the "all done" state so the dentist knows money is still open.
  final String? outstandingLabel;

  @override
  State<TreatmentsSection> createState() => _TreatmentsSectionState();
}

class _TreatmentsSectionState extends State<TreatmentsSection> {
  bool _onlyRemaining = false;
  final Set<String> _expanded = {};

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);

    final all = widget.treatments;
    final remaining = all
        .where((t) => t.status != TreatmentPlanStatus.completed)
        .toList();
    final shown = _onlyRemaining ? remaining : all;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              l10n.treatments,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                fontFamily: family,
                color: c.textPrimary,
              ),
            ),
            const Spacer(),
            if (all.isNotEmpty)
              _FilterSwitch(
                remainingLabel: '${l10n.remainingWork} ${remaining.length}',
                allLabel: '${l10n.allFilter} ${all.length}',
                onlyRemaining: _onlyRemaining,
                onChanged: (v) => setState(() => _onlyRemaining = v),
              ),
          ],
        ),
        SizedBox(height: 10.h),
        if (all.isEmpty)
          _EmptyPlan(onAddTreatment: widget.onAddTreatment)
        else if (remaining.isEmpty && _onlyRemaining)
          _AllDone(
            outstandingLabel: widget.outstandingLabel,
            onFinishCase: widget.onFinishCase,
          )
        else ...[
          for (final t in shown) ...[
            _TreatmentRow(
              treatment: t,
              expanded: _expanded.contains(t.id),
              onToggleExpand: () => setState(() {
                if (!_expanded.remove(t.id)) _expanded.add(t.id);
              }),
              onToggleDone: () => widget.onToggleDone(t),
              onAddNote: (note) => widget.onAddNote(t, note),
              onRemove: () => widget.onRemove(t),
            ),
            SizedBox(height: 8.h),
          ],
          if (remaining.isEmpty)
            _AllDone(
              outstandingLabel: widget.outstandingLabel,
              onFinishCase: widget.onFinishCase,
            ),
        ],
      ],
    );
  }
}

/// Two segments in one grey track rather than two loose pills: the choice is
/// exclusive, and a shared track says that where a gap does not.
class _FilterSwitch extends StatelessWidget {
  const _FilterSwitch({
    required this.remainingLabel,
    required this.allLabel,
    required this.onlyRemaining,
    required this.onChanged,
  });

  final String remainingLabel;
  final String allLabel;
  final bool onlyRemaining;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: c.cardBgSecondary,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _seg(context, remainingLabel, onlyRemaining, () => onChanged(true)),
          SizedBox(width: 2.w),
          _seg(context, allLabel, !onlyRemaining, () => onChanged(false)),
        ],
      ),
    );
  }

  Widget _seg(BuildContext context, String label, bool active, VoidCallback t) {
    final c = ColorManager.of(context);
    return GestureDetector(
      onTap: t,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: active ? ColorManager.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11.5.sp,
            fontWeight: active ? FontWeight.w600 : FontWeight.w500,
            fontFamily: FontHelper.fontFamily(context),
            color: active ? ColorManager.white : c.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _TreatmentRow extends StatefulWidget {
  const _TreatmentRow({
    required this.treatment,
    required this.expanded,
    required this.onToggleExpand,
    required this.onToggleDone,
    required this.onAddNote,
    required this.onRemove,
  });

  final PlannedTreatment treatment;
  final bool expanded;
  final VoidCallback onToggleExpand;
  final VoidCallback onToggleDone;
  final ValueChanged<String> onAddNote;
  final VoidCallback onRemove;

  @override
  State<_TreatmentRow> createState() => _TreatmentRowState();
}

class _TreatmentRowState extends State<_TreatmentRow> {
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _submitNote() {
    final text = _noteController.text.trim();
    if (text.isEmpty) return;
    widget.onAddNote(text);
    _noteController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);
    final t = widget.treatment;
    final done = t.status == TreatmentPlanStatus.completed;

    return Container(
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: c.borderLight),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 44dp target - the whole point of the row.
              Semantics(
                checked: done,
                label: t.type.name,
                child: InkWell(
                  onTap: widget.onToggleDone,
                  customBorder: const CircleBorder(),
                  child: SizedBox(
                    width: 44.w,
                    height: 44.w,
                    child: Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 140),
                        width: 22.w,
                        height: 22.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: done
                              ? ColorManager.success
                              : Colors.transparent,
                          border: Border.all(
                            color: done ? ColorManager.success : c.border,
                            width: 1.6,
                          ),
                        ),
                        child: done
                            ? Icon(
                                Icons.check_rounded,
                                size: 14.w,
                                color: ColorManager.white,
                              )
                            : null,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: widget.onToggleExpand,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          t.type.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.5.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: family,
                            color: done ? c.textSecondary : c.textPrimary,
                            decoration: done
                                ? TextDecoration.lineThrough
                                : null,
                            decorationColor: c.textTertiary,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            // Loose fit: a long localised label ("General
                            // treatment" in Arabic) must ellipsize inside the
                            // pill rather than push the note counter off-row.
                            Flexible(
                              child: _LocationPill(toothNumber: t.toothNumber),
                            ),
                            if (t.visitNotes.isNotEmpty) ...[
                              SizedBox(width: 6.w),
                              Icon(
                                Icons.sticky_note_2_outlined,
                                size: 13.w,
                                color: c.textTertiary,
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                '${t.visitNotes.length}',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontFamily: family,
                                  color: c.textTertiary,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: widget.onToggleExpand,
                icon: AnimatedRotation(
                  turns: widget.expanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 160),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 20.w,
                    color: c.textTertiary,
                  ),
                ),
              ),
            ],
          ),
          if (widget.expanded) ...[
            Divider(height: 1, color: c.borderLight),
            Padding(
              padding: EdgeInsets.fromLTRB(14.w, 12.h, 12.w, 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (t.notes.trim().isNotEmpty) ...[
                    Text(
                      t.notes.trim(),
                      style: TextStyle(
                        fontSize: 11.5.sp,
                        height: 1.45,
                        fontFamily: family,
                        color: c.textSecondary,
                      ),
                    ),
                    SizedBox(height: 12.h),
                  ],
                  for (final n in t.visitNotes) ...[
                    _NoteLine(date: n.date, text: n.text),
                    SizedBox(height: 8.h),
                  ],
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _noteController,
                          textInputAction: TextInputAction.send,
                          onSubmitted: (_) => _submitNote(),
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontFamily: family,
                            color: c.textPrimary,
                          ),
                          decoration: formOutlinedInput(
                            context,
                            hintText: l10n.addVisitNoteHint,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      IconButton(
                        onPressed: _submitNote,
                        icon: Icon(
                          Icons.arrow_upward_rounded,
                          size: 18.w,
                          color: ColorManager.primaryDarker,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: ColorManager.primary.withValues(
                            alpha: 0.12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextButton.icon(
                      onPressed: widget.onRemove,
                      icon: Icon(
                        Icons.delete_outline_rounded,
                        size: 16.w,
                        color: ColorManager.destructive,
                      ),
                      label: Text(
                        l10n.removeAction,
                        style: TextStyle(
                          fontSize: 12.5.sp,
                          fontFamily: family,
                          color: ColorManager.destructive,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Tooth-specific reads as a blue tooth number, general as a grey pill, so the
/// two are distinguishable without reading the label.
class _LocationPill extends StatelessWidget {
  const _LocationPill({required this.toothNumber});
  final String? toothNumber;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final isTooth = toothNumber != null && toothNumber!.trim().isNotEmpty;
    final bg = isTooth
        ? ColorManager.primary.withValues(alpha: 0.12)
        : c.cardBgSecondary;
    final fg = isTooth ? ColorManager.primaryDarker : c.textTertiary;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Text(
        // toothLabel takes the number as a placeholder - interpolating the
        // getter itself printed "Closure: (String) => String".
        isTooth
            ? l10n.toothLabel(toothNumber!.trim())
            : l10n.generalTreatmentLabel,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          fontFamily: FontHelper.fontFamily(context),
          color: fg,
        ),
      ),
    );
  }
}

class _NoteLine extends StatelessWidget {
  const _NoteLine({required this.date, required this.text});
  final DateTime date;
  final String text;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final d =
        '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/${date.year}';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6.w,
          height: 6.w,
          margin: EdgeInsets.only(top: 6.h),
          decoration: BoxDecoration(
            color: ColorManager.primary.withValues(alpha: 0.5),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                d,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontFamily: family,
                  color: c.textTertiary,
                ),
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 11.5.sp,
                  height: 1.4,
                  fontFamily: family,
                  color: c.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _EmptyPlan extends StatelessWidget {
  const _EmptyPlan({required this.onAddTreatment});
  final VoidCallback onAddTreatment;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return PatientDetailPlaceholder(
      icon: Icons.medical_services_outlined,
      title: l10n.noTreatmentsPlanned,
      message: l10n.openChartHint,
      primaryLabel: l10n.addTreatmentButton,
      onPrimary: onAddTreatment,
    );
  }
}

class _AllDone extends StatelessWidget {
  const _AllDone({required this.outstandingLabel, required this.onFinishCase});
  final String? outstandingLabel;
  final VoidCallback? onFinishCase;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return PatientDetailPlaceholder(
      icon: Icons.task_alt_rounded,
      tone: ColorManager.success,
      title: l10n.allTreatmentsCompleted,
      message: outstandingLabel,
      primaryLabel: onFinishCase == null ? null : l10n.finishCaseAction,
      onPrimary: onFinishCase,
    );
  }
}
