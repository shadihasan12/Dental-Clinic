import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/invitation_entity.dart';
import 'package:dental_clinic_app/features/clinic/presentation/bloc/invitation_bloc.dart';

class MyClinicsPage extends StatelessWidget {
  const MyClinicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InvitationBloc()
        ..add(const InvitationEvent.loadReceivedInvitations('user@example.com')), // TODO: Get from auth
      child: const _MyClinicsContent(),
    );
  }
}

class _MyClinicsContent extends StatelessWidget {
  const _MyClinicsContent();

  @override
  Widget build(BuildContext context) {
    // TODO: Get actual memberships from auth state
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
          if (state.acceptSuccess) {
            AppSnackbar.showSuccess(
              context,
              title: 'Invitation Accepted',
              message: 'You have joined the clinic',
            );
          }
          if (state.rejectSuccess) {
            AppSnackbar.showSuccess(
              context,
              title: 'Invitation Declined',
              message: 'The invitation has been declined',
            );
          }
          if (state.error != null) {
            AppSnackbar.showError(
              context,
              title: 'Error',
              message: state.error,
            );
          }
        },
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              // Header
              SliverToBoxAdapter(
                child: GradientHeader(
                  title: 'My Clinics',
                  subtitle: 'Manage your clinic memberships',
                  height: 160.h,
                  showBackButton: true,
                  onBackPressed: () => context.pop(),
                ),
              ),

              // Pending Invitations Section
              if (state.receivedInvitations.isNotEmpty) ...[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.mail_outline,
                              size: 20.w,
                              color: ColorManager.primary,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Pending Invitations',
                              style: TextStyleManager.titleMedium.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: ColorManager.primary,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Text(
                                '${state.receivedInvitations.length}',
                                style: TextStyleManager.labelSmall.copyWith(
                                  color: ColorManager.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final invitation = state.receivedInvitations[index];
                        return _InvitationCard(
                          invitation: invitation,
                          isUpdating: state.isUpdating,
                          onAccept: () {
                            context.read<InvitationBloc>().add(
                              InvitationEvent.acceptInvitation(invitation.id),
                            );
                          },
                          onReject: () {
                            context.read<InvitationBloc>().add(
                              InvitationEvent.rejectInvitation(invitation.id),
                            );
                          },
                        );
                      },
                      childCount: state.receivedInvitations.length,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: 16.h),
                ),
              ],

              // My Clinics Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'My Clinics',
                        style: TextStyleManager.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          context.pushNamed(AppRoutesNames.createClinic);
                        },
                        icon: const Icon(Icons.add, size: 20),
                        label: const Text('Create Clinic'),
                        style: TextButton.styleFrom(
                          foregroundColor: ColorManager.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Clinics List
              if (memberships.isEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(32.w),
                    child: Column(
                      children: [
                        Icon(
                          Icons.business_outlined,
                          size: 64.w,
                          color: ColorManager.textTertiary,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'No clinics yet',
                          style: TextStyleManager.titleMedium.copyWith(
                            color: ColorManager.textSecondary,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Create your own clinic or accept an invitation',
                          style: TextStyleManager.bodyMedium.copyWith(
                            color: ColorManager.textTertiary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
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
                      },
                      childCount: memberships.length,
                    ),
                  ),
                ),

              SliverToBoxAdapter(
                child: SizedBox(height: 24.h),
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
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Leave Clinic'),
        content: Text(
          'Are you sure you want to leave ${membership.clinicName}? You will need to be re-invited to rejoin.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              // TODO: Call leave clinic
            },
            style: TextButton.styleFrom(
              foregroundColor: ColorManager.error,
            ),
            child: const Text('Leave'),
          ),
        ],
      ),
    );
  }
}

class _InvitationCard extends StatelessWidget {
  final InvitationEntity invitation;
  final bool isUpdating;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const _InvitationCard({
    required this.invitation,
    required this.isUpdating,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: ColorManager.primary.withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: ColorManager.primary.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: ColorManager.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.business,
                  color: ColorManager.primary,
                  size: 24.w,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      invitation.clinicName,
                      style: TextStyleManager.titleSmall.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: ColorManager.info.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            invitation.role == ClinicRole.dentist
                                ? 'Dentist'
                                : 'Receptionist',
                            style: TextStyleManager.labelSmall.copyWith(
                              color: ColorManager.info,
                            ),
                          ),
                        ),
                        if (invitation.invitedByName != null) ...[
                          SizedBox(width: 8.w),
                          Text(
                            'by ${invitation.invitedByName}',
                            style: TextStyleManager.bodySmall.copyWith(
                              color: ColorManager.textSecondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (invitation.message != null && invitation.message!.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: ColorManager.gray50,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                invitation.message!,
                style: TextStyleManager.bodySmall.copyWith(
                  color: ColorManager.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],

          SizedBox(height: 16.h),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: isUpdating ? null : onReject,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: ColorManager.textSecondary,
                    side: const BorderSide(color: ColorManager.gray200),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: const Text('Decline'),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: isUpdating ? null : onAccept,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primary,
                    foregroundColor: ColorManager.white,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: const Text('Accept'),
                ),
              ),
            ],
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
                        style: TextStyleManager.titleSmall.copyWith(
                          fontWeight: FontWeight.bold,
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
                              color: _getRoleColor(membership.role)
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              _getRoleName(membership.role),
                              style: TextStyleManager.labelSmall.copyWith(
                                color: _getRoleColor(membership.role),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          if (membership.joinedAt != null) ...[
                            SizedBox(width: 8.w),
                            Text(
                              'Joined ${_formatDate(membership.joinedAt!)}',
                              style: TextStyleManager.bodySmall.copyWith(
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
                      const PopupMenuItem(
                        value: 'leave',
                        child: Row(
                          children: [
                            Icon(
                              Icons.exit_to_app,
                              color: ColorManager.error,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Leave Clinic',
                              style: TextStyle(color: ColorManager.error),
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
        return ColorManager.info;
      case ClinicRole.receptionist:
        return ColorManager.secondary;
    }
  }

  String _getRoleName(ClinicRole role) {
    switch (role) {
      case ClinicRole.admin:
        return 'Admin';
      case ClinicRole.dentist:
        return 'Dentist';
      case ClinicRole.receptionist:
        return 'Receptionist';
    }
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.year}';
  }
}
