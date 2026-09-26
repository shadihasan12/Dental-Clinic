import 'package:dental_clinic_app/features/auth/domain/entities/plan_entity.dart';
import 'package:dental_clinic_app/services/subscription_guard/access_mode.dart';

/// Where the clinic's subscription stands, from `GET /subscriptions/status`.
///
/// Decide what to *enable* from [accessMode]; [status] is for what to *say*.
class SubscriptionStatusEntity {
  final String? planId;
  final String planName;

  /// One of TRIALING, ACTIVE, GRACE, EXPIRED, PENDING_ACTIVATION, CANCELED.
  final String status;
  final AccessMode accessMode;
  final bool isExpired;
  final bool isInGracePeriod;
  final int? remainingDays;
  final DateTime? startsAt;

  /// For a trial, when the trial ends; for a paid cycle, when the cycle ends.
  /// Still describes the ended cycle once [isExpired] - don't show it then.
  final DateTime? endsAt;

  /// Set only while ACTIVE (when grace would end if not renewed) or GRACE
  /// (when it does end); null otherwise.
  final DateTime? graceEndsAt;

  /// MONTHLY, YEARLY, or null during a trial - a trial was not bought.
  final String? billingPeriod;

  /// How many [billingPeriod]s the cycle being served was bought for; null
  /// during a trial. With the plan, what a renewal "as it stands" asks for.
  final int? durationQuantity;

  /// A renewal paid for ahead, which begins at [endsAt]. Null when none is.
  final NextCycleEntity? nextCycle;

  /// The clinic's balance, as a number, and in every currency offered.
  final double balanceUsd;
  final List<PriceEntity> balanceAmounts;

  const SubscriptionStatusEntity({
    this.planId,
    required this.planName,
    required this.status,
    this.accessMode = AccessMode.unknown,
    this.isExpired = false,
    this.isInGracePeriod = false,
    this.remainingDays,
    this.startsAt,
    this.endsAt,
    this.graceEndsAt,
    this.billingPeriod,
    this.durationQuantity,
    this.nextCycle,
    this.balanceUsd = 0,
    this.balanceAmounts = const [],
  });

  String get _upper => status.toUpperCase();

  bool get isTrial => _upper == 'TRIALING';
  bool get isActive => _upper == 'ACTIVE';
  bool get isGrace => _upper == 'GRACE' || isInGracePeriod;
  bool get isPendingActivation => _upper == 'PENDING_ACTIVATION';
  bool get isCanceled => _upper == 'CANCELED';

  bool get isPaidCycle => billingPeriod != null;

  /// ACTIVE, GRACE, or EXPIRED after a paid cycle: the plan picker opens as a
  /// renewal, with the current plan, period and quantity selected. Anything
  /// else - a trial, awaiting a first payment, cancelled, expired straight
  /// after a trial - buys a new subscription.
  bool get canRenew =>
      isActive || isGrace || (_upper == 'EXPIRED' && isPaidCycle);

  /// Moving up to a bigger plan now, and buying add-on units, only exist
  /// while ACTIVE.
  bool get canUpgrade => isActive;

  /// Days remaining until [endsAt]; 0 once it has ended, never negative.
  int get daysRemaining {
    if (remainingDays != null) return remainingDays!;
    if (endsAt == null) return 0;
    return calendarDaysUntil(endsAt!);
  }
}

/// The next cycle, paid for ahead. It begins on its own when the current
/// cycle ends; until then nothing else about the subscription changes.
class NextCycleEntity {
  const NextCycleEntity({
    required this.planName,
    required this.durationQuantity,
    this.planId,
    this.planVersionId,
    this.billingPeriod,
    this.startsAt,
    this.endsAt,
    this.addons = const [],
    this.paidUsd,
    this.invoiceId,
  });

  final String? planId;
  final String? planVersionId;
  final String planName;
  final String? billingPeriod;
  final int durationQuantity;
  final DateTime? startsAt;
  final DateTime? endsAt;

  /// Add-on units it was bought with: name and how many.
  final List<({String name, int quantity})> addons;
  final double? paidUsd;
  final String? invoiceId;
}

/// Whole calendar days from today to [end]'s date, never negative.
///
/// Not `end.difference(now).inDays`: that truncates, so a trial ending at
/// this time of day 30 days out reads 29 from the first minute - while the
/// server's own `remaining_days`, shown on other screens, says 30. Dates are
/// compared as UTC midnights so a DST change cannot shave off an hour.
int calendarDaysUntil(DateTime end) {
  final now = DateTime.now();
  final e = end.toLocal();
  final days = DateTime.utc(e.year, e.month, e.day)
      .difference(DateTime.utc(now.year, now.month, now.day))
      .inDays;
  return days > 0 ? days : 0;
}
