import '../../domain/entities/home_summary.dart';

/// Parses `GET /clinics/home-summary`.
///
/// Tolerant in the same way the statistics models are: every figure is read
/// through [_toDouble], so a backend that sends `"4180.50"` as a string - which
/// is what a decimal column serialised by an ORM often becomes - still lands a
/// number rather than silently zeroing the card.
class HomeSummaryModel {
  HomeSummaryModel._();

  static HomeSummary fromJson(Map<String, dynamic> json) {
    final stats = <HomeStat>[];

    final patients = json['patients'];
    if (patients is Map<String, dynamic>) {
      final total = _toDouble(patients['total']);
      if (total != null) {
        stats.add(
          HomeStat(
            kind: HomeStatKind.patients,
            value: total,
            changePercent: _toDouble(patients['change_percentage']),
            newInPeriod: _toDouble(patients['new_in_period'])?.round(),
            recentDaily: _series(patients['recent_daily']),
          ),
        );
      }
    }

    // Order is the server's and is preserved: it decides which currency the
    // owner sees first, which is a business call (the one they price in) and
    // not something the app should sort alphabetically.
    final revenues = json['revenues'];
    if (revenues is List) {
      for (final raw in revenues) {
        if (raw is! Map<String, dynamic>) continue;
        final total = _toDouble(raw['total']);
        if (total == null) continue;
        final code = raw['currency_code'];
        stats.add(
          HomeStat(
            kind: HomeStatKind.revenue,
            value: total,
            currencyCode: code is String && code.isNotEmpty ? code : null,
            changePercent: _toDouble(raw['change_percentage']),
            recentDaily: _series(raw['recent_daily']),
          ),
        );
      }
    }

    return HomeSummary(stats: stats);
  }

  static double? _toDouble(Object? raw) {
    if (raw is num) return raw.toDouble();
    if (raw is String) return double.tryParse(raw);
    return null;
  }

  /// Oldest first, at most the last seven points. A malformed entry reads as
  /// zero rather than dropping out, so the bars stay aligned to days.
  static List<double> _series(Object? raw) {
    if (raw is! List) return const [];
    final points = [for (final v in raw) _toDouble(v) ?? 0.0];
    return points.length <= 7 ? points : points.sublist(points.length - 7);
  }
}
