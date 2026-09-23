import 'dart:io';

import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/features/auth/data/datasources/remote/main_plans_request.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/plan_entity.dart';
import 'package:dental_clinic_app/features/billing/data/endpoints/billing_endpoints.dart';
import 'package:dental_clinic_app/features/billing/data/models/billing_models.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/clinic_payment_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/invoice_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/payment_method_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/payment_receipt_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/plan_features_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/quote_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/subscription_period_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/repositories/billing_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class BillingRemoteDataSource {
  Future<List<PlanEntity>> getPlans();
  Future<PlanFeaturesEntity> getPlanFeatures(String planId);
  Future<QuoteEntity> getQuote(QuoteParams params);
  Future<WithMessage<InvoiceEntity>> requestSubscription(QuoteParams params);
  Future<List<SubscriptionPeriodEntity>> getPeriods();
  Future<List<InvoiceEntity>> getInvoices();
  Future<InvoiceEntity> getInvoice(String id);
  Future<List<PaymentMethodEntity>> getPaymentMethods();
  Future<PaymentReceiptEntity> uploadReceipt(File file);
  Future<WithMessage<ClinicPaymentEntity>> reportPayment(ReportPaymentParams p);
  Future<List<ClinicPaymentEntity>> getPayments();
  Future<ClinicPaymentEntity> getPayment(String id);
  Future<ClinicPaymentEntity> cancelPayment(String id, {String? reason});
  Future<String?> getWalletBalance();
}

@Injectable(as: BillingRemoteDataSource)
class BillingRemoteDataSourceImpl implements BillingRemoteDataSource {
  BillingRemoteDataSourceImpl(this._api);

  final ApiConsumer _api;

  List<Map<String, dynamic>> _list(dynamic response) {
    final data = response['data'];
    return data is List
        ? data.whereType<Map<String, dynamic>>().toList()
        : const [];
  }

  Map<String, dynamic> _object(dynamic response) =>
      response['data'] as Map<String, dynamic>;

  String _message(dynamic response) => (response['message'] ?? '').toString();

  @override
  Future<List<PlanEntity>> getPlans() async {
    final models = await fetchMainPlans(_api);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<PlanFeaturesEntity> getPlanFeatures(String planId) async {
    final response = await _api.get(BillingEndpoints.planFeatures(planId));
    return PlanFeaturesModel.fromJson(_object(response));
  }

  @override
  Future<QuoteEntity> getQuote(QuoteParams params) async {
    final response = await _api.get(
      BillingEndpoints.quote,
      queryParameters: params.toJson(),
    );
    return QuoteModel.fromJson(_object(response));
  }

  @override
  Future<WithMessage<InvoiceEntity>> requestSubscription(QuoteParams params) async {
    final response = await _api.post(
      BillingEndpoints.requests,
      body: params.toJson(),
    );
    return WithMessage(InvoiceModel.fromJson(_object(response)), _message(response));
  }

  @override
  Future<List<SubscriptionPeriodEntity>> getPeriods() async {
    final response = await _api.get(BillingEndpoints.periods);
    return _list(response).map(SubscriptionPeriodModel.fromJson).toList();
  }

  @override
  Future<List<InvoiceEntity>> getInvoices() async {
    final response = await _api.get(BillingEndpoints.invoices);
    return _list(response).map(InvoiceModel.fromJson).toList();
  }

  @override
  Future<InvoiceEntity> getInvoice(String id) async {
    final response = await _api.get(BillingEndpoints.invoice(id));
    return InvoiceModel.fromJson(_object(response));
  }

  @override
  Future<List<PaymentMethodEntity>> getPaymentMethods() async {
    final response = await _api.get(BillingEndpoints.paymentMethods);
    return _list(response).map(PaymentMethodModel.fromJson).toList();
  }

  @override
  Future<PaymentReceiptEntity> uploadReceipt(File file) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split(Platform.pathSeparator).last,
      ),
    });
    final response = await _api.post(
      BillingEndpoints.receipts,
      formData: formData,
    );
    return PaymentReceiptModel.fromJson(_object(response));
  }

  @override
  Future<WithMessage<ClinicPaymentEntity>> reportPayment(
    ReportPaymentParams p,
  ) async {
    final response = await _api.post(BillingEndpoints.payments, body: p.toJson());
    return WithMessage(
      ClinicPaymentModel.fromJson(_object(response)),
      _message(response),
    );
  }

  @override
  Future<List<ClinicPaymentEntity>> getPayments() async {
    final response = await _api.get(BillingEndpoints.payments);
    return _list(response).map(ClinicPaymentModel.fromJson).toList();
  }

  @override
  Future<ClinicPaymentEntity> getPayment(String id) async {
    final response = await _api.get(BillingEndpoints.payment(id));
    return ClinicPaymentModel.fromJson(_object(response));
  }

  @override
  Future<ClinicPaymentEntity> cancelPayment(String id, {String? reason}) async {
    final response = await _api.post(
      BillingEndpoints.cancelPayment(id),
      body: {if (reason != null && reason.isNotEmpty) 'reason': reason},
    );
    return ClinicPaymentModel.fromJson(_object(response));
  }

  @override
  Future<String?> getWalletBalance() async {
    final response = await _api.get(BillingEndpoints.clinic);
    final data = response['data'];
    // A preformatted string (`"$0.00"`), not a number - shown as it is.
    final balance = data is Map ? data['credit_balance_usd'] : null;
    return balance?.toString();
  }
}
