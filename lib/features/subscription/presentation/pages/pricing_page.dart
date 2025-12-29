import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/config/app_config.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/gradient_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_plan_entity.dart';
import 'package:dental_clinic_app/features/subscription/presentation/bloc/subscription_bloc.dart';

class PricingPage extends StatelessWidget {
  const PricingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubscriptionBloc()
        ..add(const SubscriptionEvent.loadPlans()),
      child: const _PricingContent(),
    );
  }
}

class _PricingContent extends StatelessWidget {
  const _PricingContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      body: BlocConsumer<SubscriptionBloc, SubscriptionState>(
        listener: (context, state) {
          if (state.subscribeSuccess) {
            AppSnackbar.showSuccess(
              context,
              title: 'Subscription Active',
              message: 'Welcome to your new plan!',
            );
            context.pop();
          }
          if (state.trialStarted) {
            AppSnackbar.showSuccess(
              context,
              title: 'Trial Started',
              message: 'Enjoy 30 days of full access!',
            );
            context.pop();
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
                child: _buildHeader(context),
              ),

              // Billing Toggle
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: _BillingToggle(
                    selectedCycle: state.selectedBillingCycle,
                    onChanged: (cycle) {
                      context.read<SubscriptionBloc>().add(
                            SubscriptionEvent.changeBillingCycle(cycle),
                          );
                    },
                  ),
                ),
              ),

              SizedBox(height: 24.h).sliver,

              // Plans
              if (state.isLoadingPlans)
                const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                )
              else
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final plan = state.availablePlans[index];
                        return _PlanCard(
                          plan: plan,
                          billingCycle: state.selectedBillingCycle,
                          isSelected: state.selectedPlan?.id == plan.id,
                          isCurrentPlan:
                              state.currentSubscription?.planTier == plan.tier,
                          onSelect: () {
                            context.read<SubscriptionBloc>().add(
                                  SubscriptionEvent.selectPlan(plan),
                                );
                          },
                        );
                      },
                      childCount: state.availablePlans.length,
                    ),
                  ),
                ),

              // Free Trial Banner
              if (!state.hasActiveSubscription)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: _TrialBanner(
                      onStartTrial: () {
                        context.read<SubscriptionBloc>().add(
                              const SubscriptionEvent.startTrial('user_id'),
                            );
                      },
                    ),
                  ),
                ),

              // Subscribe Button
              if (state.selectedPlan != null)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: _SubscribeButton(
                      plan: state.selectedPlan!,
                      billingCycle: state.selectedBillingCycle,
                      isProcessing: state.isProcessing,
                      onSubscribe: () {
                        context.read<SubscriptionBloc>().add(
                              const SubscriptionEvent.subscribe(
                                userId: 'user_id',
                                paymentMethodId: 'payment_method_id',
                              ),
                            );
                      },
                    ),
                  ),
                ),

              SliverToBoxAdapter(
                child: SizedBox(height: 32.h),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: GradientManager.primaryHeader,
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 32.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: ColorManager.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: ColorManager.white,
                        size: 20.w,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Text(
                'Choose Your Plan',
                style: TextStyleManager.headlineMedium.copyWith(
                  color: ColorManager.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Simple pricing that grows with your practice',
                style: TextStyleManager.bodyMedium.copyWith(
                  color: ColorManager.white.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BillingToggle extends StatelessWidget {
  final BillingCycle selectedCycle;
  final ValueChanged<BillingCycle> onChanged;

  const _BillingToggle({
    required this.selectedCycle,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 24.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: ColorManager.gray100,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: _ToggleOption(
              label: 'Monthly',
              isSelected: selectedCycle == BillingCycle.monthly,
              onTap: () => onChanged(BillingCycle.monthly),
            ),
          ),
          Expanded(
            child: _ToggleOption(
              label: 'Yearly',
              badge: AppConfig.yearlyBadgeText,
              isSelected: selectedCycle == BillingCycle.yearly,
              onTap: () => onChanged(BillingCycle.yearly),
            ),
          ),
        ],
      ),
    );
  }
}

class _ToggleOption extends StatelessWidget {
  final String label;
  final String? badge;
  final bool isSelected;
  final VoidCallback onTap;

  const _ToggleOption({
    required this.label,
    this.badge,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? ColorManager.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: ColorManager.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                  )
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyleManager.titleSmall.copyWith(
                color: isSelected
                    ? ColorManager.primary
                    : ColorManager.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            if (badge != null) ...[
              SizedBox(width: 6.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: ColorManager.success,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  badge!,
                  style: TextStyleManager.labelSmall.copyWith(
                    color: ColorManager.white,
                    fontSize: 10.sp,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final SubscriptionPlanEntity plan;
  final BillingCycle billingCycle;
  final bool isSelected;
  final bool isCurrentPlan;
  final VoidCallback onSelect;

  const _PlanCard({
    required this.plan,
    required this.billingCycle,
    required this.isSelected,
    required this.isCurrentPlan,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final price = plan.getPrice(billingCycle);
    final isYearly = billingCycle == BillingCycle.yearly;

    return GestureDetector(
      onTap: isCurrentPlan ? null : onSelect,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? ColorManager.primary
                : plan.isPopular
                    ? ColorManager.primary.withValues(alpha: 0.3)
                    : ColorManager.gray200,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? ColorManager.primary.withValues(alpha: 0.15)
                  : ColorManager.black.withValues(alpha: 0.05),
              blurRadius: isSelected ? 12 : 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with badges
            if (plan.isPopular || isCurrentPlan)
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  color: isCurrentPlan
                      ? ColorManager.success
                      : ColorManager.primary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14.r),
                    topRight: Radius.circular(14.r),
                  ),
                ),
                child: Text(
                  isCurrentPlan ? 'Current Plan' : 'Most Popular',
                  style: TextStyleManager.labelMedium.copyWith(
                    color: ColorManager.white,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Plan name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        plan.name,
                        style: TextStyleManager.headlineSmall.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (isSelected)
                        Container(
                          width: 24.w,
                          height: 24.w,
                          decoration: const BoxDecoration(
                            color: ColorManager.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            color: ColorManager.white,
                            size: 16.w,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    plan.description,
                    style: TextStyleManager.bodySmall.copyWith(
                      color: ColorManager.textSecondary,
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Price
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$${price.toStringAsFixed(2)}',
                        style: TextStyleManager.headlineMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: ColorManager.primary,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 4.h, left: 4.w),
                        child: Text(
                          isYearly ? '/year' : '/month',
                          style: TextStyleManager.bodyMedium.copyWith(
                            color: ColorManager.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (isYearly) ...[
                    SizedBox(height: 4.h),
                    Text(
                      '\$${plan.yearlyMonthlyEquivalent.toStringAsFixed(2)}/mo • Save \$${plan.yearlySavings.toStringAsFixed(0)}',
                      style: TextStyleManager.labelSmall.copyWith(
                        color: ColorManager.success,
                      ),
                    ),
                  ],

                  SizedBox(height: 16.h),
                  Divider(color: ColorManager.gray200, height: 1),
                  SizedBox(height: 16.h),

                  // Features
                  ...plan.features.take(5).map(
                        (feature) => Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: ColorManager.success,
                                size: 18.w,
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Text(
                                  feature,
                                  style: TextStyleManager.bodySmall.copyWith(
                                    color: ColorManager.textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                  if (plan.features.length > 5) ...[
                    SizedBox(height: 8.h),
                    Text(
                      '+ ${plan.features.length - 5} more features',
                      style: TextStyleManager.labelSmall.copyWith(
                        color: ColorManager.primary,
                      ),
                    ),
                  ],

                  // Limitations
                  if (plan.limitations.isNotEmpty) ...[
                    SizedBox(height: 12.h),
                    ...plan.limitations.map(
                      (limitation) => Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: ColorManager.textTertiary,
                              size: 16.w,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                limitation,
                                style: TextStyleManager.labelSmall.copyWith(
                                  color: ColorManager.textTertiary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TrialBanner extends StatelessWidget {
  final VoidCallback onStartTrial;

  const _TrialBanner({required this.onStartTrial});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: GradientManager.primaryButton,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: ColorManager.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.rocket_launch,
              color: ColorManager.white,
              size: 24.w,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Start Free Trial',
                  style: TextStyleManager.titleMedium.copyWith(
                    color: ColorManager.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '${AppConfig.freeTrialText} • ${AppConfig.noCreditCardText}',
                  style: TextStyleManager.bodySmall.copyWith(
                    color: ColorManager.white.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onStartTrial,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.white,
              foregroundColor: ColorManager.primary,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: const Text('Start'),
          ),
        ],
      ),
    );
  }
}

class _SubscribeButton extends StatelessWidget {
  final SubscriptionPlanEntity plan;
  final BillingCycle billingCycle;
  final bool isProcessing;
  final VoidCallback onSubscribe;

  const _SubscribeButton({
    required this.plan,
    required this.billingCycle,
    required this.isProcessing,
    required this.onSubscribe,
  });

  @override
  Widget build(BuildContext context) {
    final price = plan.getPrice(billingCycle);

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 56.h,
          child: ElevatedButton(
            onPressed: isProcessing ? null : onSubscribe,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primary,
              foregroundColor: ColorManager.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: isProcessing
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
                : Text(
                    'Subscribe to ${plan.name} - \$${price.toStringAsFixed(2)}${billingCycle == BillingCycle.yearly ? '/yr' : '/mo'}',
                    style: TextStyleManager.button.copyWith(
                      color: ColorManager.white,
                    ),
                  ),
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          AppConfig.cancelAnytimeText,
          style: TextStyleManager.labelSmall.copyWith(
            color: ColorManager.textTertiary,
          ),
        ),
      ],
    );
  }
}

extension on SizedBox {
  Widget get sliver => SliverToBoxAdapter(child: this);
}
