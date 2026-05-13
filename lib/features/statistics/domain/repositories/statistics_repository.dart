import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';

import '../entities/statistics_entities.dart';
import '../entities/statistics_period.dart';

abstract class StatisticsRepository {
  /// Fetch the statistics snapshot for [clinicId] over [period].
  Future<Either<NetworkExceptions, StatisticsSnapshot>> getStatistics({
    required String clinicId,
    required StatisticsPeriod period,
  });
}
