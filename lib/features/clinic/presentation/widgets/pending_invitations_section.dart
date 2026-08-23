import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/core/widgets/state_card.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/invitation_entity.dart';
import 'package:dental_clinic_app/features/clinic/presentation/bloc/invitation_bloc.dart';
import 'package:dental_clinic_app/features/clinic/presentation/widgets/invitation_card.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable list block for either kind of invitation.
///
/// Lays out flush with whatever gutter its parent sets — the clinics screen
/// already pads its scroll body, so nothing here adds horizontal padding of
/// its own.
class InvitationsList extends StatelessWidget {
  final InvitationCardMode mode;
  final List<InvitationEntity> invitations;
  final InvitationStatus filter;
  final bool isLoading;
  final bool isUpdating;
  final String? error;

  const InvitationsList({
    super.key,
    required this.mode,
    required this.invitations,
    required this.filter,
    required this.isLoading,
    this.isUpdating = false,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (isLoading) return const _InvitationsSkeleton();

    if (error != null) {
      return StateCard(
        icon: Icons.cloud_off_outlined,
        title: l10n.couldNotLoadInvitations,
        message: error!,
        detail: l10n.invitationsUnchanged,
        tone: ColorManager.error,
        actionLabel: l10n.retry,
        onAction: () {
          final bloc = context.read<InvitationBloc>();
          if (mode == InvitationCardMode.sent) {
            bloc.add(const InvitationEvent.loadSentInvitations());
          } else {
            bloc.add(const InvitationEvent.loadReceivedInvitations());
          }
        },
      );
    }

    if (invitations.isEmpty) {
      final isSent = mode == InvitationCardMode.sent;
      final message = switch (filter) {
        InvitationStatus.pending =>
          isSent ? l10n.noPendingSentInvitations : l10n.noPendingInvitations,
        InvitationStatus.accepted =>
          isSent ? l10n.noAcceptedSentInvitations : l10n.noAcceptedInvitations,
        InvitationStatus.declined =>
          isSent ? l10n.noDeclinedSentInvitations : l10n.noDeclinedInvitations,
        _ => l10n.noInvitations,
      };
      return StateCard(
        icon: isSent ? Icons.send_outlined : Icons.mail_outline,
        title: l10n.noInvitations,
        message: message,
      );
    }

    return Column(
      children: [
        for (final inv in invitations)
          InvitationCard(
            invitation: inv,
            mode: mode,
            isUpdating: isUpdating,
            onAccept: () => context.read<InvitationBloc>().add(
              InvitationEvent.acceptInvitation(inv.id),
            ),
            onReject: () => context.read<InvitationBloc>().add(
              InvitationEvent.rejectInvitation(inv.id),
            ),
          ),
      ],
    );
  }
}

/// Same two slots an invitation row will fill, so the list does not jump when
/// the request lands.
class _InvitationsSkeleton extends StatelessWidget {
  const _InvitationsSkeleton();

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Column(
      children: [
        for (var i = 0; i < 2; i++) ...[
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
                  radius: BorderRadius.circular(19.r),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerBox(width: 130.w, height: 11.h),
                      SizedBox(height: 6.h),
                      ShimmerBox(width: 80.w, height: 9.h),
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
