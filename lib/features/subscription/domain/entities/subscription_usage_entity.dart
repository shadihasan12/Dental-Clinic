/// Usage metric for one resource (dentists, secretaries, storage…).
///
/// `limit == null` means unlimited. `unit` is the display suffix (e.g. "MB"),
/// or empty for plain counts.
class UsageMetric {
  final String key;
  final num used;
  final num? limit;
  final String unit;

  const UsageMetric({
    required this.key,
    required this.used,
    this.limit,
    this.unit = '',
  });

  bool get isUnlimited => limit == null;

  double get progress {
    if (limit == null || limit == 0) return 0;
    return (used / limit!).clamp(0, 1).toDouble();
  }
}

/// Usage data for the current subscription.
class SubscriptionUsageEntity {
  final List<UsageMetric> metrics;

  const SubscriptionUsageEntity({required this.metrics});

  UsageMetric? metric(String key) {
    for (final m in metrics) {
      if (m.key == key) return m;
    }
    return null;
  }
}
