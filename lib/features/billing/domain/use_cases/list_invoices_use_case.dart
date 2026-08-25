import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/invoice_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/repositories/billing_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ListInvoicesUseCase
    extends UseCase<List<InvoiceEntity>, ListInvoicesParams> {
  ListInvoicesUseCase(this._repo);

  final BillingRepository _repo;

  @override
  Future<Either<NetworkExceptions, List<InvoiceEntity>>> call(
    ListInvoicesParams params,
  ) {
    return _repo.listInvoices(params.clinicId);
  }
}

class ListInvoicesParams {
  const ListInvoicesParams({required this.clinicId});
  final String clinicId;
}
