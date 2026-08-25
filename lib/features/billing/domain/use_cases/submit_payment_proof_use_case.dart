import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/invoice_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/repositories/billing_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubmitPaymentProofUseCase
    extends UseCase<InvoiceEntity, SubmitPaymentProofParams> {
  SubmitPaymentProofUseCase(this._repo);

  final BillingRepository _repo;

  @override
  Future<Either<NetworkExceptions, InvoiceEntity>> call(
    SubmitPaymentProofParams params,
  ) {
    return _repo.submitProof(
      invoiceId: params.invoiceId,
      receipt: params.receipt,
      referenceNumber: params.referenceNumber,
      method: params.method,
      notes: params.notes,
    );
  }
}

class SubmitPaymentProofParams {
  const SubmitPaymentProofParams({
    required this.invoiceId,
    required this.receipt,
    required this.referenceNumber,
    required this.method,
    this.notes,
  });

  final String invoiceId;
  final File receipt;
  final String referenceNumber;
  final ManualPaymentMethod method;
  final String? notes;
}
