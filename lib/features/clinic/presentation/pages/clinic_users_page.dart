import 'package:dental_clinic_app/core/utils/bloc_settled.dart';
import 'package:dental_clinic_app/core/utils/system_insets.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
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

  /// Pulls the roster and the seat usage together - the limit chips read off
  /// the usage call, so refreshing one without the other leaves them disagreeing.
  Future<void> _refresh() async {
    final bloc = context.read<ClinicUsersBloc>();
    bloc.add(const ClinicUsersEvent.load());
    await Future.wait([
      _loadUsage(),
      bloc.stream.settled(
        (state) => state.maybeWhen(loading: () => false, orElse: () => true),
      ),
    ]);
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
                    Padding(
                      padding: EdgeInsetsDirectional.only(end: 10.w),
                      child: DentaButton(
                        label: l10n.newButton,
                        icon: Icons.add,
                        onTap: () => _onAddUser(context, l10n),
                      ),
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
                child: DentaRefresh(
                  onRefresh: _refresh,
                  child: isLoading
                      ? const _UsersSkeleton()
                      : state.maybeWhen(
                          error: (msg) => _buildError(context, l10n, msg),
                          orElse: () => users.isEmpty
                              ? _buildEmpty(context, l10n)
                              : _buildList(context, l10n, users),
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmpty(BuildContext context, AppLocalizations l10n) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 28.h),
      child: StateCard(
        icon: Icons.people_outline,
        title: l10n.noUsersYet,
        message: l10n.noUsersYetHint,
        actionLabel: l10n.addUser,
        onAction: () => _onAddUser(context, l10n),
      ),
    );
  }

  Widget _buildError(BuildContext context, AppLocalizations l10n, String msg) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 28.h),
      child: StateCard(
        icon: Icons.cloud_off_rounded,
        tone: ColorManager.error,
        title: l10n.clinicUsersLoadFailed,
        message: msg,
        actionLabel: l10n.retry,
        onAction: () =>
            context.read<ClinicUsersBloc>().add(const ClinicUsersEvent.load()),
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
      padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 24.h),
      itemCount: users.length,
      separatorBuilder: (_, _) => SizedBox(height: 8.h),
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
      useSafeArea: true,
      backgroundColor: ColorManager.of(context).cardBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.only(bottom: systemBottomInset(context)),
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
                indent: 57.w,
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
                  indent: 57.w,
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
      useSafeArea: true,
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
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);

    // Centre dialog, because removing a user is destructive: the consequence
    // is stated in a tinted box rather than left implied.
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: c.cardBg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        titlePadding: EdgeInsets.fromLTRB(18.w, 18.h, 18.w, 0),
        contentPadding: EdgeInsets.fromLTRB(18.w, 10.h, 18.w, 0),
        actionsPadding: EdgeInsets.fromLTRB(18.w, 14.h, 18.w, 16.h),
        title: Row(
          children: [
            const IconTile(
              icon: Icons.person_remove_outlined,
              tone: ColorManager.error,
            ),
            SizedBox(width: 11.w),
            Expanded(
              child: Text(
                l10n.removeUser,
                style: TextStyle(
                  fontFamily: family,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: c.textPrimary,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.removeUserConfirmation(user.fullName),
              style: TextStyle(
                fontFamily: family,
                fontSize: 12.sp,
                height: 1.5,
                color: c.textSecondary,
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 9.h),
              decoration: BoxDecoration(
                color: c.errorBg,
                borderRadius: BorderRadius.circular(11.r),
                border: Border.all(color: ColorManager.errorBorder),
              ),
              child: Text(
                l10n.removeUserConsequence,
                style: TextStyle(
                  fontFamily: family,
                  fontSize: 11.sp,
                  height: 1.45,
                  fontWeight: FontWeight.w500,
                  color: ColorManager.error,
                ),
              ),
            ),
          ],
        ),
        actions: [
          DentaOutlineButton(
            label: l10n.cancel,
            onTap: () => Navigator.pop(dialogContext),
          ),
          DentaButton(
            label: l10n.removeUser,
            tone: ColorManager.destructive,
            onTap: () {
              Navigator.pop(dialogContext);
              context.read<ClinicUsersBloc>().add(
                ClinicUsersEvent.removeUser(user.id),
              );
            },
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
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorManager.of(context).borderLight),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onMore,
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: ColorManager.primary.withValues(alpha: 0.15),
                  backgroundImage: user.imageUrl != null
                      ? NetworkImage(user.imageUrl!)
                      : null,
                  child: user.imageUrl == null
                      ? Text(
                          _initials(),
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: ColorManager.primaryDarker,
                          ),
                        )
                      : null,
                ),
                SizedBox(width: 11.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.5.sp,
                          fontFamily: FontHelper.fontFamily(context),
                          fontWeight: FontWeight.w600,
                          color: ColorManager.of(context).textPrimary,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        user.email,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11.sp,
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
                Icon(
                  Icons.more_vert,
                  color: ColorManager.of(context).textSubtle,
                  size: 18.w,
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
    final c = ColorManager.of(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(14.w, 6.h, 14.w, 10.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: ColorManager.primary.withValues(alpha: 0.15),
            backgroundImage: user.imageUrl != null
                ? NetworkImage(user.imageUrl!)
                : null,
            child: user.imageUrl == null
                ? Text(
                    _initials(user.fullName),
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.primaryDarker,
                    ),
                  )
                : null,
          ),
          SizedBox(width: 11.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  user.fullName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w700,
                    color: c.textPrimary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  user.email,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    color: c.textTertiary,
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
    final c = ColorManager.of(context);
    final tone = destructive ? ColorManager.error : ColorManager.primary;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 11.h),
        child: Row(
          children: [
            IconTile(icon: icon, tone: tone),
            SizedBox(width: 11.w),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12.5.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: FontWeight.w600,
                  color: destructive ? ColorManager.error : c.textPrimary,
                ),
              ),
            ),
            DirectionalChevron(size: 18.w, color: c.textSubtle),
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

    final c = ColorManager.of(context);
    return Container(
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
      ),
      padding: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, bottomInset + 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          SizedBox(height: 14.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.manageRoles,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        fontWeight: FontWeight.w700,
                        color: c.textPrimary,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      widget.user.fullName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        color: c.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Icon(Icons.close, size: 20.w, color: c.textSecondary),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          for (final role in _allRoles) ...[
            _RoleRow(
              label: _roleLabel(context, role),
              selected: _selectedRoles.contains(role),
              onTap: () => setState(() {
                _selectedRoles.contains(role)
                    ? _selectedRoles.remove(role)
                    : _selectedRoles.add(role);
              }),
            ),
            SizedBox(height: 8.h),
          ],
          SizedBox(height: 6.h),
          DentaButton(
            label: l10n.updateRoles,
            expand: true,
            onTap: _selectedRoles.isEmpty
                ? null
                : () {
                    context.read<ClinicUsersBloc>().add(
                      ClinicUsersEvent.updateRoles(
                        userId: widget.user.id,
                        roles: _selectedRoles.toList(),
                      ),
                    );
                    Navigator.pop(context);
                  },
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

/// One role, on or off. A bordered card rather than a Material checkbox
/// tile so it matches the selectable rows everywhere else in the app.
class _RoleRow extends StatelessWidget {
  const _RoleRow({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final radius = BorderRadius.circular(12.r);

    return Material(
      color: selected ? ColorManager.primary.withValues(alpha: 0.08) : c.cardBg,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(
              color: selected ? ColorManager.primary : c.borderLight,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.5.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                    color: selected
                        ? ColorManager.primaryDarker
                        : c.textPrimary,
                  ),
                ),
              ),
              Icon(
                selected
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked_rounded,
                size: 18.w,
                color: selected ? ColorManager.primaryDarker : c.textSubtle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Keeps the avatar, two text lines and the role chips in place while the
/// user list loads, so nothing jumps when it lands.
class _UsersSkeleton extends StatelessWidget {
  const _UsersSkeleton();

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 24.h),
      itemCount: 5,
      separatorBuilder: (_, _) => SizedBox(height: 8.h),
      itemBuilder: (_, _) => Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: c.cardBg,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: c.borderLight),
        ),
        // ignore: avoid_unnecessary_containers
        child: AppShimmer(
          child: Row(
            children: [
              ShimmerBox(
                width: 40.w,
                height: 40.w,
                radius: BorderRadius.circular(40.w),
              ),
              SizedBox(width: 11.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerBox(width: 130.w, height: 12.h),
                    SizedBox(height: 6.h),
                    ShimmerBox(width: 160.w, height: 10.h),
                    SizedBox(height: 8.h),
                    ShimmerBox(
                      width: 60.w,
                      height: 16.h,
                      radius: BorderRadius.circular(6.r),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
