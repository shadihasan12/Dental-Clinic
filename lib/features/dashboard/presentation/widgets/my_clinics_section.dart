import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';

/// My clinics section for dentists showing clinic memberships and invitations
class MyClinicsSection extends StatelessWidget {
  const MyClinicsSection({
    super.key,
    required this.onViewAllClinics,
    required this.onAcceptInvitation,
    required this.onRejectInvitation,
    this.clinicsCount = 0,
    this.pendingInvitations = const [],
  });

  final VoidCallback onViewAllClinics;
  final void Function(String invitationId) onAcceptInvitation;
  final void Function(String invitationId) onRejectInvitation;
  final int clinicsCount;
  final List<PendingInvitationData> pendingInvitations;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: ColorManager.info.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.business_center_outlined,
                      color: ColorManager.info,
                      size: 22.w,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Clinics',
                        style: TextStyleManager.titleMedium.copyWith(
                          color: ColorManager.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        clinicsCount == 0
                            ? 'Not part of any clinic'
                            : '$clinicsCount clinic${clinicsCount > 1 ? 's' : ''}',
                        style: TextStyleManager.bodySmall.copyWith(
                          color: ColorManager.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              TextButton(
                onPressed: onViewAllClinics,
                child: Text(
                  'View All',
                  style: TextStyleManager.labelMedium.copyWith(
                    color: ColorManager.primary,
                  ),
                ),
              ),
            ],
          ),

          // Pending Invitations
          if (pendingInvitations.isNotEmpty) ...[
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: ColorManager.warning.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: ColorManager.warning.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.mail_outline,
                        color: ColorManager.warning,
                        size: 18.w,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Pending Invitations',
                        style: TextStyleManager.titleSmall.copyWith(
                          color: ColorManager.warning,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: ColorManager.warning,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          '${pendingInvitations.length}',
                          style: TextStyleManager.labelSmall.copyWith(
                            color: ColorManager.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  ...pendingInvitations.take(2).map(
                        (invitation) => _InvitationCard(
                          invitation: invitation,
                          onAccept: () => onAcceptInvitation(invitation.id),
                          onReject: () => onRejectInvitation(invitation.id),
                        ),
                      ),
                  if (pendingInvitations.length > 2) ...[
                    SizedBox(height: 8.h),
                    Center(
                      child: TextButton(
                        onPressed: onViewAllClinics,
                        child: Text(
                          'View ${pendingInvitations.length - 2} more invitation${pendingInvitations.length - 2 > 1 ? 's' : ''}',
                          style: TextStyleManager.labelMedium.copyWith(
                            color: ColorManager.warning,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ] else ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: ColorManager.gray50,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: ColorManager.success,
                    size: 24.w,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'No pending invitations',
                      style: TextStyleManager.bodyMedium.copyWith(
                        color: ColorManager.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _InvitationCard extends StatelessWidget {
  const _InvitationCard({
    required this.invitation,
    required this.onAccept,
    required this.onReject,
  });

  final PendingInvitationData invitation;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: ColorManager.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.business,
                  color: ColorManager.primary,
                  size: 18.w,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      invitation.clinicName,
                      style: TextStyleManager.titleSmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: ColorManager.info.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            invitation.role,
                            style: TextStyleManager.labelSmall.copyWith(
                              color: ColorManager.info,
                              fontSize: 10.sp,
                            ),
                          ),
                        ),
                        if (invitation.inviterName != null) ...[
                          SizedBox(width: 6.w),
                          Text(
                            'by ${invitation.inviterName}',
                            style: TextStyleManager.labelSmall.copyWith(
                              color: ColorManager.textTertiary,
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
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 32.h,
                  child: OutlinedButton(
                    onPressed: onReject,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: ColorManager.textSecondary,
                      side: const BorderSide(color: ColorManager.gray200),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                    child: Text(
                      'Decline',
                      style: TextStyleManager.labelSmall,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: SizedBox(
                  height: 32.h,
                  child: ElevatedButton(
                    onPressed: onAccept,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.primary,
                      foregroundColor: ColorManager.white,
                      padding: EdgeInsets.zero,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                    child: Text(
                      'Accept',
                      style: TextStyleManager.labelSmall.copyWith(
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Data class for pending invitation
class PendingInvitationData {
  const PendingInvitationData({
    required this.id,
    required this.clinicName,
    required this.role,
    this.inviterName,
  });

  final String id;
  final String clinicName;
  final String role;
  final String? inviterName;
}
