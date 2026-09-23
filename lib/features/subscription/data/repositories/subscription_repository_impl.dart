import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/subscription/data/data_sources/subscription_remote_data_source.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_status_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_usage_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/repositories/subscription_repository.dart';
import 'package:dental_clinic_app/services/subscription_guard/subscription_guard.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SubscriptionRepository)
class SubscriptionRepositoryImpl implements SubscriptionRepository {
  final SubscriptionRemoteDataSource _dataSource;
  final SubscriptionGuard _guard;

  SubscriptionRepositoryImpl(this._dataSource, this._guard);

  @override
  Future<Either<NetworkExceptions, SubscriptionStatusEntity>> getStatus() async {
    try {
      final model = await _dataSource.getStatus();
      // The status call carries the same access mode as the permissions
      // call; whichever lands last is the freshest answer.
      _guard.update(accessMode: model.accessMode, status: model.status);
      return Right(model.toEntity());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, SubscriptionUsageEntity>> getUsage() async {
    try {
      final model = await _dataSource.getUsage();
      return Right(model.toEntity());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }
}
