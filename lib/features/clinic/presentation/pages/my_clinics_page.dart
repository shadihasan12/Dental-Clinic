import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';
import 'package:dental_clinic_app/features/clinic/presentation/bloc/invitation_bloc.dart';
import 'package:dental_clinic_app/features/clinic/presentation/bloc/my_clinics_bloc.dart';
import 'package:dental_clinic_app/features/clinic/presentation/widgets/pending_invitations_section.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              getIt<MyClinicsBloc>()..add(const MyClinicsEvent.load()),
        ),
        BlocProvider(
          create: (_) => InvitationBloc()
            ..add(
              const InvitationEvent.loadReceivedInvitations('user@example.com'),
            ),
        ),
      ],
      child: const _MyClinicsContent(),
    );
  }
}

class _MyClinicsContent extends StatelessWidget {
  const _MyClinicsContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.of(context).scaffoldBg,
      body: BlocConsumer<InvitationBloc, InvitationState>(
        listener: (context, state) {
          final l10n = AppLocalizations.of(context)!;
          if (state.acceptSuccess) {
            AppSnackbar.showSuccess(
              context,
              title: l10n.invitationAccepted,
              message: l10n.invitationAcceptedMessage,
            );
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
                        Text(
                          AppLocalizations.of(context)!.myClinics,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontFamily: FontHelper.fontFamily(context),
                            fontWeight: FontWeight.w600,
                            color: ColorManager.of(context).textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(height: 1, color: ColorManager.of(context).borderLight),
              Expanded(
                child: BlocBuilder<MyClinicsBloc, MyClinicsState>(
                  builder: (context, clinicsState) {
                    return clinicsState.when(
                      initial: () => const SizedBox.shrink(),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      loaded: (clinics) => CustomScrollView(
                        slivers: [
                          PendingInvitationsSection(
                            invitations: invitationState.receivedInvitations,
                            isUpdating: invitationState.isUpdating,
                          ),
                          SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                          SliverPadding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  final membership = clinics[index];
                                  return _ClinicMembershipCard(
                                    membership: membership,
                                    onTap: () {},
                                    onLeave: membership.role != ClinicRole.admin
                                        ? () => _showLeaveConfirmation(
                                              context,
                                              membership,
                                            )
                                        : null,
                                  );
                                },
                                childCount: clinics.length,
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                        ],
                      ),
                      error: (message) => Center(
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
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: ColorManager.of(context).textTertiary,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            TextButton(
                              onPressed: () => context
                                  .read<MyClinicsBloc>()
                                  .add(const MyClinicsEvent.load()),
                              child: Text(
                                AppLocalizations.of(context)!.retry,
                                style: TextStyle(
                                  color: ColorManager.primary,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
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
            fontWeight: FontWeight.normal,
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
                fontWeight: FontWeight.w400,
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
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ClinicMembershipCard extends StatelessWidget {
  final ClinicMembershipEntity membership;
  final VoidCallback onTap;
  final VoidCallback? onLeave;

  const _ClinicMembershipCard({
    required this.membership,
    required this.onTap,
    this.onLeave,
  });

  @override
  Widget build(BuildContext context) {
    final isAdmin = membership.role == ClinicRole.admin;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: ColorManager.of(context).cardBg,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  width: 56.w,
                  height: 56.w,
                  decoration: BoxDecoration(
                    color: isAdmin
                        ? ColorManager.primary.withValues(alpha: 0.1)
                        : ColorManager.info.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.business,
                    color: isAdmin ? ColorManager.primary : ColorManager.info,
                    size: 28.w,
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
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                          fontFamily: FontHelper.fontFamily(context),
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
                              color: ColorManager.of(context).textTertiary,
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
                                  color: ColorManager.of(context).textTertiary,
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
                            .map(
                              (r) => Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: _getRoleColor(r).withValues(
                                    alpha: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Text(
                                  _getRoleName(context, r),
                                  style: TextStyle(
                                    color: _getRoleColor(r),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11.sp,
                                    fontFamily: FontHelper.fontFamily(context),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
                if (isAdmin)
                  Icon(
                    Icons.chevron_right,
                    color: ColorManager.of(context).textTertiary,
                  )
                else if (onLeave != null)
                  PopupMenuButton<String>(
                    icon: Icon(
                      Icons.more_vert,
                      color: ColorManager.of(context).textTertiary,
                    ),
                    onSelected: (value) {
                      if (value == 'leave') onLeave!();
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'leave',
                        child: Row(
                          children: [
                            const Icon(
                              Icons.exit_to_app,
                              color: ColorManager.error,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              AppLocalizations.of(context)!.leaveClinic,
                              style:
                                  const TextStyle(color: ColorManager.error),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getRoleColor(ClinicRole role) {
    switch (role) {
      case ClinicRole.admin:
        return ColorManager.primary;
      case ClinicRole.dentist:
        return ColorManager.infoLight;
      case ClinicRole.secretary:
        return ColorManager.secondary;
      case ClinicRole.receptionist:
        return ColorManager.secondary;
    }
  }

  String _getRoleName(BuildContext context, ClinicRole role) {
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
