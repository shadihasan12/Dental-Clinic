import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import '../widgets/widgets.dart';

class AddPatientPage extends StatefulWidget {
  const AddPatientPage({super.key});

  @override
  State<AddPatientPage> createState() => _AddPatientPageState();
}

class _AddPatientPageState extends State<AddPatientPage> {
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
    final l10n = AppLocalizations.of(context)!;
    AppLoadingDialog.show(context: context, message: l10n.savingPatient);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) AppLoadingDialog.dismiss(context);

    if (mounted) {
      final shouldAddTreatment = await AppConfirmationDialog.show(
        context: context,
        title: l10n.patientSavedSuccessfully,
        subtitle: l10n.addTreatmentQuestion,
        icon: Icons.check_circle,
      );

      if (shouldAddTreatment == true) {
        if (mounted) {
          context.pushReplacementNamed(
            AppRoutesNames.addTreatment,
            extra: {'caseId': 123, 'isInitial': true},
          );
        }
      } else {
        if (mounted) context.pop();
      }
    }
  }

  Future<void> _selectDate() async {
    final l10n = AppLocalizations.of(context)!;
    DateTime tempDate = _dateOfBirth ?? DateTime(1990);

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) => SizedBox(
        height: 300.h,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      l10n.cancel,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.sp,
                        fontFamily: FontHelper.fontFamily(context),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() => _dateOfBirth = tempDate);
                      Navigator.pop(context);
                    },
                    child: Text(
                      l10n.close,
                      style: TextStyle(
                        color: const Color(0xFF70B2B2),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: FontHelper.fontFamily(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: Colors.grey.shade200),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _dateOfBirth ?? DateTime(1990),
                minimumDate: DateTime(1900),
                maximumDate: DateTime.now(),
                onDateTimeChanged: (date) => tempDate = date,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: PageHeader(
        title: l10n.addPatient,
        onBack: () => context.pop(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: PatientInfoForm(
          firstNameController: _firstNameController,
          lastNameController: _lastNameController,
          phoneController: _phoneController,
          medicalHistoryController: _medicalHistoryController,
          allergiesController: _allergiesController,
          selectedGender: _selectedGender,
          dateOfBirth: _dateOfBirth,
          onGenderChanged: (v) => setState(() => _selectedGender = v),
          onDateOfBirthTap: _selectDate,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 8.h),
        child: SafeArea(
          top: false,
          child: ElevatedButton(
            onPressed: _savePatient,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primary,
              foregroundColor: ColorManager.white,
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              l10n.save,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
