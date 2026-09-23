/// One line of an invoice or a quote: `"Pro Plan (Monthly) × 3"` and what
/// it costs. The quote's lines are exactly what the invoice will say, so the
/// confirmation sheet and the invoice agree.
class BillingLineEntity {
  const BillingLineEntity({
    required this.kind,
    required this.description,
    required this.quantity,
    required this.unitPriceUsd,
    required this.amountUsd,
    this.periodStart,
    this.periodEnd,
  });

  /// `PLAN` today.
  final String kind;

  /// Generated server-side, in English for now.
  final String description;
  final int quantity;
  final double unitPriceUsd;
  final double amountUsd;
  final DateTime? periodStart;
  final DateTime? periodEnd;
}

/// `MONTHLY` or `YEARLY` - what a plan is priced and bought by.
enum BillingPeriod {
  monthly('MONTHLY'),
  yearly('YEARLY');

  const BillingPeriod(this.apiValue);

  final String apiValue;

  static BillingPeriod? fromApi(String? value) {
    for (final p in BillingPeriod.values) {
      if (p.apiValue == value?.toUpperCase()) return p;
    }
    return null;
  }
}
