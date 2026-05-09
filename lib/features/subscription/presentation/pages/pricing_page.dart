import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/config/app_config.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/gradient_manager.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/billing/presentation/bloc/billing_bloc.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_plan_entity.dart';
import 'package:dental_clinic_app/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:dental_clinic_app/features/subscription/presentation/utils/pricing_l10n.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';

class PricingPage extends StatelessWidget {
  const PricingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<SubscriptionBloc>()
            ..add(const SubscriptionEvent.loadPlans()),
        ),
        // BillingBloc lives alongside SubscriptionBloc so the Subscribe
        // CTA can create an invoice and let the listener navigate to the
        // payment-instructions page once the new invoice is in state.
        BlocProvider(create: (_) => getIt<BillingBloc>()),
      ],
      child: const _PricingContent(),
    );
  }
}

class _PricingContent extends StatelessWidget {
  const _PricingContent();

  @override
  Widget build(BuildContext context) {
    // The page scrolls as one piece — header included — so the user can
    // see the full plan list, the trial banner, and the subscribe CTA in
    // one continuous flow. Bottom padding accounts for the Android system
    // nav bar (edge-to-edge is enabled globally in main.dart).
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: ColorManager.of(context).scaffoldBg,
      // The body fills the screen including under the status bar so the
      // gradient header reaches edge-to-edge. We wrap the scrollable in a
      // SafeArea(top: false, bottom: false) so we can manage insets per
      // section ourselves.
      extendBodyBehindAppBar: true,
      body: MultiBlocListener(
        listeners: [
          // Subscription bloc only handles the trial flow on this page —
          // the paid subscribe path goes through the invoice flow below.
          BlocListener<SubscriptionBloc, SubscriptionState>(
            listener: (context, state) {
              final l10n = AppLocalizations.of(context)!;
              if (state.trialStarted) {
                AppSnackbar.showSuccess(
                  context,
                  title: l10n.pricingTrialStartedTitle,
                  message: l10n.pricingTrialStartedMessage,
                );
                context.pop();
              }
              if (state.error != null) {
                AppSnackbar.showError(
                  context,
                  title: l10n.errorTitle,
                  message: state.error,
                );
              }
            },
          ),
          // When the dentist taps Subscribe we create an invoice and route
          // them to the invoice details page so they can see payment
          // instructions and upload proof. Activation only happens once
          // an admin approves the invoice.
          BlocListener<BillingBloc, BillingState>(
            listener: (context, state) {
              final l10n = AppLocalizations.of(context)!;
              if (state.error != null) {
                AppSnackbar.showError(
                  context,
                  title: l10n.errorTitle,
                  message: state.error!,
                );
                context.read<BillingBloc>().add(
                      const BillingEvent.clearFlags(),
                    );
              }
              if (state.createdInvoice != null) {
                final invoice = state.createdInvoice!;
                context.read<BillingBloc>().add(
                      const BillingEvent.clearFlags(),
                    );
                context.pushReplacementNamed(
                  AppRoutesNames.invoiceDetails,
                  extra: invoice,
                );
              }
            },
          ),
        ],
        child: BlocBuilder<SubscriptionBloc, SubscriptionState>(
          builder: (context, state) {
          if (state.isLoadingPlans) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Header(),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
                  child: _BillingToggle(
                    selectedCycle: state.selectedBillingCycle,
                    onChanged: (cycle) {
                      context.read<SubscriptionBloc>().add(
                            SubscriptionEvent.changeBillingCycle(cycle),
                          );
                    },
                  ),
                ),
                SizedBox(height: 20.h),
                ...state.availablePlans.map(
                  (plan) => Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 12.h),
                    child: _PlanCard(
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
                    ),
                  ),
                ),
                if (!state.hasActiveSubscription)
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
                    child: _TrialBanner(
                      onStartTrial: () {
                        context.read<SubscriptionBloc>().add(
                              const SubscriptionEvent.startTrial('user_id'),
                            );
                      },
                    ),
                  ),
                // Subscribe CTA only for paid tiers — Custom uses its own
                // in-card "Contact Us" button instead.
                if (state.selectedPlan != null &&
                    !state.selectedPlan!.isCustom)
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
                    child: BlocBuilder<BillingBloc, BillingState>(
                      builder: (context, billingState) {
                        return _SubscribeButton(
                          plan: state.selectedPlan!,
                          billingCycle: state.selectedBillingCycle,
                          // Show the spinner while the invoice is being
                          // created — this is what blocks the user from
                          // double-tapping into two pending invoices.
                          isProcessing: billingState.isProcessing,
                          onSubscribe: () {
                            final clinicId = getIt<UserStorage>()
                                    .getSelectedClinicId() ??
                                '';
                            context.read<BillingBloc>().add(
                                  BillingEvent.createInvoice(
                                    clinicId: clinicId,
                                    plan: state.selectedPlan!,
                                    cycle: state.selectedBillingCycle,
                                  ),
                                );
                          },
                        );
                      },
                    ),
                  ),
                // Bottom inset = system nav bar on Android + breathing room.
                SizedBox(height: 24.h + bottomInset),
              ],
            ),
          );
          },
        ),
      ),
    );
  }
}

// ─── Header ────────────────────────────────────

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(gradient: GradientManager.primaryHeader),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(12.w, 4.h, 16.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isRtl
                        ? Icons.arrow_forward_ios
                        : Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 18.w,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                l10n.pricingTitle,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                l10n.pricingSubtitle,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withValues(alpha: 0.85),
                ),
              ),
            ],
          ),
        ),
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
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: ColorManager.of(context).cardBgSecondary,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          _buildOption(context, l10n.billingMonthly, BillingCycle.monthly),
          _buildOption(
            context,
            l10n.billingYearly,
            BillingCycle.yearly,
            badge: AppConfig.yearlyBadgeText,
          ),
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
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color:
                isSelected ? ColorManager.of(context).cardBg : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
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
                  fontSize: 13.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected
                      ? ColorManager.primary
                      : ColorManager.of(context).textSecondary,
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
                      color: Colors.white,
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

// ─── Plan Card (vertical, compact) ────────────────

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
      case PlanTier.solo:
        return Icons.person_rounded;
      case PlanTier.duo:
        return Icons.people_alt_rounded;
      case PlanTier.clinic:
        return Icons.local_hospital_rounded;
      case PlanTier.practice:
        return Icons.business_rounded;
      case PlanTier.custom:
        return Icons.handshake_rounded;
      default:
        return Icons.star_rounded;
    }
  }

  Color get _accentColor {
    switch (plan.tier) {
      case PlanTier.solo:
        return ColorManager.info;
      case PlanTier.duo:
        return ColorManager.primary;
      case PlanTier.clinic:
        return ColorManager.primary;
      case PlanTier.practice:
        return ColorManager.purple;
      case PlanTier.custom:
        return ColorManager.warning;
      default:
        return ColorManager.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);
    final l10n = AppLocalizations.of(context)!;
    final price = plan.getPrice(billingCycle);
    final isYearly = billingCycle == BillingCycle.yearly;
    final localizedName = PricingL10n.name(l10n, plan.tier);
    final localizedDescription = PricingL10n.description(l10n, plan.tier);
    final localizedFeatures = PricingL10n.features(l10n, plan.tier);

    return GestureDetector(
      onTap: isCurrentPlan ? null : onSelect,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: c.cardBg,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: isSelected
                ? _accentColor
                : plan.isPopular
                    ? _accentColor.withValues(alpha: 0.35)
                    : c.borderLight,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? _accentColor.withValues(alpha: 0.18)
                  : ColorManager.black.withValues(alpha: 0.05),
              blurRadius: isSelected ? 16 : 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: icon, name + description, price
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
              child: Row(
                children: [
                  Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: BoxDecoration(
                      color: _accentColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(_planIcon,
                        color: _accentColor, size: 22.w),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                localizedName,
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  fontFamily: fontFamily,
                                  fontWeight: FontWeight.w700,
                                  color: c.textPrimary,
                                ),
                              ),
                            ),
                            if (plan.isPopular || isCurrentPlan) ...[
                              SizedBox(width: 8.w),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: isCurrentPlan
                                      ? ColorManager.success
                                      : _accentColor,
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Text(
                                  isCurrentPlan
                                      ? l10n.pricingCurrentBadge
                                      : l10n.pricingPopularBadge,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontFamily: fontFamily,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          localizedDescription,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: fontFamily,
                            color: c.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Divider(color: c.divider, height: 1),
            ),
            // Price block — Custom plan shows "Contact us" copy instead.
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
              child: plan.isCustom
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          l10n.pricingCustomPricing,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.w800,
                            color: _accentColor,
                            height: 1,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${price.toStringAsFixed(price % 1 == 0 ? 0 : 2)}',
                          style: TextStyle(
                            fontSize: 26.sp,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.w800,
                            color: _accentColor,
                            height: 1,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Padding(
                          padding: EdgeInsets.only(bottom: 4.h),
                          child: Text(
                            isYearly
                                ? l10n.pricingYearSuffix
                                : l10n.pricingMonthSuffix,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontFamily: fontFamily,
                              color: c.textTertiary,
                            ),
                          ),
                        ),
                        const Spacer(),
                        if (isYearly && plan.yearlySavings > 0)
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: ColorManager.successBackground,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              l10n.pricingSaveAmount(
                                plan.yearlySavings.toStringAsFixed(0),
                              ),
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontFamily: fontFamily,
                                fontWeight: FontWeight.w600,
                                color: ColorManager.success,
                              ),
                            ),
                          ),
                      ],
                    ),
            ),
            // Full feature list — every feature the plan offers, no
            // truncation, so the dentist can compare plans top-to-bottom.
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...localizedFeatures.map(
                    (feature) => Padding(
                      padding: EdgeInsets.only(bottom: 6.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 16.w,
                            height: 16.w,
                            decoration: BoxDecoration(
                              color: _accentColor.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.check_rounded,
                                color: _accentColor, size: 11.w),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Text(
                              feature,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: fontFamily,
                                color: c.textPrimary,
                                height: 1.3,
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
            // Footer pill button. Custom plan routes to contact-sales
            // instead of selecting; Subscribe flow doesn't apply.
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isCurrentPlan
                      ? null
                      : plan.isCustom
                          ? () => context.pushNamed(
                                AppRoutesNames.contactSupport,
                              )
                          : onSelect,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected
                        ? _accentColor
                        : _accentColor.withValues(alpha: 0.1),
                    foregroundColor:
                        isSelected ? Colors.white : _accentColor,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (plan.isCustom) ...[
                        Icon(Icons.mail_outline_rounded, size: 16.w),
                        SizedBox(width: 6.w),
                      ] else if (isSelected) ...[
                        Icon(Icons.check_circle_rounded, size: 16.w),
                        SizedBox(width: 6.w),
                      ],
                      Text(
                        plan.isCustom
                            ? l10n.pricingContactUs
                            : isCurrentPlan
                                ? l10n.pricingCurrentPlanLabel
                                : isSelected
                                    ? l10n.pricingSelectedLabel
                                    : l10n.pricingChooseAction(localizedName),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
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
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: GradientManager.primaryButton,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.primary.withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.rocket_launch_rounded,
              color: Colors.white,
              size: 22.w,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.pricingStartFreeTrial,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '${AppConfig.freeTrialText} · ${AppConfig.noCreditCardText}',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    color: Colors.white.withValues(alpha: 0.9),
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
                color: ColorManager.of(context).cardBg,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                l10n.pricingStartShort,
                style: TextStyle(
                  fontSize: 13.sp,
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
    final l10n = AppLocalizations.of(context)!;
    final price = plan.getPrice(billingCycle);
    final isYearly = billingCycle == BillingCycle.yearly;
    final priceText =
        '\$${price.toStringAsFixed(price % 1 == 0 ? 0 : 2)}'
        '${isYearly ? l10n.pricingYrSuffix : l10n.pricingMoSuffix}';
    final localizedPlanName = PricingL10n.name(l10n, plan.tier);

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 54.h,
          child: ElevatedButton(
            onPressed: isProcessing ? null : onSubscribe,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
            ),
            child: isProcessing
                ? SizedBox(
                    width: 22.w,
                    height: 22.h,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    l10n.pricingSubscribeAction(localizedPlanName, priceText),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          AppConfig.cancelAnytimeText,
          style: TextStyle(
            fontSize: 11.sp,
            fontFamily: FontHelper.fontFamily(context),
            color: ColorManager.of(context).textTertiary,
          ),
        ),
      ],
    );
  }
}
