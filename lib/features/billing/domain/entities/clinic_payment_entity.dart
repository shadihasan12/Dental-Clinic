enum ClinicPaymentStatus {
  /// Waiting for a Dentech admin to check it.
  pending,

  /// Confirmed; the money is in the wallet.
  verified,

  /// Not accepted; the reason is appended to the notes.
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

/// A transfer the clinic reported, from `/clinic-payments`.
///
/// Reporting it moves nothing. The money reaches the wallet only once an
/// admin verifies it, and then the server settles open invoices from the
/// wallet, oldest first - the app never links a payment to an invoice.
class ClinicPaymentEntity {
  const ClinicPaymentEntity({
    required this.id,
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
  });

  final String id;
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

  /// The clinic's note, with any rejection or cancellation reason the
  /// backend appended after ` | `.
  final String? notes;

  /// Signed, expiring links. Re-read the payment for fresh ones rather than
  /// holding on to these.
  final List<PaymentAttachmentEntity> attachments;

  bool get isPending => status == ClinicPaymentStatus.pending;

  static const _rejectionMarker = 'Rejection Reason:';
  static const _cancellationMarker = 'Cancellation Reason:';

  /// The admin's reason, split off the notes. The marker is written by the
  /// backend in English whatever the language.
  String? get rejectionReason => _after(_rejectionMarker);

  String? get cancellationReason => _after(_cancellationMarker);

  /// The note the clinic wrote itself, without the appended reasons.
  String? get clinicNote {
    final text = notes;
    if (text == null) return null;
    var cut = text.length;
    for (final marker in [_rejectionMarker, _cancellationMarker]) {
      final i = text.indexOf(marker);
      if (i >= 0 && i < cut) cut = i;
    }
    final note = text.substring(0, cut).trim();
    final cleaned =
        note.endsWith('|') ? note.substring(0, note.length - 1).trim() : note;
    return cleaned.isEmpty ? null : cleaned;
  }

  String? _after(String marker) {
    final text = notes;
    if (text == null) return null;
    final i = text.lastIndexOf(marker);
    if (i < 0) return null;
    var reason = text.substring(i + marker.length);
    // Another reason appended after this one belongs to it, not to us.
    final pipe = reason.indexOf(' | ');
    if (pipe >= 0) reason = reason.substring(0, pipe);
    reason = reason.trim();
    return reason.isEmpty ? null : reason;
  }
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
