/// A transfer slip uploaded through `POST /clinic-payments/receipts`.
///
/// Its [id] is what goes into the payment's `media_item_ids`.
class PaymentReceiptEntity {
  const PaymentReceiptEntity({
    required this.id,
    required this.filename,
    required this.mimeType,
    this.url,
  });

  final String id;
  final String filename;
  final String mimeType;
  final String? url;

  bool get isImage => mimeType.startsWith('image/');
}
