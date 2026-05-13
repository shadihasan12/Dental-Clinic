/// Time window the statistics page is currently showing.
///
/// Backends must accept this as a `period` query parameter and respond
/// with a payload whose buckets match the period (7 days / 30 days /
/// 12 months). See `BACKEND_API.md`.
enum StatisticsPeriod {
  week,
  month,
  year,
}

extension StatisticsPeriodX on StatisticsPeriod {
  /// The wire value sent to the API.
  String get apiValue {
    switch (this) {
      case StatisticsPeriod.week:
        return 'week';
      case StatisticsPeriod.month:
        return 'month';
      case StatisticsPeriod.year:
        return 'year';
    }
  }
}
