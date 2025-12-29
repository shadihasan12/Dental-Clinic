import 'package:freezed_annotation/freezed_annotation.dart';
import 'subscription_plan_entity.dart';

part 'user_subscription_entity.freezed.dart';

/// Status of a subscription
enum SubscriptionStatus {
  /// Active trial period
  trial,

  /// Active paid subscription
  active,

  /// Payment failed, grace period
  pastDue,

  /// Subscription cancelled but still active until period ends
  cancelled,

  /// Subscription expired
  expired,

  /// No subscription (free tier / limited access)
  none,
}

/// Represents a user's or clinic's subscription
@freezed
class UserSubscriptionEntity with _$UserSubscriptionEntity {
  const factory UserSubscriptionEntity({
    required String id,
    required String userId, // or clinicId
    required PlanTier planTier,
    required SubscriptionStatus status,
    required BillingCycle billingCycle,
    required DateTime startDate,
    required DateTime currentPeriodEnd,
    DateTime? trialEndDate,
    DateTime? cancelledAt,
    @Default(false) bool autoRenew,
    String? paymentMethodId,
    String? lastPaymentId,
    DateTime? lastPaymentDate,
    double? lastPaymentAmount,

    // Usage tracking
    @Default(0) int currentDentistCount,
    @Default(0) int currentAssistantCount,
    @Default(0) int currentBranchCount,
    @Default(0) int currentPatientCount,
  }) = _UserSubscriptionEntity;

  const UserSubscriptionEntity._();

  /// Check if subscription is currently valid
  bool get isValid {
    if (status == SubscriptionStatus.none ||
        status == SubscriptionStatus.expired) {
      return false;
    }
    return DateTime.now().isBefore(currentPeriodEnd);
  }

  /// Check if in trial period
  bool get isInTrial {
    if (trialEndDate == null) return false;
    return status == SubscriptionStatus.trial &&
        DateTime.now().isBefore(trialEndDate!);
  }

  /// Days remaining in trial
  int get trialDaysRemaining {
    if (trialEndDate == null) return 0;
    final remaining = trialEndDate!.difference(DateTime.now()).inDays;
    return remaining > 0 ? remaining : 0;
  }

  /// Days until renewal/expiry
  int get daysUntilRenewal {
    final remaining = currentPeriodEnd.difference(DateTime.now()).inDays;
    return remaining > 0 ? remaining : 0;
  }

  /// Check if near expiry (7 days or less)
  bool get isNearExpiry => daysUntilRenewal <= 7 && daysUntilRenewal > 0;

  /// Check if can add more dentists
  bool canAddDentist(int maxAllowed) => currentDentistCount < maxAllowed;

  /// Check if can add more assistants
  bool canAddAssistant(int maxAllowed) => currentAssistantCount < maxAllowed;

  /// Check if can add more branches
  bool canAddBranch(int maxAllowed) => currentBranchCount < maxAllowed;
}

/// Free trial configuration
class TrialConfig {
  TrialConfig._();

  /// Trial duration in days
  static const int trialDays = 30;

  /// Features available during trial (same as Growing plan)
  static const PlanTier trialTier = PlanTier.growing;

  /// Create a new trial subscription
  static UserSubscriptionEntity createTrial({
    required String userId,
  }) {
    final now = DateTime.now();
    return UserSubscriptionEntity(
      id: 'trial_${userId}_${now.millisecondsSinceEpoch}',
      userId: userId,
      planTier: trialTier,
      status: SubscriptionStatus.trial,
      billingCycle: BillingCycle.monthly,
      startDate: now,
      currentPeriodEnd: now.add(const Duration(days: trialDays)),
      trialEndDate: now.add(const Duration(days: trialDays)),
      autoRenew: false,
    );
  }
}
