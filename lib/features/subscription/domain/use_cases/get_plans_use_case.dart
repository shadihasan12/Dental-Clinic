import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_plan_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/repositories/subscription_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetPlansUseCase
    extends UseCase<List<SubscriptionPlanEntity>, NoParams> {
  final SubscriptionRepository _repository;

  GetPlansUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, List<SubscriptionPlanEntity>>> call(
    NoParams params,
  ) {
    return _repository.getPlans();
  }
}
