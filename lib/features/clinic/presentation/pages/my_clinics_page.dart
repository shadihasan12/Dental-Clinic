import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';
import 'package:dental_clinic_app/features/clinic/presentation/bloc/invitation_bloc.dart';
import 'package:dental_clinic_app/features/clinic/presentation/widgets/pending_invitations_section.dart';

class MyClinicsPage extends StatelessWidget {
  const MyClinicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InvitationBloc()
        ..add(
          const InvitationEvent.loadReceivedInvitations('user@example.com'),
        ),
      child: const _MyClinicsContent(),
    );
  }
}

class _MyClinicsContent extends StatelessWidget {
  const _MyClinicsContent();

  @override
  Widget build(BuildContext context) {
    final memberships = <ClinicMembershipEntity>[
      ClinicMembershipEntity(
        id: '1',
        userId: 'user_1',
        clinicId: 'clinic_1',
        clinicName: 'Bright Smile Dental',
        role: ClinicRole.dentist,
        status: MembershipStatus.active,
        joinedAt: DateTime.now().subtract(const Duration(days: 180)),
      ),
      ClinicMembershipEntity(
        id: '2',
        userId: 'user_1',
        clinicId: 'clinic_2',
        clinicName: 'City Dental Care',
        role: ClinicRole.admin,
        status: MembershipStatus.active,
        joinedAt: DateTime.now().subtract(const Duration(days: 30)),
      ),
    ];

    return Scaffold(
      backgroundColor: ColorManager.background,
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
        builder: (context, state) {
          return Column(
            children: [
              // Clean white header
              Container(
                width: double.infinity,
                color: ColorManager.white,
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
                            color: ColorManager.textPrimary,
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
                            color: ColorManager.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Divider(height: 1, color: ColorManager.borderLight),

              // Content
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    // Pending Invitations Section
                    PendingInvitationsSection(
                      invitations: state.receivedInvitations,
                      isUpdating: state.isUpdating,
                    ),
                    // // My Clinics Section
                    SliverToBoxAdapter(child: SizedBox(height: 16.h)),

                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final membership = memberships[index];
                          return _ClinicMembershipCard(
                            membership: membership,
                            onTap: () {
                              // Navigate to clinic details or switch context
                            },
                            onLeave: membership.role != ClinicRole.admin
                                ? () {
                                    _showLeaveConfirmation(context, membership);
                                  }
                                : null,
                          );
                        }, childCount: memberships.length),
                      ),
                    ),

                    SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                  ],
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
        backgroundColor: ColorManager.white,
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
            onPressed: () {
              Navigator.pop(dialogContext);
            },
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
        color: ColorManager.white,
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
                // Clinic Icon
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

                // Info
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
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: _getRoleColor(
                                membership.role,
                              ).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              _getRoleName(context, membership.role),
                              style: TextStyle(
                                color: _getRoleColor(membership.role),
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                                fontFamily: FontHelper.fontFamily(context),
                              ),
                            ),
                          ),
                          if (membership.joinedAt != null) ...[
                            SizedBox(width: 8.w),
                            Text(
                              AppLocalizations.of(
                                context,
                              )!.joined(_formatDate(membership.joinedAt!)),
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: FontHelper.fontFamily(context),
                                color: ColorManager.textTertiary,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),

                // Arrow or Menu
                if (isAdmin)
                  const Icon(
                    Icons.chevron_right,
                    color: ColorManager.textTertiary,
                  )
                else if (onLeave != null)
                  PopupMenuButton<String>(
                    icon: const Icon(
                      Icons.more_vert,
                      color: ColorManager.textTertiary,
                    ),
                    onSelected: (value) {
                      if (value == 'leave') {
                        onLeave!();
                      }
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
                              style: const TextStyle(color: ColorManager.error),
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
      case ClinicRole.receptionist:
        return l10n.roleReceptionist;
    }
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.year}';
  }
}
