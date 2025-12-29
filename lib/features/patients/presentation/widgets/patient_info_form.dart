import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';

/// Step 1: Patient personal, contact, and medical information form
class PatientInfoForm extends StatelessWidget {
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
          Row(
            children: [
              Expanded(
                child: AppFormField(
                  label: 'First Name *',
                  controller: firstNameController,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: AppFormField(
                  label: 'Last Name *',
                  controller: lastNameController,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          AppDateField(
            label: 'Date of Birth',
            value: dateOfBirth,
            onTap: onDateOfBirthTap,
          ),
          SizedBox(height: 16.h),
          AppDropdownField(
            label: 'Gender',
            value: selectedGender,
            items: const ['Male', 'Female', 'Other'],
            onChanged: onGenderChanged,
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
            controller: phoneController,
            hintText: '(555) 123-4567',
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: 16.h),
          AppFormField(
            label: 'Email',
            controller: emailController,
            hintText: 'patient@email.com',
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 16.h),
          AppFormField(
            label: 'Street Address',
            controller: addressController,
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
            controller: medicalHistoryController,
            hintText: 'Previous dental procedures, conditions, etc.',
            maxLines: 3,
          ),
          SizedBox(height: 16.h),
          AppFormField(
            label: 'Allergies',
            controller: allergiesController,
            hintText: 'List any known allergies',
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
