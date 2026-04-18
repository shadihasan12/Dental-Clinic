import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/custom_widgets/desktop_shell.dart';
import 'package:dental_clinic_app/features/patients/domain/entities/patient_entity.dart';
import 'package:dental_clinic_app/features/patients/presentation/manager/add_patient/add_patient_bloc.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/desktop/desktop_form_widgets.dart';
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
  bool _hasAllergies = false;

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

  bool get _canSave =>
      _firstNameController.text.trim().isNotEmpty &&
      _lastNameController.text.trim().isNotEmpty &&
      _phoneController.text.trim().isNotEmpty;

  void _savePatient() {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final phone = _phoneController.text.trim();

    if (firstName.isEmpty || lastName.isEmpty || phone.isEmpty) return;

    final now = DateTime.now();
    final dob = _dateOfBirth ?? DateTime(1990);
    final age = now.year -
        dob.year -
        ((now.month < dob.month ||
                (now.month == dob.month && now.day < dob.day))
            ? 1
            : 0);

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

  Future<void> _selectDateMobile() async {
    FocusScope.of(context).unfocus();
    final l10n = AppLocalizations.of(context)!;
    DateTime tempDate = _dateOfBirth ?? DateTime(1990);

    await showModalBottomSheet(
      context: context,
      backgroundColor: ColorManager.of(context).cardBg,
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

  Future<void> _selectDateDesktop() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? DateTime(1990),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: ColorManager.primary,
              ),
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
    final l10n = AppLocalizations.of(context)!;

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
            AppSnackbar.showError(
              context,
              title: l10n.error,
              message: message,
            );
          },
        );
      },
      child: Responsive.isDesktop(context)
          ? _buildDesktopLayout(l10n)
          : _buildMobileLayout(l10n),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // DESKTOP LAYOUT
  // ═══════════════════════════════════════════════════════════════

  Widget _buildDesktopLayout(AppLocalizations l10n) {
    final c = ColorManager.of(context);

    return DesktopShell(
      title: l10n.addPatient,
      body: Scaffold(
        backgroundColor: c.scaffoldBg,
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(28, 24, 28, 32),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 880),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DesktopPageHeader(
                    title: l10n.addPatient,
                    subtitle: l10n.personalInformation,
                  ),
                  const SizedBox(height: 20),
                  _desktopPersonalCard(l10n),
                  const SizedBox(height: 16),
                  _desktopMedicalCard(l10n),
                  const SizedBox(height: 20),
                  _desktopActionRow(l10n),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _desktopPersonalCard(AppLocalizations l10n) {
    return DesktopSectionCard(
      title: l10n.personalInformation,
      subtitle: '${l10n.firstName}, ${l10n.phone.toLowerCase()}',
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: DesktopTextField(
                  label: l10n.firstName,
                  controller: _firstNameController,
                  onChanged: (_) => setState(() {}),
                  isRequired: true,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DesktopTextField(
                  label: l10n.lastName,
                  controller: _lastNameController,
                  onChanged: (_) => setState(() {}),
                  isRequired: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: DesktopDateField(
                  label: l10n.dateOfBirth,
                  value: _dateOfBirth,
                  onTap: _selectDateDesktop,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DesktopDropdownField(
                  label: l10n.gender,
                  value: _selectedGender,
                  items: [l10n.male, l10n.female, l10n.other],
                  onChanged: (v) => setState(() => _selectedGender = v),
                  hint: l10n.selectGender,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          DesktopTextField(
            label: l10n.phone,
            controller: _phoneController,
            hintText: l10n.phoneHint,
            keyboardType: TextInputType.phone,
            onChanged: (_) => setState(() {}),
            isRequired: true,
          ),
        ],
      ),
    );
  }

  Widget _desktopMedicalCard(AppLocalizations l10n) {
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);
    return DesktopSectionCard(
      title: l10n.medicalInformation,
      subtitle: l10n.medicalHistory,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DesktopTextField(
            label: l10n.medicalHistory,
            controller: _medicalHistoryController,
            hintText: l10n.previousDentalProcedures,
            maxLines: 4,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: c.inputBg,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: c.borderLight),
            ),
            child: Row(
              children: [
                Icon(Icons.warning_amber_rounded,
                    size: 18, color: ColorManager.warning),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    l10n.hasAllergies,
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500,
                      color: c.textPrimary,
                    ),
                  ),
                ),
                Switch(
                  value: _hasAllergies,
                  activeThumbColor: Colors.white,
                  activeTrackColor: ColorManager.primary,
                  onChanged: (value) {
                    setState(() {
                      _hasAllergies = value;
                      if (!value) _allergiesController.clear();
                    });
                  },
                ),
              ],
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            child: _hasAllergies
                ? Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: DesktopTextField(
                      label: '',
                      controller: _allergiesController,
                      hintText: l10n.listAnyAllergies,
                      maxLines: 3,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _desktopActionRow(AppLocalizations l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        DesktopSecondaryButton(
          label: l10n.cancel,
          onPressed: () => context.pop(),
        ),
        const SizedBox(width: 12),
        DesktopPrimaryButton(
          label: l10n.save,
          icon: Icons.check,
          onPressed: _canSave ? _savePatient : null,
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // MOBILE LAYOUT (unchanged)
  // ═══════════════════════════════════════════════════════════════

  Widget _buildMobileLayout(AppLocalizations l10n) {
    return Scaffold(
      backgroundColor: ColorManager.of(context).cardBg,
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
                onDateOfBirthTap: _selectDateMobile,
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
    );
  }
}
