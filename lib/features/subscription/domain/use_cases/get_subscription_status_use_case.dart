import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_status_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/repositories/subscription_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSubscriptionStatusUseCase
    implements UseCase<SubscriptionStatusEntity, NoParams> {
  final SubscriptionRepository _repository;

  GetSubscriptionStatusUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, SubscriptionStatusEntity>> call(
    NoParams params,
  ) {
    return _repository.getStatus();
  }
}
