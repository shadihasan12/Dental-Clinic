import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_plan_entity.freezed.dart';

/// Subscription plan tiers
enum PlanTier {
  /// Free trial - all features for limited time
  trial,

  /// For individual dentists or new small clinics
  /// 1 dentist, 1 assistant, limited features
  starter,

  /// For growing clinics
  /// 2-4 dentists, full features, unlimited patients
  growing,

  /// For busy clinics with multiple branches
  /// 5+ dentists, advanced reports, priority support
  advanced,
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

  /// Get price based on billing cycle
  double getPrice(BillingCycle cycle) {
    return cycle == BillingCycle.yearly ? yearlyPrice : monthlyPrice;
  }

  /// Get monthly equivalent for yearly plan
  double get yearlyMonthlyEquivalent => yearlyPrice / 12;

  /// Calculate savings with yearly plan
  double get yearlySavings => (monthlyPrice * 12) - yearlyPrice;

  /// Get savings percentage
  int get savingsPercentage =>
      ((yearlySavings / (monthlyPrice * 12)) * 100).round();
}

/// Predefined plans - Unified for all dental professionals
/// Plans scale based on practice size, not account type
class SubscriptionPlans {
  SubscriptionPlans._();

  /// Starter Plan - Solo practitioners
  static const starterPlan = SubscriptionPlanEntity(
    id: 'starter',
    tier: PlanTier.starter,
    name: 'Starter',
    description: 'Perfect for solo practitioners',
    monthlyPrice: 4.99,
    yearlyPrice: 49.99, // ~2 months free
    maxDentists: 1,
    maxAssistants: 1,
    maxBranches: 1,
    features: [
      'Unlimited patients',
      'Appointment scheduling',
      'Treatment records',
      'Invoice generation',
      'Email reminders',
      'Cloud sync & backup',
    ],
    limitations: [
      '1 dentist',
      '1 assistant',
      'Basic reports',
      'Email support',
    ],
  );

  /// Growing Plan - Small teams
  static const growingPlan = SubscriptionPlanEntity(
    id: 'growing',
    tier: PlanTier.growing,
    name: 'Growing',
    description: 'For practices ready to expand',
    monthlyPrice: 14.99,
    yearlyPrice: 149.99, // ~2 months free
    maxDentists: 4,
    maxAssistants: 6,
    maxBranches: 2,
    isPopular: true,
    features: [
      'Everything in Starter',
      'Up to 4 dentists',
      'Up to 6 staff members',
      'Up to 2 locations',
      'Advanced reports & analytics',
      'X-ray & photo storage',
      'SMS reminders',
      'Priority email support',
    ],
    limitations: [
      '4 dentists max',
      '2 branches max',
    ],
  );

  /// Advanced Plan - Large practices & chains
  static const advancedPlan = SubscriptionPlanEntity(
    id: 'advanced',
    tier: PlanTier.advanced,
    name: 'Advanced',
    description: 'For busy multi-location practices',
    monthlyPrice: 34.99,
    yearlyPrice: 349.99, // ~2 months free
    maxDentists: 99,
    maxAssistants: 99,
    maxBranches: 99,
    features: [
      'Everything in Growing',
      'Unlimited dentists',
      'Unlimited staff',
      'Unlimited branches',
      'Cross-location analytics',
      'Custom branding',
      'API access',
      'Dedicated account manager',
      'Phone & chat support',
      'Training sessions',
    ],
    limitations: [],
  );

  /// Get all available plans (unified for all users)
  static List<SubscriptionPlanEntity> get allPlans => [
        starterPlan,
        growingPlan,
        advancedPlan,
      ];

  /// Get plan by tier
  static SubscriptionPlanEntity? getPlanByTier(PlanTier tier) {
    switch (tier) {
      case PlanTier.starter:
        return starterPlan;
      case PlanTier.growing:
        return growingPlan;
      case PlanTier.advanced:
        return advancedPlan;
      case PlanTier.trial:
        return growingPlan; // Trial has Growing features
    }
  }
}
