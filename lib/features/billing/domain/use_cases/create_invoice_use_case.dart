import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/invoice_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/repositories/billing_repository.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_plan_entity.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateInvoiceUseCase
    extends UseCase<InvoiceEntity, CreateInvoiceParams> {
  CreateInvoiceUseCase(this._repo);

  final BillingRepository _repo;

  @override
  Future<Either<NetworkExceptions, InvoiceEntity>> call(
    CreateInvoiceParams params,
  ) {
    return _repo.createInvoice(
      clinicId: params.clinicId,
      plan: params.plan,
      cycle: params.cycle,
      isRenewal: params.isRenewal,
    );
  }
}

class CreateInvoiceParams {
  const CreateInvoiceParams({
    required this.clinicId,
    required this.plan,
    required this.cycle,
    this.isRenewal = false,
  });

  final String clinicId;
  final SubscriptionPlanEntity plan;
  final BillingCycle cycle;
  final bool isRenewal;
}
