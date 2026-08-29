import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/custom_widgets/adaptive_content_width.dart';
import 'package:dental_clinic_app/custom_widgets/adaptive_page_scaffold.dart';
import 'package:dental_clinic_app/custom_widgets/denta_form.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/specialty_entity.dart';
import 'package:dental_clinic_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dental_clinic_app/features/clinic/presentation/bloc/clinic_users_bloc.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AddClinicUserPage extends StatefulWidget {
  const AddClinicUserPage({
    super.key,
    this.dentistsReached = false,
    this.secretariesReached = false,
  });

  /// True when the subscription's dentist limit is at max. The DENTIST role
  /// chip on this page becomes greyed-out and non-tappable in that case.
  final bool dentistsReached;

  /// True when the subscription's secretary limit is at max. The SECRETARY
  /// role chip becomes greyed-out and non-tappable.
  final bool secretariesReached;

  @override
  State<AddClinicUserPage> createState() => _AddClinicUserPageState();
}

class _AddClinicUserPageState extends State<AddClinicUserPage> {
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _mobileCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  final _selectedRoles = <String>{};
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  List<SpecialtyEntity> _specialties = [];
  SpecialtyEntity? _selectedSpecialty;
  bool _loadingSpecialties = false;

  bool get _isDentistSelected => _selectedRoles.contains('DENTIST');

  static const _allRoles = ['ADMIN', 'DENTIST', 'SECRETARY'];

  @override
  void initState() {
    super.initState();
    _loadSpecialties();
  }

  Future<void> _loadSpecialties() async {
    setState(() => _loadingSpecialties = true);
    final result = await getIt<AuthRepository>().getSpecialties();
    if (!mounted) return;
    setState(() {
      result.fold((_) {}, (list) => _specialties = list);
      _loadingSpecialties = false;
    });
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _mobileCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  bool _isRoleDisabled(String role) {
    if (role == 'DENTIST') return widget.dentistsReached;
    if (role == 'SECRETARY') return widget.secretariesReached;
    return false;
  }

  bool get _canSubmit =>
      _firstNameCtrl.text.trim().isNotEmpty &&
      _lastNameCtrl.text.trim().isNotEmpty &&
      _emailCtrl.text.trim().isNotEmpty &&
      _mobileCtrl.text.trim().isNotEmpty &&
      _passwordCtrl.text.length >= 8 &&
      _passwordCtrl.text == _confirmCtrl.text &&
      _selectedRoles.isNotEmpty &&
      _selectedRoles.every((r) => !_isRoleDisabled(r)) &&
      (!_isDentistSelected || _selectedSpecialty != null);

  void _submit() {
    context.read<ClinicUsersBloc>().add(
          ClinicUsersEvent.addUser(
            firstName: _firstNameCtrl.text.trim(),
            lastName: _lastNameCtrl.text.trim(),
            email: _emailCtrl.text.trim(),
            mobileNumber: _mobileCtrl.text.trim(),
            password: _passwordCtrl.text,
            passwordConfirmation: _confirmCtrl.text,
            roles: _selectedRoles.toList(),
            specialtyId: _selectedSpecialty?.id,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);

    return BlocListener<ClinicUsersBloc, ClinicUsersState>(
      listenWhen: (prev, curr) => curr.maybeWhen(
        submitSuccess: (_, message) => message == 'userAddedSuccess',
        orElse: () => false,
      ),
      listener: (context, state) {
        if (mounted) context.pop();
      },
      child: BlocBuilder<ClinicUsersBloc, ClinicUsersState>(
        builder: (context, state) {
          final isSubmitting = state.maybeWhen(
            submitting: (_) => true,
            orElse: () => false,
          );

          final wide = Responsive.isDesktop(context);

          // Was a bare Scaffold with the mobile PageHeader, which on desktop
          // meant a phone title bar and no side nav - the page dropped out of
          // the shell the rest of the app lives in. AdaptivePageScaffold hands
          // desktop the real top bar and leaves mobile exactly as it was.
          return AdaptivePageScaffold(
            title: l10n.addUser,
            breadcrumb: l10n.clinicUsers,
            backgroundColor: c.scaffoldBg,
            onBack: () => context.pop(),
            bottomNavigationBar: FormActionBar(
              label: l10n.addUser,
              busy: isSubmitting,
              onPressed: _canSubmit ? _submit : null,
            ),
            body: SingleChildScrollView(
              padding: wide
                  ? const EdgeInsets.fromLTRB(24, 20, 24, 28)
                  : EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 24.h),
              child: AdaptiveContentWidth(
                // Narrower than a list page: this is six short controls, and
                // an email box half a metre wide is harder to read, not easier.
                maxWidth: 720,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FormSectionCard(
                      title: l10n.personalInformation,
                      children: [
                        // Was a raw Row, so the two boxes stayed pinned side by
                        // side however little room they had. Same 8px gap on a
                        // phone, but it can stack now if the box gets tight.
                        FormFieldRow(
                          minFieldWidth: 140,
                          spacing: 8,
                          children: [
                            FormTextField(
                              label: l10n.firstName,
                              required: true,
                              controller: _firstNameCtrl,
                              textCapitalization: TextCapitalization.words,
                              onChanged: () => setState(() {}),
                            ),
                            FormTextField(
                              label: l10n.lastName,
                              required: true,
                              controller: _lastNameCtrl,
                              textCapitalization: TextCapitalization.words,
                              onChanged: () => setState(() {}),
                            ),
                          ],
                        ),
                        // Contact details pair up on desktop and stay stacked on
                        // a phone, where an email address needs the full width.
                        FormFieldRow(
                          minFieldWidth: 240,
                          children: [
                            FormTextField(
                              label: l10n.emailAddress,
                              required: true,
                              controller: _emailCtrl,
                              keyboardType: TextInputType.emailAddress,
                              textDirection: TextDirection.ltr,
                              onChanged: () => setState(() {}),
                            ),
                            FormTextField(
                              label: l10n.mobileNumber,
                              controller: _mobileCtrl,
                              keyboardType: TextInputType.phone,
                              textDirection: TextDirection.ltr,
                              onChanged: () => setState(() {}),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    FormSectionCard(
                      title: l10n.password,
                      children: [
                        // The two password boxes are a natural pair to compare
                        // side by side once there is room for both.
                        FormFieldRow(
                          minFieldWidth: 240,
                          children: [
                            FormTextField(
                              label: l10n.password,
                              required: true,
                              controller: _passwordCtrl,
                              obscureText: _obscurePassword,
                              onChanged: () => setState(() {}),
                              suffix: _RevealToggle(
                                obscured: _obscurePassword,
                                onTap: () => setState(
                                  () => _obscurePassword = !_obscurePassword,
                                ),
                              ),
                            ),
                            FormTextField(
                              label: l10n.confirmPassword,
                              required: true,
                              controller: _confirmCtrl,
                              obscureText: _obscureConfirm,
                              onChanged: () => setState(() {}),
                              suffix: _RevealToggle(
                                obscured: _obscureConfirm,
                                onTap: () => setState(
                                  () => _obscureConfirm = !_obscureConfirm,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    FormSectionCard(
                      title: l10n.selectRoles,
                      children: [
                        Wrap(
                          spacing: 8.w,
                          runSpacing: 8.h,
                          children: _allRoles.map((role) {
                            final selected = _selectedRoles.contains(role);
                            final disabled = _isRoleDisabled(role);
                            return GestureDetector(
                              onTap: disabled
                                  ? null
                                  : () => setState(() {
                                        selected
                                            ? _selectedRoles.remove(role)
                                            : _selectedRoles.add(role);
                                        if (!_isDentistSelected) {
                                          _selectedSpecialty = null;
                                        }
                                      }),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 150),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14.w,
                                  vertical: 8.h,
                                ),
                                decoration: BoxDecoration(
                                  color: disabled
                                      ? c.cardBgSecondary
                                      : selected
                                          ? ColorManager.primary.withValues(
                                              alpha: 0.12,
                                            )
                                          : c.cardBg,
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(
                                    color: disabled
                                        ? c.borderLight
                                        : selected
                                            ? ColorManager.primary
                                            : c.borderLight,
                                    width: selected && !disabled ? 1.5 : 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (disabled) ...[
                                      Icon(
                                        Icons.lock_outline_rounded,
                                        size: 12.w,
                                        color: c.textTertiary,
                                      ),
                                      SizedBox(width: 4.w),
                                    ],
                                    Text(
                                      _roleLabel(l10n, role),
                                      style: TextStyle(
                                        fontSize: 11.5.sp,
                                        fontFamily: FontHelper.fontFamily(
                                          context,
                                        ),
                                        fontWeight: selected
                                            ? FontWeight.w600
                                            : FontWeight.w500,
                                        color: disabled
                                            ? c.textTertiary
                                            : selected
                                                ? ColorManager.primaryDarker
                                                : c.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        if (widget.dentistsReached || widget.secretariesReached)
                          _RoleLimitNote(
                            dentists: widget.dentistsReached,
                            secretaries: widget.secretariesReached,
                          ),
                        // Only a dentist has a specialty, so the field appears
                        // with the role rather than sitting there greyed out.
                        if (_isDentistSelected)
                          FormPickerField(
                            label: l10n.specialization,
                            value: _selectedSpecialty?.name,
                            placeholder: _loadingSpecialties
                                ? '...'
                                : l10n.selectSpecialization,
                            onTap: _loadingSpecialties || _specialties.isEmpty
                                ? null
                                : _pickSpecialty,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Specialties in a sheet rather than a dropdown menu, matching the
  /// picker on Edit Profile.
  Future<void> _pickSpecialty() async {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);

    await showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      backgroundColor: c.cardBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: c.borderLight,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 8.h),
              child: Text(
                l10n.specialization,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: family,
                  fontWeight: FontWeight.w600,
                  color: c.textPrimary,
                ),
              ),
            ),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _specialties.length,
                itemBuilder: (_, index) {
                  final spec = _specialties[index];
                  final isSelected = _selectedSpecialty?.id == spec.id;
                  return InkWell(
                    onTap: () {
                      setState(() => _selectedSpecialty = spec);
                      Navigator.pop(sheetContext);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 12.h,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 18.w,
                            height: 18.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? ColorManager.primary
                                    : c.border,
                                width: isSelected ? 5 : 1.5,
                              ),
                            ),
                          ),
                          SizedBox(width: 11.w),
                          Expanded(
                            child: Text(
                              spec.name,
                              style: TextStyle(
                                fontSize: 12.5.sp,
                                fontFamily: family,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                                color: isSelected
                                    ? ColorManager.primaryDarker
                                    : c.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  String _roleLabel(AppLocalizations l10n, String role) {
    switch (role) {
      case 'ADMIN':
        return l10n.roleAdmin;
      case 'DENTIST':
        return l10n.roleDentist;
      case 'SECRETARY':
        return l10n.roleSecretary;
      default:
        return role;
    }
  }
}

class _RoleLimitNote extends StatelessWidget {
  const _RoleLimitNote({required this.dentists, required this.secretaries});

  final bool dentists;
  final bool secretaries;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final lockedRoles = <String>[
      if (dentists) l10n.roleDentist,
      if (secretaries) l10n.roleSecretary,
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorManager.warning.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(11.r),
        border: Border.all(color: ColorManager.warning.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: 16.w,
            color: ColorManager.warning,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              l10n.roleLimitInfo(lockedRoles.join(' / ')),
              style: TextStyle(
                fontSize: 11.sp,
                fontFamily: FontHelper.fontFamily(context),
                color: c.textSecondary,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Show/hide control for a password field, shaped for [FormTextField.suffix].
class _RevealToggle extends StatelessWidget {
  const _RevealToggle({required this.obscured, required this.onTap});

  final bool obscured;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Icon(
        obscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
        size: 18,
        color: ColorManager.of(context).textTertiary,
      ),
    );
  }
}
