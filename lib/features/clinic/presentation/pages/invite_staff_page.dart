import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/invitation_entity.dart';
import 'package:dental_clinic_app/features/clinic/presentation/bloc/invitation_bloc.dart';

class InviteStaffPage extends StatelessWidget {
  final String clinicId;
  final String clinicName;

  const InviteStaffPage({
    super.key,
    required this.clinicId,
    required this.clinicName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InvitationBloc()
        ..add(InvitationEvent.loadSentInvitations(clinicId)),
      child: _InviteStaffContent(
        clinicId: clinicId,
        clinicName: clinicName,
      ),
    );
  }
}

class _InviteStaffContent extends StatefulWidget {
  final String clinicId;
  final String clinicName;

  const _InviteStaffContent({
    required this.clinicId,
    required this.clinicName,
  });

  @override
  State<_InviteStaffContent> createState() => _InviteStaffContentState();
}

class _InviteStaffContentState extends State<_InviteStaffContent> {
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      body: BlocConsumer<InvitationBloc, InvitationState>(
        listener: (context, state) {
          if (state.sendSuccess) {
            AppSnackbar.showSuccess(
              context,
              title: 'Invitation Sent',
              message: 'Invitation has been sent successfully',
            );
            _emailController.clear();
            _messageController.clear();
          }
          if (state.cancelSuccess) {
            AppSnackbar.showSuccess(
              context,
              title: 'Invitation Cancelled',
              message: 'The invitation has been cancelled',
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
                  title: 'Invite Staff',
                  subtitle: widget.clinicName,
                  height: 160.h,
                  showBackButton: true,
                  onBackPressed: () => context.pop(),
                ),
              ),

              // Invite Form
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: ColorManager.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Send Invitation',
                          style: TextStyleManager.titleMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16.h),

                        // Email Field
                        _buildLabel('Email Address *'),
                        SizedBox(height: 8.h),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            context.read<InvitationBloc>().add(
                              InvitationEvent.updateInviteeEmail(value),
                            );
                          },
                          decoration: _buildInputDecoration(
                            hintText: 'colleague@email.com',
                            prefixIcon: const Icon(Icons.email_outlined),
                          ),
                        ),

                        SizedBox(height: 16.h),

                        // Role Dropdown
                        _buildLabel('Role *'),
                        SizedBox(height: 8.h),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          decoration: BoxDecoration(
                            color: ColorManager.gray50,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<ClinicRole>(
                              value: state.inviteeRole,
                              isExpanded: true,
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: ColorManager.textSecondary,
                              ),
                              items: [ClinicRole.dentist, ClinicRole.receptionist]
                                  .map((role) {
                                return DropdownMenuItem<ClinicRole>(
                                  value: role,
                                  child: Row(
                                    children: [
                                      Icon(
                                        _getRoleIcon(role),
                                        color: ColorManager.textSecondary,
                                        size: 20.w,
                                      ),
                                      SizedBox(width: 12.w),
                                      Text(
                                        _getRoleName(role),
                                        style: TextStyleManager.bodyLarge,
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  context.read<InvitationBloc>().add(
                                    InvitationEvent.updateInviteeRole(value),
                                  );
                                }
                              },
                            ),
                          ),
                        ),

                        SizedBox(height: 16.h),

                        // Message Field
                        _buildLabel('Personal Message (Optional)'),
                        SizedBox(height: 8.h),
                        TextFormField(
                          controller: _messageController,
                          maxLines: 3,
                          onChanged: (value) {
                            context.read<InvitationBloc>().add(
                              InvitationEvent.updateInviteMessage(value),
                            );
                          },
                          decoration: _buildInputDecoration(
                            hintText: 'Add a personal message...',
                            prefixIcon: const Icon(Icons.message_outlined),
                          ),
                        ),

                        SizedBox(height: 24.h),

                        // Send Button
                        SizedBox(
                          width: double.infinity,
                          height: 52.h,
                          child: ElevatedButton(
                            onPressed: state.isSending
                                ? null
                                : () {
                                    context.read<InvitationBloc>().add(
                                      InvitationEvent.sendInvitation(
                                        clinicId: widget.clinicId,
                                        clinicName: widget.clinicName,
                                      ),
                                    );
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManager.primary,
                              foregroundColor: ColorManager.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: state.isSending
                                ? SizedBox(
                                    width: 24.w,
                                    height: 24.h,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        ColorManager.white,
                                      ),
                                    ),
                                  )
                                : const Text('Send Invitation'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Pending Invitations Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24.h),
                      Text(
                        'Pending Invitations',
                        style: TextStyleManager.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                    ],
                  ),
                ),
              ),

              // Pending Invitations List
              if (state.isLoading)
                const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              else if (state.sentInvitations.isEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(32.w),
                    child: Center(
                      child: Text(
                        'No pending invitations',
                        style: TextStyleManager.bodyMedium.copyWith(
                          color: ColorManager.textTertiary,
                        ),
                      ),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final invitation = state.sentInvitations[index];
                        return _InvitationCard(
                          invitation: invitation,
                          onCancel: () {
                            context.read<InvitationBloc>().add(
                              InvitationEvent.cancelInvitation(invitation.id),
                            );
                          },
                        );
                      },
                      childCount: state.sentInvitations.length,
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

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyleManager.titleSmall.copyWith(
        color: ColorManager.textPrimary,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String hintText,
    required Widget prefixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyleManager.bodyMedium.copyWith(
        color: ColorManager.textTertiary,
      ),
      prefixIcon: prefixIcon,
      filled: true,
      fillColor: ColorManager.gray50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(
          color: ColorManager.primary,
          width: 1.5,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      ),
    );
  }

  IconData _getRoleIcon(ClinicRole role) {
    switch (role) {
      case ClinicRole.admin:
        return Icons.admin_panel_settings;
      case ClinicRole.dentist:
        return Icons.medical_services_outlined;
      case ClinicRole.receptionist:
        return Icons.person_outline;
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
}

class _InvitationCard extends StatelessWidget {
  final InvitationEntity invitation;
  final VoidCallback onCancel;

  const _InvitationCard({
    required this.invitation,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
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
          // Icon
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: ColorManager.warning.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.mail_outline,
              color: ColorManager.warning,
              size: 24.w,
            ),
          ),
          SizedBox(width: 12.w),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  invitation.inviteeEmail,
                  style: TextStyleManager.titleSmall.copyWith(
                    fontWeight: FontWeight.w600,
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
                        color: ColorManager.info.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8.r),
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
                    SizedBox(width: 8.w),
                    Text(
                      'Pending',
                      style: TextStyleManager.bodySmall.copyWith(
                        color: ColorManager.warning,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Cancel Button
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  title: const Text('Cancel Invitation'),
                  content: Text(
                    'Are you sure you want to cancel the invitation to ${invitation.inviteeEmail}?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(dialogContext);
                        onCancel();
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: ColorManager.error,
                      ),
                      child: const Text('Cancel Invitation'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(
              Icons.close,
              color: ColorManager.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
