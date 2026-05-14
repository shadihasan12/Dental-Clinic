import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/storage/token_storage.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';
import 'package:dental_clinic_app/features/clinic/presentation/bloc/invitation_bloc.dart';
import 'package:dental_clinic_app/features/clinic/presentation/bloc/my_clinics_bloc.dart';
import 'package:dental_clinic_app/features/clinic/presentation/widgets/invitation_card.dart';
import 'package:dental_clinic_app/features/clinic/presentation/widgets/pending_invitations_section.dart';
import 'package:dental_clinic_app/features/clinic/presentation/widgets/send_invite_sheet.dart';
import 'package:dental_clinic_app/features/root/presentation/pages/root_page.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MyClinicsPage extends StatelessWidget {
  const MyClinicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isAdmin = getIt<UserStorage>().isAdmin;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              getIt<MyClinicsBloc>()..add(const MyClinicsEvent.load()),
        ),
        BlocProvider(
          create: (_) {
            final bloc = getIt<InvitationBloc>()
              ..add(const InvitationEvent.loadReceivedInvitations());
            if (isAdmin) {
              bloc.add(const InvitationEvent.loadSentInvitations());
            }
            return bloc;
          },
        ),
      ],
      child: _MyClinicsContent(isAdmin: isAdmin),
    );
  }
}

class _MyClinicsContent extends StatefulWidget {
  final bool isAdmin;
  const _MyClinicsContent({required this.isAdmin});

  @override
  State<_MyClinicsContent> createState() => _MyClinicsContentState();
}

class _MyClinicsContentState extends State<_MyClinicsContent> {
  /// 0 = received, 1 = sent (admin only).
  int _activeTab = 0;

  /// Currently selected clinic id (the one the auth interceptor sends as
  /// `X-Selected-Clinic-id`). Read from [TokenStorage] on each rebuild so
  /// the "Active" badge stays accurate after the user picks a new clinic.
  String? get _activeClinicId => getIt<TokenStorage>().getClinicId();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: ColorManager.of(context).scaffoldBg,
      body: BlocConsumer<InvitationBloc, InvitationState>(
        listenWhen: (prev, curr) =>
            prev.sendSuccess != curr.sendSuccess ||
            prev.acceptSuccess != curr.acceptSuccess ||
            prev.rejectSuccess != curr.rejectSuccess ||
            prev.error != curr.error,
        listener: (context, state) {
          if (state.sendSuccess) {
            AppSnackbar.showSuccess(
              context,
              title: l10n.success,
              message: l10n.inviteSentSuccess,
            );
          }
          if (state.acceptSuccess) {
            AppSnackbar.showSuccess(
              context,
              title: l10n.invitationAccepted,
              message: l10n.invitationAcceptedMessage,
            );
            // Joining the clinic means a new membership row — refetch.
            context.read<MyClinicsBloc>().add(const MyClinicsEvent.load());
          }
          if (state.rejectSuccess) {
            AppSnackbar.showSuccess(
              context,
              title: l10n.invitationDeclined,
              message: l10n.invitationDeclinedMessage,
            );
          }
          if (state.error != null) {
            AppSnackbar.showError(
              context,
              title: l10n.error,
              message: state.error,
            );
          }
        },
        builder: (context, invitationState) {
          return Column(
            children: [
              PageHeader(
                title: l10n.myClinics,
                onBack: () => context.pop(),
                actions: widget.isAdmin
                    ? [
                        IconButton(
                          icon: Icon(
                            Icons.person_add_alt_outlined,
                            color: ColorManager.primary,
                            size: 22.w,
                          ),
                          tooltip: l10n.sendInvite,
                          onPressed: () => SendInviteSheet.show(context),
                        ),
                      ]
                    : null,
              ),
              Expanded(
                child: BlocBuilder<MyClinicsBloc, MyClinicsState>(
                  builder: (context, clinicsState) {
                    return clinicsState.when(
                      initial: () => const SizedBox.shrink(),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (message) => _buildClinicsError(context, message),
                      loaded: (clinics) => _buildLoaded(
                        context,
                        clinics: clinics,
                        invitationState: invitationState,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLoaded(
    BuildContext context, {
    required List<ClinicMembershipEntity> clinics,
    required InvitationState invitationState,
  }) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Clinics ───────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
            child: _SectionTitle(label: l10n.myClinics, count: clinics.length),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: clinics
                  .map((m) => _ClinicMembershipCard(
                        membership: m,
                        isActive: m.clinicId == _activeClinicId,
                        onTap: () =>
                            _showClinicActionsSheet(context, m),
                      ))
                  .toList(),
            ),
          ),

          SizedBox(height: 16.h),
          Divider(height: 1, color: ColorManager.of(context).borderLight),
          SizedBox(height: 16.h),

          // ── Invitations ───────────────────────────────────────────
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
            child: Row(
              children: [
                Icon(
                  Icons.mail_outline,
                  size: 20.w,
                  color: ColorManager.primary,
                ),
                SizedBox(width: 8.w),
                Text(
                  l10n.invitations,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    color: ColorManager.of(context).textPrimary,
                  ),
                ),
                const Spacer(),
                if (widget.isAdmin)
                  TextButton.icon(
                    onPressed: () => SendInviteSheet.show(context),
                    icon: Icon(Icons.add, size: 18.w),
                    label: Text(
                      l10n.sendInvite,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: ColorManager.primary,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          if (widget.isAdmin) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: _SegmentedTabs(
                tabs: [l10n.received, l10n.sent],
                activeIndex: _activeTab,
                onChanged: (i) => setState(() => _activeTab = i),
              ),
            ),
            SizedBox(height: 12.h),
          ],

          if (widget.isAdmin && _activeTab == 1)
            InvitationsList(
              mode: InvitationCardMode.sent,
              invitations: invitationState.sentInvitations,
              filter: invitationState.sentFilter,
              isLoading: invitationState.isLoading,
              isUpdating: invitationState.isUpdating,
              error: invitationState.error,
            )
          else
            InvitationsList(
              mode: InvitationCardMode.received,
              invitations: invitationState.receivedInvitations,
              filter: invitationState.receivedFilter,
              isLoading: invitationState.isLoading,
              isUpdating: invitationState.isUpdating,
              error: invitationState.error,
            ),
        ],
      ),
    );
  }

  Widget _buildClinicsError(BuildContext context, String message) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48.w,
              color: ColorManager.of(context).textTertiary,
            ),
            SizedBox(height: 12.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: ColorManager.of(context).textTertiary,
                fontFamily: FontHelper.fontFamily(context),
              ),
            ),
            SizedBox(height: 16.h),
            TextButton(
              onPressed: () => context
                  .read<MyClinicsBloc>()
                  .add(const MyClinicsEvent.load()),
              child: Text(
                l10n.retry,
                style: TextStyle(
                  color: ColorManager.primary,
                  fontSize: 14.sp,
                  fontFamily: FontHelper.fontFamily(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showClinicActionsSheet(
    BuildContext context,
    ClinicMembershipEntity membership,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final isActive = membership.clinicId == _activeClinicId;
    final canLeave = membership.role != ClinicRole.admin;

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
              _ClinicActionsHeader(membership: membership),
              SizedBox(height: 8.h),
              Divider(height: 1, color: ColorManager.of(context).borderLight),
              _ClinicActionRow(
                icon: isActive
                    ? Icons.check_circle_outline
                    : Icons.swap_horiz_rounded,
                label: isActive ? l10n.currentlyActive : l10n.useThisClinic,
                disabled: isActive,
                onTap: isActive
                    ? null
                    : () {
                        Navigator.pop(sheetContext);
                        _onSelectClinic(context, membership);
                      },
              ),
              if (canLeave) ...[
                Divider(
                  height: 1,
                  indent: 16.w,
                  color: ColorManager.of(context).borderLight,
                ),
                _ClinicActionRow(
                  icon: Icons.exit_to_app,
                  label: l10n.leaveClinic,
                  destructive: true,
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _showLeaveConfirmation(context, membership);
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onSelectClinic(
    BuildContext context,
    ClinicMembershipEntity membership,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    // The auth interceptor reads from TokenStorage on every request, so
    // saving here is enough to flip every subsequent call to the new
    // clinic. The user storage carries the display name for the home
    // header. profileUpdateNotifier rebuilds the home page.
    await getIt<TokenStorage>().saveClinicId(membership.clinicId);
    await getIt<UserStorage>().saveClinicName(membership.clinicName);
    UserStorage.notifyProfileUpdated();

    if (!context.mounted) return;

    AppSnackbar.showSuccess(
      context,
      title: l10n.success,
      message: l10n.clinicSelectedMessage(membership.clinicName),
    );

    // Jump back to the home tab and dismiss this screen.
    RootPage.selectedTab.value = 0;
    if (context.mounted) context.pop();
  }

  void _showLeaveConfirmation(
    BuildContext context,
    ClinicMembershipEntity membership,
  ) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: ColorManager.of(context).cardBg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        title: Text(
          l10n.leaveClinic,
          style: TextStyle(
            fontFamily: FontHelper.fontFamily(context),
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          l10n.leaveClinicConfirmation(membership.clinicName),
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
                fontSize: 14.sp,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            style: TextButton.styleFrom(foregroundColor: ColorManager.error),
            child: Text(
              l10n.leaveClinic,
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Section title ──────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String label;
  final int count;
  const _SectionTitle({required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16.sp,
            fontFamily: FontHelper.fontFamily(context),
            color: ColorManager.of(context).textPrimary,
          ),
        ),
        if (count > 0) ...[
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: ColorManager.primary,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              '$count',
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: FontHelper.fontFamily(context),
                color: ColorManager.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// ─── Segmented tab control (Received / Sent) ───────────────────────

class _SegmentedTabs extends StatelessWidget {
  final List<String> tabs;
  final int activeIndex;
  final ValueChanged<int> onChanged;

  const _SegmentedTabs({
    required this.tabs,
    required this.activeIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: c.cardBgSecondary,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          for (var i = 0; i < tabs.length; i++)
            Expanded(
              child: GestureDetector(
                onTap: () => onChanged(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  decoration: BoxDecoration(
                    color: activeIndex == i ? c.cardBg : Colors.transparent,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: activeIndex == i
                        ? [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.06),
                              blurRadius: 6,
                              offset: const Offset(0, 1),
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    tabs[i],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      fontWeight: activeIndex == i
                          ? FontWeight.w600
                          : FontWeight.w500,
                      color: activeIndex == i
                          ? c.textPrimary
                          : c.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ─── Clinic card ────────────────────────────────────────────────────

class _ClinicMembershipCard extends StatelessWidget {
  final ClinicMembershipEntity membership;
  final bool isActive;
  final VoidCallback onTap;

  const _ClinicMembershipCard({
    required this.membership,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final isAdmin = membership.role == ClinicRole.admin;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: c.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14.r),
          child: Padding(
            padding: EdgeInsets.all(14.w),
            child: Row(
              children: [
                Container(
                  width: 52.w,
                  height: 52.w,
                  decoration: BoxDecoration(
                    color: (isAdmin ? ColorManager.primary : ColorManager.info)
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.business,
                    color: isAdmin ? ColorManager.primary : ColorManager.info,
                    size: 26.w,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        membership.clinicName,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          fontFamily: FontHelper.fontFamily(context),
                          color: c.textPrimary,
                        ),
                      ),
                      if (membership.address != null &&
                          membership.address!.isNotEmpty) ...[
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 12.w,
                              color: c.textTertiary,
                            ),
                            SizedBox(width: 3.w),
                            Expanded(
                              child: Text(
                                membership.address!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontFamily: FontHelper.fontFamily(context),
                                  color: c.textTertiary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                      SizedBox(height: 6.h),
                      Wrap(
                        spacing: 6.w,
                        runSpacing: 4.h,
                        children: (membership.roles.isNotEmpty
                                ? membership.roles
                                : [membership.role])
                            .map((r) => _RoleChip(role: r))
                            .toList(),
                      ),
                    ],
                  ),
                ),
                if (isActive)
                  _ActiveBadge()
                else
                  Icon(Icons.chevron_right, color: c.textTertiary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RoleChip extends StatelessWidget {
  final ClinicRole role;
  const _RoleChip({required this.role});

  @override
  Widget build(BuildContext context) {
    final color = _color();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        _label(context),
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 11.sp,
          fontFamily: FontHelper.fontFamily(context),
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

// ─── Active badge ──────────────────────────────────────────────────

class _ActiveBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: ColorManager.success.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle,
            size: 12.w,
            color: ColorManager.success,
          ),
          SizedBox(width: 4.w),
          Text(
            l10n.active,
            style: TextStyle(
              fontSize: 10.sp,
              fontFamily: FontHelper.fontFamily(context),
              fontWeight: FontWeight.w700,
              color: ColorManager.success,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Clinic actions bottom sheet bits ──────────────────────────────

class _ClinicActionsHeader extends StatelessWidget {
  final ClinicMembershipEntity membership;
  const _ClinicActionsHeader({required this.membership});

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final isAdmin = membership.role == ClinicRole.admin;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: (isAdmin ? ColorManager.primary : ColorManager.info)
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.business,
              size: 22.w,
              color: isAdmin ? ColorManager.primary : ColorManager.info,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  membership.clinicName,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF111111),
                  ),
                ),
                if (membership.address != null &&
                    membership.address!.isNotEmpty) ...[
                  SizedBox(height: 2.h),
                  Text(
                    membership.address!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      color: c.textTertiary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ClinicActionRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool destructive;
  final bool disabled;

  const _ClinicActionRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.destructive = false,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final Color tint;
    if (disabled) {
      tint = ColorManager.success;
    } else if (destructive) {
      tint = ColorManager.error;
    } else {
      tint = ColorManager.primary;
    }
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        child: Row(
          children: [
            Icon(icon, size: 20.w, color: tint),
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
                      : disabled
                          ? c.textTertiary
                          : const Color(0xFF111111),
                ),
              ),
            ),
            if (!disabled)
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
