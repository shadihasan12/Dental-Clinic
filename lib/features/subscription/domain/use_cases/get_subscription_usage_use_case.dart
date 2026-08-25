import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_usage_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/repositories/subscription_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSubscriptionUsageUseCase
    implements UseCase<SubscriptionUsageEntity, NoParams> {
  final SubscriptionRepository _repository;

  GetSubscriptionUsageUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, SubscriptionUsageEntity>> call(
    NoParams params,
  ) {
    return _repository.getUsage();
  }
}
