import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/statistic_metric.dart';
import '../../domain/entities/statistic_result.dart';
import '../endpoints/statistics_endpoints.dart';
import '../models/statistic_metric_model.dart';
import '../models/statistic_result_model.dart';

abstract class StatisticsCatalogRemoteDataSource {
  Future<List<StatisticMetric>> getAvailableStatistics();
  Future<Map<String, StatisticResult>> fetchMetrics(
    List<String> keys,
    Map<String, dynamic> filters,
  );
}

@Injectable(as: StatisticsCatalogRemoteDataSource)
class StatisticsCatalogRemoteDataSourceImpl
    implements StatisticsCatalogRemoteDataSource {
  final ApiConsumer _apiConsumer;

  StatisticsCatalogRemoteDataSourceImpl(this._apiConsumer);

  @override
  Future<List<StatisticMetric>> getAvailableStatistics() async {
    final response = await _apiConsumer.get(StatisticsEndpoints.available);
    final list = response['data'] as List? ?? const [];
    return list
        .whereType<Map<String, dynamic>>()
        .map(StatisticMetricModel.fromJson)
        .toList();
  }

  @override
  Future<Map<String, StatisticResult>> fetchMetrics(
    List<String> keys,
    Map<String, dynamic> filters,
  ) async {
    final response = await _apiConsumer.get(
      StatisticsEndpoints.fetch,
      queryParameters: {
        'metrics': keys.join(','),
        ...filters,
      },
    );
    final data = response['data'] as Map<String, dynamic>? ?? const {};
    final result = <String, StatisticResult>{};
    data.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        result[key] = StatisticResultModel.fromJson(key, value);
      }
    });
    return result;
  }
}
