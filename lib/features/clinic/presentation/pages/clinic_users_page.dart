import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_user_entity.dart';
import 'package:dental_clinic_app/features/clinic/presentation/bloc/clinic_users_bloc.dart';
import 'package:dental_clinic_app/features/clinic/presentation/pages/add_clinic_user_page.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_usage_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/use_cases/get_subscription_usage_use_case.dart';
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

class _ClinicUsersContent extends StatefulWidget {
  const _ClinicUsersContent();

  @override
  State<_ClinicUsersContent> createState() => _ClinicUsersContentState();
}

class _ClinicUsersContentState extends State<_ClinicUsersContent> {
  SubscriptionUsageEntity? _usage;

  bool _isMetricReached(String key) {
    final m = _usage?.metric(key);
    if (m == null || m.isUnlimited) return false;
    return m.used >= m.limit!;
  }

  bool get _dentistsReached => _isMetricReached('dentists');
  bool get _secretariesReached => _isMetricReached('secretaries');

  @override
  void initState() {
    super.initState();
    _loadUsage();
  }

  Future<void> _loadUsage() async {
    final result = await getIt<GetSubscriptionUsageUseCase>()(NoParams());
    if (!mounted) return;
    setState(() {
      result.fold((_) => _usage = null, (u) => _usage = u);
    });
  }

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
                // Refetch usage so the limit reflects the new count
                _loadUsage();
              } else if (message == 'userRemovedSuccess') {
                text = l10n.userRemovedSuccess;
                _loadUsage();
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
              PageHeader(
                title: l10n.clinicUsers,
                onBack: () => context.pop(),
                actions: [
                  if (!isLoading && !isSubmitting)
                    IconButton(
                      icon: Icon(
                        Icons.person_add_outlined,
                        color: ColorManager.primary,
                        size: 22.w,
                      ),
                      onPressed: () => _onAddUser(context, l10n),
                    ),
                  if (isSubmitting)
                    Padding(
                      padding: EdgeInsets.only(right: 8.w),
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
          Icon(Icons.people_outline,
              size: 48.w, color: ColorManager.of(context).border),
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
            onPressed: () => _onAddUser(context, l10n),
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
          Icon(Icons.error_outline,
              size: 48.w, color: ColorManager.of(context).textTertiary),
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
            child: Text(
              l10n.retry,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
                color: ColorManager.of(context).textTertiary,
              ),
            ),
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
      separatorBuilder: (_, _) => SizedBox(height: 10.h),
      itemBuilder: (_, index) {
        final user = users[index];
        return _UserCard(
          user: user,
          isSelf: user.email == currentEmail,
          onMore: () => _showUserActionsSheet(context, l10n, user),
        );
      },
    );
  }

  void _onAddUser(BuildContext context, AppLocalizations l10n) {
    // Block entirely only when every limited role is full. If at least one
    // role still has capacity, let the user enter the form — the disabled
    // chips on that page will steer them to a role they can actually pick.
    if (_dentistsReached && _secretariesReached) {
      InfoPopup.show(
        context: context,
        icon: Icons.lock_outline_rounded,
        title: l10n.subscriptionLimitTitle,
        body: l10n.dentistLimitMessage,
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<ClinicUsersBloc>(),
          child: AddClinicUserPage(
            dentistsReached: _dentistsReached,
            secretariesReached: _secretariesReached,
          ),
        ),
      ),
    );
  }

  void _showUserActionsSheet(
    BuildContext context,
    AppLocalizations l10n,
    ClinicUserEntity user,
  ) {
    final isSelf = user.email == getIt<UserStorage>().getUserEmail();
    // Three-way gate on the destructive "Remove" action:
    //   • only an admin may delete (the page itself is admin-only, but
    //     we double-check at the action level)
    //   • users can't remove themselves
    //   • the clinic owner can't be removed by anyone, even other admins
    final canRemove = getIt<UserStorage>().isAdmin && !isSelf && !user.isOwner;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetContext) => SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 12.h, 0, 12.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              SizedBox(height: 14.h),
              _ActionsHeader(user: user),
              SizedBox(height: 8.h),
              Divider(height: 1, color: ColorManager.of(context).borderLight),
              _ActionRow(
                icon: Icons.manage_accounts_outlined,
                label: l10n.manageRoles,
                onTap: () {
                  Navigator.pop(sheetContext);
                  _showManageRolesSheet(context, l10n, user);
                },
              ),
              Divider(
                height: 1,
                indent: 16.w,
                color: ColorManager.of(context).borderLight,
              ),
              _ActionRow(
                icon: Icons.schedule_outlined,
                label: l10n.manageWorkingHours,
                onTap: () {
                  Navigator.pop(sheetContext);
                  context.pushNamed(
                    AppRoutesNames.userHours,
                    pathParameters: {'userId': user.id},
                    extra: <String, dynamic>{'userName': user.fullName},
                  );
                },
              ),
              if (canRemove) ...[
                Divider(
                  height: 1,
                  indent: 16.w,
                  color: ColorManager.of(context).borderLight,
                ),
                _ActionRow(
                  icon: Icons.person_remove_outlined,
                  label: l10n.removeUser,
                  destructive: true,
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _confirmRemove(context, l10n, user);
                  },
                ),
              ],
            ],
          ),
        ),
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
  final VoidCallback onMore;

  const _UserCard({
    required this.user,
    required this.isSelf,
    required this.onMore,
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
          onTap: onMore,
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.all(14.w),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22.r,
                  backgroundColor:
                      ColorManager.primary.withValues(alpha: 0.12),
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
                IconButton(
                  onPressed: onMore,
                  icon: Icon(
                    Icons.more_vert,
                    color: ColorManager.of(context).textTertiary,
                    size: 20.w,
                  ),
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

// ─── Actions Bottom Sheet helpers ─────────────────────────────────────────────

class _ActionsHeader extends StatelessWidget {
  final ClinicUserEntity user;
  const _ActionsHeader({required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: ColorManager.primary.withValues(alpha: 0.1),
            backgroundImage: user.imageUrl != null
                ? NetworkImage(user.imageUrl!)
                : null,
            child: user.imageUrl == null
                ? Text(
                    _initials(user.fullName),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.primary,
                    ),
                  )
                : null,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  user.fullName,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF111111),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  user.email,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    color: const Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _initials(String name) {
    final parts = name.split(' ').where((p) => p.isNotEmpty).toList();
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts.isNotEmpty ? parts.first[0].toUpperCase() : '?';
  }
}

class _ActionRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool destructive;

  const _ActionRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.destructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = destructive ? ColorManager.error : ColorManager.primary;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        child: Row(
          children: [
            Icon(icon, size: 20.w, color: color),
            SizedBox(width: 14.w),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: FontWeight.w500,
                  color: destructive
                      ? ColorManager.error
                      : const Color(0xFF111111),
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 18.w,
              color: const Color(0xFFB5B5B5),
            ),
          ],
        ),
      ),
    );
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
