part of 'subscription_bloc.dart';

@freezed
class SubscriptionState with _$SubscriptionState {
  const factory SubscriptionState({
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingPlans,
    @Default(false) bool isProcessing,
    UserSubscriptionEntity? currentSubscription,
    @Default([]) List<SubscriptionPlanEntity> availablePlans,
    SubscriptionPlanEntity? selectedPlan,
    @Default(BillingCycle.monthly) BillingCycle selectedBillingCycle,
    SubscriptionPlanEntity? pendingDowngrade,
    String? error,

    // Success flags
    @Default(false) bool trialStarted,
    @Default(false) bool subscribeSuccess,
    @Default(false) bool cancelSuccess,
    @Default(false) bool reactivateSuccess,
    @Default(false) bool upgradeSuccess,
    @Default(false) bool downgradeSuccess,
  }) = _SubscriptionState;

  const SubscriptionState._();

  /// Check if user has an active subscription
  bool get hasActiveSubscription =>
      currentSubscription?.isValid ?? false;

  /// Check if user is in trial
  bool get isInTrial => currentSubscription?.isInTrial ?? false;

  /// Get current plan tier
  PlanTier? get currentTier => currentSubscription?.planTier;

  /// Check if can upgrade
  bool canUpgradeTo(SubscriptionPlanEntity plan) {
    if (currentSubscription == null) return true;
    return plan.tier.index > currentSubscription!.planTier.index;
  }

  /// Check if can downgrade
  bool canDowngradeTo(SubscriptionPlanEntity plan) {
    if (currentSubscription == null) return false;
    return plan.tier.index < currentSubscription!.planTier.index;
  }
}
