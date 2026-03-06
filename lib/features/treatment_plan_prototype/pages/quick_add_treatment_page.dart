import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_card.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../models/prototype_models.dart';

/// Quick add treatment — simple mode for doctors who don't want
/// to use the full treatment planning system.
/// Just pick a treatment type, optionally set a tooth, add cost, done.
class QuickAddTreatmentPage extends StatefulWidget {
  const QuickAddTreatmentPage({super.key});

  @override
  State<QuickAddTreatmentPage> createState() => _QuickAddTreatmentPageState();
}

class _QuickAddTreatmentPageState extends State<QuickAddTreatmentPage> {
  TreatmentTypeInfo? _selectedType;
  final TextEditingController _costController = TextEditingController();
  final TextEditingController _toothController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  int _idCounter = 0;

  @override
  void dispose() {
    _costController.dispose();
    _toothController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _selectType(TreatmentTypeInfo type) {
    setState(() {
      _selectedType = type;
      _costController.text = type.defaultCost.toStringAsFixed(0);
    });
  }

  void _save() {
    if (_selectedType == null) return;

    final cost = double.tryParse(_costController.text) ?? 0;
    final toothNumber =
        _toothController.text.trim().isEmpty ? null : _toothController.text.trim();

    final treatment = PlannedTreatment(
      id: 'quick_${_idCounter++}',
      type: _selectedType!,
      toothNumber: toothNumber,
      cost: cost,
      notes: _notesController.text.trim(),
    );

    Navigator.pop(context, treatment);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.scaffoldBackground,
      body: Column(
        children: [
          PageHeader(
            title: 'Quick Add',
            onBack: () => context.pop(),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info banner
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: ColorManager.warning.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: ColorManager.warning.withValues(alpha: 0.15),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.bolt,
                          size: 20.w,
                          color: ColorManager.warning,
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            'Quick mode — add a treatment without detailed planning',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: FontHelper.fontFamily(context),
                              color: ColorManager.warning,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Treatment type selection
                  Text(
                    'Treatment Type',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      fontWeight: FontWeight.w600,
                      color: ColorManager.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  _buildTypeList('Tooth Specific', MockTreatmentTypes.toothSpecific),
                  SizedBox(height: 12.h),
                  _buildTypeList('General', MockTreatmentTypes.general),
                  SizedBox(height: 20.h),

                  // Optional fields (only show after type selected)
                  if (_selectedType != null) ...[
                    // Tooth number (optional)
                    if (_selectedType!.category ==
                        TreatmentCategory.toothSpecific) ...[
                      CustomCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tooth Number (optional)',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontFamily: FontHelper.fontFamily(context),
                                fontWeight: FontWeight.w500,
                                color: ColorManager.textSecondary,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            TextField(
                              controller: _toothController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: FontHelper.fontFamily(context),
                                color: ColorManager.textPrimary,
                              ),
                              decoration: _inputDecoration('e.g., 16, 24'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.h),
                    ],

                    // Cost
                    CustomCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cost',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontFamily: FontHelper.fontFamily(context),
                              fontWeight: FontWeight.w500,
                              color: ColorManager.textSecondary,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          TextField(
                            controller: _costController,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontFamily: FontHelper.fontFamily(context),
                              fontWeight: FontWeight.w700,
                              color: ColorManager.textPrimary,
                            ),
                            decoration: _inputDecoration('\$0').copyWith(
                              prefixText: '\$ ',
                              prefixStyle: TextStyle(
                                fontSize: 24.sp,
                                fontFamily: FontHelper.fontFamily(context),
                                fontWeight: FontWeight.w700,
                                color: ColorManager.textTertiary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Notes
                    CustomCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Notes (optional)',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontFamily: FontHelper.fontFamily(context),
                              fontWeight: FontWeight.w500,
                              color: ColorManager.textSecondary,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          TextField(
                            controller: _notesController,
                            maxLines: 3,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: FontHelper.fontFamily(context),
                              color: ColorManager.textPrimary,
                            ),
                            decoration:
                                _inputDecoration('Add any notes...'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Save button
                    GestureDetector(
                      onTap: _save,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        decoration: BoxDecoration(
                          color: ColorManager.primary,
                          borderRadius: BorderRadiusManager.lg,
                        ),
                        child: Text(
                          'Add Treatment',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontFamily: FontHelper.fontFamily(context),
                            fontWeight: FontWeight.w600,
                            color: ColorManager.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeList(String title, List<TreatmentTypeInfo> types) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: FontHelper.fontFamily(context),
            fontWeight: FontWeight.w500,
            color: ColorManager.textTertiary,
          ),
        ),
        SizedBox(height: 6.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: types.map((type) {
            final isSelected = _selectedType?.id == type.id;
            return GestureDetector(
              onTap: () => _selectType(type),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 10.h,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? ColorManager.primary.withValues(alpha: 0.1)
                      : ColorManager.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: isSelected
                        ? ColorManager.primary
                        : ColorManager.borderLight,
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      type.icon,
                      size: 16.w,
                      color: isSelected
                          ? ColorManager.primary
                          : ColorManager.textSecondary,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      type.nameEn,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: isSelected
                            ? ColorManager.primary
                            : ColorManager.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        fontSize: 14.sp,
        color: ColorManager.textTertiary,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      filled: true,
      fillColor: ColorManager.gray50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: ColorManager.borderLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: ColorManager.borderLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: ColorManager.primary),
      ),
    );
  }
}
