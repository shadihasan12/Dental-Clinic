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
  final _scrollController = ScrollController();
  late String _gender;
  DateTime? _dateOfBirth;
  PatientFormErrors _errors = PatientFormErrors.none;

  /// Errors stay hidden until the first save attempt, then track edits.
  bool _submitted = false;

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
    _gender = PatientGenders.normalise(widget.patient.gender);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _medicalHistoryController.dispose();
    _allergiesController.dispose();
    super.dispose();
  }

  PatientFormErrors _validate() {
    return PatientFormErrors.validate(
      AppLocalizations.of(context)!,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      phone: _phoneController.text,
      dateOfBirth: _dateOfBirth,
    );
  }

  void _revalidate() {
    if (!_submitted) return;
    final next = _validate();
    if (next.firstName != _errors.firstName ||
        next.lastName != _errors.lastName ||
        next.phone != _errors.phone ||
        next.dateOfBirth != _errors.dateOfBirth) {
      setState(() => _errors = next);
    }
  }

  Future<void> _selectDate() async {
    final picked = await DatePickerSheet.show(
      context,
      title: AppLocalizations.of(context)!.dateOfBirth,
      initial: _dateOfBirth,
    );
    if (picked == null || !mounted) return;
    setState(() => _dateOfBirth = picked);
    _revalidate();
  }

  Future<void> _save() async {
    FocusScope.of(context).unfocus();
    final l10n = AppLocalizations.of(context)!;
    final errors = _validate();

    setState(() {
      _submitted = true;
      _errors = errors;
    });

    if (errors.hasAny) {
      // Every required field is in the first card, so the top of the
      // scroll puts all of them in view at once.
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
      AppSnackbar.showError(
        context,
        title: l10n.error,
        message: l10n.checkHighlightedFields,
      );
      return;
    }

    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final phone = _phoneController.text.trim();
    final dob = _dateOfBirth!;
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
      gender: _gender,
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
    final c = ColorManager.of(context);

    return Scaffold(
      backgroundColor: c.scaffoldBg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              color: c.surfaceBg,
              padding: EdgeInsetsDirectional.fromSTEB(4.w, 4.h, 14.w, 6.h),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      size: 18.w,
                      color: c.textPrimary,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      l10n.editPatient,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: FontHelper.fontFamily(context),
                        color: c.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.fromLTRB(14.w, 8.h, 14.w, 24.h),
                child: PatientInfoForm(
                  firstNameController: _firstNameController,
                  lastNameController: _lastNameController,
                  phoneController: _phoneController,
                  medicalHistoryController: _medicalHistoryController,
                  allergiesController: _allergiesController,
                  gender: _gender,
                  dateOfBirth: _dateOfBirth,
                  errors: _errors,
                  onGenderChanged: (v) => setState(() => _gender = v),
                  onDateOfBirthTap: _selectDate,
                  onFieldChanged: _revalidate,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: FormActionBar(
        label: l10n.save,
        onPressed: _save,
      ),
    );
  }
}
