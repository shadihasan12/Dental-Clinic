import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';

import '../../domain/entities/statistics_entities.dart';
import '../../domain/entities/statistics_period.dart';
import '../../domain/repositories/statistics_repository.dart';
import '../data_sources/statistics_remote_data_source.dart';

class StatisticsRepositoryImpl implements StatisticsRepository {
  StatisticsRepositoryImpl(this._remote);

  final StatisticsRemoteDataSource _remote;

  @override
  Future<Either<NetworkExceptions, StatisticsSnapshot>> getStatistics({
    required String clinicId,
    required StatisticsPeriod period,
  }) async {
    try {
      final snapshot = await _remote.getStatistics(
        clinicId: clinicId,
        period: period,
      );
      return Right(snapshot);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }
}
