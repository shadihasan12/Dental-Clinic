import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_usage_entity.dart';

class SubscriptionUsageModel {
  final List<UsageMetric> metrics;

  const SubscriptionUsageModel({required this.metrics});

  /// Parses the flat `max_<resource>` / `current_<resource>` /
  /// `<resource>_reached` shape:
  ///   { "max_users": 2, "current_users": 1, "remaining_users": 1,
  ///     "users_reached": false, "max_storage_mb": 1024, ... }
  ///
  /// A `_mb` suffix is stripped from the resource name and surfaced as the
  /// metric's display unit, so callers look up `'storage'` regardless of how
  /// the API names the unit-bearing fields.
  factory SubscriptionUsageModel.fromJson(Map<String, dynamic> json) {
    final metrics = <UsageMetric>[];

    for (final entry in json.entries) {
      if (!entry.key.startsWith('max_')) continue;

      final rawResource = entry.key.substring(4);
      final (key, unit) = _splitUnit(rawResource);
      final used = (json['current_$rawResource'] as num?) ?? 0;
      final raw = entry.value as num?;
      // API uses -1 to mean "unlimited" (in addition to null).
      final limit = (raw == null || raw < 0) ? null : raw;
      final reached =
          json['${key}_reached'] as bool? ?? (limit != null && used >= limit);

      metrics.add(UsageMetric(
        key: key,
        used: used,
        limit: limit,
        unit: unit,
        reached: reached,
      ));
    }

    return SubscriptionUsageModel(metrics: metrics);
  }

  static (String key, String unit) _splitUnit(String rawResource) {
    if (rawResource.endsWith('_mb')) {
      return (rawResource.substring(0, rawResource.length - 3), 'MB');
    }
    if (rawResource.endsWith('_gb')) {
      return (rawResource.substring(0, rawResource.length - 3), 'GB');
    }
    return (rawResource, '');
  }

  SubscriptionUsageEntity toEntity() =>
      SubscriptionUsageEntity(metrics: metrics);
}
