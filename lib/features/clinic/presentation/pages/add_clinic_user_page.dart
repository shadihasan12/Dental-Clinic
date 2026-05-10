import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
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

          return Scaffold(
            backgroundColor: c.scaffoldBg,
            body: Column(
              children: [
                PageHeader(
                  title: l10n.addUser,
                  onBack: () => context.pop(),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _field(l10n.firstName, _firstNameCtrl),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: _field(l10n.lastName, _lastNameCtrl),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        _field(
                          l10n.emailAddress,
                          _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 12.h),
                        _field(
                          l10n.mobileNumber,
                          _mobileCtrl,
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(height: 12.h),
                        _passwordField(
                          l10n.password,
                          _passwordCtrl,
                          _obscurePassword,
                          () => setState(
                              () => _obscurePassword = !_obscurePassword),
                        ),
                        SizedBox(height: 12.h),
                        _passwordField(
                          l10n.confirmPassword,
                          _confirmCtrl,
                          _obscureConfirm,
                          () => setState(
                              () => _obscureConfirm = !_obscureConfirm),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          l10n.selectRoles,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontFamily: FontHelper.fontFamily(context),
                            fontWeight: FontWeight.w600,
                            color: c.textPrimary,
                          ),
                        ),
                        SizedBox(height: 8.h),
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
                                      ? c.inputBg
                                      : selected
                                          ? ColorManager.primary
                                          : c.inputBg,
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(
                                    color: disabled
                                        ? c.borderLight
                                        : selected
                                            ? ColorManager.primary
                                            : c.borderLight,
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
                                        fontSize: 13.sp,
                                        fontFamily:
                                            FontHelper.fontFamily(context),
                                        fontWeight: FontWeight.w500,
                                        color: disabled
                                            ? c.textTertiary
                                            : selected
                                                ? Colors.white
                                                : c.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        if (widget.dentistsReached ||
                            widget.secretariesReached) ...[
                          SizedBox(height: 8.h),
                          _RoleLimitNote(
                            dentists: widget.dentistsReached,
                            secretaries: widget.secretariesReached,
                          ),
                        ],
                        if (_isDentistSelected) ...[
                          SizedBox(height: 16.h),
                          Text(
                            l10n.specialization,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontFamily: FontHelper.fontFamily(context),
                              fontWeight: FontWeight.w600,
                              color: c.textPrimary,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          _loadingSpecialties
                              ? SizedBox(
                                  height: 48.h,
                                  child: Center(
                                    child: SizedBox(
                                      width: 20.w,
                                      height: 20.w,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: ColorManager.primary,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    color: c.inputBg,
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(
                                      color: _selectedSpecialty != null
                                          ? ColorManager.primary
                                          : c.borderLight,
                                    ),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child:
                                        DropdownButton<SpecialtyEntity>(
                                      value: _selectedSpecialty,
                                      isExpanded: true,
                                      hint: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12.w,
                                        ),
                                        child: Text(
                                          l10n.selectSpecialization,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontFamily:
                                                FontHelper.fontFamily(context),
                                            color: c.textTertiary,
                                          ),
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                      ),
                                      borderRadius: BorderRadius.circular(10.r),
                                      items: _specialties
                                          .map(
                                            (s) => DropdownMenuItem(
                                              value: s,
                                              child: Text(
                                                s.name,
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontFamily:
                                                      FontHelper.fontFamily(
                                                    context,
                                                  ),
                                                  color: c.textPrimary,
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (val) => setState(
                                          () => _selectedSpecialty = val),
                                    ),
                                  ),
                                ),
                        ],
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 20.h),
                  child: SafeArea(
                    top: false,
                    child: GestureDetector(
                      onTap: (_canSubmit && !isSubmitting) ? _submit : null,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        decoration: BoxDecoration(
                          color: (_canSubmit && !isSubmitting)
                              ? ColorManager.primary
                              : c.border,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: isSubmitting
                            ? SizedBox(
                                height: 18.h,
                                child: Center(
                                  child: SizedBox(
                                    width: 18.w,
                                    height: 18.w,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            : Text(
                                l10n.addUser,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontFamily: FontHelper.fontFamily(context),
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController ctrl, {
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: FontHelper.fontFamily(context),
            fontWeight: FontWeight.w500,
            color: ColorManager.of(context).textSecondary,
          ),
        ),
        SizedBox(height: 4.h),
        TextField(
          controller: ctrl,
          keyboardType: keyboardType,
          onChanged: (_) => setState(() {}),
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: FontHelper.fontFamily(context),
            color: ColorManager.of(context).textPrimary,
          ),
          decoration: _inputDecoration(),
        ),
      ],
    );
  }

  Widget _passwordField(
    String label,
    TextEditingController ctrl,
    bool obscure,
    VoidCallback toggle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: FontHelper.fontFamily(context),
            fontWeight: FontWeight.w500,
            color: ColorManager.of(context).textSecondary,
          ),
        ),
        SizedBox(height: 4.h),
        TextField(
          controller: ctrl,
          obscureText: obscure,
          onChanged: (_) => setState(() {}),
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: FontHelper.fontFamily(context),
            color: ColorManager.of(context).textPrimary,
          ),
          decoration: _inputDecoration().copyWith(
            suffixIcon: IconButton(
              icon: Icon(
                obscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 18.w,
                color: ColorManager.of(context).textTertiary,
              ),
              onPressed: toggle,
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration() {
    final c = ColorManager.of(context);
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      filled: true,
      fillColor: c.inputBg,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: c.borderLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: c.borderLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: ColorManager.primary),
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
  const _RoleLimitNote({
    required this.dentists,
    required this.secretaries,
  });

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
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: ColorManager.warning.withValues(alpha: 0.25),
        ),
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
                fontSize: 12.sp,
                fontFamily: FontHelper.fontFamily(context),
                color: c.textSecondary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
