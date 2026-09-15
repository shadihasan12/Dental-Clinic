/// What a single card in the Home carousel is about.
enum HomeStatKind {
  /// Patients registered at the clinic.
  patients,

  /// Money taken, in one currency. There is one of these per currency the
  /// clinic actually bills in, so a clinic that only ever charges in SYP
  /// gets one revenue card and not an empty USD one.
  revenue,
}

/// One card's worth of numbers.
///
/// Currency lives on the stat rather than on the summary because the point of
/// splitting revenue per currency is that the two totals must never be added
/// together - a clinic taking 4,000 USD and 12,000,000 SYP has no meaningful
/// single "revenue" figure, and showing one would be a lie in whichever
/// currency the label claimed.
class HomeStat {
  const HomeStat({
    required this.kind,
    required this.value,
    this.currencyCode,
    this.changePercent,
    this.newInPeriod,
    this.recentDaily = const [],
  });

  final HomeStatKind kind;

  /// The headline figure: the clinic's patient count, or the period's takings
  /// in [currencyCode].
  final double value;

  /// Set on revenue stats only, and only when the server named one. Never
  /// inferred - a guessed symbol on a money figure is worse than no symbol.
  final String? currencyCode;

  /// Movement against the previous period, when the server sends one.
  final double? changePercent;

  /// Patients added during the period. Null when the server did not say, in
  /// which case the card shows the total alone rather than an invented zero.
  final int? newInPeriod;

  /// The last seven days of the underlying series, oldest first, for the
  /// trend bars. Empty means "no series", and the bars then sit flat rather
  /// than borrowing a shape from somewhere else.
  final List<double> recentDaily;

  bool get isRevenue => kind == HomeStatKind.revenue;
}

/// Everything the Home carousel renders, in the order it renders it.
///
/// The list is the server's: it decides how many revenue currencies a clinic
/// has, and the carousel draws one card per entry. Today that is three cards
/// (patients, USD, SYP); a clinic that adds a third currency gets a fourth
/// card with no app release.
class HomeSummary {
  const HomeSummary({required this.stats});

  const HomeSummary.empty() : stats = const [];

  final List<HomeStat> stats;

  bool get isEmpty => stats.isEmpty;
}
