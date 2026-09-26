import 'package:dental_clinic_app/features/billing/domain/entities/billing_line_entity.dart';

/// Why a stretch of the subscription stopped.
enum PeriodEndReason {
  /// Still running.
  running,

  /// Ran its full term - including the cycle before a renewal.
  completed,

  /// The trial, ended early because the clinic subscribed.
  trialConverted,

  /// The trial, ran its full length.
  trialEnded,

  /// Replaced mid-way by a bigger plan (an upgrade).
  planChanged,

  /// Really cancelled.
  cancelled,
  unknown;

  static PeriodEndReason fromApi(String? value) {
    switch (value) {
      case null:
        return PeriodEndReason.running;
      case 'completed':
        return PeriodEndReason.completed;
      case 'trial_converted':
        return PeriodEndReason.trialConverted;
      case 'trial_ended':
        return PeriodEndReason.trialEnded;
      case 'plan_changed':
        return PeriodEndReason.planChanged;
      case 'cancelled':
        return PeriodEndReason.cancelled;
      default:
        return PeriodEndReason.unknown;
    }
  }
}

/// One stretch the clinic has been served, from `GET /subscriptions/periods`:
/// which plan, for how long, for how much. The history screen.
///
/// Labelled from [isTrial] and [endReason] - never from [status] or
/// [canceledAt], which stay for the books and call every stretch cut short
/// "cancelled", an upgrade included.
class SubscriptionPeriodEntity {
  const SubscriptionPeriodEntity({
    required this.id,
    required this.status,
    required this.planName,
    required this.durationQuantity,
    required this.priceUsd,
    this.kind = 'paid',
    this.endReason = PeriodEndReason.unknown,
    this.creditUsd,
    this.billingPeriod,
    this.startsAt,
    this.endsAt,
    this.canceledAt,
  });

  final String id;

  /// `trial` or `paid`.
  final String kind;
  final PeriodEndReason endReason;

  /// For the books only: `ACTIVE`, `COMPLETED`, `CANCELED`.
  final String status;
  final String planName;
  final BillingPeriod? billingPeriod;
  final int durationQuantity;
  final DateTime? startsAt;

  /// For a stretch cut short, the day it really stopped.
  final DateTime? endsAt;

  /// What the stretch was agreed at.
  final double priceUsd;

  /// What came back for the days not used; 0 otherwise. Null only on a
  /// stretch cancelled before the server kept the link to the money.
  final double? creditUsd;
  final DateTime? canceledAt;

  bool get isTrial => kind == 'trial';
}
