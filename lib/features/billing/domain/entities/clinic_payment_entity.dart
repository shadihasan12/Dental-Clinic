enum ClinicPaymentStatus {
  /// Waiting for a Dentech admin to check it.
  pending,

  /// Confirmed; the money is in the wallet.
  verified,

  /// Not accepted; the reason is in [ClinicPaymentEntity.rejectionReason].
  rejected,

  /// Withdrawn by the clinic itself. Two Ls, as the API spells it.
  cancelled,
  unknown;

  static ClinicPaymentStatus fromApi(String? value) {
    switch (value?.toUpperCase()) {
      case 'PENDING':
        return ClinicPaymentStatus.pending;
      case 'VERIFIED':
        return ClinicPaymentStatus.verified;
      case 'REJECTED':
        return ClinicPaymentStatus.rejected;
      case 'CANCELLED':
      case 'CANCELED':
        return ClinicPaymentStatus.cancelled;
      default:
        return ClinicPaymentStatus.unknown;
    }
  }
}

/// Real money between the clinic and us, from `/clinic-payments`: a transfer
/// the clinic reported (or cash an admin recorded), or - [isRefund] - a
/// balance we sent back to it.
///
/// Reporting a transfer moves nothing. The money reaches the wallet only once
/// an admin verifies it, and then the server settles open invoices from the
/// wallet, oldest first - the app never links a payment to an invoice.
class ClinicPaymentEntity {
  const ClinicPaymentEntity({
    required this.id,
    this.kind = 'payment',
    required this.method,
    required this.referenceNumber,
    required this.amountOriginal,
    required this.currencyOriginal,
    required this.amountUsd,
    required this.status,
    required this.attachments,
    this.paymentAccountId,
    this.bankName,
    this.exchangeRate,
    this.paidAt,
    this.notes,
    this.rejectionReason,
    this.cancellationReason,
  });

  final String id;

  /// `payment` - the clinic sent it to us - or `refund`, a balance sent back
  /// to the clinic, listed once it really went out and always VERIFIED.
  final String kind;
  final String method;
  final String referenceNumber;

  /// What they typed - the figure to show them.
  final double amountOriginal;
  final String currencyOriginal;

  /// The server's own reading of [amountOriginal], at its rate.
  final double amountUsd;
  final double? exchangeRate;
  final ClinicPaymentStatus status;
  final String? paymentAccountId;
  final String? bankName;
  final DateTime? paidAt;

  /// Only what the clinic wrote. Can be null.
  final String? notes;

  /// Set on REJECTED: the admin's reason, in its own field.
  final String? rejectionReason;

  /// Set on CANCELLED: why the clinic withdrew it.
  final String? cancellationReason;

  /// Signed, expiring links. Re-read the payment for fresh ones rather than
  /// holding on to these.
  final List<PaymentAttachmentEntity> attachments;

  bool get isPending => status == ClinicPaymentStatus.pending;

  /// Money received by the clinic, not paid by it.
  bool get isRefund => kind.toLowerCase() == 'refund';
}

class PaymentAttachmentEntity {
  const PaymentAttachmentEntity({
    required this.id,
    required this.viewUrl,
    this.downloadUrl,
  });

  final String id;
  final String viewUrl;
  final String? downloadUrl;
}
