/// One way to send money, from `GET /billing/payment-methods`, with the
/// destinations an admin entered for it in the dashboard.
///
/// `CASH` never appears: cash is handed over in person and entered by
/// whoever took it. The list is rendered as it comes - the app does not
/// hardcode which methods exist.
class PaymentMethodEntity {
  const PaymentMethodEntity({
    required this.method,
    required this.name,
    required this.requiresReference,
    required this.accounts,
  });

  /// The value sent back on a payment: `BANK_TRANSFER`, `SHAM_CASH`,
  /// `MTN_CASH`, `SYRIATEL_CASH`.
  final String method;

  /// Already in the user's language.
  final String name;
  final bool requiresReference;
  final List<PaymentAccountEntity> accounts;

  bool get isBankTransfer => method == 'BANK_TRANSFER';
}

class PaymentAccountEntity {
  const PaymentAccountEntity({
    required this.id,
    required this.accountName,
    required this.accountNumber,
    required this.currency,
    required this.currencyName,
    this.instructions,
  });

  /// Sent as `payment_account_id` - it makes verification quicker.
  final String id;
  final String accountName;

  /// Offered as copy-to-clipboard: a mistyped wallet number is the most
  /// common way this flow fails.
  final String accountNumber;

  /// The currency to send, and to report the transfer in.
  final String currency;
  final String currencyName;

  /// Already translated; rendered under the account as it is.
  final String? instructions;
}
