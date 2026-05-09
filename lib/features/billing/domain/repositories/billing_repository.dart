import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/invoice_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/payment_instructions_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_plan_entity.dart';

abstract class BillingRepository {
  Future<Either<NetworkExceptions, List<InvoiceEntity>>> listInvoices(
    String clinicId,
  );

  Future<Either<NetworkExceptions, InvoiceEntity>> getInvoice(String id);

  Future<Either<NetworkExceptions, InvoiceEntity>> createInvoice({
    required String clinicId,
    required SubscriptionPlanEntity plan,
    required BillingCycle cycle,
    required bool isRenewal,
  });

  Future<Either<NetworkExceptions, InvoiceEntity>> submitProof({
    required String invoiceId,
    required File receipt,
    required String referenceNumber,
    required ManualPaymentMethod method,
    String? notes,
  });

  PaymentInstructions instructionsFor(InvoiceEntity invoice);

  /// Admin action: mark the invoice as paid and activate the linked
  /// subscription. In production this lives behind admin auth on the
  /// backend; the dentist app only learns about the result via
  /// [watchChanges].
  Future<Either<NetworkExceptions, InvoiceEntity>> approveInvoice(
    String invoiceId,
  );

  /// Admin action: reject the invoice with an optional reason. The
  /// dentist sees the reason on the invoice details page.
  Future<Either<NetworkExceptions, InvoiceEntity>> rejectInvoice(
    String invoiceId, {
    String? reason,
  });

  /// Stream of invoice changes — used by the bloc to refresh the list
  /// after a status transition without a manual refetch. Maps to a
  /// Firestore document/collection listener or a WebSocket subscription
  /// on the real backend.
  Stream<InvoiceEntity> watchChanges();
}
