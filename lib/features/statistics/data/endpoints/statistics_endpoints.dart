/// Endpoints for the dynamic statistics dashboard.
class StatisticsEndpoints {
  StatisticsEndpoints._();

  /// Catalog of available metrics (definitions + filter specs).
  static const String available = '/clinics/statistics';

  /// Per-metric data fetch — `?metrics=key1,key2&start_date=…`.
  static const String fetch = '/clinics/statistics/fetch';
}
