import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/statistic_metric.dart';
import '../../domain/entities/statistic_result.dart';
import '../../domain/repositories/statistics_catalog_repository.dart';
import '../data_sources/statistics_catalog_remote_data_source.dart';

@Injectable(as: StatisticsCatalogRepository)
class StatisticsCatalogRepositoryImpl implements StatisticsCatalogRepository {
  final StatisticsCatalogRemoteDataSource _remoteDataSource;

  StatisticsCatalogRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<NetworkExceptions, List<StatisticMetric>>>
      getAvailableStatistics() async {
    try {
      final result = await _remoteDataSource.getAvailableStatistics();
      return Right(result);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, Map<String, StatisticResult>>> fetchMetrics(
    List<String> keys, {
    Map<String, dynamic> filters = const {},
  }) async {
    try {
      final result = await _remoteDataSource.fetchMetrics(keys, filters);
      return Right(result);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }
}
