import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/plan_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/addon_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/billing_line_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/clinic_payment_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/invoice_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/payment_method_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/payment_receipt_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/plan_features_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/quote_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/subscription_period_entity.dart';

/// Add-on units to buy with a cycle.
class AddonSelection {
  const AddonSelection({required this.planVersionId, required this.quantity});

  final String planVersionId;

  /// 0 drops the add-on at the renewal.
  final int quantity;
}

/// The same fields go to the quote and to the request, so the invoice raised
/// is exactly the one that was priced.
class QuoteParams {
  const QuoteParams({
    required this.planVersionId,
    required this.billingPeriod,
    this.durationQuantity = 1,
    this.addons,
  });

  /// The plan's `version_id`, not its `id` - prices live on the version.
  final String planVersionId;
  final BillingPeriod billingPeriod;

  /// How many periods at once, 1-36.
  final int durationQuantity;

  /// Null leaves `addons` out: a renewal carries on every unit the clinic
  /// holds, a new subscription buys none. Sent, it is the whole list for the
  /// new cycle - every add-on, 0 included.
  final List<AddonSelection>? addons;

  static const int maxDuration = 36;

  Map<String, dynamic> _base() => {
        'plan_version_id': planVersionId,
        'billing_period': billingPeriod.apiValue,
        'duration_quantity': durationQuantity,
      };

  /// The query string can't carry a list, so each unit is spelled out:
  /// `addons[0][plan_version_id]=...&addons[0][quantity]=1`.
  Map<String, dynamic> toQuery() => {
        ..._base(),
        if (addons != null)
          for (var i = 0; i < addons!.length; i++) ...{
            'addons[$i][plan_version_id]': addons![i].planVersionId,
            'addons[$i][quantity]': addons![i].quantity,
          },
      };

  Map<String, dynamic> toBody() => {
        ..._base(),
        if (addons != null)
          'addons': [
            for (final a in addons!)
              {'plan_version_id': a.planVersionId, 'quantity': a.quantity},
          ],
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

/// What asking to be billed came to - for a cycle, an upgrade or add-ons:
///
/// - an OPEN [invoice]: the pay flow;
/// - a PAID one: the clinic's balance covered it, and it has already taken
///   effect (or, for a renewal bought ahead, the next cycle is booked);
/// - no invoice at all: the credits outweighed the charge, and the
///   difference went to the balance.
///
/// Either way [message] says which, in the server's words.
class BillingRequestResult {
  const BillingRequestResult({this.invoice, required this.message});

  final InvoiceEntity? invoice;
  final String message;

  bool get needsPayment => invoice != null && invoice!.isOpen;
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

  /// Raises an invoice for a whole cycle - new, or a renewal. The
  /// subscription itself does not change until the invoice is settled.
  Future<Either<NetworkExceptions, BillingRequestResult>> requestSubscription(
    QuoteParams params,
  );

  /// Moving up to a bigger plan now. Only while ACTIVE.
  Future<Either<NetworkExceptions, QuoteEntity>> getUpgradeQuote(
    String planVersionId,
  );

  Future<Either<NetworkExceptions, BillingRequestResult>> requestUpgrade(
    String planVersionId,
  );

  /// The add-ons on sale, and the units the clinic holds. Can be empty.
  Future<Either<NetworkExceptions, List<AddonEntity>>> getAddons();

  /// [quantity] units more, for the rest of the cycle. Only while ACTIVE.
  Future<Either<NetworkExceptions, QuoteEntity>> getAddonQuote(
    String planVersionId,
    int quantity,
  );

  Future<Either<NetworkExceptions, BillingRequestResult>> requestAddons(
    String planVersionId,
    int quantity,
  );

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
}
