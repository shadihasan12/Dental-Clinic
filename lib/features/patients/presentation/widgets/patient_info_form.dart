import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/denta_form.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The gender values the API accepts.
///
/// The form holds the API value rather than the translated label so switching
/// language mid-form cannot orphan the selection.
class PatientGenders {
  PatientGenders._();

  static const String male = 'MALE';
  static const String female = 'FEMALE';

  /// What a fresh form starts on. A create form should never open with an
  /// empty required field it will only complain about later.
  static const String defaultValue = male;

  static const List<String> all = [male, female];

  /// Maps whatever the server sent onto one of the two values this form
  /// offers. Anything else - including the `OTHER` earlier builds could
  /// write - falls back to [defaultValue].
  static String normalise(String? raw) {
    return raw?.trim().toUpperCase() == female ? female : male;
  }

  static String label(AppLocalizations l10n, String value) =>
      value == female ? l10n.female : l10n.male;
}

/// Per-field validation messages. `null` means the field is fine.
///
/// Carried as one object so a page can hand the whole result of a validation
/// pass to the form in a single rebuild.
class PatientFormErrors {
  const PatientFormErrors({
    this.firstName,
    this.lastName,
    this.phone,
    this.dateOfBirth,
  });

  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? dateOfBirth;

  static const PatientFormErrors none = PatientFormErrors();

  bool get hasAny =>
      firstName != null ||
      lastName != null ||
      phone != null ||
      dateOfBirth != null;

  /// Runs the required-field checks. Everything here is required because the
  /// record is unusable without it: a patient with no name cannot be found
  /// again, no phone cannot be reached, and no date of birth makes every age
  /// on the clinical screens a guess.
  static PatientFormErrors validate(
    AppLocalizations l10n, {
    required String firstName,
    required String lastName,
    required String phone,
    required DateTime? dateOfBirth,
  }) {
    return PatientFormErrors(
      firstName: firstName.trim().isEmpty ? l10n.pleaseEnterFirstName : null,
      lastName: lastName.trim().isEmpty ? l10n.pleaseEnterLastName : null,
      phone: phone.trim().isEmpty ? l10n.pleaseEnterPhone : null,
      dateOfBirth: dateOfBirth == null ? l10n.pleaseSelectDateOfBirth : null,
    );
  }
}

/// The patient record form, shared by Add and Edit.
///
/// Two cards on the page ground: identity first, then the clinical fields.
/// Allergies stay visible as a stated answer rather than an empty box that
/// could be read either way - an unanswered allergy field and a confirmed
/// "none" must not look the same.
class PatientInfoForm extends StatefulWidget {
  const PatientInfoForm({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.phoneController,
    required this.medicalHistoryController,
    required this.allergiesController,
    required this.gender,
    required this.dateOfBirth,
    required this.onGenderChanged,
    required this.onDateOfBirthTap,
    this.errors = PatientFormErrors.none,
    this.onFieldChanged,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final TextEditingController medicalHistoryController;
  final TextEditingController allergiesController;

  /// An API value - see [PatientGenders]. Never null; the form always has a
  /// selection.
  final String gender;
  final DateTime? dateOfBirth;
  final ValueChanged<String> onGenderChanged;
  final VoidCallback onDateOfBirthTap;
  final PatientFormErrors errors;

  /// Fired on every edit so a page that has already failed a save can clear
  /// the error as soon as the field is fixed.
  final VoidCallback? onFieldChanged;

  @override
  State<PatientInfoForm> createState() => _PatientInfoFormState();
}

class _PatientInfoFormState extends State<PatientInfoForm> {
  late bool _hasAllergies =
      widget.allergiesController.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final e = widget.errors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FormSectionCard(
          title: l10n.personalInformation,
          children: [
            FormTextField(
              label: l10n.firstName,
              required: true,
              controller: widget.firstNameController,
              errorText: e.firstName,
              textCapitalization: TextCapitalization.words,
              onChanged: widget.onFieldChanged,
            ),
            FormTextField(
              label: l10n.lastName,
              required: true,
              controller: widget.lastNameController,
              errorText: e.lastName,
              textCapitalization: TextCapitalization.words,
              onChanged: widget.onFieldChanged,
            ),
            FormTextField(
              label: l10n.phone,
              required: true,
              controller: widget.phoneController,
              hintText: l10n.phoneHint,
              keyboardType: TextInputType.phone,
              errorText: e.phone,
              onChanged: widget.onFieldChanged,
            ),
            FormDateField(
              label: l10n.dateOfBirth,
              required: true,
              value: widget.dateOfBirth,
              onTap: widget.onDateOfBirthTap,
              errorText: e.dateOfBirth,
            ),
            _GenderPicker(
              label: l10n.gender,
              value: widget.gender,
              onChanged: widget.onGenderChanged,
            ),
          ],
        ),
        SizedBox(height: 8.h),
        FormSectionCard(
          title: l10n.medicalInformation,
          children: [
            // Allergies lead the clinical card: they are the one thing on
            // this form that changes what is safe to do at the chair.
            _AllergiesField(
              hasAllergies: _hasAllergies,
              controller: widget.allergiesController,
              onToggle: (value) {
                setState(() {
                  _hasAllergies = value;
                  if (!value) widget.allergiesController.clear();
                });
                widget.onFieldChanged?.call();
              },
              onChanged: widget.onFieldChanged,
            ),
            FormTextField(
              label: l10n.medicalHistory,
              controller: widget.medicalHistoryController,
              hintText: l10n.previousDentalProcedures,
              maxLines: 3,
              onChanged: widget.onFieldChanged,
            ),
          ],
        ),
      ],
    );
  }
}

/// Three chips in one track. A dropdown hid the fact that this always has an
/// answer; the chips show the current one without a tap.
class _GenderPicker extends StatelessWidget {
  const _GenderPicker({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;

    return FormFieldShell(
      label: label,
      child: Container(
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: c.cardBgSecondary,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: c.borderLight),
        ),
        child: Row(
          children: [
            for (final option in PatientGenders.all)
              Expanded(
                child: GestureDetector(
                  onTap: () => onChanged(option),
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    decoration: BoxDecoration(
                      color: option == value
                          ? ColorManager.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      PatientGenders.label(l10n, option),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: option == value
                            ? FontWeight.w600
                            : FontWeight.w500,
                        fontFamily: FontHelper.fontFamily(context),
                        color: option == value
                            ? ColorManager.white
                            : c.textSecondary,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Allergies are safety-critical, so the "off" state says out loud what will
/// be written to the record instead of leaving a blank that reads as unknown.
class _AllergiesField extends StatelessWidget {
  const _AllergiesField({
    required this.hasAllergies,
    required this.controller,
    required this.onToggle,
    required this.onChanged,
  });

  final bool hasAllergies;
  final TextEditingController controller;
  final ValueChanged<bool> onToggle;
  final VoidCallback? onChanged;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.hasAllergies,
                style: TextStyle(
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: family,
                  color: c.textPrimary,
                ),
              ),
            ),
            Switch(
              value: hasAllergies,
              onChanged: onToggle,
              activeThumbColor: ColorManager.white,
              activeTrackColor: ColorManager.primary,
            ),
          ],
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          alignment: Alignment.topCenter,
          child: hasAllergies
              ? Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: FormTextField(
                    label: l10n.allergies,
                    controller: controller,
                    hintText: l10n.listAnyAllergies,
                    maxLines: 2,
                    onChanged: onChanged,
                  ),
                )
              : Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 4.h),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: c.cardBgSecondary,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: c.borderLight),
                  ),
                  child: Text(
                    l10n.noKnownAllergiesRecorded,
                    style: TextStyle(
                      fontSize: 11.sp,
                      height: 1.35,
                      fontFamily: family,
                      color: c.textTertiary,
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
