import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/statistic_metric.dart';
import '../../domain/entities/statistic_result.dart';
import '../../domain/repositories/statistics_catalog_repository.dart';

part 'statistics_dashboard_event.dart';
part 'statistics_dashboard_state.dart';

/// Drives the dynamic statistics dashboard:
///   1. loads the metric catalog once,
///   2. fetches each metric's data independently so cards stream in
///      one by one,
///   3. refetches the affected cards when the global date range or a
///      per-card limit changes.
@injectable
class StatisticsDashboardBloc
    extends Bloc<StatisticsDashboardEvent, StatisticsDashboardState> {
  final StatisticsCatalogRepository _repository;

  StatisticsDashboardBloc(this._repository)
      : super(StatisticsDashboardState.initial()) {
    on<DashboardStarted>(_onStarted);
    on<DashboardDateRangeChanged>(_onDateRangeChanged);
    on<DashboardMetricLimitChanged>(_onMetricLimitChanged);
    on<DashboardMetricRetried>(_onMetricRetried);
  }

  static final DateFormat _apiDate = DateFormat('yyyy-MM-dd');

  Future<void> _onStarted(
    DashboardStarted event,
    Emitter<StatisticsDashboardState> emit,
  ) async {
    emit(state.copyWith(catalogStatus: CatalogStatus.loading));

    final result = await _repository.getAvailableStatistics();
    final failure = result.fold((l) => l, (_) => null);
    if (failure != null) {
      emit(state.copyWith(
        catalogStatus: CatalogStatus.failure,
        catalogError: NetworkExceptions.getErrorMessage(failure),
      ));
      return;
    }

    final metrics = result.getOrElse(() => const []);
    emit(state.copyWith(
      catalogStatus: CatalogStatus.success,
      metrics: metrics,
      // Every card starts in loading; each fetch flips its own entry.
      results: {
        for (final m in metrics) m.key: const MetricState.loading(),
      },
    ));

    await _fetchAll(metrics, emit);
  }

  Future<void> _onDateRangeChanged(
    DashboardDateRangeChanged event,
    Emitter<StatisticsDashboardState> emit,
  ) async {
    // Only the date-aware metrics need a refetch; cards with no date
    // filter (demographics, outstanding balances) keep their data.
    final affected =
        state.metrics.where((m) => m.acceptsDateRange).toList();
    final results = Map<String, MetricState>.from(state.results);
    for (final m in affected) {
      results[m.key] = (results[m.key] ?? const MetricState.loading())
          .copyWith(status: MetricStatus.loading);
    }
    emit(state.copyWith(
      startDate: event.start,
      endDate: event.end,
      results: results,
    ));

    await _fetchAll(affected, emit);
  }

  Future<void> _onMetricLimitChanged(
    DashboardMetricLimitChanged event,
    Emitter<StatisticsDashboardState> emit,
  ) async {
    final metric = _metricByKey(event.key);
    if (metric == null) return;
    emit(state.copyWith(
      results: _patch(
        event.key,
        (current) => current.copyWith(
          status: MetricStatus.loading,
          limit: event.limit,
        ),
      ),
    ));
    await _fetchOne(metric, emit);
  }

  Future<void> _onMetricRetried(
    DashboardMetricRetried event,
    Emitter<StatisticsDashboardState> emit,
  ) async {
    final metric = _metricByKey(event.key);
    if (metric == null) return;
    emit(state.copyWith(
      results: _patch(
        event.key,
        (current) => current.copyWith(status: MetricStatus.loading),
      ),
    ));
    await _fetchOne(metric, emit);
  }

  // ── Fetching ─────────────────────────────────────────────────────

  /// Fires every metric fetch concurrently and emits as each resolves,
  /// so cards fill in independently. [Future.wait] keeps the event
  /// handler alive until the last one completes — emits stay valid.
  Future<void> _fetchAll(
    List<StatisticMetric> metrics,
    Emitter<StatisticsDashboardState> emit,
  ) async {
    await Future.wait(metrics.map((m) => _fetchOne(m, emit)));
  }

  Future<void> _fetchOne(
    StatisticMetric metric,
    Emitter<StatisticsDashboardState> emit,
  ) async {
    final result = await _repository.fetchMetrics(
      [metric.key],
      filters: _filtersFor(metric),
    );
    result.fold(
      (error) => emit(state.copyWith(
        results: _patch(
          metric.key,
          (current) => current.copyWith(
            status: MetricStatus.failure,
            error: NetworkExceptions.getErrorMessage(error),
          ),
        ),
      )),
      (map) => emit(state.copyWith(
        results: _patch(
          metric.key,
          (current) => current.copyWith(
            status: MetricStatus.success,
            result: map[metric.key],
            clearError: true,
          ),
        ),
      )),
    );
  }

  /// Builds the query filters for one metric from the global date range
  /// plus any per-card limit override.
  Map<String, dynamic> _filtersFor(StatisticMetric metric) {
    final filters = <String, dynamic>{};
    if (metric.acceptsDateRange) {
      filters['start_date'] = _apiDate.format(state.startDate);
      filters['end_date'] = _apiDate.format(state.endDate);
    }
    final limitFilter = metric.limitFilter;
    if (limitFilter != null) {
      final override = state.results[metric.key]?.limit;
      final fallback = (limitFilter.defaultValue as num?)?.toInt() ?? 5;
      filters['limit'] = override ?? fallback;
    }
    return filters;
  }

  StatisticMetric? _metricByKey(String key) {
    for (final m in state.metrics) {
      if (m.key == key) return m;
    }
    return null;
  }

  /// Returns a new results map with [key]'s entry transformed.
  Map<String, MetricState> _patch(
    String key,
    MetricState Function(MetricState current) transform,
  ) {
    final next = Map<String, MetricState>.from(state.results);
    next[key] = transform(next[key] ?? const MetricState.loading());
    return next;
  }
}
