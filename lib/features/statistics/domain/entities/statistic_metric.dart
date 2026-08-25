/// The visualization a statistic metric renders as.
///
/// The backend sends a snake_case `type` string; [fromApi] maps it and
/// falls back to [unknown] so a new server-side type can never crash
/// the dashboard — it just renders a graceful "unsupported" card.
enum StatisticChartType {
  kpiCard,
  kpiWithList,
  donutChart,
  pieChart,
  barChart,
  horizontalBarChart,
  areaChart,
  dualLineChart,
  heatmap,
  dentalChartHeatmap,
  demographicsBreakdown,
  unknown;

  static StatisticChartType fromApi(String? raw) {
    switch (raw) {
      case 'kpi_card':
        return kpiCard;
      case 'kpi_with_list':
        return kpiWithList;
      case 'donut_chart':
        return donutChart;
      case 'pie_chart':
        return pieChart;
      case 'bar_chart':
        return barChart;
      case 'horizontal_bar_chart':
        return horizontalBarChart;
      case 'area_chart':
        return areaChart;
      case 'dual_line_chart':
        return dualLineChart;
      case 'heatmap':
        return heatmap;
      case 'dental_chart_heatmap':
        return dentalChartHeatmap;
      case 'demographics_breakdown':
        return demographicsBreakdown;
      default:
        return unknown;
    }
  }
}

/// The input type of a single metric filter.
enum StatisticFilterType {
  date,
  number,
  unknown;

  static StatisticFilterType fromApi(String? raw) {
    switch (raw) {
      case 'date':
        return date;
      case 'number':
        return number;
      default:
        return unknown;
    }
  }
}

/// One configurable filter on a metric, e.g. `start_date`, `end_date`
/// or `limit`. Mirrors the per-filter object the catalog endpoint
/// returns under each metric's `filters` map.
class StatisticFilter {
  const StatisticFilter({
    required this.name,
    required this.type,
    this.format,
    this.required = false,
    this.defaultValue,
    this.min,
    this.max,
  });

  /// The query-parameter name (`start_date`, `limit`, ...).
  final String name;
  final StatisticFilterType type;

  /// API format hint — `Y-m-d` for dates, `int` for numbers.
  final String? format;
  final bool required;

  /// Raw default from the API. For dates this is a token such as
  /// `start_of_month`; for numbers it is a literal like `5`.
  final Object? defaultValue;
  final num? min;
  final num? max;
}

/// A metric definition from `GET /clinics/statistics`. Describes what
/// the metric is and how it can be filtered — but carries no data;
/// the actual values come from a separate fetch call.
class StatisticMetric {
  const StatisticMetric({
    required this.key,
    required this.name,
    required this.description,
    required this.type,
    this.cacheTtl = 0,
    this.filters = const [],
  });

  final String key;
  final String name;
  final String description;
  final StatisticChartType type;
  final int cacheTtl;
  final List<StatisticFilter> filters;

  StatisticFilter? filterByName(String name) {
    for (final f in filters) {
      if (f.name == name) return f;
    }
    return null;
  }

  /// True when the metric accepts a date window — drives whether the
  /// global date-range picker affects this card.
  bool get acceptsDateRange =>
      filterByName('start_date') != null || filterByName('end_date') != null;

  /// The `limit` filter, when present (e.g. top-treatments). Cards with
  /// this get an inline count control.
  StatisticFilter? get limitFilter => filterByName('limit');
}
