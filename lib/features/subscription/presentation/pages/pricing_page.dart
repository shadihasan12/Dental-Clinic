import 'dart:math' as math;
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
import 'package:dental_clinic_app/injection.dart';

class PricingPage extends StatelessWidget {
  const PricingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SubscriptionBloc>()
        ..add(const SubscriptionEvent.loadPlans()),
      child: const _PricingContent(),
    );
  }
}

class _PricingContent extends StatefulWidget {
  const _PricingContent();

  @override
  State<_PricingContent> createState() => _PricingContentState();
}

class _PricingContentState extends State<_PricingContent> {
  late PageController _pageController;
  int _currentPage = 1; // Start on "Growing" (popular)

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.82,
      initialPage: _currentPage,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.scaffoldBackground,
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
          return Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: state.isLoadingPlans
                    ? const Center(child: CircularProgressIndicator())
                    : _buildContent(context, state),
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
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 28.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    Icons.arrow_back_ios_new,
                    color: ColorManager.white,
                    size: 18.w,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 56.w,
                      height: 56.w,
                      decoration: BoxDecoration(
                        color: ColorManager.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Icon(
                        Icons.workspace_premium_rounded,
                        color: ColorManager.white,
                        size: 30.w,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Choose Your Plan',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        fontWeight: FontWeight.w700,
                        color: ColorManager.white,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Simple pricing that grows with your practice',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        fontWeight: FontWeight.w400,
                        color: ColorManager.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, SubscriptionState state) {
    final plans = state.availablePlans;
    if (plans.isEmpty) return const SizedBox.shrink();

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20.h),

          // Billing toggle
          _BillingToggle(
            selectedCycle: state.selectedBillingCycle,
            onChanged: (cycle) {
              context.read<SubscriptionBloc>().add(
                    SubscriptionEvent.changeBillingCycle(cycle),
                  );
            },
          ),

          SizedBox(height: 24.h),

          // Horizontal sliding plan cards
          SizedBox(
            height: 460.h,
            child: PageView.builder(
              controller: _pageController,
              itemCount: plans.length,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double scale = 1.0;
                    if (_pageController.position.haveDimensions) {
                      final page = _pageController.page ??
                          _pageController.initialPage.toDouble();
                      scale = math.max(0.88, 1 - (page - index).abs() * 0.12);
                    }
                    return Transform.scale(
                      scale: scale,
                      child: child,
                    );
                  },
                  child: _PlanCard(
                    plan: plans[index],
                    billingCycle: state.selectedBillingCycle,
                    isSelected: state.selectedPlan?.id == plans[index].id,
                    isCurrentPlan:
                        state.currentSubscription?.planTier == plans[index].tier,
                    onSelect: () {
                      context.read<SubscriptionBloc>().add(
                            SubscriptionEvent.selectPlan(plans[index]),
                          );
                    },
                  ),
                );
              },
            ),
          ),

          // Page indicator dots
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              plans.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                width: _currentPage == index ? 24.w : 8.w,
                height: 8.w,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? ColorManager.primary
                      : ColorManager.gray300,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
          ),

          SizedBox(height: 20.h),

          // Free trial banner
          if (!state.hasActiveSubscription)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: _TrialBanner(
                onStartTrial: () {
                  context.read<SubscriptionBloc>().add(
                        const SubscriptionEvent.startTrial('user_id'),
                      );
                },
              ),
            ),

          // Subscribe button
          if (state.selectedPlan != null)
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
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

          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}

// ─── Billing Toggle ────────────────────────────

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
      margin: EdgeInsets.symmetric(horizontal: 40.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: ColorManager.gray100,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          _buildOption(context, 'Monthly', BillingCycle.monthly),
          _buildOption(context, 'Yearly', BillingCycle.yearly,
              badge: AppConfig.yearlyBadgeText),
        ],
      ),
    );
  }

  Widget _buildOption(
    BuildContext context,
    String label,
    BillingCycle cycle, {
    String? badge,
  }) {
    final isSelected = selectedCycle == cycle;
    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(cycle),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? ColorManager.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: ColorManager.black.withValues(alpha: 0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    )
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? ColorManager.primary
                      : ColorManager.textSecondary,
                ),
              ),
              if (badge != null) ...[
                SizedBox(width: 6.w),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: ColorManager.success,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    badge,
                    style: TextStyle(
                      fontSize: 9.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      fontWeight: FontWeight.w600,
                      color: ColorManager.white,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Plan Card ────────────────────────────────

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

  IconData get _planIcon {
    switch (plan.tier) {
      case PlanTier.starter:
        return Icons.rocket_launch_rounded;
      case PlanTier.growing:
        return Icons.trending_up_rounded;
      case PlanTier.advanced:
        return Icons.diamond_rounded;
      default:
        return Icons.star_rounded;
    }
  }

  Color get _accentColor {
    switch (plan.tier) {
      case PlanTier.starter:
        return ColorManager.info;
      case PlanTier.growing:
        return ColorManager.primary;
      case PlanTier.advanced:
        return ColorManager.purple;
      default:
        return ColorManager.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final price = plan.getPrice(billingCycle);
    final isYearly = billingCycle == BillingCycle.yearly;

    return GestureDetector(
      onTap: isCurrentPlan ? null : onSelect,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: isSelected
                ? _accentColor
                : plan.isPopular
                    ? _accentColor.withValues(alpha: 0.3)
                    : ColorManager.gray200,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? _accentColor.withValues(alpha: 0.2)
                  : ColorManager.black.withValues(alpha: 0.06),
              blurRadius: isSelected ? 20 : 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top badge
            if (plan.isPopular || isCurrentPlan)
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  gradient: isCurrentPlan
                      ? GradientManager.success
                      : LinearGradient(
                          colors: [
                            _accentColor,
                            _accentColor.withValues(alpha: 0.8),
                          ],
                        ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22.r),
                    topRight: Radius.circular(22.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isCurrentPlan
                          ? Icons.check_circle_rounded
                          : Icons.star_rounded,
                      color: ColorManager.white,
                      size: 14.w,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      isCurrentPlan ? 'Current Plan' : 'Most Popular',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        fontWeight: FontWeight.w600,
                        color: ColorManager.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Plan icon + name
                    Row(
                      children: [
                        Container(
                          width: 44.w,
                          height: 44.w,
                          decoration: BoxDecoration(
                            color: _accentColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            _planIcon,
                            color: _accentColor,
                            size: 22.w,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              plan.name,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontFamily: FontHelper.fontFamily(context),
                                fontWeight: FontWeight.w700,
                                color: ColorManager.textPrimary,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              plan.description,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: FontHelper.fontFamily(context),
                                color: ColorManager.textTertiary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    // Price
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 32.sp,
                            fontFamily: FontHelper.fontFamily(context),
                            fontWeight: FontWeight.w800,
                            color: _accentColor,
                            height: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 4.h, left: 4.w),
                          child: Text(
                            isYearly ? '/year' : '/month',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: FontHelper.fontFamily(context),
                              color: ColorManager.textTertiary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (isYearly) ...[
                      SizedBox(height: 4.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 3.h),
                        decoration: BoxDecoration(
                          color: ColorManager.successBackground,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          '\$${plan.yearlyMonthlyEquivalent.toStringAsFixed(2)}/mo · Save \$${plan.yearlySavings.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontFamily: FontHelper.fontFamily(context),
                            fontWeight: FontWeight.w600,
                            color: ColorManager.success,
                          ),
                        ),
                      ),
                    ],

                    SizedBox(height: 16.h),
                    Divider(color: ColorManager.gray200, height: 1),
                    SizedBox(height: 12.h),

                    // Features
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            ...plan.features.take(5).map(
                                  (feature) => Padding(
                                    padding: EdgeInsets.only(bottom: 8.h),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 18.w,
                                          height: 18.w,
                                          decoration: BoxDecoration(
                                            color: _accentColor
                                                .withValues(alpha: 0.1),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.check_rounded,
                                            color: _accentColor,
                                            size: 12.w,
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        Expanded(
                                          child: Text(
                                            feature,
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              fontFamily:
                                                  FontHelper.fontFamily(
                                                      context),
                                              color: ColorManager.textPrimary,
                                              height: 1.3,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            if (plan.features.length > 5)
                              Padding(
                                padding: EdgeInsets.only(top: 4.h),
                                child: Text(
                                  '+ ${plan.features.length - 5} more features',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily:
                                        FontHelper.fontFamily(context),
                                    fontWeight: FontWeight.w500,
                                    color: _accentColor,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),

                    // Choose button
                    SizedBox(height: 8.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isCurrentPlan ? null : onSelect,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isSelected
                              ? _accentColor
                              : _accentColor.withValues(alpha: 0.1),
                          foregroundColor:
                              isSelected ? ColorManager.white : _accentColor,
                          elevation: 0,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (isSelected)
                              Padding(
                                padding: EdgeInsets.only(right: 6.w),
                                child: Icon(
                                  Icons.check_circle_rounded,
                                  size: 18.w,
                                ),
                              ),
                            Text(
                              isCurrentPlan
                                  ? 'Current Plan'
                                  : isSelected
                                      ? 'Selected'
                                      : 'Choose ${plan.name}',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontFamily: FontHelper.fontFamily(context),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Trial Banner ────────────────────────────────

class _TrialBanner extends StatelessWidget {
  final VoidCallback onStartTrial;

  const _TrialBanner({required this.onStartTrial});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: GradientManager.primaryButton,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.primary.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: ColorManager.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(
              Icons.rocket_launch_rounded,
              color: ColorManager.white,
              size: 24.w,
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Start Free Trial',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w700,
                    color: ColorManager.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '${AppConfig.freeTrialText} · ${AppConfig.noCreditCardText}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    color: ColorManager.white.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          GestureDetector(
            onTap: onStartTrial,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                'Start',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: FontWeight.w600,
                  color: ColorManager.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Subscribe Button ────────────────────────────

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
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
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
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          AppConfig.cancelAnytimeText,
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: FontHelper.fontFamily(context),
            color: ColorManager.textTertiary,
          ),
        ),
      ],
    );
  }
}
