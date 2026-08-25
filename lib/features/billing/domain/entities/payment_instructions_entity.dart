import 'package:dental_clinic_app/features/billing/domain/entities/invoice_entity.dart';

/// What the dentist sees on the "How to pay" screen for a given provider.
/// For the manual provider this is rendered as a list of channels with the
/// account/phone number to send money to. Stripe etc. would render their
/// own payment widgets and ignore this.
class PaymentInstructions {
  const PaymentInstructions({
    required this.providerKind,
    required this.referenceNumber,
    required this.amount,
    required this.currency,
    required this.channels,
  });

  final PaymentProviderKind providerKind;
  final String referenceNumber;
  final double amount;
  final String currency;
  final List<ManualPaymentChannel> channels;
}

class ManualPaymentChannel {
  const ManualPaymentChannel({
    required this.method,
    required this.account,
    this.holderName,
    this.note,
  });

  final ManualPaymentMethod method;

  /// Phone number, IBAN, or wallet ID the dentist should send to.
  final String account;
  final String? holderName;
  final String? note;
}
