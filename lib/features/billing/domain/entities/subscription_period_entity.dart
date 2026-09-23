import 'package:dental_clinic_app/features/billing/domain/entities/billing_line_entity.dart';

/// One cycle the clinic has been served, from `GET /subscriptions/periods`:
/// which plan, for how long, for how much. The history screen.
///
/// A trial is a row of its own with [priceUsd] 0 and no [billingPeriod]; it
/// is COMPLETED the moment a paid cycle starts. A CANCELED cycle's [endsAt]
/// is the day it really stopped.
class SubscriptionPeriodEntity {
  const SubscriptionPeriodEntity({
    required this.id,
    required this.status,
    required this.planName,
    required this.durationQuantity,
    required this.priceUsd,
    this.billingPeriod,
    this.startsAt,
    this.endsAt,
    this.canceledAt,
  });

  final String id;

  /// `ACTIVE`, `COMPLETED`, `CANCELED`.
  final String status;
  final String planName;
  final BillingPeriod? billingPeriod;
  final int durationQuantity;
  final DateTime? startsAt;
  final DateTime? endsAt;
  final double priceUsd;
  final DateTime? canceledAt;

  bool get isTrial => billingPeriod == null && priceUsd == 0;
}
