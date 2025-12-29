part of 'subscription_bloc.dart';

@freezed
class SubscriptionEvent with _$SubscriptionEvent {
  /// Load current subscription for user/clinic
  const factory SubscriptionEvent.loadSubscription(String userId) = _LoadSubscription;

  /// Load available plans
  const factory SubscriptionEvent.loadPlans() = _LoadPlans;

  /// Select a plan for purchase
  const factory SubscriptionEvent.selectPlan(SubscriptionPlanEntity plan) = _SelectPlan;

  /// Change billing cycle (monthly/yearly)
  const factory SubscriptionEvent.changeBillingCycle(BillingCycle cycle) = _ChangeBillingCycle;

  /// Start free trial
  const factory SubscriptionEvent.startTrial(String userId) = _StartTrial;

  /// Subscribe to selected plan
  const factory SubscriptionEvent.subscribe({
    required String userId,
    required String paymentMethodId,
  }) = _Subscribe;

  /// Cancel subscription
  const factory SubscriptionEvent.cancelSubscription() = _CancelSubscription;

  /// Reactivate cancelled subscription
  const factory SubscriptionEvent.reactivateSubscription() = _ReactivateSubscription;

  /// Upgrade to a higher plan
  const factory SubscriptionEvent.upgradePlan(SubscriptionPlanEntity newPlan) = _UpgradePlan;

  /// Downgrade to a lower plan (takes effect at end of period)
  const factory SubscriptionEvent.downgradePlan(SubscriptionPlanEntity newPlan) = _DowngradePlan;
}
