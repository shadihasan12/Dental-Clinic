import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import '../widgets/widgets.dart';

/// Add new patient page
class AddPatientPage extends StatefulWidget {
  const AddPatientPage({super.key});

  @override
  State<AddPatientPage> createState() => _AddPatientPageState();
}

class _AddPatientPageState extends State<AddPatientPage> {
  // Form controllers
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _medicalHistoryController = TextEditingController();
  final _allergiesController = TextEditingController();
  String? _selectedGender;
  DateTime? _dateOfBirth;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _medicalHistoryController.dispose();
    _allergiesController.dispose();
    super.dispose();
  }

  Future<void> _savePatient() async {
    // Show loading dialog
    AppLoadingDialog.show(context: context, message: 'Saving Patient...');

    // Simulate saving process
    await Future.delayed(const Duration(seconds: 2));

    // Close loading dialog
    if (mounted) AppLoadingDialog.dismiss(context);

    // Show success dialog with treatment option
    if (mounted) {
      final shouldAddTreatment = await AppConfirmationDialog.show(
        context: context,
        title: 'Patient Saved Successfully!',
        subtitle: 'Would you like to add treatment for this patient?',
        icon: Icons.check_circle,
      );

      if (shouldAddTreatment == true) {
        // Navigate to add treatment page
        if (mounted) {
          context.pushNamed(
            AppRoutesNames.addTreatment,
            extra: {'dentalCase': '', 'isInitial': true},
          );
        }
      } else {
        // Go back to patients list
        if (mounted) context.pop();
      }
    }
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? DateTime(1990),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: Color(0xFF70B2B2)),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() => _dateOfBirth = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF70B2B2),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorManager.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Add New Patient',
          style: TextStyle(
            color: ColorManager.white,
            fontSize: 18.sp,
            fontFamily: FontFamily.geist,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: PatientInfoForm(
          firstNameController: _firstNameController,
          lastNameController: _lastNameController,
          phoneController: _phoneController,
          emailController: _emailController,
          addressController: _addressController,
          medicalHistoryController: _medicalHistoryController,
          allergiesController: _allergiesController,
          selectedGender: _selectedGender,
          dateOfBirth: _dateOfBirth,
          onGenderChanged: (v) => setState(() => _selectedGender = v),
          onDateOfBirthTap: _selectDate,
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: ColorManager.white,
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: ElevatedButton(
            onPressed: _savePatient,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF70B2B2),
              foregroundColor: ColorManager.white,
              elevation: 2,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Save Patient',
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: FontFamily.geist,
                fontWeight: FontWeight.w600,
                color: ColorManager.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
