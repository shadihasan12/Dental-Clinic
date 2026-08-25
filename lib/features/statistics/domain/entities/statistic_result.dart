import 'statistic_metric.dart';

/// The fetched payload for one metric from
/// `GET /clinics/statistics/fetch`.
///
/// [data] is intentionally kept as a raw value (`Map`, `List` or
/// `null`) rather than a typed model: the shape differs per chart type
/// — a donut sends `{labels, values}`, a KPI sends an object (or `[]`
/// when there's nothing yet), a heatmap sends a grid. Each chart widget
/// extracts what it needs through the typed accessors below, so a
/// surprising shape degrades to an empty state instead of a crash.
class StatisticResult {
  const StatisticResult({
    required this.key,
    required this.type,
    this.data,
    this.meta = const {},
  });

  final String key;
  final StatisticChartType type;
  final Object? data;
  final Map<String, dynamic> meta;

  /// [data] as a string-keyed map, or an empty map when it isn't one.
  Map<String, dynamic> get dataMap =>
      data is Map<String, dynamic> ? data as Map<String, dynamic> : const {};

  /// [data] as a list, or an empty list when it isn't one.
  List<dynamic> get dataList => data is List ? data as List<dynamic> : const [];

  /// True when the server returned no usable data for this metric
  /// (`null`, `[]` or `{}`).
  bool get isEmpty {
    final d = data;
    if (d == null) return true;
    if (d is List) return d.isEmpty;
    if (d is Map) return d.isEmpty;
    return false;
  }
}
