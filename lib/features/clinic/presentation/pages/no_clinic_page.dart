import 'dart:async';

import 'package:dental_clinic_app/core/utils/exit_on_second_back.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/services/notifications/notification_service.dart';
import 'package:dental_clinic_app/core/session/session_manager.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/core/widgets/app_refresh_view.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
import 'package:dental_clinic_app/custom_widgets/adaptive_content_width.dart';
import 'package:dental_clinic_app/custom_widgets/app_snackbar.dart';
import 'package:dental_clinic_app/features/clinic/data/own_clinic_service.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/invitation_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/use_cases/get_my_clinics_use_case.dart';
import 'package:dental_clinic_app/features/clinic/domain/use_cases/switch_active_clinic_use_case.dart';
import 'package:dental_clinic_app/features/clinic/presentation/bloc/invitation_bloc.dart';
import 'package:dental_clinic_app/features/clinic/presentation/widgets/invitation_card.dart';
import 'package:dental_clinic_app/features/clinic/presentation/widgets/pending_invitations_section.dart';
import 'package:dental_clinic_app/features/home/domain/entities/notification_entity.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Signed in, a member of no clinic: taken out of their last one, an owner
/// who closed their own, or someone who never had one.
///
/// Four ways out - open a clinic of their own, accept an invitation, delete
/// the account, log out. Nothing here names a clinic: every call it makes
/// (`/users/clinics`, the invitations, `/auth/*`, `/plans`) needs none, and
/// with nothing selected the interceptor sends no clinic header.
///
/// A clinic can appear while the user waits here - an invitation accepted
/// from the email link - so the list is read again on every return to the
/// front and on pull, and a clinic in it opens straight away.
class NoClinicPage extends StatelessWidget {
  const NoClinicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<InvitationBloc>()
        ..add(const InvitationEvent.loadReceivedInvitations()),
      child: const _NoClinicView(),
    );
  }
}

class _NoClinicView extends StatefulWidget {
  const _NoClinicView();

  @override
  State<_NoClinicView> createState() => _NoClinicViewState();
}

class _NoClinicViewState extends State<_NoClinicView>
    with WidgetsBindingObserver {
  late bool _trialEligible = getIt<UserStorage>().isTrialEligible;
  StreamSubscription<NotificationEntity>? _invitations;
  bool _opening = false;

  final ExitOnSecondBack _exit = ExitOnSecondBack();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // A session that reaches here with a clinic after all - one stored
    // before clinics could be empty - goes straight into it.
    _openIfMember();
    _refreshTrial();
    // An invitation arrives as a `clinic_invitation` push (or polled row on
    // Windows): the count has to follow.
    _invitations = getIt<NotificationService>()
        .onNotificationReceived
        .where((n) =>
            n.category == NotificationCategories.clinicInvitation ||
            n.data['type'] == NotificationCategories.clinicInvitation)
        .listen((_) => _reloadInvitations());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _invitations?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _refresh();
  }

  Future<void> _refreshTrial() async {
    final result = await getIt<OwnClinicService>().trialEligible();
    if (!mounted) return;
    result.fold((_) {}, (v) => setState(() => _trialEligible = v));
  }

  void _reloadInvitations() {
    if (!mounted) return;
    context
        .read<InvitationBloc>()
        .add(const InvitationEvent.loadReceivedInvitations());
  }

  /// Opens the first clinic the list now holds, if any.
  Future<bool> _openIfMember() async {
    final result = await getIt<GetMyClinicsUseCase>()();
    final clinics = result.getOrElse(() => const []);
    if (clinics.isEmpty || !mounted || _opening) return false;
    _opening = true;
    final pick = clinics.firstWhere(
      (m) => m.role == ClinicRole.admin,
      orElse: () => clinics.first,
    );
    await getIt<SwitchActiveClinicUseCase>().activate(pick);
    if (mounted) context.goNamed(AppRoutesNames.root);
    return true;
  }

  Future<void> _refresh() async {
    if (await _openIfMember()) return;
    _reloadInvitations();
    await _refreshTrial();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);

    return PopScope(
      // Nothing behind this screen to go back to: back leaves the app, on
      // the second press, as from home.
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _exit.onBack(context);
      },
      child: Scaffold(
        backgroundColor: c.scaffoldBg,
        body: SafeArea(
          child: BlocListener<InvitationBloc, InvitationState>(
            listenWhen: (prev, curr) =>
                prev.acceptSuccess != curr.acceptSuccess ||
                prev.rejectSuccess != curr.rejectSuccess ||
                prev.actionError != curr.actionError,
            listener: (context, state) {
              if (state.acceptSuccess) {
                AppSnackbar.showSuccess(
                  context,
                  title: l10n.invitationAccepted,
                  message: l10n.invitationAcceptedMessage,
                );
                // Accepted: the clinic is in the list now - open it.
                _openIfMember();
              }
              if (state.rejectSuccess) {
                AppSnackbar.showSuccess(
                  context,
                  title: l10n.invitationDeclined,
                  message: l10n.invitationDeclinedMessage,
                );
              }
              // Already answered from the email (409), or the inviting
              // clinic has no subscription: the server's own sentence. A
              // stale row is refreshed away.
              if (state.actionError != null) {
                AppSnackbar.showError(
                  context,
                  title: l10n.error,
                  message: state.actionError,
                );
                _reloadInvitations();
              }
            },
            child: AppRefreshView(
              onRefresh: _refresh,
              padding: EdgeInsets.fromLTRB(16.w, 28.h, 16.w, 24.h),
              child: AdaptiveContentWidth(
                maxWidth: 560,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: IconTile(
                        icon: Icons.storefront_outlined,
                        size: 56.w,
                        iconSize: 28.w,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      l10n.noClinicTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: family,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: c.textPrimary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      l10n.noClinicMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: family,
                        fontSize: 13.sp,
                        height: 1.5,
                        color: c.textSecondary,
                      ),
                    ),
                    SizedBox(height: 22.h),
                    DentaButton(
                      label: l10n.openMyClinic,
                      icon: Icons.add_business_outlined,
                      expand: true,
                      onTap: () => context.pushNamed(AppRoutesNames.openClinic),
                    ),
                    // Only to those who will get it.
                    if (_trialEligible) ...[
                      SizedBox(height: 6.h),
                      Text(
                        l10n.openMyClinicTrialHint,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: family,
                          fontSize: 11.5.sp,
                          fontWeight: FontWeight.w500,
                          color: ColorManager.primaryDarker,
                        ),
                      ),
                    ],
                    SizedBox(height: 26.h),
                    const _InvitationsSection(),
                    SizedBox(height: 26.h),
                    DentaOutlineButton(
                      label: l10n.deleteMyAccount,
                      icon: Icons.person_remove_outlined,
                      expand: true,
                      tone: c.textSecondary,
                      onTap: () =>
                          context.pushNamed(AppRoutesNames.deleteAccount),
                    ),
                    SizedBox(height: 10.h),
                    DentaOutlineButton(
                      label: l10n.logout,
                      icon: Icons.logout_rounded,
                      expand: true,
                      tone: ColorManager.error,
                      onTap: () => getIt<SessionManager>().endSession(),
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

/// The invitations received, with the pending count, accept and decline.
class _InvitationsSection extends StatelessWidget {
  const _InvitationsSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);

    return BlocBuilder<InvitationBloc, InvitationState>(
      builder: (context, state) {
        final pending = state.receivedInvitations
            .where((i) => i.status == InvitationStatus.pending)
            .toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text(
                  l10n.invitations,
                  style: TextStyle(
                    fontFamily: family,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: c.textPrimary,
                  ),
                ),
                if (pending.isNotEmpty) ...[
                  SizedBox(width: 8.w),
                  CountPill(pending.length),
                ],
              ],
            ),
            SizedBox(height: 10.h),
            InvitationsList(
              mode: InvitationCardMode.received,
              invitations: pending,
              filter: InvitationStatus.pending,
              isLoading: state.isLoading && state.receivedInvitations.isEmpty,
              isUpdating: state.isUpdating,
              error: state.error,
            ),
          ],
        );
      },
    );
  }
}
