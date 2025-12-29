import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'teeth_diagram.dart';

/// Step 3: Initial visit information form
class VisitInfoForm extends StatelessWidget {
  const VisitInfoForm({
    super.key,
    required this.visitDate,
    required this.onVisitDateTap,
    required this.selectedTreatmentTypes,
    required this.availableTreatmentTypes,
    required this.onTreatmentToggle,
    required this.toothTreatments,
    required this.onToothTap,
    required this.visitSummaryController,
    required this.isRecording,
    required this.onRecordingToggle,
    required this.attachments,
    required this.onUploadTap,
    required this.onAttachmentRemove,
  });

  final DateTime visitDate;
  final VoidCallback onVisitDateTap;
  final List<String> selectedTreatmentTypes;
  final List<String> availableTreatmentTypes;
  final void Function(String treatment) onTreatmentToggle;
  final Map<int, String> toothTreatments;
  final void Function(int toothNumber) onToothTap;
  final TextEditingController visitSummaryController;
  final bool isRecording;
  final VoidCallback onRecordingToggle;
  final List<String> attachments;
  final VoidCallback onUploadTap;
  final void Function(int index) onAttachmentRemove;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildVisitInfoSection(),
        SizedBox(height: 16.h),
        _buildTeethDiagramSection(),
        SizedBox(height: 16.h),
        _buildVisitSummarySection(),
        SizedBox(height: 16.h),
        _buildAttachmentsSection(),
        SizedBox(height: 80.h),
      ],
    );
  }

  Widget _buildVisitInfoSection() {
    return SectionCard(
      title: 'Visit Information',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppDateField(
            label: 'Visit Date',
            value: visitDate,
            onTap: onVisitDateTap,
          ),
          SizedBox(height: 16.h),
          Text(
            'Treatment Types (Select Multiple)',
            style: TextStyleManager.titleSmall.copyWith(
              color: ColorManager.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12.h),
          _TreatmentChips(
            treatments: availableTreatmentTypes,
            selected: selectedTreatmentTypes,
            onToggle: onTreatmentToggle,
          ),
        ],
      ),
    );
  }

  Widget _buildTeethDiagramSection() {
    return SectionCard(
      title: 'Teeth Treatment Diagram',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Click on a tooth to record treatment',
            style: TextStyleManager.bodySmall.copyWith(
              color: ColorManager.textTertiary,
            ),
          ),
          SizedBox(height: 20.h),
          TeethDiagram(
            toothTreatments: toothTreatments,
            onToothTap: onToothTap,
          ),
        ],
      ),
    );
  }

  Widget _buildVisitSummarySection() {
    return SectionCard(
      title: 'Visit Summary',
      child: SizedBox(
        height: 150.h,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorManager.gray50,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: ColorManager.gray200),
              ),
              child: TextField(
                controller: visitSummaryController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Enter visit summary and notes...',
                  hintStyle: TextStyleManager.bodyMedium.copyWith(
                    color: ColorManager.textTertiary,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16.w),
                ),
              ),
            ),
            Positioned(
              right: 12.w,
              bottom: 12.h,
              child: _MicButton(
                isRecording: isRecording,
                onTap: onRecordingToggle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachmentsSection() {
    return SectionCard(
      title: 'Attachments',
      child: Column(
        children: [
          OutlinedButton.icon(
            onPressed: onUploadTap,
            icon: Icon(Icons.cloud_upload_outlined, size: 20.w),
            label: const Text('Upload X-rays or Documents'),
            style: OutlinedButton.styleFrom(
              foregroundColor: ColorManager.textSecondary,
              side: BorderSide(color: ColorManager.gray200),
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
          if (attachments.isNotEmpty) ...[
            SizedBox(height: 12.h),
            ...attachments.asMap().entries.map((entry) {
              return _AttachmentItem(
                name: entry.value,
                onRemove: () => onAttachmentRemove(entry.key),
              );
            }),
          ],
        ],
      ),
    );
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
              style: TextStyleManager.bodySmall.copyWith(
                color: isSelected ? ColorManager.white : ColorManager.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _MicButton extends StatelessWidget {
  const _MicButton({required this.isRecording, required this.onTap});

  final bool isRecording;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: isRecording ? Colors.red : const Color(0xFF70B2B2),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Icon(Icons.mic, color: ColorManager.white, size: 20.w),
      ),
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
          Expanded(
            child: Text(name, style: TextStyleManager.bodySmall, overflow: TextOverflow.ellipsis),
          ),
          GestureDetector(
            onTap: onRemove,
            child: Icon(Icons.close, size: 18.w, color: ColorManager.textSecondary),
          ),
        ],
      ),
    );
  }
}
