import 'dart:io';

import 'package:dental_clinic_app/features/billing/data/data_sources/billing_local_data_source.dart';
import 'package:dental_clinic_app/features/billing/data/models/invoice_model.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/invoice_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/payment_instructions_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/payment_providers/payment_provider.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_plan_entity.dart';
import 'package:injectable/injectable.dart';

/// Off-app payment flow: dentist pays via cash / Syriatel Cash / Sham Cash /
/// bank transfer, then uploads a receipt screenshot. Admin verifies the
/// receipt out-of-band and flips the invoice to Paid.
///
/// The channel details (account numbers / wallet IDs) are mocked here.
/// In production they should come from a remote config / admin-managed
/// settings endpoint so they can be rotated without an app update.
@LazySingleton(as: PaymentProvider)
class ManualPaymentProvider implements PaymentProvider {
  ManualPaymentProvider(this._data);

  final BillingLocalDataSource _data;

  static const _channels = <ManualPaymentChannel>[
    ManualPaymentChannel(
      method: ManualPaymentMethod.cash,
      account: '—',
      note: 'Pay in person at the clinic admin office.',
    ),
    ManualPaymentChannel(
      method: ManualPaymentMethod.syriatelCash,
      account: '0987 654 321',
      holderName: 'Dental Clinic App',
    ),
    ManualPaymentChannel(
      method: ManualPaymentMethod.shamCash,
      account: 'SHAM-1234-5678',
      holderName: 'Dental Clinic App',
    ),
    ManualPaymentChannel(
      method: ManualPaymentMethod.bankTransfer,
      account: 'SY00 1234 5678 9012 3456',
      holderName: 'Dental Clinic App LLC',
      note: 'Use the invoice number as the transfer reference.',
    ),
  ];

  @override
  PaymentProviderKind get kind => PaymentProviderKind.manual;

  @override
  Future<InvoiceEntity> createInvoice({
    required String clinicId,
    required SubscriptionPlanEntity plan,
    required BillingCycle cycle,
    required bool isRenewal,
  }) async {
    final ds = _data as InMemoryBillingDataSource;
    final now = DateTime.now();
    final number = ds.generateInvoiceNumber(now);
    final periodDays = cycle == BillingCycle.yearly ? 365 : 30;

    final model = InvoiceModel(
      id: 'inv_${now.millisecondsSinceEpoch}',
      number: number,
      clinicId: clinicId,
      kind: InvoiceKind.subscription,
      status: InvoiceStatus.pending,
      provider: PaymentProviderKind.manual,
      amount: plan.getPrice(cycle),
      currency: 'USD',
      issuedAt: now,
      dueAt: now.add(const Duration(days: 7)),
      planTier: plan.tier,
      billingCycle: cycle,
      isRenewal: isRenewal,
      activatesUntil: now.add(Duration(days: periodDays)),
    );

    final saved = await _data.saveInvoice(model);
    return saved.toEntity();
  }

  @override
  PaymentInstructions instructionsFor(InvoiceEntity invoice) {
    return PaymentInstructions(
      providerKind: kind,
      referenceNumber: invoice.number,
      amount: invoice.amount,
      currency: invoice.currency,
      channels: _channels,
    );
  }

  @override
  Future<InvoiceEntity> submitProof({
    required String invoiceId,
    required File receipt,
    required String referenceNumber,
    required ManualPaymentMethod method,
    String? notes,
  }) async {
    final current = await _data.getInvoice(invoiceId);
    if (current.status != InvoiceStatus.pending) {
      throw StateError(
        'Cannot submit proof for an invoice in status ${current.status.name}',
      );
    }
    final updated = current.copyWith(
      status: InvoiceStatus.underReview,
      proof: PaymentProofModel(
        receiptPath: receipt.path,
        referenceNumber: referenceNumber,
        methodUsed: method,
        submittedAt: DateTime.now(),
        notes: notes,
      ),
    );
    final saved = await _data.saveInvoice(updated);
    return saved.toEntity();
  }
}
