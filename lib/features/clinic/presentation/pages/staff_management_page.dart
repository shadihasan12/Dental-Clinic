import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';
import 'package:dental_clinic_app/features/clinic/presentation/bloc/clinic_bloc.dart';

class StaffManagementPage extends StatelessWidget {
  final String clinicId;

  const StaffManagementPage({
    super.key,
    required this.clinicId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClinicBloc()
        ..add(ClinicEvent.loadClinic(clinicId))
        ..add(ClinicEvent.loadMembers(clinicId)),
      child: _StaffManagementContent(clinicId: clinicId),
    );
  }
}

class _StaffManagementContent extends StatelessWidget {
  final String clinicId;

  const _StaffManagementContent({required this.clinicId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      body: BlocConsumer<ClinicBloc, ClinicState>(
        listener: (context, state) {
          if (state.removeSuccess) {
            AppSnackbar.showSuccess(
              context,
              title: 'Member Removed',
              message: 'Staff member has been removed from the clinic',
            );
          }
          if (state.updateSuccess) {
            AppSnackbar.showSuccess(
              context,
              title: 'Role Updated',
              message: 'Member role has been updated',
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
                  title: 'Staff Management',
                  subtitle: state.clinic?.name ?? 'Manage your team',
                  height: 160.h,
                  showBackButton: true,
                  onBackPressed: () => context.pop(),
                ),
              ),

              // Invite Button
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      context.pushNamed(
                        AppRoutesNames.inviteStaff,
                        extra: {
                          'clinicId': clinicId,
                          'clinicName': state.clinic?.name ?? '',
                        },
                      );
                    },
                    icon: const Icon(Icons.person_add_outlined),
                    label: const Text('Invite Staff Member'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.primary,
                      foregroundColor: ColorManager.white,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
              ),

              // Members List
              if (state.isLoading || state.isMembersLoading)
                const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (state.members.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.group_outlined,
                          size: 64.w,
                          color: ColorManager.textTertiary,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'No staff members yet',
                          style: TextStyleManager.titleMedium.copyWith(
                            color: ColorManager.textSecondary,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Invite dentists and receptionists to join your clinic',
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
                        final member = state.members[index];
                        return _MemberCard(
                          member: member,
                          isCurrentUserAdmin: true, // TODO: Check from auth state
                          onRoleChanged: (newRole) {
                            context.read<ClinicBloc>().add(
                              ClinicEvent.updateMemberRole(
                                membershipId: member.id,
                                newRole: newRole,
                              ),
                            );
                          },
                          onRemove: () {
                            _showRemoveConfirmation(context, member);
                          },
                        );
                      },
                      childCount: state.members.length,
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

  void _showRemoveConfirmation(BuildContext context, ClinicMembershipEntity member) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Remove Member'),
        content: Text(
          'Are you sure you want to remove ${member.userName ?? 'this member'} from the clinic?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<ClinicBloc>().add(
                ClinicEvent.removeMember(member.id),
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: ColorManager.error,
            ),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }
}

class _MemberCard extends StatelessWidget {
  final ClinicMembershipEntity member;
  final bool isCurrentUserAdmin;
  final void Function(ClinicRole) onRoleChanged;
  final VoidCallback onRemove;

  const _MemberCard({
    required this.member,
    required this.isCurrentUserAdmin,
    required this.onRoleChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final isAdmin = member.role == ClinicRole.admin;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
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
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 24.r,
            backgroundColor: _getRoleColor(member.role).withValues(alpha: 0.1),
            child: member.userAvatarUrl != null
                ? ClipOval(
                    child: Image.network(
                      member.userAvatarUrl!,
                      width: 48.w,
                      height: 48.w,
                      fit: BoxFit.cover,
                    ),
                  )
                : Text(
                    _getInitials(member.userName ?? 'U'),
                    style: TextStyleManager.titleMedium.copyWith(
                      color: _getRoleColor(member.role),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
          SizedBox(width: 12.w),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.userName ?? 'Unknown',
                  style: TextStyleManager.titleSmall.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  member.userEmail ?? '',
                  style: TextStyleManager.bodySmall.copyWith(
                    color: ColorManager.textSecondary,
                  ),
                ),
                SizedBox(height: 6.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: _getRoleColor(member.role).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    _getRoleName(member.role),
                    style: TextStyleManager.labelSmall.copyWith(
                      color: _getRoleColor(member.role),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Actions (only for non-admin members if current user is admin)
          if (isCurrentUserAdmin && !isAdmin)
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) {
                if (value == 'remove') {
                  onRemove();
                } else if (value == 'dentist') {
                  onRoleChanged(ClinicRole.dentist);
                } else if (value == 'receptionist') {
                  onRoleChanged(ClinicRole.receptionist);
                }
              },
              itemBuilder: (context) => [
                if (member.role != ClinicRole.dentist)
                  const PopupMenuItem(
                    value: 'dentist',
                    child: Row(
                      children: [
                        Icon(Icons.medical_services_outlined),
                        SizedBox(width: 8),
                        Text('Change to Dentist'),
                      ],
                    ),
                  ),
                if (member.role != ClinicRole.receptionist)
                  const PopupMenuItem(
                    value: 'receptionist',
                    child: Row(
                      children: [
                        Icon(Icons.person_outline),
                        SizedBox(width: 8),
                        Text('Change to Receptionist'),
                      ],
                    ),
                  ),
                const PopupMenuItem(
                  value: 'remove',
                  child: Row(
                    children: [
                      Icon(Icons.remove_circle_outline, color: ColorManager.error),
                      SizedBox(width: 8),
                      Text('Remove', style: TextStyle(color: ColorManager.error)),
                    ],
                  ),
                ),
              ],
            ),
        ],
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

  String _getInitials(String name) {
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : 'U';
  }
}
