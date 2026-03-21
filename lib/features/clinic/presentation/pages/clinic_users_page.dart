import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/specialty_entity.dart';
import 'package:dental_clinic_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_user_entity.dart';
import 'package:dental_clinic_app/features/clinic/presentation/bloc/clinic_users_bloc.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ClinicUsersPage extends StatelessWidget {
  final String clinicId;

  const ClinicUsersPage({super.key, required this.clinicId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<ClinicUsersBloc>(param1: clinicId)
            ..add(const ClinicUsersEvent.load()),
      child: const _ClinicUsersContent(),
    );
  }
}

class _ClinicUsersContent extends StatelessWidget {
  const _ClinicUsersContent();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManager.of(context).scaffoldBg,
      body: BlocConsumer<ClinicUsersBloc, ClinicUsersState>(
        listener: (context, state) {
          state.maybeWhen(
            submitSuccess: (_, message) {
              String text;
              if (message == 'userAddedSuccess') {
                text = l10n.userAddedSuccess;
              } else if (message == 'userRemovedSuccess') {
                text = l10n.userRemovedSuccess;
              } else {
                text = l10n.rolesUpdatedSuccess;
              }
              AppSnackbar.showSuccess(
                context,
                title: l10n.success,
                message: text,
              );
              context.read<ClinicUsersBloc>().add(
                const ClinicUsersEvent.load(),
              );
            },
            submitError: (_, message) {
              AppSnackbar.showError(
                context,
                title: l10n.error,
                message: message,
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          final users = state.maybeWhen(
            loaded: (u) => u,
            submitting: (u) => u,
            submitSuccess: (u, _) => u,
            submitError: (u, _) => u,
            orElse: () => <ClinicUserEntity>[],
          );
          final isLoading = state.maybeWhen(
            loading: () => true,
            orElse: () => false,
          );
          final isSubmitting = state.maybeWhen(
            submitting: (_) => true,
            orElse: () => false,
          );

          return Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                color: ColorManager.of(context).cardBg,
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 8.h,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            color: ColorManager.of(context).textPrimary,
                            size: 20.w,
                          ),
                          onPressed: () => context.pop(),
                        ),
                        Expanded(
                          child: Text(
                            l10n.clinicUsers,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontFamily: FontHelper.fontFamily(context),
                              fontWeight: FontWeight.w600,
                              color: ColorManager.of(context).textPrimary,
                            ),
                          ),
                        ),
                        if (!isLoading && !isSubmitting)
                          IconButton(
                            icon: Icon(
                              Icons.person_add_outlined,
                              color: ColorManager.primary,
                              size: 22.w,
                            ),
                            onPressed: () => _showAddUserSheet(context, l10n),
                          ),
                        if (isSubmitting)
                          Padding(
                            padding: EdgeInsets.only(right: 16.w),
                            child: SizedBox(
                              width: 20.w,
                              height: 20.w,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: ColorManager.primary,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(height: 1, color: ColorManager.of(context).borderLight),

              // Body
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : state.maybeWhen(
                        error: (msg) => _buildError(context, l10n, msg),
                        orElse: () => users.isEmpty
                            ? _buildEmpty(context, l10n)
                            : _buildList(context, l10n, users),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmpty(BuildContext context, AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.people_outline, size: 48.w, color: ColorManager.of(context).border),
          SizedBox(height: 12.h),
          Text(
            l10n.noUsersYet,
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: FontHelper.fontFamily(context),
              color: ColorManager.of(context).textTertiary,
            ),
          ),
          SizedBox(height: 8.h),
          TextButton(
            onPressed: () =>
                _showAddUserSheet(context, AppLocalizations.of(context)!),
            child: Text(
              l10n.addUser,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
                color: ColorManager.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context, AppLocalizations l10n, String msg) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, size: 48.w, color: ColorManager.of(context).textTertiary),
          SizedBox(height: 12.h),
          Text(
            msg,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: ColorManager.of(context).textTertiary,
              fontFamily: FontHelper.fontFamily(context),
            ),
          ),
          SizedBox(height: 12.h),
          TextButton(
            onPressed: () => context.read<ClinicUsersBloc>().add(
              const ClinicUsersEvent.load(),
            ),
            child: Text(l10n.retry),
          ),
        ],
      ),
    );
  }

  Widget _buildList(
    BuildContext context,
    AppLocalizations l10n,
    List<ClinicUserEntity> users,
  ) {
    final currentEmail = getIt<UserStorage>().getUserEmail();
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      itemCount: users.length,
      separatorBuilder: (_, __) => SizedBox(height: 10.h),
      itemBuilder: (_, index) {
        final user = users[index];
        return _UserCard(
          user: user,
          isSelf: user.email == currentEmail,
          onManageRoles: () => _showManageRolesSheet(context, l10n, user),
          onRemove: () => _confirmRemove(context, l10n, user),
        );
      },
    );
  }

  void _showAddUserSheet(BuildContext context, AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<ClinicUsersBloc>(),
        child: _AddUserSheet(l10n: l10n),
      ),
    );
  }

  void _showManageRolesSheet(
    BuildContext context,
    AppLocalizations l10n,
    ClinicUserEntity user,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<ClinicUsersBloc>(),
        child: _ManageRolesSheet(user: user, l10n: l10n),
      ),
    );
  }

  void _confirmRemove(
    BuildContext context,
    AppLocalizations l10n,
    ClinicUserEntity user,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: ColorManager.of(context).cardBg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        title: Text(
          l10n.removeUser,
          style: TextStyle(
            fontFamily: FontHelper.fontFamily(context),
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: ColorManager.error,
          ),
        ),
        content: Text(
          l10n.removeUserConfirmation(user.fullName),
          style: TextStyle(
            fontFamily: FontHelper.fontFamily(context),
            fontSize: 14.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              l10n.cancel,
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                color: ColorManager.of(context).textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<ClinicUsersBloc>().add(
                ClinicUsersEvent.removeUser(user.id),
              );
            },
            style: TextButton.styleFrom(foregroundColor: ColorManager.error),
            child: Text(
              l10n.removeUser,
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── User Card ────────────────────────────────────────────────────────────────

class _UserCard extends StatelessWidget {
  final ClinicUserEntity user;
  final bool isSelf;
  final VoidCallback onManageRoles;
  final VoidCallback onRemove;

  const _UserCard({
    required this.user,
    required this.isSelf,
    required this.onManageRoles,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.of(context).cardBg,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onManageRoles,
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.all(14.w),
            child: Row(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 22.r,
                  backgroundColor: ColorManager.primary.withValues(alpha: 0.12),
                  backgroundImage: user.imageUrl != null
                      ? NetworkImage(user.imageUrl!)
                      : null,
                  child: user.imageUrl == null
                      ? Text(
                          _initials(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: ColorManager.primary,
                          ),
                        )
                      : null,
                ),
                SizedBox(width: 12.w),

                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullName,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: FontHelper.fontFamily(context),
                          fontWeight: FontWeight.w600,
                          color: ColorManager.of(context).textPrimary,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        user.email,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: FontHelper.fontFamily(context),
                          color: ColorManager.of(context).textTertiary,
                        ),
                      ),
                      if (user.roles.isNotEmpty) ...[
                        SizedBox(height: 6.h),
                        Wrap(
                          spacing: 4.w,
                          runSpacing: 4.h,
                          children: user.roles
                              .map((r) => _RoleChip(role: r))
                              .toList(),
                        ),
                      ],
                    ],
                  ),
                ),

                // Actions
                PopupMenuButton<String>(
                  icon: Icon(
                    Icons.more_vert,
                    color: ColorManager.of(context).textTertiary,
                    size: 20.w,
                  ),
                  onSelected: (value) {
                    if (value == 'roles') onManageRoles();
                    if (value == 'remove') onRemove();
                  },
                  itemBuilder: (context) {
                    final l10n = AppLocalizations.of(context)!;
                    return [
                      PopupMenuItem(
                        value: 'roles',
                        child: Row(
                          children: [
                            Icon(
                              Icons.manage_accounts_outlined,
                              size: 18.w,
                              color: ColorManager.primary,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              l10n.manageRoles,
                              style: TextStyle(
                                fontFamily: FontHelper.fontFamily(context),
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!isSelf)
                        PopupMenuItem(
                          value: 'remove',
                          child: Row(
                            children: [
                              Icon(
                                Icons.person_remove_outlined,
                                size: 18.w,
                                color: ColorManager.error,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                l10n.removeUser,
                                style: TextStyle(
                                  fontFamily: FontHelper.fontFamily(context),
                                  fontSize: 13.sp,
                                  color: ColorManager.error,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ];
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _initials() {
    final parts = user.fullName.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return user.fullName.isNotEmpty ? user.fullName[0].toUpperCase() : '?';
  }
}

class _RoleChip extends StatelessWidget {
  final ClinicRole role;
  const _RoleChip({required this.role});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: _color().withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        _label(context),
        style: TextStyle(
          fontSize: 10.sp,
          fontFamily: FontHelper.fontFamily(context),
          fontWeight: FontWeight.w600,
          color: _color(),
        ),
      ),
    );
  }

  Color _color() {
    switch (role) {
      case ClinicRole.admin:
        return ColorManager.primary;
      case ClinicRole.dentist:
        return ColorManager.info;
      case ClinicRole.secretary:
      case ClinicRole.receptionist:
        return ColorManager.secondary;
    }
  }

  String _label(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (role) {
      case ClinicRole.admin:
        return l10n.roleAdmin;
      case ClinicRole.dentist:
        return l10n.roleDentist;
      case ClinicRole.secretary:
        return l10n.roleSecretary;
      case ClinicRole.receptionist:
        return l10n.roleReceptionist;
    }
  }
}

// ─── Add User Bottom Sheet ────────────────────────────────────────────────────

class _AddUserSheet extends StatefulWidget {
  final AppLocalizations l10n;
  const _AddUserSheet({required this.l10n});

  @override
  State<_AddUserSheet> createState() => _AddUserSheetState();
}

class _AddUserSheetState extends State<_AddUserSheet> {
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
    result.fold((_) {}, (list) => setState(() => _specialties = list));
    setState(() => _loadingSpecialties = false);
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

  bool get _canSubmit =>
      _firstNameCtrl.text.trim().isNotEmpty &&
      _lastNameCtrl.text.trim().isNotEmpty &&
      _emailCtrl.text.trim().isNotEmpty &&
      _mobileCtrl.text.trim().isNotEmpty &&
      _passwordCtrl.text.length >= 8 &&
      _passwordCtrl.text == _confirmCtrl.text &&
      _selectedRoles.isNotEmpty &&
      (!_isDentistSelected || _selectedSpecialty != null);

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final size = MediaQuery.of(context).size;

    return Container(
      constraints: BoxConstraints(maxHeight: size.height * 0.92),
      decoration: BoxDecoration(
        color: ColorManager.of(context).cardBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: ColorManager.of(context).border,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 8.h),
            child: Text(
              l10n.addUser,
              style: TextStyle(
                fontSize: 17.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w600,
                color: ColorManager.of(context).textPrimary,
              ),
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _field(l10n.firstName, _firstNameCtrl, context),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _field(l10n.lastName, _lastNameCtrl, context),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  _field(
                    l10n.emailAddress,
                    _emailCtrl,
                    context,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 12.h),
                  _field(
                    l10n.mobileNumber,
                    _mobileCtrl,
                    context,
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 12.h),
                  _passwordField(
                    l10n.password,
                    _passwordCtrl,
                    context,
                    _obscurePassword,
                    () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                  SizedBox(height: 12.h),
                  _passwordField(
                    l10n.confirmPassword,
                    _confirmCtrl,
                    context,
                    _obscureConfirm,
                    () {
                      setState(() => _obscureConfirm = !_obscureConfirm);
                    },
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    l10n.selectRoles,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      fontWeight: FontWeight.w600,
                      color: ColorManager.of(context).textPrimary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: _allRoles.map((role) {
                      final selected = _selectedRoles.contains(role);
                      return GestureDetector(
                        onTap: () => setState(() {
                          selected
                              ? _selectedRoles.remove(role)
                              : _selectedRoles.add(role);
                          if (!_isDentistSelected) _selectedSpecialty = null;
                        }),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: selected
                                ? ColorManager.primary
                                : ColorManager.of(context).inputBg,
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: selected
                                  ? ColorManager.primary
                                  : ColorManager.of(context).borderLight,
                            ),
                          ),
                          child: Text(
                            _roleLabel(context, role),
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontFamily: FontHelper.fontFamily(context),
                              fontWeight: FontWeight.w500,
                              color: selected
                                  ? Colors.white
                                  : ColorManager.of(context).textSecondary,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  if (_isDentistSelected) ...[
                    SizedBox(height: 16.h),
                    Text(
                      l10n.specialization,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        fontWeight: FontWeight.w600,
                        color: ColorManager.of(context).textPrimary,
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
                              color: ColorManager.of(context).inputBg,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: _selectedSpecialty != null
                                    ? ColorManager.primary
                                    : ColorManager.of(context).borderLight,
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<SpecialtyEntity>(
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
                                      fontFamily: FontHelper.fontFamily(
                                        context,
                                      ),
                                      color: ColorManager.of(context).textTertiary,
                                    ),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                borderRadius: BorderRadius.circular(10.r),
                                items: _specialties
                                    .map(
                                      (s) => DropdownMenuItem(
                                        value: s,
                                        child: Text(
                                          s.name,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontFamily: FontHelper.fontFamily(
                                              context,
                                            ),
                                            color: ColorManager.of(context).textPrimary,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (val) =>
                                    setState(() => _selectedSpecialty = val),
                              ),
                            ),
                          ),
                  ],
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, bottomInset + 20.h),
            child: GestureDetector(
              onTap: _canSubmit ? _submit : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                decoration: BoxDecoration(
                  color: _canSubmit
                      ? ColorManager.primary
                      : ColorManager.of(context).border,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
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
        ],
      ),
    );
  }

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
    Navigator.pop(context);
  }

  Widget _field(
    String label,
    TextEditingController ctrl,
    BuildContext context, {
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
    BuildContext context,
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
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      filled: true,
      fillColor: ColorManager.of(context).inputBg,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: ColorManager.of(context).borderLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: ColorManager.of(context).borderLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: ColorManager.primary),
      ),
    );
  }

  String _roleLabel(BuildContext context, String role) {
    final l10n = AppLocalizations.of(context)!;
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

// ─── Manage Roles Bottom Sheet ────────────────────────────────────────────────

class _ManageRolesSheet extends StatefulWidget {
  final ClinicUserEntity user;
  final AppLocalizations l10n;
  const _ManageRolesSheet({required this.user, required this.l10n});

  @override
  State<_ManageRolesSheet> createState() => _ManageRolesSheetState();
}

class _ManageRolesSheetState extends State<_ManageRolesSheet> {
  late Set<String> _selectedRoles;

  static const _allRoles = ['ADMIN', 'DENTIST', 'SECRETARY'];

  @override
  void initState() {
    super.initState();
    _selectedRoles = widget.user.roles.map(_roleToString).toSet();
  }

  String _roleToString(ClinicRole role) {
    switch (role) {
      case ClinicRole.admin:
        return 'ADMIN';
      case ClinicRole.dentist:
        return 'DENTIST';
      case ClinicRole.secretary:
      case ClinicRole.receptionist:
        return 'SECRETARY';
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: BoxDecoration(
        color: ColorManager.of(context).cardBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, bottomInset + 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: ColorManager.of(context).border,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            l10n.manageRoles,
            style: TextStyle(
              fontSize: 17.sp,
              fontFamily: FontHelper.fontFamily(context),
              fontWeight: FontWeight.w600,
              color: ColorManager.of(context).textPrimary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            widget.user.fullName,
            style: TextStyle(
              fontSize: 13.sp,
              fontFamily: FontHelper.fontFamily(context),
              color: ColorManager.of(context).textTertiary,
            ),
          ),
          SizedBox(height: 16.h),
          ..._allRoles.map((role) {
            final selected = _selectedRoles.contains(role);
            return CheckboxListTile(
              value: selected,
              onChanged: (val) => setState(() {
                val == true
                    ? _selectedRoles.add(role)
                    : _selectedRoles.remove(role);
              }),
              title: Text(
                _roleLabel(context, role),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  color: ColorManager.of(context).textPrimary,
                ),
              ),
              activeColor: ColorManager.primary,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
            );
          }),
          SizedBox(height: 8.h),
          GestureDetector(
            onTap: _selectedRoles.isNotEmpty
                ? () {
                    context.read<ClinicUsersBloc>().add(
                      ClinicUsersEvent.updateRoles(
                        userId: widget.user.id,
                        roles: _selectedRoles.toList(),
                      ),
                    );
                    Navigator.pop(context);
                  }
                : null,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              decoration: BoxDecoration(
                color: _selectedRoles.isNotEmpty
                    ? ColorManager.primary
                    : ColorManager.of(context).border,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                l10n.updateRoles,
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
        ],
      ),
    );
  }

  String _roleLabel(BuildContext context, String role) {
    final l10n = AppLocalizations.of(context)!;
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
