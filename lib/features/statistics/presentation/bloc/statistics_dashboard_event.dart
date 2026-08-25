part of 'statistics_dashboard_bloc.dart';

abstract class StatisticsDashboardEvent {
  const StatisticsDashboardEvent();
}

/// Fired once on page open — loads the catalog, then every metric.
class DashboardStarted extends StatisticsDashboardEvent {
  const DashboardStarted();
}

/// The global date range changed — refetch every date-aware metric.
class DashboardDateRangeChanged extends StatisticsDashboardEvent {
  const DashboardDateRangeChanged({required this.start, required this.end});
  final DateTime start;
  final DateTime end;
}

/// A single card's `limit` filter changed (e.g. top-treatments count).
class DashboardMetricLimitChanged extends StatisticsDashboardEvent {
  const DashboardMetricLimitChanged({required this.key, required this.limit});
  final String key;
  final int limit;
}

/// Retry a single failed metric without reloading the whole dashboard.
class DashboardMetricRetried extends StatisticsDashboardEvent {
  const DashboardMetricRetried(this.key);
  final String key;
}
