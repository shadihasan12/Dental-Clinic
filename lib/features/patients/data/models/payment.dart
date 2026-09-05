class Payment {
  final String id;
  final double amount;
  final String? notes;
  final String caseId;
  final DateTime createdAt;

  /// The currency the payment was actually taken in, which is not necessarily
  /// the case currency: a case priced in USD can be paid in SYP at a rate the
  /// user sets. Null when the API omits it, in which case the UI falls back
  /// to the case currency rather than inventing a symbol.
  final String? currencyCode;

  /// The same payment converted into the case currency, and the rate used.
  /// Both are what the client sent when recording it; kept so history can
  /// show the conversion rather than just the raw figure.
  final double? amountInCaseCurrency;
  final double? exchangeRate;

  const Payment({
    required this.id,
    required this.amount,
    this.notes,
    required this.caseId,
    required this.createdAt,
    this.currencyCode,
    this.amountInCaseCurrency,
    this.exchangeRate,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'] as String,
      amount: _toDouble(json['amount']) ?? 0,
      notes: json['notes'] as String?,
      caseId: json['case_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      currencyCode: _currencyCode(json),
      amountInCaseCurrency: _toDouble(json['amount_in_case_currency']),
      exchangeRate: _toDouble(json['exchange_rate']),
    );
  }

  /// Accepts the nested `currency` object the list endpoints use elsewhere,
  /// and a flat `currency_code` string, so the label survives either shape.
  static String? _currencyCode(Map<String, dynamic> json) {
    final nested = json['currency'];
    if (nested is Map<String, dynamic>) {
      final code = nested['currency_code'];
      if (code is String && code.isNotEmpty) return code;
    }
    final flat = json['currency_code'];
    if (flat is String && flat.isNotEmpty) return flat;
    return null;
  }

  /// The API has sent money as both numbers and strings.
  static double? _toDouble(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }
}
