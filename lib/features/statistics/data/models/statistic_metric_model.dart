import '../../domain/entities/statistic_metric.dart';

/// Parses a single catalog entry from `GET /clinics/statistics`.
class StatisticMetricModel {
  StatisticMetricModel._();

  static StatisticMetric fromJson(Map<String, dynamic> json) {
    return StatisticMetric(
      key: json['key'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      type: StatisticChartType.fromApi(json['type'] as String?),
      cacheTtl: (json['cache_ttl'] as num?)?.toInt() ?? 0,
      filters: _parseFilters(json['filters']),
    );
  }

  /// `filters` is a `{name: {...}}` map when the metric is filterable,
  /// but an empty list `[]` when it isn't — tolerate both shapes.
  static List<StatisticFilter> _parseFilters(dynamic raw) {
    if (raw is! Map) return const [];
    final result = <StatisticFilter>[];
    raw.forEach((name, def) {
      if (def is Map) {
        result.add(
          StatisticFilter(
            name: name.toString(),
            type: StatisticFilterType.fromApi(def['type'] as String?),
            format: def['format'] as String?,
            required: def['required'] as bool? ?? false,
            defaultValue: def['default'],
            min: def['min'] as num?,
            max: def['max'] as num?,
          ),
        );
      }
    });
    return result;
  }
}
