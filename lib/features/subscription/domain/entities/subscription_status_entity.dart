/// Subscription status shown on the home card.
///
/// Mirrors the `/subscriptions/status` response.
class SubscriptionStatusEntity {
  final String planName;
  final String status;
  final bool isTrial;
  final bool isExpired;
  final bool isInGracePeriod;
  final int? remainingDays;
  final DateTime? startsAt;
  final DateTime? endsAt;
  final DateTime? graceEndsAt;
  final String? billingPeriod;

  const SubscriptionStatusEntity({
    required this.planName,
    required this.status,
    required this.isTrial,
    this.isExpired = false,
    this.isInGracePeriod = false,
    this.remainingDays,
    this.startsAt,
    this.endsAt,
    this.graceEndsAt,
    this.billingPeriod,
  });

  /// Days remaining until [endsAt]. Prefers the server-provided value.
  int get daysRemaining {
    if (remainingDays != null) return remainingDays!;
    if (endsAt == null) return 0;
    final diff = endsAt!.difference(DateTime.now()).inDays;
    return diff > 0 ? diff : 0;
  }

  bool get isActive => status.toUpperCase() == 'ACTIVE';
}
