import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/patients/domain/entities/patient_entity.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/update_patient_use_case.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../widgets/widgets.dart';

class EditPatientPage extends StatefulWidget {
  final PatientEntity patient;

  const EditPatientPage({super.key, required this.patient});

  @override
  State<EditPatientPage> createState() => _EditPatientPageState();
}

class _EditPatientPageState extends State<EditPatientPage> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _medicalHistoryController;
  late final TextEditingController _allergiesController;
  String? _selectedGender;
  DateTime? _dateOfBirth;

  @override
  void initState() {
    super.initState();
    final parts = widget.patient.name.trim().split(RegExp(r'\s+'));
    _firstNameController = TextEditingController(text: parts.first);
    _lastNameController = TextEditingController(
      text: parts.length > 1 ? parts.sublist(1).join(' ') : '',
    );
    _phoneController = TextEditingController(text: widget.patient.phone);
    _medicalHistoryController =
        TextEditingController(text: widget.patient.medicalHistory ?? '');
    _allergiesController =
        TextEditingController(text: widget.patient.allergies ?? '');
    _dateOfBirth = widget.patient.dateOfBirth;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _medicalHistoryController.dispose();
    _allergiesController.dispose();
    super.dispose();
  }

  String _localizedGenderFromApi() {
    final l10n = AppLocalizations.of(context)!;
    switch (widget.patient.gender.toUpperCase()) {
      case 'MALE':
        return l10n.male;
      case 'FEMALE':
        return l10n.female;
      default:
        return l10n.other;
    }
  }

  String _mapGenderToApi(String? localizedGender) {
    final l10n = AppLocalizations.of(context)!;
    if (localizedGender == l10n.male) return 'MALE';
    if (localizedGender == l10n.female) return 'FEMALE';
    return 'OTHER';
  }

  Future<void> _selectDate() async {
    FocusScope.of(context).unfocus();
    final l10n = AppLocalizations.of(context)!;
    DateTime tempDate = _dateOfBirth ?? DateTime(1990);

    await showModalBottomSheet(
      context: context,
      backgroundColor: ColorManager.of(context).cardBg,
      useSafeArea: true,
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
                        color: ColorManager.of(context).textTertiary,
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
                        color: ColorManager.primary,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: FontHelper.fontFamily(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: ColorManager.of(context).divider),
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

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context)!;
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final phone = _phoneController.text.trim();
    if (firstName.isEmpty || lastName.isEmpty || phone.isEmpty) return;

    final dob = _dateOfBirth ?? widget.patient.dateOfBirth;
    final now = DateTime.now();
    final age = now.year -
        dob.year -
        ((now.month < dob.month ||
                (now.month == dob.month && now.day < dob.day))
            ? 1
            : 0);

    final updated = widget.patient.copyWith(
      name: '$firstName $lastName',
      age: age,
      gender: _mapGenderToApi(_selectedGender),
      phone: phone,
      dateOfBirth: dob,
      medicalHistory: _medicalHistoryController.text.trim().isEmpty
          ? null
          : _medicalHistoryController.text.trim(),
      allergies: _allergiesController.text.trim().isEmpty
          ? null
          : _allergiesController.text.trim(),
    );

    AppLoadingDialog.show(context: context, message: l10n.updatingPatient);
    final result = await getIt<UpdatePatientUseCase>()(updated);
    if (!mounted) return;
    AppLoadingDialog.dismiss(context);

    result.fold(
      (error) => AppSnackbar.showError(
        context,
        title: l10n.error,
        message: NetworkExceptions.getErrorMessage(error),
      ),
      (_) {
        UserStorage.notifyPatientsChanged();
        AppSnackbar.showSuccess(
          context,
          title: l10n.success,
          message: l10n.patientUpdated,
        );
        context.pop(true);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    _selectedGender ??= _localizedGenderFromApi();
    return Scaffold(
      backgroundColor: ColorManager.of(context).cardBg,
      body: Column(
        children: [
          PageHeader(title: l10n.editPatient, onBack: () => context.pop()),
          Expanded(
            child: SingleChildScrollView(
              padding:
                  EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
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
            onPressed: _save,
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
