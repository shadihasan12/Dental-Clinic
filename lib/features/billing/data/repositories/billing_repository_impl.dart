import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/billing/data/data_sources/billing_local_data_source.dart';
import 'package:dental_clinic_app/features/billing/data/models/invoice_model.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/invoice_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/payment_instructions_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/payment_providers/payment_provider.dart';
import 'package:dental_clinic_app/features/billing/domain/repositories/billing_repository.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_plan_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/user_subscription_entity.dart';
import 'package:dental_clinic_app/services/subscription_guard/subscription_guard.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BillingRepository)
class BillingRepositoryImpl implements BillingRepository {
  BillingRepositoryImpl(this._data, this._provider, this._guard);

  final BillingLocalDataSource _data;
  final PaymentProvider _provider;
  final SubscriptionGuard _guard;

  @override
  Future<Either<NetworkExceptions, List<InvoiceEntity>>> listInvoices(
    String clinicId,
  ) async {
    try {
      final models = await _data.listInvoices(clinicId);
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, InvoiceEntity>> getInvoice(
    String id,
  ) async {
    try {
      final model = await _data.getInvoice(id);
      return Right(model.toEntity());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, InvoiceEntity>> createInvoice({
    required String clinicId,
    required SubscriptionPlanEntity plan,
    required BillingCycle cycle,
    required bool isRenewal,
  }) async {
    try {
      final invoice = await _provider.createInvoice(
        clinicId: clinicId,
        plan: plan,
        cycle: cycle,
        isRenewal: isRenewal,
      );
      return Right(invoice);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, InvoiceEntity>> submitProof({
    required String invoiceId,
    required File receipt,
    required String referenceNumber,
    required ManualPaymentMethod method,
    String? notes,
  }) async {
    try {
      final invoice = await _provider.submitProof(
        invoiceId: invoiceId,
        receipt: receipt,
        referenceNumber: referenceNumber,
        method: method,
        notes: notes,
      );
      return Right(invoice);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  PaymentInstructions instructionsFor(InvoiceEntity invoice) =>
      _provider.instructionsFor(invoice);

  @override
  Future<Either<NetworkExceptions, InvoiceEntity>> approveInvoice(
    String invoiceId,
  ) async {
    try {
      final current = await _data.getInvoice(invoiceId);
      if (current.status != InvoiceStatus.underReview &&
          current.status != InvoiceStatus.pending) {
        throw StateError(
          'Cannot approve an invoice in status ${current.status.name}',
        );
      }
      final now = DateTime.now();
      // The invoice was minted with `activatesUntil` already set; if
      // somehow missing (or this is a manual approval before proof), fall
      // back to a one-period extension from now.
      final periodEnd = current.activatesUntil ??
          now.add(Duration(
            days: current.billingCycle == BillingCycle.yearly ? 365 : 30,
          ));
      final updated = current.copyWith(
        status: InvoiceStatus.paid,
        paidAt: now,
        activatesUntil: periodEnd,
      );
      final saved = await _data.saveInvoice(updated);

      // Activate the clinic subscription. In production this would be a
      // backend webhook firing off the subscription update; here we
      // update the in-process guard so the rest of the app sees the new
      // active subscription immediately.
      _guard.update(
        UserSubscriptionEntity(
          id: 'sub_from_${saved.id}',
          userId: saved.clinicId,
          planTier: saved.planTier ?? PlanTier.solo,
          status: SubscriptionStatus.active,
          billingCycle: saved.billingCycle ?? BillingCycle.monthly,
          startDate: now,
          currentPeriodEnd: periodEnd,
          autoRenew: false,
          lastPaymentDate: now,
          lastPaymentAmount: saved.amount,
          lastPaymentId: saved.id,
        ),
      );

      return Right(saved.toEntity());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, InvoiceEntity>> rejectInvoice(
    String invoiceId, {
    String? reason,
  }) async {
    try {
      final current = await _data.getInvoice(invoiceId);
      if (current.status == InvoiceStatus.paid ||
          current.status == InvoiceStatus.rejected) {
        throw StateError(
          'Invoice is already ${current.status.name}; nothing to reject.',
        );
      }
      final updated = current.copyWith(
        status: InvoiceStatus.rejected,
        rejection: RejectionModel(rejectedAt: DateTime.now(), reason: reason),
      );
      final saved = await _data.saveInvoice(updated);
      return Right(saved.toEntity());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Stream<InvoiceEntity> watchChanges() =>
      _data.changes.map((m) => m.toEntity());
}
