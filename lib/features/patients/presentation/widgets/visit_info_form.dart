import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/patients/data/models/core_treatment.dart';
import 'package:dental_clinic_app/features/patients/data/models/tooth.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/add/tooth_chart.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/core/utils/date_time_helper.dart';

class VisitInfoForm extends StatefulWidget {
  const VisitInfoForm({
    super.key,
    this.isInitial = false,
    required this.visitDate,
    required this.onVisitDateTap,
    required this.selectedTreatmentTypes,
    required this.availableTreatmentTypes,
    required this.onTreatmentToggle,
    required this.teeth,
    required this.selectedTeeth,
    required this.onTeethChanged,
    required this.visitSummaryController,
    required this.attachments,
    required this.onUploadTap,
    required this.onAttachmentRemove,
    this.totalCostController,
    this.labFeesController,
  });

  final bool isInitial;
  final DateTime visitDate;
  final VoidCallback onVisitDateTap;
  final List<String> selectedTreatmentTypes;
  final List<CoreTreatment> availableTreatmentTypes;
  final void Function(String treatmentId) onTreatmentToggle;
  final List<Tooth> teeth;
  final List<String> selectedTeeth;
  final ValueChanged<List<String>> onTeethChanged;
  final TextEditingController visitSummaryController;
  final List<String> attachments;
  final VoidCallback onUploadTap;
  final void Function(int index) onAttachmentRemove;
  final TextEditingController? totalCostController;
  final TextEditingController? labFeesController;

  @override
  State<VisitInfoForm> createState() => _VisitInfoFormState();
}

class _VisitInfoFormState extends State<VisitInfoForm> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // — Visit date: subtle, tappable row — defaults to today
        _buildDateRow(context, l10n),

        _divider(),

        // — Treatment types: quick tap chips
        _sectionLabel(context, l10n.treatmentType),
        SizedBox(height: 10.h),
        _TreatmentChips(
          treatments: widget.availableTreatmentTypes,
          selected: widget.selectedTreatmentTypes,
          onToggle: widget.onTreatmentToggle,
        ),

        _divider(),

        // — Tooth selection
        _sectionLabel(context, l10n.teeth),
        SizedBox(height: 10.h),
        ToothChart(
          teeth: widget.teeth,
          selectedTeeth: widget.selectedTeeth,
          onSelectionChanged: widget.onTeethChanged,
        ),

        _divider(),

        // — Notes
        _sectionLabel(context, l10n.notes),
        SizedBox(height: 10.h),
        AppFormField(
          controller: widget.visitSummaryController,
          maxLines: 3,
          hintText: l10n.addNotesAboutTreatment, label: '',
        ),

        // — Cost (only for initial)
        if (widget.isInitial) ...[
          _divider(),
          SizedBox(height: 10.h),
          AppFormField(
            controller: widget.totalCostController ?? TextEditingController(),
            enabled: widget.totalCostController != null,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            hintText: l10n.totalCostHint,
            prefixIcon: Icon(
              Icons.attach_money,
              color: ColorManager.of(context).textSubtle,
              size: 20,
            ), label: l10n.totalCost,
          ),
          SizedBox(height: 12.h),
          AppFormField(
            controller: widget.labFeesController ?? TextEditingController(),
            enabled: widget.labFeesController != null,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            hintText: l10n.labFeesHint,
            prefixIcon: Icon(
              Icons.science_outlined,
              color: ColorManager.of(context).textSubtle,
              size: 20,
            ), label: l10n.labFees,
          ),
        ],

        _divider(),

        // — Attachments
        _buildAttachments(context, l10n),

        SizedBox(height: 80.h),
      ],
    );
  }

  // — Visit date as a simple inline row
  Widget _buildDateRow(BuildContext context, AppLocalizations l10n) {
    final formatted = AppDate.medium(context, widget.visitDate);
    final isToday = DateUtils.isSameDay(widget.visitDate, DateTime.now());

    return GestureDetector(
      onTap: widget.onVisitDateTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Row(
          children: [
            Icon(Icons.calendar_today_outlined,
                size: 16.w, color: ColorManager.of(context).textTertiary),
            SizedBox(width: 8.w),
            Text(
              isToday ? '${l10n.today}, $formatted' : formatted,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w500,
                color: ColorManager.of(context).textPrimary,
              ),
            ),
            const Spacer(),
            Text(
              l10n.change,
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w500,
                color: ColorManager.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // — Attachments as a simple add button + list
  Widget _buildAttachments(BuildContext context, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: widget.onUploadTap,
          child: Row(
            children: [
              Icon(Icons.add_circle_outline,
                  size: 20.w, color: ColorManager.primary),
              SizedBox(width: 8.w),
              Text(
                l10n.addXraysOrPhotos,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: FontWeight.w500,
                  color: ColorManager.primary,
                ),
              ),
            ],
          ),
        ),
        if (widget.attachments.isNotEmpty) ...[
          SizedBox(height: 12.h),
          ...widget.attachments.asMap().entries.map((entry) {
            return _AttachmentItem(
              name: entry.value,
              onRemove: () => widget.onAttachmentRemove(entry.key),
            );
          }),
        ],
      ],
    );
  }

  Widget _sectionLabel(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
        color: ColorManager.of(context).textSubtle,
        fontFamily: FontHelper.fontFamily(context),
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 18.h),
      child: Divider(color: ColorManager.of(context).divider),
    );
  }
}

// ─── Treatment Chips ─────────────────────────────────────────────────────────

class _TreatmentChips extends StatelessWidget {
  const _TreatmentChips({
    required this.treatments,
    required this.selected,
    required this.onToggle,
  });

  final List<CoreTreatment> treatments;
  final List<String> selected;
  final void Function(String) onToggle;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: treatments.map((treatment) {
        final isSelected = selected.contains(treatment.id);
        return GestureDetector(
          onTap: () => onToggle(treatment.id),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isSelected
                  ? ColorManager.primary
                  : ColorManager.of(context).inputBg,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: isSelected
                    ? ColorManager.primary
                    : ColorManager.of(context).border,
              ),
            ),
            child: Text(
              treatment.displayName,
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w500,
                color: isSelected ? ColorManager.white : ColorManager.of(context).textPrimary,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ─── Attachment Item ─────────────────────────────────────────────────────────

class _AttachmentItem extends StatelessWidget {
  const _AttachmentItem({required this.name, required this.onRemove});

  final String name;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Icon(Icons.attach_file, size: 16.w, color: ColorManager.of(context).textSubtle),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: FontHelper.fontFamily(context),
                color: ColorManager.of(context).textPrimary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GestureDetector(
            onTap: onRemove,
            child: Icon(Icons.close, size: 16.w, color: ColorManager.of(context).textSubtle),
          ),
        ],
      ),
    );
  }
}