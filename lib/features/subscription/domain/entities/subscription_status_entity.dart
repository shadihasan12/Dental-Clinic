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

  /// Null during a trial: a trial that runs out gets no grace period.
  final DateTime? graceEndsAt;

  /// MONTHLY, YEARLY, or null during a trial - a trial was not bought.
  final String? billingPeriod;

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
  });

  String get _upper => status.toUpperCase();

  bool get isTrial => _upper == 'TRIALING';
  bool get isActive => _upper == 'ACTIVE';
  bool get isGrace => _upper == 'GRACE' || isInGracePeriod;
  bool get isPendingActivation => _upper == 'PENDING_ACTIVATION';
  bool get isCanceled => _upper == 'CANCELED';

  /// Nothing is running, so the app may ask to be billed for a plan. While
  /// ACTIVE or GRACE the quote says `can_request: false` and the request is a
  /// 409 - renewing from the app is not built yet.
  bool get canSubscribe => !isActive && !isGrace;

  /// Days remaining until [endsAt]. Prefers the server-provided value.
  int get daysRemaining {
    if (remainingDays != null) return remainingDays!;
    if (endsAt == null) return 0;
    return calendarDaysUntil(endsAt!);
  }
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
