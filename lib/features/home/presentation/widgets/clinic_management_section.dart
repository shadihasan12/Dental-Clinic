import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';

/// Clinic management section for clinic admins
class ClinicManagementSection extends StatelessWidget {
  const ClinicManagementSection({
    super.key,
    required this.clinicName,
    required this.onManageStaff,
    required this.onPendingApprovals,
    required this.onInviteStaff,
    this.pendingApprovalsCount = 0,
    this.staffCount = 0,
  });

  final String clinicName;
  final VoidCallback onManageStaff;
  final VoidCallback onPendingApprovals;
  final VoidCallback onInviteStaff;
  final int pendingApprovalsCount;
  final int staffCount;

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
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: ColorManager.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.business,
                  color: ColorManager.primary,
                  size: 22.w,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Clinic Management',
                      style: TextStyleManager.titleMedium.copyWith(
                        color: ColorManager.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      clinicName,
                      style: TextStyleManager.bodySmall.copyWith(
                        color: ColorManager.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _ManagementCard(
                  icon: Icons.group_outlined,
                  title: 'Staff',
                  subtitle: '$staffCount members',
                  color: ColorManager.info,
                  onTap: onManageStaff,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _ManagementCard(
                  icon: Icons.pending_actions,
                  title: 'Approvals',
                  subtitle: pendingApprovalsCount > 0
                      ? '$pendingApprovalsCount pending'
                      : 'None pending',
                  color: pendingApprovalsCount > 0
                      ? ColorManager.warning
                      : ColorManager.success,
                  onTap: onPendingApprovals,
                  badgeCount: pendingApprovalsCount,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onInviteStaff,
              icon: const Icon(Icons.person_add_outlined),
              label: const Text('Invite Staff Member'),
              style: OutlinedButton.styleFrom(
                foregroundColor: ColorManager.primary,
                side: const BorderSide(color: ColorManager.primary),
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ManagementCard extends StatelessWidget {
  const _ManagementCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
    this.badgeCount = 0,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;
  final int badgeCount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: color.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(icon, color: color, size: 20.w),
                ),
                if (badgeCount > 0)
                  Positioned(
                    top: -4.h,
                    right: -4.w,
                    child: Container(
                      width: 18.w,
                      height: 18.w,
                      decoration: const BoxDecoration(
                        color: ColorManager.error,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          badgeCount > 9 ? '9+' : '$badgeCount',
                          style: TextStyleManager.labelSmall.copyWith(
                            color: ColorManager.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyleManager.titleSmall.copyWith(
                      color: ColorManager.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyleManager.labelSmall.copyWith(
                      color: ColorManager.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: ColorManager.textTertiary,
              size: 20.w,
            ),
          ],
        ),
      ),
    );
  }
}
