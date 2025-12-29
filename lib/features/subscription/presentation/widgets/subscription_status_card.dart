import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/gradient_manager.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_plan_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/user_subscription_entity.dart';

/// Shows current subscription status on dashboard
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

class _NoSubscriptionCard extends StatelessWidget {
  final VoidCallback onStartTrial;

  const _NoSubscriptionCard({required this.onStartTrial});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: GradientManager.primaryButton,
        borderRadius: BorderRadius.circular(16.r),
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
                  color: ColorManager.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.rocket_launch,
                  color: ColorManager.white,
                  size: 22.w,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Get Started',
                      style: TextStyleManager.titleMedium.copyWith(
                        color: ColorManager.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Try all features free for 30 days',
                      style: TextStyleManager.bodySmall.copyWith(
                        color: ColorManager.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onStartTrial,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.white,
                foregroundColor: ColorManager.primary,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: const Text('Start Free Trial'),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrialStatusCard extends StatelessWidget {
  final UserSubscriptionEntity subscription;
  final VoidCallback onUpgrade;

  const _TrialStatusCard({
    required this.subscription,
    required this.onUpgrade,
  });

  @override
  Widget build(BuildContext context) {
    final daysLeft = subscription.trialDaysRemaining;
    final isUrgent = daysLeft <= 3;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isUrgent
              ? ColorManager.warning.withValues(alpha: 0.5)
              : ColorManager.primary.withValues(alpha: 0.3),
          width: 1.5,
        ),
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
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: isUrgent
                      ? ColorManager.warning.withValues(alpha: 0.1)
                      : ColorManager.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  isUrgent ? Icons.timer : Icons.star,
                  color: isUrgent ? ColorManager.warning : ColorManager.primary,
                  size: 22.w,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Free Trial',
                      style: TextStyleManager.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$daysLeft day${daysLeft != 1 ? 's' : ''} remaining',
                      style: TextStyleManager.bodySmall.copyWith(
                        color: isUrgent
                            ? ColorManager.warning
                            : ColorManager.textSecondary,
                        fontWeight:
                            isUrgent ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: ColorManager.info.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'TRIAL',
                  style: TextStyleManager.labelSmall.copyWith(
                    color: ColorManager.info,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: daysLeft / 30,
              backgroundColor: ColorManager.gray200,
              valueColor: AlwaysStoppedAnimation<Color>(
                isUrgent ? ColorManager.warning : ColorManager.primary,
              ),
              minHeight: 6.h,
            ),
          ),

          SizedBox(height: 16.h),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onUpgrade,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: ColorManager.primary,
                    side: const BorderSide(color: ColorManager.primary),
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: const Text('View Plans'),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: onUpgrade,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primary,
                    foregroundColor: ColorManager.white,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: const Text('Upgrade Now'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActiveSubscriptionCard extends StatelessWidget {
  final UserSubscriptionEntity subscription;
  final VoidCallback onManage;
  final VoidCallback onUpgrade;

  const _ActiveSubscriptionCard({
    required this.subscription,
    required this.onManage,
    required this.onUpgrade,
  });

  @override
  Widget build(BuildContext context) {
    final planName = _getPlanName(subscription.planTier);
    final isCancelled = subscription.status == SubscriptionStatus.cancelled;

    return Container(
      padding: EdgeInsets.all(16.w),
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
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: ColorManager.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.verified,
                  color: ColorManager.success,
                  size: 22.w,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$planName Plan',
                      style: TextStyleManager.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      isCancelled
                          ? 'Cancels ${_formatDate(subscription.currentPeriodEnd)}'
                          : 'Renews ${_formatDate(subscription.currentPeriodEnd)}',
                      style: TextStyleManager.bodySmall.copyWith(
                        color: isCancelled
                            ? ColorManager.warning
                            : ColorManager.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isCancelled
                      ? ColorManager.warning.withValues(alpha: 0.1)
                      : ColorManager.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  isCancelled ? 'CANCELLING' : 'ACTIVE',
                  style: TextStyleManager.labelSmall.copyWith(
                    color:
                        isCancelled ? ColorManager.warning : ColorManager.success,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onManage,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: ColorManager.textSecondary,
                    side: const BorderSide(color: ColorManager.gray300),
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: const Text('Manage'),
                ),
              ),
              if (subscription.planTier != PlanTier.advanced) ...[
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onUpgrade,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.primary,
                      foregroundColor: ColorManager.white,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: const Text('Upgrade'),
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
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
