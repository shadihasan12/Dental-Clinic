import '../../domain/entities/statistics_entities.dart';
import '../../domain/entities/statistics_period.dart';

/// Contract that the real `StatisticsApiDataSource` will implement once
/// the backend ships. For now the only implementation is
/// [MockStatisticsDataSource], so swapping it later is a one-line change
/// in `statistics_injection.dart`.
abstract class StatisticsRemoteDataSource {
  Future<StatisticsSnapshot> getStatistics({
    required String clinicId,
    required StatisticsPeriod period,
  });
}
