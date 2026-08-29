import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/patients/domain/entities/patient_entity.dart';
import 'package:dental_clinic_app/features/patients/presentation/manager/add_patient/add_patient_bloc.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
  final _scrollController = ScrollController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _medicalHistoryController = TextEditingController();
  final _allergiesController = TextEditingController();

  /// Starts on a value rather than empty - gender is required, and an
  /// unanswered required field is a complaint waiting to happen.
  String _gender = PatientGenders.defaultValue;
  DateTime? _dateOfBirth;

  PatientFormErrors _errors = PatientFormErrors.none;

  /// Errors only appear after the first save attempt, then keep themselves
  /// current on every keystroke. Flagging empty fields before the user has
  /// tried to submit anything reads as nagging.
  bool _submitted = false;

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
    if (next.hasAny != _errors.hasAny ||
        next.firstName != _errors.firstName ||
        next.lastName != _errors.lastName ||
        next.phone != _errors.phone ||
        next.dateOfBirth != _errors.dateOfBirth) {
      setState(() => _errors = next);
    }
  }

  Future<void> _pickDateOfBirth() async {
    final picked = await DatePickerSheet.show(
      context,
      title: AppLocalizations.of(context)!.dateOfBirth,
      initial: _dateOfBirth,
    );
    if (picked == null || !mounted) return;
    setState(() => _dateOfBirth = picked);
    _revalidate();
  }

  void _savePatient() {
    FocusScope.of(context).unfocus();
    final l10n = AppLocalizations.of(context)!;
    final errors = _validate();

    setState(() {
      _submitted = true;
      _errors = errors;
    });

    if (errors.hasAny) {
      // Every required field lives in the first card, so returning to the top
      // is enough to put all of them in view.
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

    final dob = _dateOfBirth!;
    final now = DateTime.now();
    final age =
        now.year -
        dob.year -
        ((now.month < dob.month ||
                (now.month == dob.month && now.day < dob.day))
            ? 1
            : 0);

    final patient = PatientEntity(
      id: '',
      name:
          '${_firstNameController.text.trim()} '
          '${_lastNameController.text.trim()}',
      age: age,
      gender: _gender,
      phone: _phoneController.text.trim(),
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final wide = Responsive.isDesktop(context);

    return BlocListener<AddPatientBloc, AddPatientState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          saving: () {
            AppLoadingDialog.show(
              context: context,
              message: l10n.savingPatient,
            );
          },
          success: (patient) async {
            AppLoadingDialog.dismiss(context);
            UserStorage.notifyPatientsChanged();

            if (!context.mounted) return;
            final shouldAddTreatment = await PatientSavedSheet.show(context);

            if (shouldAddTreatment == true) {
              if (context.mounted) {
                context.pushReplacementNamed(
                  AppRoutesNames.addTreatment,
                  extra: {
                    'patientId': patient.id,
                    'patientName': patient.name,
                    'isInitial': true,
                  },
                );
              }
            } else {
              if (context.mounted) context.pop();
            }
          },
          error: (message) {
            AppLoadingDialog.dismiss(context);
            AppSnackbar.showError(context, title: l10n.error, message: message);
          },
        );
      },
      child: AdaptivePageScaffold(
        title: l10n.addPatient,
        onBack: () => context.pop(),
        backgroundColor: c.scaffoldBg,
        mobileHeader: FormTopBar(
          title: l10n.addPatient,
          onBack: () => context.pop(),
        ),
        body: SafeArea(
          bottom: false,
          top: false,
          child: SingleChildScrollView(
            controller: _scrollController,
            // The window is the column on desktop: a phone-width form
            // floating in the middle of a monitor reads as a mistake, and the
            // fields pair up rather than stretch, so the width buys content.
            padding: wide
                ? const EdgeInsets.fromLTRB(24, 20, 24, 32)
                : EdgeInsets.fromLTRB(14.w, 8.h, 14.w, 24.h),
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
              onDateOfBirthTap: _pickDateOfBirth,
              onFieldChanged: _revalidate,
            ),
          ),
        ),
        bottomNavigationBar: FormActionBar(
          label: l10n.save,
          onPressed: _savePatient,
        ),
      ),
    );
  }
}
