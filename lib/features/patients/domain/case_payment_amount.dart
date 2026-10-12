/// What a case payment is worth in the case's own currency, worked out the
/// way the server checks it.
///
/// A payment carries the amount paid, a rate, and the same money in the
/// case's currency. The server refuses one whose two amounts do not agree
/// with the rate - either way round, within a cent or 1% - so the second
/// amount is never typed: it is computed here from the first and the rate.
class CasePaymentAmount {
  CasePaymentAmount._();

  /// The server's bounds on either amount.
  static const double minAmount = 0.01;
  static const double maxAmount = 99999999.99;

  /// The server's bounds on the rate, which it keeps to six decimals.
  static const double minRate = 0.000001;
  static const double maxRate = 999999999.999999;

  /// [amount] in the case's currency, to the cent.
  ///
  /// The rate can be entered either way round. [rateIsPerPaymentUnit] says
  /// which: true for "1 of the payment's currency = [rate] of the case's"
  /// (multiply), false for "1 of the case's currency = [rate] of the
  /// payment's" (divide). In the case's own currency pass a rate of 1.
  static double inCaseCurrency({
    required double amount,
    required double rate,
    required bool rateIsPerPaymentUnit,
  }) {
    final converted = rateIsPerPaymentUnit ? amount * rate : amount / rate;
    return (converted * 100).roundToDouble() / 100;
  }

  static bool isAmountInRange(double amount) =>
      amount >= minAmount && amount <= maxAmount;

  static bool isRateInRange(double rate) => rate >= minRate && rate <= maxRate;
}
