import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/plan_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/billing_line_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/clinic_payment_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/invoice_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/payment_method_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/payment_receipt_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/plan_features_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/quote_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/subscription_period_entity.dart';

/// The same three fields go to the quote and to the request, so the invoice
/// raised is exactly the one that was priced.
class QuoteParams {
  const QuoteParams({
    required this.planVersionId,
    required this.billingPeriod,
    this.durationQuantity = 1,
  });

  /// The plan's `version_id`, not its `id` - prices live on the version.
  final String planVersionId;
  final BillingPeriod billingPeriod;

  /// How many periods at once, 1-36.
  final int durationQuantity;

  static const int maxDuration = 36;

  Map<String, dynamic> toJson() => {
        'plan_version_id': planVersionId,
        'billing_period': billingPeriod.apiValue,
        'duration_quantity': durationQuantity,
      };
}

/// A transfer the clinic made outside the app, being reported.
///
/// There is deliberately no exchange rate, USD amount, invoice id or purpose
/// here: the server decides all four, and rejects them if sent.
class ReportPaymentParams {
  const ReportPaymentParams({
    required this.method,
    required this.amountOriginal,
    required this.currencyOriginal,
    required this.referenceNumber,
    this.paymentAccountId,
    this.bankName,
    this.paidAt,
    this.notes,
    this.mediaItemIds = const [],
  });

  /// From the payment-methods list. Never `CASH`.
  final String method;

  /// What they actually sent, as typed.
  final String amountOriginal;
  final String currencyOriginal;
  final String referenceNumber;
  final String? paymentAccountId;
  final String? bankName;
  final DateTime? paidAt;
  final String? notes;

  /// Up to [maxReceipts] ids from `POST /clinic-payments/receipts`.
  final List<String> mediaItemIds;

  static const int maxReceipts = 5;

  Map<String, dynamic> toJson() => {
        'method': method,
        'amount_original': amountOriginal,
        'currency_original': currencyOriginal,
        'reference_number': referenceNumber,
        if (paymentAccountId != null) 'payment_account_id': paymentAccountId,
        if (bankName != null && bankName!.isNotEmpty) 'bank_name': bankName,
        if (paidAt != null) 'paid_at': paidAt!.toUtc().toIso8601String(),
        if (notes != null && notes!.isNotEmpty) 'notes': notes,
        if (mediaItemIds.isNotEmpty) 'media_item_ids': mediaItemIds,
      };
}

/// A write that came back with the server's own sentence, which the billing
/// screens show verbatim rather than composing their own text.
class WithMessage<T> {
  const WithMessage(this.value, this.message);

  final T value;
  final String message;
}

abstract class BillingRepository {
  Future<Either<NetworkExceptions, List<PlanEntity>>> getPlans();

  Future<Either<NetworkExceptions, PlanFeaturesEntity>> getPlanFeatures(
    String planId,
  );

  Future<Either<NetworkExceptions, QuoteEntity>> getQuote(QuoteParams params);

  /// Raises an OPEN invoice. The subscription itself does not change until
  /// the invoice is settled.
  Future<Either<NetworkExceptions, WithMessage<InvoiceEntity>>>
      requestSubscription(QuoteParams params);

  Future<Either<NetworkExceptions, List<SubscriptionPeriodEntity>>>
      getPeriods();

  Future<Either<NetworkExceptions, List<InvoiceEntity>>> getInvoices();

  Future<Either<NetworkExceptions, InvoiceEntity>> getInvoice(String id);

  Future<Either<NetworkExceptions, List<PaymentMethodEntity>>>
      getPaymentMethods();

  Future<Either<NetworkExceptions, PaymentReceiptEntity>> uploadReceipt(
    File file,
  );

  /// Records a PENDING payment. Nothing moves until an admin verifies it.
  Future<Either<NetworkExceptions, WithMessage<ClinicPaymentEntity>>>
      reportPayment(ReportPaymentParams params);

  Future<Either<NetworkExceptions, List<ClinicPaymentEntity>>> getPayments();

  Future<Either<NetworkExceptions, ClinicPaymentEntity>> getPayment(String id);

  /// Withdraws a report that is still PENDING.
  Future<Either<NetworkExceptions, ClinicPaymentEntity>> cancelPayment(
    String id, {
    String? reason,
  });

  /// The clinic's wallet, preformatted (`"$0.00"`).
  Future<Either<NetworkExceptions, String?>> getWalletBalance();
}
