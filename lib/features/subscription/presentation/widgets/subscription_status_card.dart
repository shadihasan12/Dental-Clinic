import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_plan_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/user_subscription_entity.dart';

class SubscriptionStatusCard extends StatelessWidget {
  const SubscriptionStatusCard({
    super.key,
    required this.subscription,
    required this.onUpgrade,
    required this.onManage,
  });

  final UserSubscriptionEntity? subscription;
  final VoidCallback onUpgrade;
  final VoidCallback onManage;

  @override
  Widget build(BuildContext context) {
    if (subscription == null) {
      return _NoSubscriptionCard(onStartTrial: onUpgrade);
    }

    if (subscription!.isInTrial) {
      return _TrialStatusCard(
        subscription: subscription!,
        onUpgrade: onUpgrade,
      );
    }

    return _ActiveSubscriptionCard(
      subscription: subscription!,
      onManage: onManage,
      onUpgrade: onUpgrade,
    );
  }
}

// ─── No Subscription ──────────────────────────────────────────────────────────

class _NoSubscriptionCard extends StatelessWidget {
  const _NoSubscriptionCard({required this.onStartTrial});

  final VoidCallback onStartTrial;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(Icons.rocket_launch_outlined,
              size: 22.w, color: ColorManager.primary),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Get Started',
                  style: TextStyle(
                    fontFamily: FontHelper.fontFamily(context),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2D2D2D),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Try all features free for 30 days',
                  style: TextStyle(
                    fontFamily: FontHelper.fontFamily(context),
                    fontSize: 12.sp,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: onStartTrial,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: ColorManager.primary,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                'Start Trial',
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Trial ────────────────────────────────────────────────────────────────────

class _TrialStatusCard extends StatelessWidget {
  const _TrialStatusCard({
    required this.subscription,
    required this.onUpgrade,
  });

  final UserSubscriptionEntity subscription;
  final VoidCallback onUpgrade;

  @override
  Widget build(BuildContext context) {
    final daysLeft = subscription.trialDaysRemaining;
    final isUrgent = daysLeft <= 3;
    final accentColor = isUrgent ? const Color(0xFFF59E0B) : ColorManager.primary;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              Icon(
                isUrgent ? Icons.timer_outlined : Icons.star_outline,
                size: 20.w,
                color: accentColor,
              ),
              SizedBox(width: 8.w),
              Text(
                'Free Trial',
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2D2D2D),
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  '$daysLeft day${daysLeft != 1 ? 's' : ''} left',
                  style: TextStyle(
                    fontFamily: FontHelper.fontFamily(context),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: accentColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(3.r),
            child: LinearProgressIndicator(
              value: daysLeft / 30,
              backgroundColor: accentColor.withValues(alpha: 0.12),
              valueColor: AlwaysStoppedAnimation<Color>(accentColor),
              minHeight: 4.h,
            ),
          ),
          SizedBox(height: 14.h),

          // Upgrade button
          GestureDetector(
            onTap: onUpgrade,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(
                color: ColorManager.primary,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: Text(
                  'Upgrade Now',
                  style: TextStyle(
                    fontFamily: FontHelper.fontFamily(context),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Active ───────────────────────────────────────────────────────────────────

class _ActiveSubscriptionCard extends StatelessWidget {
  const _ActiveSubscriptionCard({
    required this.subscription,
    required this.onManage,
    required this.onUpgrade,
  });

  final UserSubscriptionEntity subscription;
  final VoidCallback onManage;
  final VoidCallback onUpgrade;

  @override
  Widget build(BuildContext context) {
    final planName = _getPlanName(subscription.planTier);
    final isCancelled = subscription.status == SubscriptionStatus.cancelled;
    final statusColor =
        isCancelled ? const Color(0xFFF59E0B) : const Color(0xFF10B981);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              Icon(Icons.verified_outlined, size: 20.w, color: statusColor),
              SizedBox(width: 8.w),
              Text(
                '$planName Plan',
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2D2D2D),
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  isCancelled ? 'CANCELLING' : 'ACTIVE',
                  style: TextStyle(
                    fontFamily: FontHelper.fontFamily(context),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),

          // Renewal info
          Text(
            isCancelled
                ? 'Cancels ${_formatDate(subscription.currentPeriodEnd)}'
                : 'Renews ${_formatDate(subscription.currentPeriodEnd)}',
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 12.sp,
              color: isCancelled ? const Color(0xFFF59E0B) : Colors.black38,
            ),
          ),
          SizedBox(height: 14.h),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onManage,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Center(
                      child: Text(
                        'Manage',
                        style: TextStyle(
                          fontFamily: FontHelper.fontFamily(context),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (subscription.planTier != PlanTier.advanced) ...[
                SizedBox(width: 10.w),
                Expanded(
                  child: GestureDetector(
                    onTap: onUpgrade,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        color: ColorManager.primary,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: Text(
                          'Upgrade',
                          style: TextStyle(
                            fontFamily: FontHelper.fontFamily(context),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  String _getPlanName(PlanTier tier) {
    switch (tier) {
      case PlanTier.trial:
        return 'Trial';
      case PlanTier.starter:
        return 'Starter';
      case PlanTier.growing:
        return 'Growing';
      case PlanTier.advanced:
        return 'Advanced';
    }
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}