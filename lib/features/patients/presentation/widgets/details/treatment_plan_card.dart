import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_plan_models.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TreatmentPlanCard extends StatefulWidget {
  final PlannedTreatment treatment;
  final bool showCheckbox;
  final bool removeBorder;
  final ValueChanged<bool?>? onStatusChanged;
  final VoidCallback? onTap;

  /// If provided, the card becomes expandable with a timeline of visit notes
  /// and a text field to add new notes.
  final void Function(PlannedTreatment treatment, String note)? onAddNote;

  /// If true, the notes section is read-only (no text field).
  final bool readOnly;

  const TreatmentPlanCard({
    super.key,
    required this.treatment,
    this.showCheckbox = false,
    this.removeBorder = false,
    this.onStatusChanged,
    this.onTap,
    this.onAddNote,
    this.readOnly = false,
  });

  @override
  State<TreatmentPlanCard> createState() => _TreatmentPlanCardState();
}

class _TreatmentPlanCardState extends State<TreatmentPlanCard>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late final TextEditingController _noteController;

  bool get _isExpandable => widget.treatment.visitNotes.isNotEmpty || !widget.readOnly;

  Color get _statusColor {
    switch (widget.treatment.status) {
      case TreatmentPlanStatus.completed:
        return ColorManager.success;
      case TreatmentPlanStatus.inProgress:
        return ColorManager.warning;
      case TreatmentPlanStatus.planned:
        return ColorManager.primary;
    }
  }

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _submitNote() {
    final text = _noteController.text.trim();
    if (text.isEmpty) return;
    widget.onAddNote?.call(widget.treatment, text);
    _noteController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isCompleted =
        widget.treatment.status == TreatmentPlanStatus.completed;

    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: widget.removeBorder
            ? null
            : BoxDecoration(
                color: isCompleted
                    ? ColorManager.success.withValues(alpha: 0.04)
                    : ColorManager.of(context).cardBg,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: isCompleted
                      ? ColorManager.success.withValues(alpha: 0.2)
                      : ColorManager.of(context).borderLight,
                ),
              ),
        child: Column(
          children: [
            // Main row
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              child: Row(
                children: [
                  // Status indicator or checkbox
                  if (widget.showCheckbox)
                    GestureDetector(
                      onTap: () =>
                          widget.onStatusChanged?.call(!isCompleted),
                      child: Container(
                        width: 24.w,
                        height: 24.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isCompleted
                              ? ColorManager.success
                              : Colors.transparent,
                          border: Border.all(
                            color: isCompleted
                                ? ColorManager.success
                                : ColorManager.of(context).borderLight,
                            width: 2,
                          ),
                        ),
                        child: isCompleted
                            ? Icon(Icons.check,
                                size: 14.w, color: Colors.white)
                            : null,
                      ),
                    )
                  else
                    Container(
                      width: 6.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: _statusColor,
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                    ),
                  SizedBox(width: 12.w),

                  // Treatment icon
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: _statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      widget.treatment.type.icon,
                      size: 20.w,
                      color: _statusColor,
                    ),
                  ),
                  SizedBox(width: 12.w),

                  // Treatment details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.treatment.type.name,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: FontHelper.fontFamily(context),
                            fontWeight: FontWeight.w500,
                            color: isCompleted
                                ? ColorManager.of(context).textTertiary
                                : ColorManager.of(context).textPrimary,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            if (widget.treatment.toothNumber != null) ...[
                              Icon(
                                Icons.location_on_outlined,
                                size: 12.w,
                                color: ColorManager.of(context).textTertiary,
                              ),
                              SizedBox(width: 3.w),
                              Text(
                                '${AppLocalizations.of(context)!.tooth} ${widget.treatment.toothNumber}',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: FontHelper.fontFamily(context),
                                  color: ColorManager.of(context).textTertiary,
                                ),
                              ),
                            ] else
                              Text(
                                AppLocalizations.of(context)!.general,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: FontHelper.fontFamily(context),
                                  color: ColorManager.of(context).textTertiary,
                                ),
                              ),
                            if (widget.treatment.visitNotes.isNotEmpty) ...[
                              SizedBox(width: 6.w),
                              Icon(
                                Icons.sticky_note_2_outlined,
                                size: 12.w,
                                color: ColorManager.primary,
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                '${widget.treatment.visitNotes.length}',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontFamily: FontHelper.fontFamily(context),
                                  fontWeight: FontWeight.w500,
                                  color: ColorManager.primary,
                                ),
                              ),
                            ] else if (widget.treatment.notes.isNotEmpty) ...[
                              SizedBox(width: 6.w),
                              Icon(
                                Icons.sticky_note_2_outlined,
                                size: 12.w,
                                color: ColorManager.primary,
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Status badge (hide for planned)
                  if (widget.treatment.status != TreatmentPlanStatus.planned)
                    _buildStatusBadge(context),

                  // Expand arrow
                  if (_isExpandable) ...[
                    SizedBox(width: 4.w),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => setState(() => _expanded = !_expanded),
                      child: Padding(
                        padding: EdgeInsets.all(8.w),
                        child: AnimatedRotation(
                          turns: _expanded ? 0.5 : 0,
                          duration: const Duration(milliseconds: 200),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            size: 24.w,
                            color: ColorManager.of(context).textTertiary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Expandable notes section
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: _buildNotesSection(context),
              crossFadeState: _expanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 200),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotesSection(BuildContext context) {
    final notes = widget.treatment.visitNotes;

    return Container(
      padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: ColorManager.of(context).borderLight, height: 1),
          SizedBox(height: 12.h),

          // Timeline
          if (notes.isNotEmpty)
            ...List.generate(notes.length, (i) {
              final note = notes[i];
              final isLast = i == notes.length - 1;
              return _buildTimelineItem(context, note, isLast);
            }),

          // Add note field (non-read-only)
          if (!widget.readOnly && widget.onAddNote != null) ...[
            SizedBox(height: 8.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: _noteController,
                    maxLines: 2,
                    minLines: 1,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      color: ColorManager.of(context).textPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.addANote,
                      hintStyle: TextStyle(
                        fontSize: 13.sp,
                        color: ColorManager.of(context).textTertiary,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 10.h),
                      filled: true,
                      fillColor: ColorManager.of(context).cardBgSecondary,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide:
                            BorderSide(color: ColorManager.of(context).borderLight),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide:
                            BorderSide(color: ColorManager.of(context).borderLight),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide:
                            BorderSide(color: ColorManager.primary),
                      ),
                      isDense: true,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: _submitNote,
                  child: Container(
                    width: 38.w,
                    height: 38.w,
                    decoration: BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.send_rounded,
                      size: 18.w,
                      color: ColorManager.white,
                    ),
                  ),
                ),
              ],
            ),
          ],

          if (notes.isEmpty && widget.readOnly)
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Text(
                  AppLocalizations.of(context)!.noNotesYet,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    color: ColorManager.of(context).textTertiary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(
      BuildContext context, VisitNote note, bool isLast) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline line + dot
          SizedBox(
            width: 24.w,
            child: Column(
              children: [
                Container(
                  width: 10.w,
                  height: 10.w,
                  decoration: BoxDecoration(
                    color: ColorManager.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2.w,
                      color: ColorManager.primary.withValues(alpha: 0.2),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: 8.w),

          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${note.date.day}/${note.date.month}/${note.date.year}',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      fontWeight: FontWeight.w500,
                      color: ColorManager.primary,
                    ),
                  ),
                  SizedBox(height: 3.h),
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
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final label = switch (widget.treatment.status) {
      TreatmentPlanStatus.completed => l10n.done,
      TreatmentPlanStatus.inProgress => l10n.inProgress,
      TreatmentPlanStatus.planned => l10n.planned,
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: _statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.sp,
          fontFamily: FontHelper.fontFamily(context),
          fontWeight: FontWeight.w500,
          color: _statusColor,
        ),
      ),
    );
  }
}
