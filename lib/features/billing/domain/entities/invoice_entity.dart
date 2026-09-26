import 'package:dental_clinic_app/features/auth/domain/entities/plan_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/billing_line_entity.dart';

enum InvoiceStatus {
  /// Owed.
  open,
  paid,

  /// Cancelled - by a Dentech admin, or on its own when the cycle it was
  /// priced for ended first. Nothing is owed on it: shown struck through,
  /// never with "how to pay".
  voided,

  /// The app does not normally see these two.
  draft,
  uncollectible,
  unknown;

  static InvoiceStatus fromApi(String? value) {
    switch (value?.toUpperCase()) {
      case 'OPEN':
        return InvoiceStatus.open;
      case 'PAID':
        return InvoiceStatus.paid;
      case 'VOID':
        return InvoiceStatus.voided;
      case 'DRAFT':
        return InvoiceStatus.draft;
      case 'UNCOLLECTIBLE':
        return InvoiceStatus.uncollectible;
      default:
        return InvoiceStatus.unknown;
    }
  }
}

/// What the clinic was billed, from `GET /invoices`.
///
/// The one shape with a trap: [amounts] is [remainingUsd] converted at
/// today's rate - the figure to transfer - not [amountUsd]. That is why it is
/// zero on a paid invoice. To show what an invoice was worth, use
/// [amountUsd].
class InvoiceEntity {
  const InvoiceEntity({
    required this.id,
    required this.number,
    this.kind = 'charge',
    required this.purpose,
    required this.status,
    required this.isCreditNote,
    required this.amountUsd,
    required this.amountPaidUsd,
    required this.remainingUsd,
    required this.amounts,
    required this.items,
    this.dueAt,
    this.paidAt,
    this.voidedAt,
    this.createdAt,
  });

  final String id;
  final String number;

  /// `charge` - the clinic was asked to pay it - or `refund`, the record of a
  /// balance sent back to the clinic: born PAID, negative [amountUsd].
  final String kind;

  /// `SUBSCRIPTION_NEW`, `SUBSCRIPTION_RENEW`, `SUBSCRIPTION_UPGRADE`,
  /// `ADDON_ADD` and the like. Older invoices can carry values that are no
  /// longer produced, so nothing branches on it.
  final String purpose;
  final InvoiceStatus status;

  /// Always false in what the app receives: credit notes stay in the
  /// dashboard. Kept only because the field is still sent.
  final bool isCreditNote;
  final double amountUsd;
  final double amountPaidUsd;
  final double remainingUsd;

  /// [remainingUsd] in every currency the app offers. Re-read the invoice
  /// before showing it as an amount to transfer - the rate moves.
  final List<PriceEntity> amounts;
  final List<BillingLineEntity> items;

  /// Seven days after the invoice opens. Past it the invoice is overdue and a
  /// reminder goes out; it does not void itself - except one priced for the
  /// running cycle (an upgrade, add-on units, a renewal replacing a next
  /// cycle), which is cancelled if still unpaid when that cycle ends.
  final DateTime? dueAt;
  final DateTime? paidAt;
  final DateTime? voidedAt;
  final DateTime? createdAt;

  bool get isOpen => status == InvoiceStatus.open;

  /// Money sent *to* the clinic - never something to pay.
  bool get isRefund => kind.toLowerCase() == 'refund';

  bool get isOverdue =>
      isOpen && dueAt != null && dueAt!.isBefore(DateTime.now());

  /// The amount to transfer in [currency], if the server priced it there.
  PriceEntity? amountIn(String currency) {
    for (final a in amounts) {
      if (a.currency == currency) return a;
    }
    return null;
  }
}
