import 'package:dental_clinic_app/features/auth/domain/entities/plan_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/billing_line_entity.dart';

/// What a purchase would cost, from one of the three quote calls - a whole
/// cycle (`/subscriptions/quote`), an upgrade now, or add-on units now. All
/// three answer this shape. Nothing is written by asking.
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
    this.blockers = const [],
    this.periodStart,
    this.periodEnd,
    this.startsLater = false,
    this.paymentPurpose,
    this.addons = const [],
  });

  /// `new`, `renewal`, `upgrade` or `addon`.
  final String kind;

  /// The only thing that decides whether the confirm button is enabled.
  final bool canRequest;

  /// Why [canRequest] is false, translated and ready to show.
  final String? reason;

  /// When the reason is that the clinic does not fit: each ceiling it is
  /// already above. Empty in the normal case.
  final List<QuoteBlockerEntity> blockers;

  /// The plan - or, for an add-on quote, the add-on.
  final String planName;
  final String planVersionId;
  final BillingPeriod? billingPeriod;
  final int durationQuantity;

  /// For a cycle that starts when paid, when it would run *if it were paid
  /// now*. For a renewal bought while the cycle runs, fixed: it follows the
  /// current cycle.
  final DateTime? periodStart;
  final DateTime? periodEnd;

  /// A renewal bought while the cycle runs: paid now, it begins at
  /// [periodStart], when the current cycle ends.
  final bool startsLater;
  final String? paymentPurpose;

  /// The credits outweigh the charge: nothing is paid, and [amountUsd] is
  /// what goes *to* the clinic's balance.
  final bool isCredit;
  final double amountUsd;

  /// The figure to transfer, at today's rate. Never cached: the invoice is
  /// converted again every time it is read.
  final List<PriceEntity> amounts;
  final List<BillingLineEntity> lines;

  /// The add-on units the cycle is bought with, as priced.
  final List<QuoteAddonEntity> addons;

  bool get isRenewal => kind == 'renewal';
}

/// One ceiling the clinic is already over for the plan being quoted.
class QuoteBlockerEntity {
  const QuoteBlockerEntity({
    required this.limit,
    required this.allowed,
    required this.current,
    required this.excess,
    required this.message,
  });

  /// `max-users` or `max-storage-mb`.
  final String limit;
  final int allowed;
  final int current;

  /// How far over: members to remove, or MB to free.
  final int excess;

  /// Translated, ready to show.
  final String message;

  bool get isSeats => limit == 'max-users';
}

/// Add-on units priced into a quote, or held by a next cycle.
class QuoteAddonEntity {
  const QuoteAddonEntity({
    required this.versionId,
    required this.name,
    required this.quantity,
    required this.amountUsd,
    this.planId,
    this.unitPriceUsd,
  });

  final String? planId;
  final String versionId;
  final String name;
  final int quantity;
  final double? unitPriceUsd;
  final double amountUsd;
}
