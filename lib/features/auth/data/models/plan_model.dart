import 'package:dental_clinic_app/features/auth/domain/entities/plan_entity.dart';

/// Data model for price with JSON serialization
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
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      display: json['display'] as String,
    );
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'currency': currency,
      'display': display,
    };
  }

  /// Convert model to domain entity
  PriceEntity toEntity() {
    return PriceEntity(
      amount: amount,
      currency: currency,
      display: display,
    );
  }

  /// Create model from domain entity
  factory PriceModel.fromEntity(PriceEntity entity) {
    return PriceModel(
      amount: entity.amount,
      currency: entity.currency,
      display: entity.display,
    );
  }
}

/// Data model for subscription plan with JSON serialization
class PlanModel {
  final String id;
  final String versionId;
  final String name;
  final String description;
  final List<PriceModel> priceMonthly;
  final List<PriceModel> priceYearly;
  final bool supportsTrial;
  final int trialPeriodDays;
  final int gracePeriodDays;
  final String clinicType;
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
    required this.clinicType,
    required this.type,
    required this.sortOrder,
  });

  /// Create model from JSON
  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
      id: json['id'] as String,
      versionId: json['version_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      priceMonthly: (json['price_monthly'] as List)
          .map((e) => PriceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      priceYearly: (json['price_yearly'] as List)
          .map((e) => PriceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      supportsTrial: json['supports_trial'] as bool,
      trialPeriodDays: json['trial_period_days'] as int,
      gracePeriodDays: json['grace_period_days'] as int,
      clinicType: json['clinic_type'] as String,
      type: json['type'] as String,
      sortOrder: json['sort_order'] as int,
    );
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'version_id': versionId,
      'name': name,
      'description': description,
      'price_monthly': priceMonthly.map((e) => e.toJson()).toList(),
      'price_yearly': priceYearly.map((e) => e.toJson()).toList(),
      'supports_trial': supportsTrial,
      'trial_period_days': trialPeriodDays,
      'grace_period_days': gracePeriodDays,
      'clinic_type': clinicType,
      'type': type,
      'sort_order': sortOrder,
    };
  }

  /// Convert model to domain entity
  PlanEntity toEntity() {
    return PlanEntity(
      id: id,
      versionId: versionId,
      name: name,
      description: description,
      priceMonthly: priceMonthly.map((e) => e.toEntity()).toList(),
      priceYearly: priceYearly.map((e) => e.toEntity()).toList(),
      supportsTrial: supportsTrial,
      trialPeriodDays: trialPeriodDays,
      gracePeriodDays: gracePeriodDays,
      clinicType: clinicType,
      type: type,
      sortOrder: sortOrder,
    );
  }

  /// Create model from domain entity
  factory PlanModel.fromEntity(PlanEntity entity) {
    return PlanModel(
      id: entity.id,
      versionId: entity.versionId,
      name: entity.name,
      description: entity.description,
      priceMonthly: entity.priceMonthly.map((e) => PriceModel.fromEntity(e)).toList(),
      priceYearly: entity.priceYearly.map((e) => PriceModel.fromEntity(e)).toList(),
      supportsTrial: entity.supportsTrial,
      trialPeriodDays: entity.trialPeriodDays,
      gracePeriodDays: entity.gracePeriodDays,
      clinicType: entity.clinicType,
      type: entity.type,
      sortOrder: entity.sortOrder,
    );
  }
}
