import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/features/patients/domain/entities/patient_entity.dart';
import 'package:dental_clinic_app/features/patients/presentation/manager/add_patient/add_patient_bloc.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import '../widgets/widgets.dart';

class AddPatientPage extends StatelessWidget {
  const AddPatientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AddPatientBloc>(),
      child: const _AddPatientContent(),
    );
  }
}

class _AddPatientContent extends StatefulWidget {
  const _AddPatientContent();

  @override
  State<_AddPatientContent> createState() => _AddPatientContentState();
}

class _AddPatientContentState extends State<_AddPatientContent> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _medicalHistoryController = TextEditingController();
  final _allergiesController = TextEditingController();
  String? _selectedGender;
  DateTime? _dateOfBirth;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _medicalHistoryController.dispose();
    _allergiesController.dispose();
    super.dispose();
  }

  String _mapGenderToApi(String? localizedGender) {
    final l10n = AppLocalizations.of(context)!;
    if (localizedGender == l10n.male) return 'MALE';
    if (localizedGender == l10n.female) return 'FEMALE';
    return 'OTHER';
  }

  void _savePatient() {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final phone = _phoneController.text.trim();

    if (firstName.isEmpty || lastName.isEmpty || phone.isEmpty) return;

    final now = DateTime.now();
    final dob = _dateOfBirth ?? DateTime(1990);
    final age = now.year - dob.year - ((now.month < dob.month || (now.month == dob.month && now.day < dob.day)) ? 1 : 0);

    final patient = PatientEntity(
      id: '',
      name: '$firstName $lastName',
      age: age,
      gender: _mapGenderToApi(_selectedGender),
      phone: phone,
      email: '',
      address: '',
      dateOfBirth: dob,
      medicalHistory: _medicalHistoryController.text.trim().isEmpty
          ? null
          : _medicalHistoryController.text.trim(),
      allergies: _allergiesController.text.trim().isEmpty
          ? null
          : _allergiesController.text.trim(),
    );

    context.read<AddPatientBloc>().add(AddPatientEvent.submit(patient));
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
    return BlocListener<AddPatientBloc, AddPatientState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          saving: () {
            AppLoadingDialog.show(context: context, message: l10n.savingPatient);
          },
          success: (patient) async {
            AppLoadingDialog.dismiss(context);

            final shouldAddTreatment = await AppConfirmationDialog.show(
              context: context,
              title: l10n.patientSavedSuccessfully,
              subtitle: l10n.addTreatmentQuestion,
              icon: Icons.check_circle,
            );

            if (shouldAddTreatment == true) {
              if (context.mounted) {
                context.pushReplacementNamed(
                  AppRoutesNames.addTreatment,
                  extra: {'patientId': patient.id, 'isInitial': true},
                );
              }
            } else {
              if (context.mounted) context.pop();
            }
          },
          error: (message) {
            AppLoadingDialog.dismiss(context);
            AppSnackbar.showError(
              context,
              title: l10n.error,
              message: message,
            );
          },
        );
      },
      child: Scaffold(
        backgroundColor: ColorManager.white,
        body: Column(
          children: [
            PageHeader(title: l10n.addPatient, onBack: () => context.pop()),
            Expanded(
              child: SingleChildScrollView(
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
            ),
          ],
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
      ),
    );
  }
}
