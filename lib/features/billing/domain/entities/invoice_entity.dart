import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_plan_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'invoice_entity.freezed.dart';

/// Lifecycle of an invoice.
///
/// pending      → just generated, awaiting the dentist to pay & submit proof
/// underReview  → proof submitted, waiting on admin verification
/// paid         → admin approved; subscription is activated/extended
/// rejected     → admin rejected the proof; the invoice is dead
/// cancelled    → dentist abandoned the invoice before paying
enum InvoiceStatus {
  pending,
  underReview,
  paid,
  rejected,
  cancelled,
}

/// What this invoice was raised for. Today only `subscription` exists, but
/// the field is here so future per-feature charges (SMS top-up, branded
/// reports, etc.) don't need a schema change.
enum InvoiceKind {
  subscription,
}

/// Identifier of the payment provider that *generated* the invoice.
///
/// All invoices flow through one provider end-to-end — a `manual` invoice
/// can't be marked Paid by Stripe and vice-versa. New providers (Stripe,
/// SyriatelMoney API, etc.) become new enum values.
enum PaymentProviderKind {
  manual,
  // stripe — placeholder for future
}

@freezed
class InvoiceEntity with _$InvoiceEntity {
  const factory InvoiceEntity({
    required String id,
    required String number,
    required String clinicId,
    required InvoiceKind kind,
    required InvoiceStatus status,
    required PaymentProviderKind provider,
    required double amount,
    required String currency,
    required DateTime issuedAt,
    required DateTime dueAt,

    // Subscription-specific (nullable so the entity can be reused for other
    // kinds later).
    PlanTier? planTier,
    BillingCycle? billingCycle,

    PaymentProofEntity? proof,
    RejectionInfo? rejection,
    DateTime? paidAt,

    /// When the linked subscription period would end if this invoice were
    /// approved right now. Used for the renewal countdown on details.
    DateTime? activatesUntil,

    @Default(false) bool isRenewal,
    String? notes,
  }) = _InvoiceEntity;

  const InvoiceEntity._();

  bool get isOpen =>
      status == InvoiceStatus.pending || status == InvoiceStatus.underReview;
  bool get isPaid => status == InvoiceStatus.paid;
  bool get awaitsProof => status == InvoiceStatus.pending;
  bool get awaitsAdmin => status == InvoiceStatus.underReview;
}

/// Proof a dentist uploads after paying outside the app.
@freezed
class PaymentProofEntity with _$PaymentProofEntity {
  const factory PaymentProofEntity({
    /// Local file path or remote URL of the receipt screenshot.
    required String receiptPath,
    required String referenceNumber,
    required ManualPaymentMethod methodUsed,
    required DateTime submittedAt,
    String? notes,
  }) = _PaymentProofEntity;

  const PaymentProofEntity._();
}

/// Reasons an invoice can be rejected. Optional — admin may approve/reject
/// without filling these in.
@freezed
class RejectionInfo with _$RejectionInfo {
  const factory RejectionInfo({
    required DateTime rejectedAt,
    String? reason,
  }) = _RejectionInfo;

  const RejectionInfo._();
}

/// The off-app payment rails available for the manual provider.
///
/// Display strings live in the localization files; this enum is just the
/// machine identifier.
enum ManualPaymentMethod {
  cash,
  syriatelCash,
  shamCash,
  bankTransfer,
}
