import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/plan_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/addon_entity.dart';
import 'package:dental_clinic_app/features/billing/data/data_sources/billing_remote_data_source.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/clinic_payment_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/invoice_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/payment_method_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/payment_receipt_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/plan_features_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/quote_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/subscription_period_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/repositories/billing_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BillingRepository)
class BillingRepositoryImpl implements BillingRepository {
  BillingRepositoryImpl(this._remote);

  final BillingRemoteDataSource _remote;

  Future<Either<NetworkExceptions, T>> _run<T>(Future<T> Function() call) async {
    try {
      return Right(await call());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, List<PlanEntity>>> getPlans() =>
      _run(_remote.getPlans);

  @override
  Future<Either<NetworkExceptions, PlanFeaturesEntity>> getPlanFeatures(
    String planId,
  ) =>
      _run(() => _remote.getPlanFeatures(planId));

  @override
  Future<Either<NetworkExceptions, QuoteEntity>> getQuote(QuoteParams params) =>
      _run(() => _remote.getQuote(params));

  @override
  Future<Either<NetworkExceptions, BillingRequestResult>> requestSubscription(
    QuoteParams params,
  ) =>
      _run(() => _remote.requestSubscription(params));

  @override
  Future<Either<NetworkExceptions, QuoteEntity>> getUpgradeQuote(
    String planVersionId,
  ) =>
      _run(() => _remote.getUpgradeQuote(planVersionId));

  @override
  Future<Either<NetworkExceptions, BillingRequestResult>> requestUpgrade(
    String planVersionId,
  ) =>
      _run(() => _remote.requestUpgrade(planVersionId));

  @override
  Future<Either<NetworkExceptions, List<AddonEntity>>> getAddons() =>
      _run(_remote.getAddons);

  @override
  Future<Either<NetworkExceptions, QuoteEntity>> getAddonQuote(
    String planVersionId,
    int quantity,
  ) =>
      _run(() => _remote.getAddonQuote(planVersionId, quantity));

  @override
  Future<Either<NetworkExceptions, BillingRequestResult>> requestAddons(
    String planVersionId,
    int quantity,
  ) =>
      _run(() => _remote.requestAddons(planVersionId, quantity));

  @override
  Future<Either<NetworkExceptions, List<SubscriptionPeriodEntity>>>
      getPeriods() => _run(_remote.getPeriods);

  @override
  Future<Either<NetworkExceptions, List<InvoiceEntity>>> getInvoices() =>
      _run(_remote.getInvoices);

  @override
  Future<Either<NetworkExceptions, InvoiceEntity>> getInvoice(String id) =>
      _run(() => _remote.getInvoice(id));

  @override
  Future<Either<NetworkExceptions, List<PaymentMethodEntity>>>
      getPaymentMethods() => _run(_remote.getPaymentMethods);

  @override
  Future<Either<NetworkExceptions, PaymentReceiptEntity>> uploadReceipt(
    File file,
  ) =>
      _run(() => _remote.uploadReceipt(file));

  @override
  Future<Either<NetworkExceptions, WithMessage<ClinicPaymentEntity>>>
      reportPayment(ReportPaymentParams params) =>
          _run(() => _remote.reportPayment(params));

  @override
  Future<Either<NetworkExceptions, List<ClinicPaymentEntity>>> getPayments() =>
      _run(_remote.getPayments);

  @override
  Future<Either<NetworkExceptions, ClinicPaymentEntity>> getPayment(
    String id,
  ) =>
      _run(() => _remote.getPayment(id));

  @override
  Future<Either<NetworkExceptions, ClinicPaymentEntity>> cancelPayment(
    String id, {
    String? reason,
  }) =>
      _run(() => _remote.cancelPayment(id, reason: reason));
}
