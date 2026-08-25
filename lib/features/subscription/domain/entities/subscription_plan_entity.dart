import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_plan_entity.freezed.dart';

/// Subscription plan tiers
enum PlanTier {
  /// Free trial
  trial,

  /// Solo practitioner — 1 dentist
  solo,

  /// Two dentists with statistics
  duo,

  /// Mid-size center — up to 4 dentists
  clinic,

  /// Big center — up to 10 dentists
  practice,

  /// Custom plan — pricing arranged via sales contact
  custom,
}

/// Billing cycle options
enum BillingCycle {
  monthly,
  yearly, // 2 months free
}

/// Represents a subscription plan with its features and limits
@freezed
class SubscriptionPlanEntity with _$SubscriptionPlanEntity {
  const factory SubscriptionPlanEntity({
    required String id,
    required PlanTier tier,
    required String name,
    required String description,
    required double monthlyPrice,
    required double yearlyPrice, // With discount
    required int maxDentists,
    required int maxAssistants,
    required int maxBranches,
    required List<String> features,
    required List<String> limitations,
    @Default(false) bool isPopular,
    @Default(true) bool isActive,
  }) = _SubscriptionPlanEntity;

  const SubscriptionPlanEntity._();

  /// True for the "Custom" plan — no fixed price; UI must route the user
  /// to the contact-sales flow instead of the normal checkout.
  bool get isCustom => tier == PlanTier.custom;

  /// Get price based on billing cycle
  double getPrice(BillingCycle cycle) {
    return cycle == BillingCycle.yearly ? yearlyPrice : monthlyPrice;
  }

  /// Get monthly equivalent for yearly plan
  double get yearlyMonthlyEquivalent =>
      yearlyPrice == 0 ? 0 : yearlyPrice / 12;

  /// Calculate savings with yearly plan
  double get yearlySavings => (monthlyPrice * 12) - yearlyPrice;

  /// Get savings percentage
  int get savingsPercentage {
    if (monthlyPrice == 0) return 0;
    return ((yearlySavings / (monthlyPrice * 12)) * 100).round();
  }
}

/// Predefined plans — four pay tiers + a custom (sales-led) tier.
///
/// Yearly price = monthly × 10 (i.e. two months free), matching the
/// original plan structure.
class SubscriptionPlans {
  SubscriptionPlans._();

  /// Solo practitioner — single-dentist clinics.
  static const soloPlan = SubscriptionPlanEntity(
    id: 'solo',
    tier: PlanTier.solo,
    name: 'Solo',
    description: 'For a single dentist starting out',
    monthlyPrice: 7,
    yearlyPrice: 70, // ~2 months free
    maxDentists: 1,
    maxAssistants: 1,
    maxBranches: 1,
    features: [
      '1 dentist',
      '1 assistant',
      'Unlimited patients',
      'Appointment scheduling',
      'Treatment plans & records',
      'Invoice generation',
      'X-ray & photo storage',
      'Cloud sync & backup',
      'Email support',
    ],
    limitations: [],
  );

  /// Duo — two dentists, with statistics.
  static const duoPlan = SubscriptionPlanEntity(
    id: 'duo',
    tier: PlanTier.duo,
    name: 'Duo',
    description: 'For two dentists working together',
    monthlyPrice: 12,
    yearlyPrice: 120, // ~2 months free
    maxDentists: 2,
    maxAssistants: 2,
    maxBranches: 1,
    features: [
      'Everything in Solo, plus:',
      'Up to 2 dentists',
      'Up to 2 assistants',
      'Statistics & analytics dashboard',
      'Email & SMS reminders',
      'Priority email support',
    ],
    limitations: [],
  );

  /// Clinic — mid-size center, up to 4 dentists.
  static const clinicPlan = SubscriptionPlanEntity(
    id: 'clinic',
    tier: PlanTier.clinic,
    name: 'Clinic',
    description: 'For mid-size centers',
    monthlyPrice: 24,
    yearlyPrice: 240, // ~2 months free
    maxDentists: 4,
    maxAssistants: 6,
    maxBranches: 1,
    isPopular: true,
    features: [
      'Up to 4 dentists',
      'Up to 6 staff members',
      '1 branch location',
      'Statistics & analytics dashboard',
      'Advanced reports',
      'Unlimited patients',
      'Appointment scheduling',
      'Treatment plans & records',
      'Invoice generation & branding',
      'X-ray & photo storage',
      'Email & SMS reminders',
      'Cloud sync & backup',
      'Live chat support',
    ],
    limitations: [],
  );

  /// Practice — big center, up to 10 dentists.
  static const practicePlan = SubscriptionPlanEntity(
    id: 'practice',
    tier: PlanTier.practice,
    name: 'Practice',
    description: 'For big centers and multi-branch practices',
    monthlyPrice: 49,
    yearlyPrice: 490, // ~2 months free
    maxDentists: 8,
    maxAssistants: 999,
    maxBranches: 3,
    features: [
      'Everything in Clinic, plus:',
      'Up to 8 dentists',
      'Unlimited staff members',
      'Up to 3 branch locations',
      'Cross-location analytics',
      'Phone & chat support',
      'Priority training sessions',
    ],
    limitations: [],
  );

  /// Custom — bespoke plan, contact sales for pricing.
  static const customPlan = SubscriptionPlanEntity(
    id: 'custom',
    tier: PlanTier.custom,
    name: 'Custom',
    description: 'Tailored to your organization',
    monthlyPrice: 0,
    yearlyPrice: 0,
    maxDentists: 999,
    maxAssistants: 999,
    maxBranches: 999,
    features: [
      '10+ dentists',
      'Unlimited staff & branches',
      'Custom integrations',
      'Dedicated account manager',
      'On-site training',
      'SLA & uptime guarantees',
      'Volume discounts',
      'Tailored to your needs',
    ],
    limitations: [],
  );

  /// Get all available plans
  static List<SubscriptionPlanEntity> get allPlans => [
        soloPlan,
        duoPlan,
        clinicPlan,
        practicePlan,
        customPlan,
      ];

  /// Get plan by tier
  static SubscriptionPlanEntity? getPlanByTier(PlanTier tier) {
    switch (tier) {
      case PlanTier.solo:
        return soloPlan;
      case PlanTier.duo:
        return duoPlan;
      case PlanTier.clinic:
        return clinicPlan;
      case PlanTier.practice:
        return practicePlan;
      case PlanTier.custom:
        return customPlan;
      case PlanTier.trial:
        return clinicPlan; // Trial gives Clinic-tier features.
    }
  }
}
