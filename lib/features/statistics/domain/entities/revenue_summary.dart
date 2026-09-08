import 'statistic_result.dart';

/// The clinic's revenue for a period, reduced to the few values a summary
/// tile needs.
///
/// Built defensively from a [StatisticResult] because the statistics API is
/// config-driven: the dashboard renders whatever the catalog lists and has
/// never pinned down the payload keys. The same tolerance the KPI chart
/// applies is applied here, so a rename on the server degrades this tile to
/// hidden rather than to a wrong number.
class RevenueSummary {
  const RevenueSummary({
    required this.value,
    this.previous,
    this.changePercent,
    this.currencyCode,
    this.recentDaily = const [],
  });

  final double value;
  final double? previous;

  /// Movement against the previous period, when the API sends one.
  final double? changePercent;

  /// Never inferred. A tile with no currency from the server shows the
  /// number alone rather than implying one.
  final String? currencyCode;

  /// The most recent points of the revenue series, oldest first, for the
  /// trend bars. Empty when the catalog offers no series to draw - the bars
  /// then render flat rather than inventing a shape.
  final List<double> recentDaily;

  /// A period the server reported as having no rows at all.
  ///
  /// Zero takings is a fact about the month, not a gap in the data, so it
  /// gets a tile like any other figure. No currency, because an empty
  /// payload carries none and inventing one would be a guess.
  const RevenueSummary.empty()
    : value = 0,
      previous = null,
      changePercent = null,
      currencyCode = null,
      recentDaily = const [];

  /// The same figure with trend points attached - used when the headline and
  /// the series arrive from two different metrics.
  RevenueSummary withSeries(List<double> points) => RevenueSummary(
    value: value,
    previous: previous,
    changePercent: changePercent,
    currencyCode: currencyCode,
    recentDaily: points,
  );

  static const List<String> revenueKeys = ['revenue', 'income', 'earnings'];

  /// Total of a series payload, when the metric is a chart rather than a
  /// single figure.
  ///
  /// A revenue-vs-expenses chart sends `{labels, revenue, expenses}`, so the
  /// series is picked by name rather than by position - summing whichever
  /// list came first would happily report the expenses as income. Only when
  /// the metric itself is already known to be about revenue does a plain
  /// `{labels, values}` payload get summed, and that is what
  /// [sumPlainSeries] gates.
  static double? _seriesTotal(Object? data, {required bool sumPlainSeries}) {
    if (data is! Map) return null;

    for (final entry in data.entries) {
      final key = entry.key.toString().toLowerCase();
      final value = entry.value;
      if (key == 'labels' || value is! List) continue;
      if (revenueKeys.any(key.contains)) return _sum(value);
    }

    if (sumPlainSeries) {
      final values = data['values'];
      if (values is List) return _sum(values);
    }
    return null;
  }

  static double _sum(List<dynamic> raw) {
    var total = 0.0;
    for (final v in raw) {
      if (v is num) {
        total += v.toDouble();
      } else if (v is String) {
        total += double.tryParse(v) ?? 0;
      }
    }
    return total;
  }

  /// Null when the payload carries no usable amount - an empty period, or a
  /// shape this cannot read. Either way there is nothing to show.
  /// The last [count] points of a revenue series, oldest first.
  ///
  /// Reads the same payloads [_seriesTotal] does, so a revenue-vs-expenses
  /// chart yields its revenue line and not its expenses line.
  static List<double> seriesPoints(Object? data, {int count = 7}) {
    if (data is! Map) return const [];

    List<dynamic>? chosen;
    for (final entry in data.entries) {
      final key = entry.key.toString().toLowerCase();
      if (key == 'labels' || entry.value is! List) continue;
      if (revenueKeys.any(key.contains)) {
        chosen = entry.value as List;
        break;
      }
    }
    chosen ??= data['values'] is List ? data['values'] as List : null;
    if (chosen == null) return const [];

    final points = [
      for (final v in chosen)
        if (v is num)
          v.toDouble()
        else if (v is String)
          double.tryParse(v) ?? 0
        else
          0.0,
    ];
    return points.length <= count
        ? points
        : points.sublist(points.length - count);
  }

  static RevenueSummary? from(
    StatisticResult result, {
    bool sumPlainSeries = false,
    List<double> recentDaily = const [],
  }) {
    final sources = <Map<String, dynamic>>[
      result.dataMap,
      result.primaryRow,
      result.meta,
    ];

    double? pickNumber(List<String> keys) {
      for (final source in sources) {
        for (final key in keys) {
          final raw = source[key];
          if (raw is num) return raw.toDouble();
          if (raw is String) {
            final parsed = double.tryParse(raw);
            if (parsed != null) return parsed;
          }
        }
      }
      return null;
    }

    String? pickString(List<String> keys) {
      for (final source in sources) {
        for (final key in keys) {
          final raw = source[key];
          if (raw is String && raw.isNotEmpty) return raw;
          if (raw is Map && raw['code'] is String) return raw['code'] as String;
        }
      }
      return null;
    }

    // A KPI sends one figure; a chart sends the points behind it. Both are
    // legitimate answers to "what did the clinic take this month", so both
    // are read - the scalar first, because it is the server's own total
    // rather than one this app added up.
    final value =
        pickNumber(const [
          'value',
          'current',
          'current_value',
          'total',
          'amount',
        ]) ??
        _seriesTotal(result.data, sumPlainSeries: sumPlainSeries);
    if (value == null) return null;

    return RevenueSummary(
      value: value,
      previous: pickNumber(const [
        'previous',
        'previous_value',
        'previous_period',
        'comparison',
      ]),
      changePercent: pickNumber(const [
        // The live backend sends `percentage_change`; the two spellings below
        // it are the ones earlier catalogs used.
        'percentage_change',
        'change_percentage',
        'change_percent',
        'percentage',
        'growth',
        'change',
      ]),
      currencyCode: pickString(const [
        'currency_code',
        'currencyCode',
        'currency',
      ]),
      recentDaily: recentDaily,
    );
  }
}
