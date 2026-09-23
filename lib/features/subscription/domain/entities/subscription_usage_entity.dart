/// Usage metric for one resource (members, storage…).
///
/// `limit == null` means unlimited. `unit` is the display suffix (e.g. "MB"),
/// or empty for plain counts.
class UsageMetric {
  final String key;
  final num used;
  final num? limit;
  final String unit;

  /// The server's own verdict (`users_reached` and the like), preferred over
  /// comparing [used] and [limit] here.
  final bool reached;

  const UsageMetric({
    required this.key,
    required this.used,
    this.limit,
    this.unit = '',
    this.reached = false,
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

  /// One seat limit for every member of the clinic, the owner included,
  /// whatever their roles. There is no separate dentist or secretary cap.
  UsageMetric? get users => metric('users');

  UsageMetric? get storage => metric('storage');

  /// Adding a member will be refused with a 409 - say so before the form.
  bool get usersReached => users?.reached ?? false;
}
