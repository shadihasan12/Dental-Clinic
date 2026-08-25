part of 'statistics_dashboard_bloc.dart';

/// Load status of the metric catalog (the `GET /clinics/statistics`
/// call). Distinct from per-metric status below.
enum CatalogStatus { initial, loading, success, failure }

/// Load status of a single metric's data fetch.
enum MetricStatus { loading, success, failure }

/// Per-card state: its data fetch status, the fetched result, an error
/// message, and any user-chosen `limit` override.
class MetricState {
  const MetricState({
    required this.status,
    this.result,
    this.error,
    this.limit,
  });

  const MetricState.loading() : this(status: MetricStatus.loading);

  final MetricStatus status;
  final StatisticResult? result;
  final String? error;

  /// User-chosen value for the metric's `limit` filter, if any.
  final int? limit;

  MetricState copyWith({
    MetricStatus? status,
    StatisticResult? result,
    String? error,
    int? limit,
    bool clearError = false,
  }) {
    return MetricState(
      status: status ?? this.status,
      result: result ?? this.result,
      error: clearError ? null : (error ?? this.error),
      limit: limit ?? this.limit,
    );
  }
}

class StatisticsDashboardState {
  const StatisticsDashboardState({
    required this.catalogStatus,
    required this.metrics,
    required this.startDate,
    required this.endDate,
    required this.results,
    this.catalogError,
  });

  /// Initial state — date range defaults to the current calendar month
  /// (mirrors the API's `start_of_month` / `end_of_month` defaults).
  factory StatisticsDashboardState.initial() {
    final now = DateTime.now();
    return StatisticsDashboardState(
      catalogStatus: CatalogStatus.initial,
      metrics: const [],
      startDate: DateTime(now.year, now.month, 1),
      endDate: DateTime(now.year, now.month + 1, 0),
      results: const {},
    );
  }

  final CatalogStatus catalogStatus;
  final List<StatisticMetric> metrics;
  final String? catalogError;
  final DateTime startDate;
  final DateTime endDate;

  /// Per-metric state, keyed by metric key.
  final Map<String, MetricState> results;

  StatisticsDashboardState copyWith({
    CatalogStatus? catalogStatus,
    List<StatisticMetric>? metrics,
    String? catalogError,
    DateTime? startDate,
    DateTime? endDate,
    Map<String, MetricState>? results,
  }) {
    return StatisticsDashboardState(
      catalogStatus: catalogStatus ?? this.catalogStatus,
      metrics: metrics ?? this.metrics,
      catalogError: catalogError ?? this.catalogError,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      results: results ?? this.results,
    );
  }
}
