import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_usage_entity.dart';

class SubscriptionUsageModel {
  final List<UsageMetric> metrics;

  const SubscriptionUsageModel({required this.metrics});

  /// Parses the flat `max_<resource>` / `current_<resource>` shape:
  ///   { "max_dentists": 1, "current_dentists": 1, ...,
  ///     "max_storage_mb": 1024, "current_storage_mb": 0, ... }
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
      final limit = entry.value as num?;

      metrics.add(UsageMetric(key: key, used: used, limit: limit, unit: unit));
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
