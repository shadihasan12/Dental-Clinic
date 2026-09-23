import 'package:dental_clinic_app/features/auth/domain/entities/plan_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/billing_line_entity.dart';

/// What buying a plan would cost, from `GET /subscriptions/quote`. Nothing
/// is written by asking.
class QuoteEntity {
  const QuoteEntity({
    required this.kind,
    required this.canRequest,
    required this.planName,
    required this.planVersionId,
    required this.billingPeriod,
    required this.durationQuantity,
    required this.isCredit,
    required this.amountUsd,
    required this.amounts,
    required this.lines,
    this.reason,
    this.periodStart,
    this.periodEnd,
    this.paymentPurpose,
  });

  /// `new` today.
  final String kind;

  /// The only thing that decides whether the confirm button is enabled.
  /// True whenever nothing is running (trial, pending, expired, cancelled).
  final bool canRequest;

  /// Why [canRequest] is false, translated and ready to show.
  final String? reason;
  final String planName;
  final String planVersionId;
  final BillingPeriod? billingPeriod;
  final int durationQuantity;

  /// When the cycle would run *if it were paid now* - not a promise.
  final DateTime? periodStart;
  final DateTime? periodEnd;
  final String? paymentPurpose;
  final bool isCredit;
  final double amountUsd;

  /// The figure to transfer, at today's rate. Never cached: the invoice is
  /// converted again every time it is read.
  final List<PriceEntity> amounts;
  final List<BillingLineEntity> lines;
}
