import 'package:dental_clinic_app/features/auth/domain/entities/plan_entity.dart';

/// One figure in one currency: `{ "amount": 719640, "currency": "SYP",
/// "display": "SYP 719,640" }`.
///
/// The backend holds every sum in USD and sends this array wherever a figure
/// is shown - plan prices, quotes, what is left on an invoice - converted at
/// today's rate. The app shows `display` and never converts anything itself.
class PriceModel {
  final double amount;
  final String currency;
  final String display;

  PriceModel({
    required this.amount,
    required this.currency,
    required this.display,
  });

  /// Create model from JSON
  factory PriceModel.fromJson(Map<String, dynamic> json) {
    return PriceModel(
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
      currency: (json['currency'] ?? '').toString(),
      display: (json['display'] ?? '').toString(),
    );
  }

  /// Parses an `amounts` array straight to entities; anything that is not a
  /// list comes back empty.
  static List<PriceEntity> listFromJson(dynamic json) {
    if (json is! List) return const [];
    return json
        .whereType<Map<String, dynamic>>()
        .map((e) => PriceModel.fromJson(e).toEntity())
        .toList();
  }

  /// Convert model to domain entity
  PriceEntity toEntity() {
    return PriceEntity(
      amount: amount,
      currency: currency,
      display: display,
    );
  }
}

/// Data model for subscription plan with JSON serialization.
///
/// `id` is the plan; `version_id` is the priced version of it on sale today,
/// and is what every purchase and every quote sends as `plan_version_id`.
/// A plan carries no clinic type any more - every clinic sees every plan.
class PlanModel {
  final String id;
  final String versionId;
  final String name;
  final String description;
  final List<PriceEntity> priceMonthly;
  final List<PriceEntity> priceYearly;
  final bool supportsTrial;
  final int trialPeriodDays;
  final int gracePeriodDays;
  final String type;
  final int sortOrder;

  PlanModel({
    required this.id,
    required this.versionId,
    required this.name,
    required this.description,
    required this.priceMonthly,
    required this.priceYearly,
    required this.supportsTrial,
    required this.trialPeriodDays,
    required this.gracePeriodDays,
    required this.type,
    required this.sortOrder,
  });

  /// Create model from JSON
  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
      id: json['id'] as String,
      versionId: json['version_id'] as String,
      name: (json['name'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      priceMonthly: PriceModel.listFromJson(json['price_monthly']),
      priceYearly: PriceModel.listFromJson(json['price_yearly']),
      supportsTrial: json['supports_trial'] as bool? ?? false,
      trialPeriodDays: (json['trial_period_days'] as num?)?.toInt() ?? 0,
      gracePeriodDays: (json['grace_period_days'] as num?)?.toInt() ?? 0,
      type: (json['type'] ?? 'MAIN').toString(),
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
    );
  }

  /// Convert model to domain entity
  PlanEntity toEntity() {
    return PlanEntity(
      id: id,
      versionId: versionId,
      name: name,
      description: description,
      priceMonthly: priceMonthly,
      priceYearly: priceYearly,
      supportsTrial: supportsTrial,
      trialPeriodDays: trialPeriodDays,
      gracePeriodDays: gracePeriodDays,
      type: type,
      sortOrder: sortOrder,
    );
  }
}
