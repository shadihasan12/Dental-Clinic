import 'package:equatable/equatable.dart';

class Plan extends Equatable {
  final int id;
  final String name;
  final String description;
  final String priceMonthly;
  final String priceYearly;
  final int maxUsers;
  final int maxPatients;
  final int maxStorageMb;
  final bool supportsTrial;
  final int trialPeriodDays;
  final bool isActive;
  final DateTime createdAt;

  const Plan({
    required this.id,
    required this.name,
    required this.description,
    required this.priceMonthly,
    required this.priceYearly,
    required this.maxUsers,
    required this.maxPatients,
    required this.maxStorageMb,
    required this.supportsTrial,
    required this.trialPeriodDays,
    required this.isActive,
    required this.createdAt,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      priceMonthly: json['price_monthly'] as String,
      priceYearly: json['price_yearly'] as String,
      maxUsers: json['max_users'] as int,
      maxPatients: json['max_patients'] as int,
      maxStorageMb: json['max_storage_mb'] as int,
      supportsTrial: json['supports_trial'] == 1,
      trialPeriodDays: json['trial_period_days'] as int,
      isActive: json['is_active'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price_monthly': priceMonthly,
      'price_yearly': priceYearly,
      'max_users': maxUsers,
      'max_patients': maxPatients,
      'max_storage_mb': maxStorageMb,
      'supports_trial': supportsTrial ? 1 : 0,
      'trial_period_days': trialPeriodDays,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
    };
  }

  /// Get storage display string (e.g., "512 MB" or "10 GB")
  String get storageDisplay {
    if (maxStorageMb >= 1024) {
      final gb = maxStorageMb / 1024;
      return '${gb.toStringAsFixed(gb.truncateToDouble() == gb ? 0 : 1)} GB';
    }
    return '$maxStorageMb MB';
  }

  /// Get patients display string (e.g., "500" or "Unlimited")
  String get patientsDisplay {
    return maxPatients >= 10000 ? 'Unlimited' : '$maxPatients';
  }

  /// Get users display string (e.g., "12" or "Unlimited")
  String get usersDisplay {
    return maxUsers >= 100 ? 'Unlimited' : '$maxUsers';
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        priceMonthly,
        priceYearly,
        maxUsers,
        maxPatients,
        maxStorageMb,
        supportsTrial,
        trialPeriodDays,
        isActive,
        createdAt,
      ];
}