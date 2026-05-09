import 'package:dental_clinic_app/features/billing/domain/entities/invoice_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_plan_entity.dart';

/// Plain data class for the (currently in-memory) data source. We keep this
/// separate from [InvoiceEntity] so swapping in a real REST/GraphQL backend
/// later doesn't ripple into the domain layer.
class InvoiceModel {
  InvoiceModel({
    required this.id,
    required this.number,
    required this.clinicId,
    required this.kind,
    required this.status,
    required this.provider,
    required this.amount,
    required this.currency,
    required this.issuedAt,
    required this.dueAt,
    this.planTier,
    this.billingCycle,
    this.proof,
    this.rejection,
    this.paidAt,
    this.activatesUntil,
    this.isRenewal = false,
    this.notes,
  });

  final String id;
  final String number;
  final String clinicId;
  final InvoiceKind kind;
  final InvoiceStatus status;
  final PaymentProviderKind provider;
  final double amount;
  final String currency;
  final DateTime issuedAt;
  final DateTime dueAt;

  final PlanTier? planTier;
  final BillingCycle? billingCycle;

  final PaymentProofModel? proof;
  final RejectionModel? rejection;
  final DateTime? paidAt;
  final DateTime? activatesUntil;

  final bool isRenewal;
  final String? notes;

  InvoiceModel copyWith({
    InvoiceStatus? status,
    PaymentProofModel? proof,
    RejectionModel? rejection,
    DateTime? paidAt,
    DateTime? activatesUntil,
  }) {
    return InvoiceModel(
      id: id,
      number: number,
      clinicId: clinicId,
      kind: kind,
      status: status ?? this.status,
      provider: provider,
      amount: amount,
      currency: currency,
      issuedAt: issuedAt,
      dueAt: dueAt,
      planTier: planTier,
      billingCycle: billingCycle,
      proof: proof ?? this.proof,
      rejection: rejection ?? this.rejection,
      paidAt: paidAt ?? this.paidAt,
      activatesUntil: activatesUntil ?? this.activatesUntil,
      isRenewal: isRenewal,
      notes: notes,
    );
  }

  InvoiceEntity toEntity() => InvoiceEntity(
        id: id,
        number: number,
        clinicId: clinicId,
        kind: kind,
        status: status,
        provider: provider,
        amount: amount,
        currency: currency,
        issuedAt: issuedAt,
        dueAt: dueAt,
        planTier: planTier,
        billingCycle: billingCycle,
        proof: proof?.toEntity(),
        rejection: rejection?.toEntity(),
        paidAt: paidAt,
        activatesUntil: activatesUntil,
        isRenewal: isRenewal,
        notes: notes,
      );
}

class PaymentProofModel {
  PaymentProofModel({
    required this.receiptPath,
    required this.referenceNumber,
    required this.methodUsed,
    required this.submittedAt,
    this.notes,
  });

  final String receiptPath;
  final String referenceNumber;
  final ManualPaymentMethod methodUsed;
  final DateTime submittedAt;
  final String? notes;

  PaymentProofEntity toEntity() => PaymentProofEntity(
        receiptPath: receiptPath,
        referenceNumber: referenceNumber,
        methodUsed: methodUsed,
        submittedAt: submittedAt,
        notes: notes,
      );
}

class RejectionModel {
  RejectionModel({required this.rejectedAt, this.reason});

  final DateTime rejectedAt;
  final String? reason;

  RejectionInfo toEntity() =>
      RejectionInfo(rejectedAt: rejectedAt, reason: reason);
}
