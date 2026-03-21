import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';

class PatientInfoForm extends StatefulWidget {
  const PatientInfoForm({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.phoneController,
    required this.medicalHistoryController,
    required this.allergiesController,
    required this.selectedGender,
    required this.dateOfBirth,
    required this.onGenderChanged,
    required this.onDateOfBirthTap,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final TextEditingController medicalHistoryController;
  final TextEditingController allergiesController;
  final String? selectedGender;
  final DateTime? dateOfBirth;
  final ValueChanged<String?> onGenderChanged;
  final VoidCallback onDateOfBirthTap;

  @override
  State<PatientInfoForm> createState() => _PatientInfoFormState();
}

class _PatientInfoFormState extends State<PatientInfoForm> {
  bool _hasAllergies = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // — Personal Information —
        _sectionLabel(context, l10n.personalInformation),
        SizedBox(height: 12.h),
        AppFormField(
          label: '${l10n.firstName} *',
          controller: widget.firstNameController,
        ),
        SizedBox(height: 14.h),
        AppFormField(
          label: '${l10n.lastName} *',
          controller: widget.lastNameController,
        ),
        SizedBox(height: 14.h),
        AppDateField(
          label: l10n.dateOfBirth,
          value: widget.dateOfBirth,
          onTap: widget.onDateOfBirthTap,
        ),
        SizedBox(height: 14.h),
        AppDropdownField(
          label: l10n.gender,
          value: widget.selectedGender,
          items: [l10n.male, l10n.female, l10n.other],
          onChanged: widget.onGenderChanged,
          hint: l10n.selectGender,
        ),
        SizedBox(height: 14.h),
        AppFormField(
          label: '${l10n.phone} *',
          controller: widget.phoneController,
          hintText: l10n.phoneHint,
          keyboardType: TextInputType.phone,
        ),

        // — Divider —
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Divider(color: ColorManager.of(context).divider),
        ),

        // — Medical History —
        _sectionLabel(context, l10n.medicalInformation),
        SizedBox(height: 12.h),
        AppFormField(
          label: l10n.medicalHistory,
          controller: widget.medicalHistoryController,
          hintText: l10n.previousDentalProcedures,
          maxLines: 3,
        ),
        SizedBox(height: 14.h),
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.hasAllergies,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorManager.of(context).textPrimary,
                  fontFamily: FontHelper.fontFamily(context),
                ),
              ),
            ),
            Switch(
              value: _hasAllergies,
              activeColor: ColorManager.white,
              onChanged: (value) {
                setState(() {
                  _hasAllergies = value;
                  if (!value) widget.allergiesController.clear();
                });
              },
            ),
          ],
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: _hasAllergies
              ? Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: AppFormField(
                    label: '',
                    controller: widget.allergiesController,
                    hintText: l10n.listAnyAllergies,
                    maxLines: 2,
                  ),
                )
              : const SizedBox.shrink(),
        ),
        SizedBox(height: 80.h),
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
}