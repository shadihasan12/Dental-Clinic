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

  /// `PLAN`, `ADDON` (seats), `STORAGE`, `PRORATION_CREDIT` (money coming
  /// off - negative), `ADJUSTMENT` or `REFUND`. Style a line by the sign of
  /// [amountUsd], not by its kind.
  final String kind;

  /// Written by the server in the language asked for, with the dates it
  /// covers. Displayed, never parsed.
  final String description;
  final int quantity;
  final double unitPriceUsd;
  final double amountUsd;
  final DateTime? periodStart;
  final DateTime? periodEnd;

  /// Money coming off: a credit for unused days or a replaced next cycle.
  bool get isCredit => amountUsd < 0;
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
