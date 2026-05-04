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

class InvitationsSection extends StatelessWidget {
  final InvitationState state;

  const InvitationsSection({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
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
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    color: ColorManager.of(context).textPrimary,
                  ),
                ),
                SizedBox(width: 8.w),
                if (state.receivedInvitations.isNotEmpty)
                  _CountBadge(count: state.receivedInvitations.length),
              ],
            ),
          ),
        ),

        SliverToBoxAdapter(child: _StatusFilters(active: state.receivedFilter)),

        SliverToBoxAdapter(child: SizedBox(height: 12.h)),

        if (state.isLoading)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(child: CircularProgressIndicator()),
            ),
          )
        else if (state.error != null)
          SliverToBoxAdapter(
            child: _InvitationsError(
              message: state.error!,
              onRetry: () => context
                  .read<InvitationBloc>()
                  .add(const InvitationEvent.loadReceivedInvitations()),
            ),
          )
        else if (state.receivedInvitations.isEmpty)
          SliverToBoxAdapter(
            child: _InvitationsEmpty(filter: state.receivedFilter),
          )
        else
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final invitation = state.receivedInvitations[index];
                  return InvitationCard(
                    invitation: invitation,
                    isUpdating: state.isUpdating,
                    onAccept: () => context.read<InvitationBloc>().add(
                          InvitationEvent.acceptInvitation(invitation.id),
                        ),
                    onReject: () => context.read<InvitationBloc>().add(
                          InvitationEvent.rejectInvitation(invitation.id),
                        ),
                  );
                },
                childCount: state.receivedInvitations.length,
              ),
            ),
          ),

        SliverToBoxAdapter(child: SizedBox(height: 16.h)),
      ],
    );
  }
}

class _StatusFilters extends StatelessWidget {
  final InvitationStatus active;
  const _StatusFilters({required this.active});

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
              onTap: () => context.read<InvitationBloc>().add(
                    InvitationEvent.filterReceivedByStatus(filters[i].$1),
                  ),
            ),
            if (i < filters.length - 1) SizedBox(width: 8.w),
          ],
        ],
      ),
    );
  }
}

class _CountBadge extends StatelessWidget {
  final int count;
  const _CountBadge({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class _InvitationsEmpty extends StatelessWidget {
  final InvitationStatus filter;
  const _InvitationsEmpty({required this.filter});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final message = switch (filter) {
      InvitationStatus.pending => l10n.noPendingInvitations,
      InvitationStatus.accepted => l10n.noAcceptedInvitations,
      InvitationStatus.declined => l10n.noDeclinedInvitations,
      _ => l10n.noInvitations,
    };

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.mail_outline,
              size: 40.w,
              color: ColorManager.of(context).textTertiary,
            ),
            SizedBox(height: 8.h),
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
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
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
