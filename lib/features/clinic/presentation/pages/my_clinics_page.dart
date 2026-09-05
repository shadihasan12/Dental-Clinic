import 'package:dental_clinic_app/core/utils/bloc_settled.dart';
import 'package:dental_clinic_app/core/utils/system_insets.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/storage/token_storage.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/core/widgets/directional_chevron.dart';
import 'package:dental_clinic_app/core/widgets/state_card.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/appointments/presentation/widgets/selectable_chip.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/invitation_entity.dart';
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
  /// 0 = received, 1 = sent (admin only). Received and sent are genuinely
  /// parallel lists, which is the one case the design language still allows
  /// a switch for.
  int _activeTab = 0;

  /// Last known number of pending received invitations. The bloc replaces
  /// `receivedInvitations` with whatever status filter is active, so the count
  /// is only recomputable while that filter is Pending — remembering it keeps
  /// the header tile honest after the user browses Accepted or Declined.
  int _pendingReceived = 0;

  /// Currently selected clinic id (the one the auth interceptor sends as
  /// `X-Selected-Clinic-id`). Read from [TokenStorage] on each rebuild so
  /// the active marker stays accurate after the user picks a new clinic.
  String? get _activeClinicId => getIt<TokenStorage>().getClinicId();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);

    return Scaffold(
      backgroundColor: c.scaffoldBg,
      // The one action on this screen that creates something. Docked in the
      // thumb arc rather than hidden behind a header icon.
      bottomNavigationBar: widget.isAdmin
          ? _DockedInviteBar(
              label: l10n.sendInvite,
              onTap: () => SendInviteSheet.show(context),
            )
          : null,
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
          if (invitationState.receivedFilter == InvitationStatus.pending &&
              !invitationState.isLoading) {
            _pendingReceived = invitationState.receivedInvitations
                .where((i) => i.status == InvitationStatus.pending)
                .length;
          }

          return BlocBuilder<MyClinicsBloc, MyClinicsState>(
            builder: (context, clinicsState) {
              final clinics = clinicsState.maybeWhen(
                loaded: (clinics) => clinics,
                orElse: () => const <ClinicMembershipEntity>[],
              );

              String activeName = '';
              for (final m in clinics) {
                if (m.clinicId == _activeClinicId) {
                  activeName = m.clinicName;
                  break;
                }
              }
              if (activeName.isEmpty) {
                activeName = getIt<UserStorage>().getClinicName() ?? '';
              }

              final sentMode = widget.isAdmin && _activeTab == 1;

              return Column(
                children: [
                  PageHeader(
                    title: l10n.myClinics,
                    onBack: () => context.pop(),
                  ),

                  // The two values that must never require scrolling.
                  _ClinicsSummaryBar(
                    activeLabel: l10n.activeClinic,
                    activeValue: activeName.isEmpty
                        ? l10n.noneSelected
                        : activeName,
                    invitationsLabel: l10n.invitations,
                    invitationsValue: '$_pendingReceived',
                  ),

                  Expanded(
                    child: DentaRefresh(
                      onRefresh: _refresh,
                      child: ListView(
                        padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 28.h),
                        children: [
                          // No heading over the clinics: the screen is already
                          // called My Clinics.
                          _buildClinics(context, clinicsState),
                          SizedBox(height: 22.h),
                          _SectionHeading(
                            label: l10n.invitations,
                            count: _pendingReceived,
                          ),
                          SizedBox(height: 10.h),
                          // One row, not two: direction on the leading side,
                          // status as a menu on the trailing side.
                          _InvitationFilterRow(
                            isAdmin: widget.isAdmin,
                            sentMode: sentMode,
                            onModeChanged: (i) =>
                                setState(() => _activeTab = i),
                            status: sentMode
                                ? invitationState.sentFilter
                                : invitationState.receivedFilter,
                          ),
                          SizedBox(height: 12.h),
                          InvitationsList(
                            mode: sentMode
                                ? InvitationCardMode.sent
                                : InvitationCardMode.received,
                            invitations: sentMode
                                ? invitationState.sentInvitations
                                : invitationState.receivedInvitations,
                            filter: sentMode
                                ? invitationState.sentFilter
                                : invitationState.receivedFilter,
                            isLoading: invitationState.isLoading,
                            isUpdating: invitationState.isUpdating,
                            error: invitationState.error,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  /// Refetches the clinic list and whichever invitation directions this user
  /// can see, and holds the band until the clinic list settles.
  Future<void> _refresh() async {
    final clinics = context.read<MyClinicsBloc>();
    final invitations = context.read<InvitationBloc>();
    clinics.add(const MyClinicsEvent.load());
    invitations.add(const InvitationEvent.loadReceivedInvitations());
    if (widget.isAdmin) {
      invitations.add(const InvitationEvent.loadSentInvitations());
    }
    await clinics.stream.settled(
      (state) => state.maybeWhen(loading: () => false, orElse: () => true),
    );
  }

  // ── clinics list ────────────────────────────────────────────────────────

  Widget _buildClinics(BuildContext context, MyClinicsState state) {
    final l10n = AppLocalizations.of(context)!;
    return state.when(
      initial: () => const _ClinicsSkeleton(),
      loading: () => const _ClinicsSkeleton(),
      error: (message) => StateCard(
        icon: Icons.cloud_off_outlined,
        title: l10n.couldNotLoadClinics,
        message: message,
        detail: l10n.activeClinicUnchanged,
        tone: ColorManager.error,
        actionLabel: l10n.retry,
        onAction: () =>
            context.read<MyClinicsBloc>().add(const MyClinicsEvent.load()),
      ),
      loaded: (clinics) {
        if (clinics.isEmpty) {
          return StateCard(
            icon: Icons.business_outlined,
            title: l10n.noClinicsTitle,
            message: l10n.noClinicsMessage,
          );
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < clinics.length; i++) ...[
              if (i > 0) SizedBox(height: 8.h),
              _ClinicRow(
                membership: clinics[i],
                isActive: clinics[i].clinicId == _activeClinicId,
                onTap: () => _showClinicActionsSheet(context, clinics[i]),
              ),
            ],
          ],
        );
      },
    );
  }

  // ── clinic actions ──────────────────────────────────────────────────────

  void _showClinicActionsSheet(
    BuildContext context,
    ClinicMembershipEntity membership,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final isActive = membership.clinicId == _activeClinicId;
    final canLeave = membership.role != ClinicRole.admin;

    showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      backgroundColor: c.cardBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
      ),
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.only(bottom: systemBottomInset(context)),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 10.h, 0, 10.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: c.border,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              _SheetTitleRow(
                membership: membership,
                onClose: () => Navigator.pop(sheetContext),
              ),
              SizedBox(height: 6.h),
              Divider(height: 1, color: c.borderLight),
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
                Divider(height: 1, indent: 14.w, color: c.borderLight),
                _ClinicActionRow(
                  icon: Icons.logout_rounded,
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
    await getIt<UserStorage>().saveUserRole(membership.role.name);
    await getIt<UserStorage>().saveIsClinicOwner(membership.isOwner);
    // profileUpdated rebuilds widgets that read the cached clinic/role
    // (e.g. the home header); clinicChanged tells the root page to refetch
    // permissions and remount every tab so each clinic-scoped API reloads.
    UserStorage.notifyProfileUpdated();
    UserStorage.notifyClinicChanged();

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
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: c.cardBg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        titlePadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 10.h),
        contentPadding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 4.h),
        title: Text(
          l10n.leaveClinic,
          style: TextStyle(
            fontFamily: family,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: c.textPrimary,
          ),
        ),
        // A destructive confirmation states the consequence in its own tinted
        // box rather than in running text.
        content: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: ColorManager.errorBackground,
            borderRadius: BorderRadius.circular(13.r),
            border: Border.all(
              color: ColorManager.error.withValues(alpha: 0.35),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                size: 18.w,
                color: ColorManager.error,
              ),
              SizedBox(width: 9.w),
              Expanded(
                child: Text(
                  l10n.leaveClinicConfirmation(membership.clinicName),
                  style: TextStyle(
                    fontFamily: family,
                    fontSize: 11.5.sp,
                    height: 1.5,
                    color: ColorManager.error,
                  ),
                ),
              ),
            ],
          ),
        ),
        actionsPadding: EdgeInsets.fromLTRB(12.w, 6.h, 12.w, 10.h),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              l10n.cancel,
              style: TextStyle(
                fontFamily: family,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: c.textSecondary,
              ),
            ),
          ),
          TextButton(
            // TODO: no leave-clinic API yet — ClinicBloc.leaveClinic is a stub
            // that fakes success, so this deliberately only closes the dialog.
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              l10n.leaveClinic,
              style: TextStyle(
                fontFamily: family,
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: ColorManager.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Vitals bar ─────────────────────────────────────────────────────

/// The two things the user came for: which clinic every request is scoped to,
/// and how many invitations are waiting.
///
/// Sizes to its content rather than to a fixed height, so Arabic line heights
/// and a raised OS text scale make it taller instead of overflowing.
class _ClinicsSummaryBar extends StatelessWidget {
  const _ClinicsSummaryBar({
    required this.activeLabel,
    required this.activeValue,
    required this.invitationsLabel,
    required this.invitationsValue,
  });

  final String activeLabel;
  final String activeValue;
  final String invitationsLabel;
  final String invitationsValue;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final hasInvites = invitationsValue != '0';

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: c.surfaceBg,
        border: Border(bottom: BorderSide(color: c.borderLight)),
      ),
      padding: EdgeInsets.fromLTRB(14.w, 6.h, 14.w, 10.h),
      // The bar sizes to its content, so the Row's height is unbounded and
      // `stretch` alone would force h=Infinity on the tiles. IntrinsicHeight
      // gives both tiles the taller one's height.
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: _NumberTile(
                label: activeLabel,
                value: activeValue,
                emphasise: true,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              flex: 2,
              child: _NumberTile(
                label: invitationsLabel,
                value: invitationsValue,
                emphasise: hasInvites,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// One figure: uppercase micro-label above, the value below. Tinted in the
/// brand blue when it carries something the user acts on.
class _NumberTile extends StatelessWidget {
  const _NumberTile({
    required this.label,
    required this.value,
    required this.emphasise,
  });

  final String label;
  final String value;
  final bool emphasise;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: emphasise
            ? ColorManager.primary.withValues(alpha: 0.10)
            : c.cardBgSecondary,
        borderRadius: BorderRadius.circular(13.r),
        border: Border.all(
          color: emphasise
              ? ColorManager.primary.withValues(alpha: 0.35)
              : c.borderLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label.toUpperCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 9.5.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
              fontFamily: family,
              color: c.textTertiary,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 15.sp,
              height: 1.2,
              fontWeight: FontWeight.w700,
              fontFamily: family,
              color: emphasise ? ColorManager.primaryDarker : c.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Invitation filters ─────────────────────────────────────────────

/// One row for two different questions: whose invitations (received or sent,
/// admins only) on the leading side, and which status on the trailing side.
/// Status is a menu rather than a second row of chips — it is a narrowing
/// filter, not a place the user switches between constantly.
class _InvitationFilterRow extends StatelessWidget {
  const _InvitationFilterRow({
    required this.isAdmin,
    required this.sentMode,
    required this.onModeChanged,
    required this.status,
  });

  final bool isAdmin;
  final bool sentMode;
  final ValueChanged<int> onModeChanged;
  final InvitationStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        // Expanded, not Flexible beside a Spacer: the status menu is measured
        // first and the chips take every pixel that is left, so "Sent" is
        // never clipped.
        if (isAdmin)
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SelectableChip(
                    label: l10n.received,
                    isSelected: !sentMode,
                    onTap: () => onModeChanged(0),
                  ),
                  SizedBox(width: 8.w),
                  SelectableChip(
                    label: l10n.sent,
                    isSelected: sentMode,
                    onTap: () => onModeChanged(1),
                  ),
                ],
              ),
            ),
          )
        else
          const Spacer(),
        SizedBox(width: 8.w),
        _StatusFilterMenu(status: status, sentMode: sentMode),
      ],
    );
  }
}

class _StatusFilterMenu extends StatelessWidget {
  const _StatusFilterMenu({required this.status, required this.sentMode});

  final InvitationStatus status;
  final bool sentMode;

  static String _label(AppLocalizations l10n, InvitationStatus status) {
    switch (status) {
      case InvitationStatus.accepted:
        return l10n.accepted;
      case InvitationStatus.declined:
        return l10n.declined;
      case InvitationStatus.expired:
        return l10n.expired;
      case InvitationStatus.cancelled:
        return l10n.cancelled;
      case InvitationStatus.pending:
        return l10n.pending;
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);
    const options = [
      InvitationStatus.pending,
      InvitationStatus.accepted,
      InvitationStatus.declined,
    ];

    return PopupMenuButton<InvitationStatus>(
      initialValue: status,
      tooltip: '',
      position: PopupMenuPosition.under,
      color: c.cardBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13.r),
        side: BorderSide(color: c.borderLight),
      ),
      onSelected: (picked) {
        final bloc = context.read<InvitationBloc>();
        if (sentMode) {
          bloc.add(InvitationEvent.filterSentByStatus(picked));
        } else {
          bloc.add(InvitationEvent.filterReceivedByStatus(picked));
        }
      },
      itemBuilder: (_) => [
        for (final option in options)
          PopupMenuItem<InvitationStatus>(
            value: option,
            height: 40.h,
            child: Text(
              _label(l10n, option),
              style: TextStyle(
                fontSize: 12.5.sp,
                fontFamily: family,
                fontWeight: option == status
                    ? FontWeight.w600
                    : FontWeight.w500,
                color: option == status
                    ? ColorManager.primaryDarker
                    : c.textPrimary,
              ),
            ),
          ),
      ],
      child: Container(
        padding: EdgeInsetsDirectional.fromSTEB(11.w, 7.h, 8.w, 7.h),
        decoration: BoxDecoration(
          color: c.cardBg,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: c.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.tune_rounded, size: 14.w, color: c.textSecondary),
            SizedBox(width: 6.w),
            Text(
              _label(l10n, status),
              style: TextStyle(
                fontSize: 12.5.sp,
                fontFamily: family,
                fontWeight: FontWeight.w500,
                color: c.textPrimary,
              ),
            ),
            Icon(
              Icons.arrow_drop_down_rounded,
              size: 18.w,
              color: c.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Section heading ────────────────────────────────────────────────

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.label, required this.count});

  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13.sp,
            fontFamily: family,
            color: c.textPrimary,
          ),
        ),
        if (count > 0) ...[
          SizedBox(width: 7.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: ColorManager.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              '$count',
              style: TextStyle(
                fontSize: 10.sp,
                fontFamily: family,
                fontWeight: FontWeight.w500,
                color: ColorManager.primaryDarker,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// ─── Clinic row ─────────────────────────────────────────────────────

/// A membership. The 3px leading stripe is the status: brand blue when this is
/// the clinic every request is scoped to, hairline grey otherwise.
class _ClinicRow extends StatelessWidget {
  const _ClinicRow({
    required this.membership,
    required this.isActive,
    required this.onTap,
  });

  final ClinicMembershipEntity membership;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final l10n = AppLocalizations.of(context)!;
    final radius = BorderRadius.circular(16.r);
    final address = membership.address;

    return Material(
      color: c.cardBg,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: radius,
            // Uniform border only: a BoxDecoration with differing sides and a
            // borderRadius throws while painting. The status accent is drawn
            // as a positioned stripe instead.
            border: Border.all(color: c.borderLight),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Full-height accent on the leading edge; RTL moves it to the
              // trailing edge with the rest of the mirror.
              PositionedDirectional(
                start: 0,
                top: 0,
                bottom: 0,
                width: 3.w,
                child: ColoredBox(
                  color: isActive ? ColorManager.primary : c.borderLight,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(14.w, 12.h, 12.w, 12.h),
                child: Row(
                  children: [
                    Container(
                      width: 38.w,
                      height: 38.w,
                      decoration: BoxDecoration(
                        color: isActive
                            ? ColorManager.primary.withValues(alpha: 0.12)
                            : c.cardBgSecondary,
                        borderRadius: BorderRadius.circular(11.r),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.business_outlined,
                        size: 19.w,
                        color: isActive
                            ? ColorManager.primaryDarker
                            : c.textSecondary,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            membership.clinicName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12.5.sp,
                              fontFamily: family,
                              color: c.textPrimary,
                            ),
                          ),
                          if (address != null && address.isNotEmpty) ...[
                            SizedBox(height: 3.h),
                            Text(
                              address,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontFamily: family,
                                color: c.textTertiary,
                              ),
                            ),
                          ],
                          SizedBox(height: 7.h),
                          Wrap(
                            spacing: 5.w,
                            runSpacing: 4.h,
                            children: [
                              if (isActive) _ActivePill(label: l10n.active),
                              for (final r
                                  in (membership.roles.isNotEmpty
                                      ? membership.roles
                                      : [membership.role]))
                                _RolePill(role: r),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 6.w),
                    DirectionalChevron(size: 16.w, color: c.textSubtle),
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

class _ActivePill extends StatelessWidget {
  const _ActivePill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: ColorManager.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          fontFamily: FontHelper.fontFamily(context),
          color: ColorManager.primaryDarker,
        ),
      ),
    );
  }
}

class _RolePill extends StatelessWidget {
  const _RolePill({required this.role});

  final ClinicRole role;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: c.cardBgSecondary,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: c.borderLight),
      ),
      child: Text(
        _label(context),
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          fontFamily: FontHelper.fontFamily(context),
          color: c.textSecondary,
        ),
      ),
    );
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

// ─── Loading skeleton ───────────────────────────────────────────────

/// Holds the same slots the loaded rows will occupy, so nothing jumps when the
/// clinics arrive.
class _ClinicsSkeleton extends StatelessWidget {
  const _ClinicsSkeleton();

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < 3; i++) ...[
          if (i > 0) SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: c.cardBg,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: c.borderLight),
            ),
            child: Row(
              children: [
                ShimmerBox(
                  width: 38.w,
                  height: 38.w,
                  radius: BorderRadius.circular(11.r),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ShimmerBox(width: 140.w, height: 11.h),
                      SizedBox(height: 6.h),
                      ShimmerBox(width: 90.w, height: 9.h),
                      SizedBox(height: 8.h),
                      ShimmerBox(width: 56.w, height: 14.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

// ─── Docked primary action ──────────────────────────────────────────

class _DockedInviteBar extends StatelessWidget {
  const _DockedInviteBar({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final radius = BorderRadius.circular(13.r);

    return Container(
      decoration: BoxDecoration(
        color: c.surfaceBg,
        border: Border(top: BorderSide(color: c.borderLight)),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: scaffoldBottomInset(context)),
        child: Padding(
          padding: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 10.h),
          child: Material(
            color: ColorManager.primary,
            borderRadius: radius,
            child: InkWell(
              onTap: onTap,
              borderRadius: radius,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 13.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_add_alt_outlined,
                      size: 17.w,
                      color: ColorManager.white,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: FontHelper.fontFamily(context),
                        color: ColorManager.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Clinic actions sheet bits ──────────────────────────────────────

class _SheetTitleRow extends StatelessWidget {
  const _SheetTitleRow({required this.membership, required this.onClose});

  final ClinicMembershipEntity membership;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final address = membership.address;

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16.w, 0, 8.w, 8.h),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: ColorManager.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(11.r),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.business_outlined,
              size: 18.w,
              color: ColorManager.primaryDarker,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  membership.clinicName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.5.sp,
                    fontFamily: family,
                    fontWeight: FontWeight.w600,
                    color: c.textPrimary,
                  ),
                ),
                if (address != null && address.isNotEmpty) ...[
                  SizedBox(height: 2.h),
                  Text(
                    address,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontFamily: family,
                      color: c.textTertiary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            onPressed: onClose,
            icon: Icon(Icons.close_rounded, size: 20.w, color: c.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _ClinicActionRow extends StatelessWidget {
  const _ClinicActionRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.destructive = false,
    this.disabled = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool destructive;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final Color tint;
    if (disabled) {
      tint = c.textTertiary;
    } else if (destructive) {
      tint = ColorManager.error;
    } else {
      tint = ColorManager.primaryDarker;
    }

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Icon(icon, size: 19.w, color: tint),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12.5.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: FontWeight.w500,
                  color: disabled ? c.textTertiary : tint,
                ),
              ),
            ),
            if (!disabled) DirectionalChevron(size: 16.w, color: c.textSubtle),
          ],
        ),
      ),
    );
  }
}
