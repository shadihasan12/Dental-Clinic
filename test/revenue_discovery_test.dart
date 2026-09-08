import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/statistics/domain/entities/statistic_metric.dart';
import 'package:dental_clinic_app/features/statistics/domain/entities/statistic_result.dart';
import 'package:dental_clinic_app/features/statistics/domain/repositories/statistics_catalog_repository.dart';
import 'package:dental_clinic_app/features/statistics/domain/use_cases/get_revenue_summary_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

/// The statistics API is a catalog the server owns, so the app has to find
/// revenue rather than name it. These cases cover the shapes it can arrive
/// in - the second one is the regression: revenue on this backend is as
/// likely to be a revenue-vs-expenses line chart as a headline number, and
/// only accepting the headline is why the home tile came back empty.
class _FakeCatalog implements StatisticsCatalogRepository {
  _FakeCatalog(this.metrics, this.results);

  final List<StatisticMetric> metrics;
  final Map<String, StatisticResult> results;

  /// The keys actually fetched, and how many round trips it took. Both are
  /// asserted: a broadened search must not turn into a request per
  /// candidate.
  final List<String> fetched = [];
  int calls = 0;

  @override
  Future<Either<NetworkExceptions, List<StatisticMetric>>>
  getAvailableStatistics() async => Right(metrics);

  @override
  Future<Either<NetworkExceptions, Map<String, StatisticResult>>> fetchMetrics(
    List<String> keys, {
    Map<String, dynamic> filters = const {},
  }) async {
    calls++;
    fetched.addAll(keys);
    return Right({
      for (final key in keys)
        if (results[key] != null) key: results[key]!,
    });
  }
}

StatisticMetric metric(String key, StatisticChartType type, {String? name}) =>
    StatisticMetric(key: key, name: name ?? key, description: '', type: type);

void main() {
  Future<dynamic> run(_FakeCatalog catalog) async {
    final result = await GetRevenueSummaryUseCase(catalog)(NoParams());
    return result.fold((e) => throw StateError('failed: $e'), (s) => s);
  }

  test('reads a headline KPI when the catalog offers one', () async {
    final catalog = _FakeCatalog(
      [metric('total_revenue', StatisticChartType.kpiCard)],
      {
        'total_revenue': const StatisticResult(
          key: 'total_revenue',
          type: StatisticChartType.kpiCard,
          data: {'value': 12480, 'change_percentage': 8.2, 'currency': 'USD'},
        ),
      },
    );

    final summary = await run(catalog);
    expect(summary!.value, 12480);
    expect(summary.changePercent, 8.2);
    expect(summary.currencyCode, 'USD');
  });

  // The regression this file exists for a second time: the live backend
  // sends a KPI as one row per currency, not as a bare object, so a reader
  // that only looked at `dataMap` found nothing and the tile hid itself
  // while the server had in fact answered with the month's takings.
  test('reads a KPI sent as a list of per-currency rows', () async {
    final catalog = _FakeCatalog(
      [metric('total_revenue', StatisticChartType.kpiCard)],
      {
        'total_revenue': const StatisticResult(
          key: 'total_revenue',
          type: StatisticChartType.kpiCard,
          data: [
            {
              'currency': 'USD',
              'value': 17010,
              'previous_value': 0,
              'percentage_change': 100,
              'trend': 'up',
            },
          ],
        ),
      },
    );

    final summary = await run(catalog);
    expect(summary!.value, 17010);
    expect(summary.previous, 0);
    expect(summary.currencyCode, 'USD');
    // `percentage_change`, not the `change_percentage` the reader used to
    // look for — the badge stayed blank on the real payload without this.
    expect(summary.changePercent, 100);
  });

  test('sums the revenue series of a revenue-vs-expenses chart', () async {
    final catalog = _FakeCatalog(
      [metric('revenue_vs_expenses', StatisticChartType.dualLineChart)],
      {
        'revenue_vs_expenses': const StatisticResult(
          key: 'revenue_vs_expenses',
          type: StatisticChartType.dualLineChart,
          data: {
            'labels': ['Jan', 'Feb', 'Mar'],
            'revenue': [100, 250, 150],
            'expenses': [900, 900, 900],
          },
        ),
      },
    );

    // Picks the series by name. Summing whichever list came first would have
    // reported the expenses as income.
    expect((await run(catalog))!.value, 500);
  });

  test('sums a plain values series on a revenue chart', () async {
    final catalog = _FakeCatalog(
      [metric('monthly_revenue', StatisticChartType.areaChart)],
      {
        'monthly_revenue': const StatisticResult(
          key: 'monthly_revenue',
          type: StatisticChartType.areaChart,
          // Money sometimes arrives as strings.
          data: {
            'labels': ['Jan', 'Feb'],
            'values': ['500.50', 249.5],
          },
        ),
      },
    );

    expect((await run(catalog))!.value, 750);
  });

  test('headlines the KPI and takes the bars from the chart, in one '
      'request', () async {
    final catalog = _FakeCatalog(
      [
        metric('revenue_trend', StatisticChartType.areaChart),
        metric('revenue', StatisticChartType.kpiCard),
      ],
      {
        'revenue': const StatisticResult(
          key: 'revenue',
          type: StatisticChartType.kpiCard,
          data: {'value': 900},
        ),
        'revenue_trend': const StatisticResult(
          key: 'revenue_trend',
          type: StatisticChartType.areaChart,
          data: {
            'labels': ['1', '2', '3'],
            'values': [10, 20, 30],
          },
        ),
      },
    );

    final summary = await run(catalog);
    // The server's own total, not the sum of the chart it was drawn from.
    expect(summary!.value, 900);
    expect(summary.recentDaily, [10, 20, 30]);
    // The bars must not cost a second round trip.
    expect(catalog.calls, 1);
    expect(catalog.fetched, ['revenue', 'revenue_trend']);
  });

  test('keeps only the last seven points of a longer series', () async {
    final catalog = _FakeCatalog(
      [metric('monthly_revenue', StatisticChartType.areaChart)],
      {
        'monthly_revenue': const StatisticResult(
          key: 'monthly_revenue',
          type: StatisticChartType.areaChart,
          data: {
            'labels': ['1', '2', '3', '4', '5', '6', '7', '8', '9'],
            'values': [1, 2, 3, 4, 5, 6, 7, 8, 9],
          },
        ),
      },
    );

    final summary = await run(catalog);
    expect(summary!.recentDaily, [3, 4, 5, 6, 7, 8, 9]);
    // The headline still totals the whole period, not just the drawn tail.
    expect(summary.value, 45);
  });

  test('an empty period reads as zero, not as no tile', () async {
    // The exact payload this API sends for a KPI with no rows in the window:
    // `data: []`, with only the metric name in meta.
    final catalog = _FakeCatalog(
      [metric('total_revenue', StatisticChartType.kpiCard)],
      {
        'total_revenue': const StatisticResult(
          key: 'total_revenue',
          type: StatisticChartType.kpiCard,
          data: [],
          meta: {'metric': 'total_revenue'},
        ),
      },
    );

    final summary = await run(catalog);
    expect(summary, isNotNull);
    expect(summary!.value, 0);
    expect(summary.currencyCode, isNull);
  });

  test('a metric the server did not answer for stays hidden', () async {
    final catalog = _FakeCatalog([
      metric('total_revenue', StatisticChartType.kpiCard),
    ], const {});

    expect(await run(catalog), isNull);
  });

  test('money owed is not money taken', () async {
    final catalog = _FakeCatalog([
      metric('outstanding_revenue', StatisticChartType.kpiCard),
      metric('patient_balances', StatisticChartType.kpiWithList),
    ], const {});

    expect(await run(catalog), isNull);
    expect(catalog.fetched, isEmpty);
  });

  test('a catalog with no revenue at all is not an error', () async {
    final catalog = _FakeCatalog([
      metric('appointments_per_day', StatisticChartType.barChart),
      metric('demographics', StatisticChartType.demographicsBreakdown),
    ], const {});

    expect(await run(catalog), isNull);
    expect(catalog.fetched, isEmpty);
  });
}
