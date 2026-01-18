import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/add/tooth_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';

class AddTreatmentForm extends StatefulWidget {
  final String patientName;
  final ValueChanged<TreatmentItem> onSave;
  final VoidCallback? onCancel;

  const AddTreatmentForm({
    super.key,
    required this.patientName,
    required this.onSave,
    this.onCancel,
  });

  @override
  State<AddTreatmentForm> createState() => _AddTreatmentFormState();
}

class _AddTreatmentFormState extends State<AddTreatmentForm> {
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  List<TreatmentType> _selectedTypes = [];
  List<int> _selectedTeeth = [];
  List<String> _attachments = [];
  bool _showExtraInfo = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_formKey.currentState?.validate() ?? false) {
      final item = TreatmentItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        description: _descriptionController.text.trim(),
        treatmentTypes: _selectedTypes,
        selectedTeeth: _selectedTeeth,
        attachments: _attachments,
        createdAt: DateTime.now(),
      );
      widget.onSave(item);
      _resetForm();
    }
  }

  void _resetForm() {
    _descriptionController.clear();
    setState(() {
      _selectedTypes = [];
      _selectedTeeth = [];
      _attachments = [];
      _showExtraInfo = false;
    });
  }

  void _toggleTreatmentType(TreatmentType type) {
    setState(() {
      if (_selectedTypes.contains(type)) {
        _selectedTypes.remove(type);
      } else {
        _selectedTypes.add(type);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(Icons.add_circle, color: ColorManager.primary, size: 24.w),
                SizedBox(width: 8.w),
                Text(
                  'Add Treatment',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: FontFamily.geist,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.textPrimary,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 16.h),
            
            // Patient field (disabled)
            _buildLabel('Patient'),
            SizedBox(height: 6.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: ColorManager.gray100,
                borderRadius: BorderRadiusManager.lg,
                border: Border.all(color: ColorManager.gray200),
              ),
              child: Row(
                children: [
                  Icon(Icons.person, size: 20.w, color: ColorManager.textSecondary),
                  SizedBox(width: 8.w),
                  Text(
                    widget.patientName,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: FontFamily.geist,
                      color: ColorManager.textSecondary,
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.lock_outline, size: 16.w, color: ColorManager.textTertiary),
                ],
              ),
            ),
            
            SizedBox(height: 16.h),
            
            // Description field
            _buildLabel('Description *'),
            SizedBox(height: 6.h),
            TextFormField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Describe the treatment...',
                hintStyle: TextStyle(
                  color: ColorManager.textTertiary,
                  fontFamily: FontFamily.geist,
                ),
                filled: true,
                fillColor: ColorManager.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadiusManager.lg,
                  borderSide: BorderSide(color: ColorManager.gray200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadiusManager.lg,
                  borderSide: BorderSide(color: ColorManager.gray200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadiusManager.lg,
                  borderSide: BorderSide(color: ColorManager.primary),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            
            SizedBox(height: 16.h),
            
            // Attachments button
            _buildAttachmentButton(),
            
            SizedBox(height: 16.h),
            
            // Extra info expandable
            _buildExtraInfoToggle(),
            
            if (_showExtraInfo) ...[
              SizedBox(height: 16.h),
              _buildExtraInfoContent(),
            ],
            
            SizedBox(height: 20.h),
            
            // Action buttons
            Row(
              children: [
                if (widget.onCancel != null)
                  Expanded(
                    child: SecondaryButton(
                      text: 'Cancel',
                      onPressed: widget.onCancel!,
                    ),
                  ),
                if (widget.onCancel != null) SizedBox(width: 12.w),
                Expanded(
                  child: PrimaryButton(
                    text: 'Save Treatment',
                    onPressed: _handleSave,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.sp,
        fontFamily: FontFamily.geist,
        fontWeight: FontWeight.w500,
        color: ColorManager.textPrimary,
      ),
    );
  }

  Widget _buildAttachmentButton() {
    return GestureDetector(
      onTap: () {
        // TODO: Implement file picker
        setState(() {
          _attachments.add('attachment_${_attachments.length + 1}.jpg');
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          border: Border.all(color: ColorManager.gray300, style: BorderStyle.solid),
          borderRadius: BorderRadiusManager.lg,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.attach_file, size: 20.w, color: ColorManager.textSecondary),
            SizedBox(width: 8.w),
            Text(
              _attachments.isEmpty 
                  ? 'Add Attachments' 
                  : '${_attachments.length} attachment(s)',
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontFamily.geist,
                color: ColorManager.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExtraInfoToggle() {
    return GestureDetector(
      onTap: () => setState(() => _showExtraInfo = !_showExtraInfo),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: ColorManager.primary.withValues(alpha: 0.05),
          borderRadius: BorderRadiusManager.lg,
          border: Border.all(color: ColorManager.primary.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Icon(
              _showExtraInfo ? Icons.expand_less : Icons.expand_more,
              size: 20.w,
              color: ColorManager.primary,
            ),
            SizedBox(width: 8.w),
            Text(
              'Extra Info (Optional)',
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontFamily.geist,
                fontWeight: FontWeight.w500,
                color: ColorManager.primary,
              ),
            ),
            const Spacer(),
            if (_selectedTypes.isNotEmpty || _selectedTeeth.isNotEmpty)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  '${_selectedTypes.length + (_selectedTeeth.isNotEmpty ? 1 : 0)}',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontFamily: FontFamily.geist,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildExtraInfoContent() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorManager.gray50,
        borderRadius: BorderRadiusManager.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Treatment types
          _buildLabel('Treatment Types'),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: TreatmentType.values.map((type) {
              final isSelected = _selectedTypes.contains(type);
              return GestureDetector(
                onTap: () => _toggleTreatmentType(type),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: isSelected ? ColorManager.primary : ColorManager.white,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: isSelected ? ColorManager.primary : ColorManager.gray300,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        type.icon,
                        size: 16.w,
                        color: isSelected ? ColorManager.white : ColorManager.textSecondary,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        type.label,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: FontFamily.geist,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? ColorManager.white : ColorManager.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          
          SizedBox(height: 16.h),
          
          // Tooth chart
          _buildLabel('Select Teeth'),
          SizedBox(height: 8.h),
          ToothChart(
            selectedTeeth: _selectedTeeth,
            onSelectionChanged: (teeth) => setState(() => _selectedTeeth = teeth),
          ),
        ],
      ),
    );
  }
}