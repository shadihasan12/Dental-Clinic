import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';

/// Step 1: Patient personal, contact, and medical information form
class PatientInfoForm extends StatefulWidget {
  const PatientInfoForm({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.phoneController,
    required this.emailController,
    required this.addressController,
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
  final TextEditingController emailController;
  final TextEditingController addressController;
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
    return Column(
      children: [
        _buildPersonalInfoSection(),
        SizedBox(height: 16.h),
        _buildContactSection(),
        SizedBox(height: 16.h),
        _buildMedicalHistorySection(),
        SizedBox(height: 80.h),
      ],
    );
  }

  Widget _buildPersonalInfoSection() {
    return SectionCard(
      title: 'Personal Information',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppFormField(
            label: 'First Name *',
            controller: widget.firstNameController,
          ),
          SizedBox(height: 16.h),
          AppFormField(
            label: 'Last Name *',
            controller: widget.lastNameController,
          ),
          SizedBox(height: 16.h),
          AppDateField(
            label: 'Date of Birth',
            value: widget.dateOfBirth,
            onTap: widget.onDateOfBirthTap,
          ),
          SizedBox(height: 16.h),
          AppDropdownField(
            label: 'Gender',
            value: widget.selectedGender,
            items: const ['Male', 'Female', 'Other'],
            onChanged: widget.onGenderChanged,
            hint: 'Select gender',
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return SectionCard(
      title: 'Contact Information',
      child: Column(
        children: [
          AppFormField(
            label: 'Phone Number *',
            controller: widget.phoneController,
            hintText: '0988026431',
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: 16.h),
          AppFormField(
            label: 'Email',
            controller: widget.emailController,
            hintText: 'patient@email.com',
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 16.h),
          AppFormField(
            label: 'Address',
            controller: widget.addressController,
            hintText: '123 Main Street',
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalHistorySection() {
    return SectionCard(
      title: 'Medical History',
      child: Column(
        children: [
          AppFormField(
            label: 'Medical History',
            controller: widget.medicalHistoryController,
            hintText: 'Previous dental procedures, conditions, etc.',
            maxLines: 3,
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Has Allergies',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    fontFamily: FontFamily.geist,
                  ),
                ),
              ),
              Switch(
                value: _hasAllergies,
                onChanged: (value) {
                  setState(() {
                    _hasAllergies = value;
                    if (!value) {
                      widget.allergiesController.clear();
                    }
                  });
                },
              ),
            ],
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: _hasAllergies
                ? Column(
                    children: [
                      SizedBox(height: 16.h),
                      AppFormField(
                        label: 'Allergies',
                        controller: widget.allergiesController,
                        hintText: 'List any known allergies',
                        maxLines: 2,
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
