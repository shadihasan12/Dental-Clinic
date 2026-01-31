import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:dental_clinic_app/features/clinic/presentation/widgets/action_button.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/add/tooth_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';

/// Treatment/Visit information form
class VisitInfoForm extends StatefulWidget {
  const VisitInfoForm({
    super.key,
    this.isInitial = false,
    required this.visitDate,
    required this.onVisitDateTap,
    required this.selectedTreatmentTypes,
    required this.availableTreatmentTypes,
    required this.onTreatmentToggle,
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
  final List<String> availableTreatmentTypes;
  final void Function(String treatment) onTreatmentToggle;
  final List<int> selectedTeeth;
  final ValueChanged<List<int>> onTeethChanged;
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
    return Column(
      children: [
        // General info section
        _buildGeneralInfoSection().paddingAll(16.w),

        // Cost section (only for initial case)
        if (widget.isInitial) _buildCostSection().paddingAll(16.w),

        // Treatment types section
        _buildTreatmentTypesSection().paddingAll(16.w),

        // Attachments section
        _buildAttachmentsSection().paddingAll(16.w),
      ],
    );
  }

  Widget _buildGeneralInfoSection() {
    return SectionCard(
      title: 'General Information',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppDateField(
            label: 'Visit Date',
            value: widget.visitDate,
            onTap: widget.onVisitDateTap,
          ),
          SizedBox(height: 16.h),
          AppFormField(
            label: 'Treatment Notes',
            controller: widget.visitSummaryController,
            enabled: true,
            maxLines: 4,
            hintText: 'Describe the treatment performed...',
          ),
        ],
      ),
    );
  }

  Widget _buildCostSection() {
    return SectionCard(
      title: 'Cost Details',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppFormField(
            label: 'Total Cost',
            controller: widget.totalCostController ?? TextEditingController(),
            enabled: widget.totalCostController != null,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            prefixIcon: Icon(
              Icons.attach_money,
              color: ColorManager.textSecondary,
              size: 20,
            ),
            hintText: 'Enter total treatment cost',
          ),
          SizedBox(height: 16.h),
          AppFormField(
            label: 'Lab Fees',
            controller: widget.labFeesController ?? TextEditingController(),
            enabled: widget.labFeesController != null,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            prefixIcon: Icon(
              Icons.science_outlined,
              color: ColorManager.textSecondary,
              size: 20,
            ),
            hintText: 'Enter lab fees (if any)',
          ),
        ],
      ),
    );
  }

  Widget _buildTreatmentTypesSection() {
    return SectionCard(
      title: 'Treatment Details',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Treatment Types',
            style: TextStyle(
              color: ColorManager.textSecondary,
              fontSize: 12.sp,
              fontFamily: FontFamily.geist,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          _TreatmentChips(
            treatments: widget.availableTreatmentTypes,
            selected: widget.selectedTreatmentTypes,
            onToggle: widget.onTreatmentToggle,
          ),
          SizedBox(height: 20.h),
          Text(
            'Select Treated Teeth',
            style: TextStyle(
              color: ColorManager.textSecondary,
              fontSize: 12.sp,
              fontFamily: FontFamily.geist,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12.h),
          ToothChart(
            selectedTeeth: widget.selectedTeeth,
            onSelectionChanged: widget.onTeethChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentsSection() {
    return SectionCard(
      title: 'Attachments',
      child: Column(
        children: [
          ActionButton(
            onPressed: widget.onUploadTap,
            text: 'Upload X-rays or Documents',
            fillColor: ColorManager.white,
            filled: false,
            textColor: ColorManager.textSecondary,
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
      ),
    );
  }
}

extension on Widget {
  Widget paddingAll(double w) {
    return Padding(padding: EdgeInsets.all(w), child: this);
  }
}

/// Treatment type selection chips
class _TreatmentChips extends StatelessWidget {
  const _TreatmentChips({
    required this.treatments,
    required this.selected,
    required this.onToggle,
  });

  final List<String> treatments;
  final List<String> selected;
  final void Function(String) onToggle;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: treatments.map((treatment) {
        final isSelected = selected.contains(treatment);
        return GestureDetector(
          onTap: () => onToggle(treatment),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF70B2B2) : ColorManager.white,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF70B2B2)
                    : ColorManager.gray300,
              ),
            ),
            child: Text(
              treatment,
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: FontFamily.geist,
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? ColorManager.white
                    : ColorManager.textSecondary,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _AttachmentItem extends StatelessWidget {
  const _AttachmentItem({required this.name, required this.onRemove});

  final String name;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorManager.gray100,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.attach_file,
            size: 18.w,
            color: ColorManager.textSecondary,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: FontFamily.geist,
                fontWeight: FontWeight.w500,
                color: ColorManager.textSecondary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GestureDetector(
            onTap: onRemove,
            child: Icon(
              Icons.close,
              size: 18.w,
              color: ColorManager.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}