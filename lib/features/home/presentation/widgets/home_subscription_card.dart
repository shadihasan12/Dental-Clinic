import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_plan_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/user_subscription_entity.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class HomeSubscriptionCard extends StatelessWidget {
  const HomeSubscriptionCard({
    super.key,
    required this.subscription,
    this.storageUsedGb = 0,
    this.storageTotalGb = 5,
    required this.onViewPlans,
    required this.onUpgrade,
  });

  final UserSubscriptionEntity? subscription;
  final double storageUsedGb;
  final double storageTotalGb;
  final VoidCallback onViewPlans;
  final VoidCallback onUpgrade;

  @override
  Widget build(BuildContext context) {
    if (subscription == null) {
      return _NoSubscriptionCard(onStartTrial: onUpgrade);
    }

    if (subscription!.isInTrial) {
      return _TrialCard(
        subscription: subscription!,
        onUpgrade: onUpgrade,
      );
    }

    return _ActivePlanCard(
      subscription: subscription!,
      storageUsedGb: storageUsedGb,
      storageTotalGb: storageTotalGb,
      onViewPlans: onViewPlans,
    );
  }
}

// ─── No Subscription ──────────────────────────────────────────────────────────

class _NoSubscriptionCard extends StatelessWidget {
  const _NoSubscriptionCard({required this.onStartTrial});

  final VoidCallback onStartTrial;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorManager.primary.withValues(alpha: 0.08),
            ColorManager.primary.withValues(alpha: 0.03),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: ColorManager.primary.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: ColorManager.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.rocket_launch_outlined,
              size: 22.w,
              color: ColorManager.primary,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.noSubscription,
                  style: TextStyle(
                    fontFamily: FontHelper.fontFamily(context),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.of(context).textPrimary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  l10n.tryAllFeatures,
                  style: TextStyle(
                    fontFamily: FontHelper.fontFamily(context),
                    fontSize: 12.sp,
                    color: ColorManager.of(context).textSubtle,
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
                l10n.startFreeTrial,
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 12.sp,
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

// ─── Free Trial ───────────────────────────────────────────────────────────────

class _TrialCard extends StatelessWidget {
  const _TrialCard({
    required this.subscription,
    required this.onUpgrade,
  });

  final UserSubscriptionEntity subscription;
  final VoidCallback onUpgrade;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final daysLeft = subscription.trialDaysRemaining;
    final isUrgent = daysLeft <= 7;
    final accentColor =
        isUrgent ? const Color(0xFFF59E0B) : ColorManager.primary;
    final progress = daysLeft / 30;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            accentColor.withValues(alpha: 0.08),
            accentColor.withValues(alpha: 0.02),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  isUrgent ? Icons.timer_outlined : Icons.star_outline,
                  size: 18.w,
                  color: accentColor,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.freeTrial,
                      style: TextStyle(
                        fontFamily: FontHelper.fontFamily(context),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.of(context).textPrimary,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      l10n.trialEndsIn(daysLeft),
                      style: TextStyle(
                        fontFamily: FontHelper.fontFamily(context),
                        fontSize: 11.sp,
                        color: ColorManager.of(context).textSubtle,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  l10n.daysLeft(daysLeft),
                  style: TextStyle(
                    fontFamily: FontHelper.fontFamily(context),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    color: accentColor,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 14.h),

          // Progress slider
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: accentColor.withValues(alpha: 0.1),
              valueColor: AlwaysStoppedAnimation<Color>(accentColor),
              minHeight: 6.h,
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
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: Text(
                  l10n.upgradeNow,
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
        ],
      ),
    );
  }
}

// ─── Active Plan ──────────────────────────────────────────────────────────────

class _ActivePlanCard extends StatelessWidget {
  const _ActivePlanCard({
    required this.subscription,
    required this.storageUsedGb,
    required this.storageTotalGb,
    required this.onViewPlans,
  });

  final UserSubscriptionEntity subscription;
  final double storageUsedGb;
  final double storageTotalGb;
  final VoidCallback onViewPlans;

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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final planName = _getPlanName(subscription.planTier);
    final isActive = subscription.status == SubscriptionStatus.active;
    final statusColor = isActive ? const Color(0xFF10B981) : const Color(0xFFF59E0B);
    final statusLabel = isActive ? l10n.active : l10n.inactive;
    final renewDate = DateFormat('MMM d, yyyy').format(subscription.currentPeriodEnd);
    final storageProgress =
        storageTotalGb > 0 ? (storageUsedGb / storageTotalGb).clamp(0.0, 1.0) : 0.0;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.of(context).cardBgSecondary,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: ColorManager.of(context).borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: plan name + status badge
          Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: ColorManager.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.verified_outlined,
                  size: 18.w,
                  color: ColorManager.primary,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$planName ${l10n.plan}',
                      style: TextStyle(
                        fontFamily: FontHelper.fontFamily(context),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.of(context).textPrimary,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      l10n.renewsOn(renewDate),
                      style: TextStyle(
                        fontFamily: FontHelper.fontFamily(context),
                        fontSize: 11.sp,
                        color: ColorManager.of(context).textSubtle,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  statusLabel,
                  style: TextStyle(
                    fontFamily: FontHelper.fontFamily(context),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 14.h),

          // Storage bar
          Row(
            children: [
              Text(
                l10n.storageUsed,
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 12.sp,
                  color: ColorManager.of(context).textSubtle,
                ),
              ),
              const Spacer(),
              Text(
                l10n.storageValue(
                  storageUsedGb.toStringAsFixed(1),
                  storageTotalGb.toStringAsFixed(0),
                ),
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorManager.of(context).textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: storageProgress,
              backgroundColor: ColorManager.of(context).borderLight,
              valueColor: AlwaysStoppedAnimation<Color>(
                storageProgress > 0.85 ? const Color(0xFFF59E0B) : ColorManager.primary,
              ),
              minHeight: 6.h,
            ),
          ),

          SizedBox(height: 14.h),

          // View all plans button
          GestureDetector(
            onTap: onViewPlans,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(
                color: ColorManager.of(context).cardBg,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: ColorManager.primary),
              ),
              child: Center(
                child: Text(
                  l10n.viewAllPlans,
                  style: TextStyle(
                    fontFamily: FontHelper.fontFamily(context),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.primary,
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
