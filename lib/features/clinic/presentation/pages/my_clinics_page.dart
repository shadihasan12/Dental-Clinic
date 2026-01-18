import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
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
                  height: 170.h,
                  showBackButton: true,
                  onBackPressed: () => context.pop(),
                ),
              ),

              // Pending Invitations Section
              PendingInvitationsSection(
                invitations: state.receivedInvitations,
                isUpdating: state.isUpdating,
              ),

              // My Clinics Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'My Clinics',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          fontFamily: FontFamily.geist,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

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
        backgroundColor: ColorManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        title: Text(
          'Leave Clinic',
          style: TextStyle(
            fontFamily: FontFamily.geist,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to leave ${membership.clinicName}? You will need to be re-invited to rejoin.',
          style: TextStyle(
            fontFamily: FontFamily.geist,
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontFamily: FontFamily.geist,
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
              'Leave',
              style: TextStyle(
                fontFamily: FontFamily.geist,
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
                          fontFamily: FontFamily.geist,
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
                              _getRoleName(membership.role),
                              style: TextStyle(
                                color: _getRoleColor(membership.role),
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                                fontFamily: FontFamily.geist,
                              ),
                            ),
                          ),
                          if (membership.joinedAt != null) ...[
                            SizedBox(width: 8.w),
                            Text(
                              'Joined ${_formatDate(membership.joinedAt!)}',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: FontFamily.geist,
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
                            Icon(Icons.exit_to_app, color: ColorManager.error),
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
        return ColorManager.infoLight;
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
