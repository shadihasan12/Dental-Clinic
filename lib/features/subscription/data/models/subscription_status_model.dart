import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_status_entity.dart';

class SubscriptionStatusModel {
  final String planName;
  final String status;
  final bool isTrial;
  final bool isExpired;
  final bool isInGracePeriod;
  final int? remainingDays;
  final DateTime? startsAt;
  final DateTime? endsAt;
  final DateTime? graceEndsAt;
  final String? billingPeriod;

  const SubscriptionStatusModel({
    required this.planName,
    required this.status,
    required this.isTrial,
    this.isExpired = false,
    this.isInGracePeriod = false,
    this.remainingDays,
    this.startsAt,
    this.endsAt,
    this.graceEndsAt,
    this.billingPeriod,
  });

  factory SubscriptionStatusModel.fromJson(Map<String, dynamic> json) {
    final status = (json['status'] ?? '').toString();
    final plan = json['plan'] as Map<String, dynamic>?;

    return SubscriptionStatusModel(
      planName: (plan?['name'] ?? '').toString(),
      status: status,
      isTrial: status.toUpperCase() == 'TRIALING',
      isExpired: json['is_expired'] as bool? ?? false,
      isInGracePeriod: json['is_in_grace_period'] as bool? ?? false,
      remainingDays: (json['remaining_days'] as num?)?.toInt(),
      startsAt: _parseDate(json['starts_at']),
      endsAt: _parseDate(json['subscription_ends']),
      graceEndsAt: _parseDate(json['grace_ends_at']),
      billingPeriod: json['billing_period'] as String?,
    );
  }

  SubscriptionStatusEntity toEntity() => SubscriptionStatusEntity(
        planName: planName,
        status: status,
        isTrial: isTrial,
        isExpired: isExpired,
        isInGracePeriod: isInGracePeriod,
        remainingDays: remainingDays,
        startsAt: startsAt,
        endsAt: endsAt,
        graceEndsAt: graceEndsAt,
        billingPeriod: billingPeriod,
      );

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }
}
