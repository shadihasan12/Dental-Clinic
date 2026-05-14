import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/appointments/presentation/widgets/selectable_chip.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/invitation_entity.dart';
import 'package:dental_clinic_app/features/clinic/presentation/bloc/invitation_bloc.dart';
import 'package:dental_clinic_app/features/clinic/presentation/widgets/invitation_card.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable list block for either kind of invitation.
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InvitationStatusFilters(mode: mode, active: filter),
        SizedBox(height: 12.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: _buildBody(context),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (error != null) {
      return _InvitationsError(
        message: error!,
        onRetry: () {
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
      return _InvitationsEmpty(mode: mode, filter: filter);
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

class InvitationStatusFilters extends StatelessWidget {
  final InvitationCardMode mode;
  final InvitationStatus active;

  const InvitationStatusFilters({
    super.key,
    required this.mode,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final filters = [
      (InvitationStatus.pending, l10n.pending),
      (InvitationStatus.accepted, l10n.accepted),
      (InvitationStatus.declined, l10n.declined),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          for (var i = 0; i < filters.length; i++) ...[
            SelectableChip(
              label: filters[i].$2,
              isSelected: active == filters[i].$1,
              onTap: () {
                final bloc = context.read<InvitationBloc>();
                if (mode == InvitationCardMode.sent) {
                  bloc.add(
                    InvitationEvent.filterSentByStatus(filters[i].$1),
                  );
                } else {
                  bloc.add(
                    InvitationEvent.filterReceivedByStatus(filters[i].$1),
                  );
                }
              },
            ),
            if (i < filters.length - 1) SizedBox(width: 8.w),
          ],
        ],
      ),
    );
  }
}

class _InvitationsEmpty extends StatelessWidget {
  final InvitationCardMode mode;
  final InvitationStatus filter;
  const _InvitationsEmpty({required this.mode, required this.filter});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 32.h),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                color: ColorManager.of(context).cardBgSecondary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isSent ? Icons.send_outlined : Icons.mail_outline,
                size: 28.w,
                color: ColorManager.of(context).textTertiary,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              message,
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: FontHelper.fontFamily(context),
                color: ColorManager.of(context).textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InvitationsError extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _InvitationsError({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 36.w,
              color: ColorManager.of(context).textTertiary,
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: FontHelper.fontFamily(context),
                color: ColorManager.of(context).textTertiary,
              ),
            ),
            SizedBox(height: 8.h),
            TextButton(
              onPressed: onRetry,
              child: Text(
                l10n.retry,
                style: TextStyle(
                  color: ColorManager.primary,
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 13.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
