import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_plan_entity.dart';

class SubscriptionPlanModel {
  final String id;
  final String tier;
  final String name;
  final String description;
  final double monthlyPrice;
  final double yearlyPrice;
  final int maxDentists;
  final int maxAssistants;
  final int maxBranches;
  final List<String> features;
  final List<String> limitations;
  final bool isPopular;
  final bool isActive;

  SubscriptionPlanModel({
    required this.id,
    required this.tier,
    required this.name,
    required this.description,
    required this.monthlyPrice,
    required this.yearlyPrice,
    required this.maxDentists,
    required this.maxAssistants,
    required this.maxBranches,
    required this.features,
    required this.limitations,
    this.isPopular = false,
    this.isActive = true,
  });

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlanModel(
      id: json['id'] as String,
      tier: json['tier'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      monthlyPrice: (json['monthly_price'] as num).toDouble(),
      yearlyPrice: (json['yearly_price'] as num).toDouble(),
      maxDentists: json['max_dentists'] as int,
      maxAssistants: json['max_assistants'] as int,
      maxBranches: json['max_branches'] as int,
      features: List<String>.from(json['features'] as List),
      limitations: List<String>.from(json['limitations'] as List),
      isPopular: json['is_popular'] as bool? ?? false,
      isActive: json['is_active'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tier': tier,
      'name': name,
      'description': description,
      'monthly_price': monthlyPrice,
      'yearly_price': yearlyPrice,
      'max_dentists': maxDentists,
      'max_assistants': maxAssistants,
      'max_branches': maxBranches,
      'features': features,
      'limitations': limitations,
      'is_popular': isPopular,
      'is_active': isActive,
    };
  }

  static PlanTier _parseTier(String tier) {
    switch (tier) {
      case 'trial':
        return PlanTier.trial;
      case 'solo':
        return PlanTier.solo;
      case 'duo':
        return PlanTier.duo;
      case 'clinic':
        return PlanTier.clinic;
      case 'practice':
        return PlanTier.practice;
      case 'custom':
        return PlanTier.custom;
      default:
        return PlanTier.solo;
    }
  }

  SubscriptionPlanEntity toEntity() {
    return SubscriptionPlanEntity(
      id: id,
      tier: _parseTier(tier),
      name: name,
      description: description,
      monthlyPrice: monthlyPrice,
      yearlyPrice: yearlyPrice,
      maxDentists: maxDentists,
      maxAssistants: maxAssistants,
      maxBranches: maxBranches,
      features: features,
      limitations: limitations,
      isPopular: isPopular,
      isActive: isActive,
    );
  }

  factory SubscriptionPlanModel.fromEntity(SubscriptionPlanEntity entity) {
    return SubscriptionPlanModel(
      id: entity.id,
      tier: entity.tier.name,
      name: entity.name,
      description: entity.description,
      monthlyPrice: entity.monthlyPrice,
      yearlyPrice: entity.yearlyPrice,
      maxDentists: entity.maxDentists,
      maxAssistants: entity.maxAssistants,
      maxBranches: entity.maxBranches,
      features: entity.features,
      limitations: entity.limitations,
      isPopular: entity.isPopular,
      isActive: entity.isActive,
    );
  }
}
