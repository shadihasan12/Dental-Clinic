import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';

import '../entities/statistic_metric.dart';
import '../entities/statistic_result.dart';

/// Repository for the dynamic, config-driven statistics dashboard.
///
/// Two steps: first read the catalog of available metrics, then fetch
/// the data for whichever metrics the dashboard wants to render.
abstract class StatisticsCatalogRepository {
  /// `GET /clinics/statistics` — the metric catalog (definitions only).
  Future<Either<NetworkExceptions, List<StatisticMetric>>>
      getAvailableStatistics();

  /// `GET /clinics/statistics/fetch?metrics=…` — the data for the given
  /// metric keys. [filters] are flattened straight into the query
  /// string (`start_date`, `end_date`, `limit`, …).
  Future<Either<NetworkExceptions, Map<String, StatisticResult>>> fetchMetrics(
    List<String> keys, {
    Map<String, dynamic> filters,
  });
}
