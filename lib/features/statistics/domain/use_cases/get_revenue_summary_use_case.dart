import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

import '../entities/revenue_summary.dart';
import '../entities/statistic_metric.dart';
import '../repositories/statistics_catalog_repository.dart';

/// This month's revenue, for the home screen.
///
/// The statistics API is a catalog the server owns: it lists the metrics a
/// clinic has and the app renders them, and no metric key is written down in
/// the app anywhere. So rather than hard-coding a key that a rename would
/// silently break, this asks the catalog what it has and takes the revenue
/// metric if one is offered.
///
/// A clinic whose catalog has no revenue metric is a normal outcome, not a
/// failure: the call succeeds with null and the caller shows nothing. Only a
/// transport or server error comes back on the left.
@injectable
class GetRevenueSummaryUseCase implements UseCase<RevenueSummary?, NoParams> {
  GetRevenueSummaryUseCase(this._repository);

  final StatisticsCatalogRepository _repository;

  static final DateFormat _apiDate = DateFormat('yyyy-MM-dd');

  /// Tried in order, against the metric key. These are the names the catalog
  /// is most likely to use; anything else falls through to the substring
  /// pass below.
  static const List<String> _preferredKeys = [
    'total_revenue',
    'revenue',
    'clinic_revenue',
    'revenue_summary',
    'total_income',
    'income',
  ];

  @override
  Future<Either<NetworkExceptions, RevenueSummary?>> call(
    NoParams params,
  ) async {
    final catalog = await _repository.getAvailableStatistics();
    final catalogFailure = catalog.fold((l) => l, (_) => null);
    if (catalogFailure != null) return Left(catalogFailure);

    final metrics = catalog.getOrElse(() => const []);
    final matches = metrics.where(_looksLikeRevenue).toList();
    if (matches.isEmpty) {
      _reportNoMatch(metrics);
      return const Right(null);
    }

    final headline = _pickHeadline(matches);
    final trend = _pickTrend(matches, exclude: headline);
    if (headline == null && trend == null) return const Right(null);

    // Both keys go in one request - the repository takes a list - so the
    // trend bars cost no extra round trip. That is the only reason they are
    // worth drawing on a screen the user opens constantly.
    final keys = <String>[
      if (headline != null) headline.key,
      if (trend != null) trend.key,
    ];
    final wantsDates =
        (headline?.acceptsDateRange ?? false) ||
        (trend?.acceptsDateRange ?? false);

    final fetched = await _repository.fetchMetrics(
      keys,
      filters: wantsDates ? _thisMonth() : const {},
    );
    final fetchFailure = fetched.fold((l) => l, (_) => null);
    if (fetchFailure != null) return Left(fetchFailure);

    final results = fetched.getOrElse(() => const {});

    // With no headline metric the series is the only source, so its own
    // total becomes the figure.
    final source = headline == null
        ? results[trend!.key]
        : results[headline.key];

    // The bars come from the dedicated trend metric when there is one, and
    // otherwise from the headline itself - a lone revenue chart is both the
    // total and the shape, and asking for a second metric to draw what is
    // already in hand would be a wasted round trip.
    final pointsSource = trend != null
        ? results[trend.key]
        : (headline != null && _isSeries(headline) ? source : null);
    final points = pointsSource == null
        ? const <double>[]
        : RevenueSummary.seriesPoints(pointsSource.data);

    // The key is missing from the response entirely - the server did not
    // answer for this metric, which is not the same as answering "nothing".
    if (source == null) return const Right(null);

    // It answered, with nothing in it. `[]` is what this API sends for a KPI
    // with no rows in the period, so the honest reading is zero, not
    // silence: a clinic that has taken nothing this month is entitled to see
    // that rather than to watch the tile vanish and wonder if it is broken.
    if (source.isEmpty) {
      return Right(const RevenueSummary.empty().withSeries(points));
    }

    return Right(
      RevenueSummary.from(
        source,
        // The metric is already known to be about revenue, so an unnamed
        // `values` series in its payload is revenue and may be summed. That
        // assumption is not safe for a metric picked on a looser match.
        sumPlainSeries: true,
        recentDaily: points,
      ),
    );
  }

  /// The single figure to headline with - the server's own total, which
  /// beats one this app adds up.
  static StatisticMetric? _pickHeadline(List<StatisticMetric> matches) {
    for (final key in _preferredKeys) {
      for (final metric in matches) {
        if (metric.key.toLowerCase() == key && _isKpi(metric)) return metric;
      }
    }
    for (final metric in matches) {
      if (_isKpi(metric)) return metric;
    }
    // No KPI on offer: a chart's points sum to the same total.
    for (final metric in matches) {
      if (_isSeries(metric)) return metric;
    }
    return null;
  }

  /// The series behind the trend bars, when the catalog has one to spare.
  static StatisticMetric? _pickTrend(
    List<StatisticMetric> matches, {
    StatisticMetric? exclude,
  }) {
    for (final metric in matches) {
      if (metric.key == exclude?.key) continue;
      if (_isSeries(metric)) return metric;
    }
    return null;
  }

  static bool _looksLikeRevenue(StatisticMetric metric) {
    final haystack = '${metric.key} ${metric.name}'.toLowerCase();
    // Money owed is not money taken, and a user reading it as revenue would
    // be reading a different number entirely.
    if (haystack.contains('outstanding')) return false;
    if (haystack.contains('balance')) return false;
    return RevenueSummary.revenueKeys.any(haystack.contains);
  }

  static bool _isKpi(StatisticMetric metric) =>
      metric.type == StatisticChartType.kpiCard ||
      metric.type == StatisticChartType.kpiWithList;

  /// Shapes whose payload is a list of points over the period. Donut and pie
  /// are deliberately absent: those are as often proportions as amounts, and
  /// summing percentages would produce a confident nonsense figure.
  static bool _isSeries(StatisticMetric metric) =>
      metric.type == StatisticChartType.areaChart ||
      metric.type == StatisticChartType.dualLineChart ||
      metric.type == StatisticChartType.barChart ||
      metric.type == StatisticChartType.horizontalBarChart;

  /// Names the catalog in debug builds when nothing matched.
  ///
  /// The keys are the server's, not the app's, so when this tile is missing
  /// the only way to find out why is to see what was actually on offer.
  static void _reportNoMatch(List<StatisticMetric> metrics) {
    if (!kDebugMode) return;
    debugPrint(
      'GetRevenueSummaryUseCase: no revenue metric in the catalog. '
      'Available: '
      '${metrics.map((m) => '${m.key} (${m.type.name})').join(', ')}',
    );
  }

  /// Month to date - the window a clinic owner reads "total revenue" as.
  static Map<String, dynamic> _thisMonth() {
    final now = DateTime.now();
    return {
      'start_date': _apiDate.format(DateTime(now.year, now.month, 1)),
      'end_date': _apiDate.format(now),
    };
  }
}
