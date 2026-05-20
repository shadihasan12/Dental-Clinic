import '../../domain/entities/statistic_metric.dart';
import '../../domain/entities/statistic_result.dart';

/// Parses one metric's payload from `GET /clinics/statistics/fetch`.
///
/// The `data` field is passed through untouched — its shape depends on
/// the chart type and the chart widgets do the typed extraction.
class StatisticResultModel {
  StatisticResultModel._();

  static StatisticResult fromJson(String key, Map<String, dynamic> json) {
    return StatisticResult(
      key: key,
      type: StatisticChartType.fromApi(json['type'] as String?),
      data: json['data'],
      meta: (json['meta'] as Map<String, dynamic>?) ?? const {},
    );
  }
}
