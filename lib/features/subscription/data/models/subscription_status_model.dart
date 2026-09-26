import 'package:dental_clinic_app/features/auth/data/models/plan_model.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/plan_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_status_entity.dart';
import 'package:dental_clinic_app/services/subscription_guard/access_mode.dart';

class SubscriptionStatusModel {
  final String? planId;
  final String planName;
  final String status;
  final String? accessMode;
  final bool isExpired;
  final bool isInGracePeriod;
  final int? remainingDays;
  final DateTime? startsAt;
  final DateTime? endsAt;
  final DateTime? graceEndsAt;
  final String? billingPeriod;
  final int? durationQuantity;
  final NextCycleEntity? nextCycle;
  final double balanceUsd;
  final List<PriceEntity> balanceAmounts;

  const SubscriptionStatusModel({
    this.planId,
    required this.planName,
    required this.status,
    this.accessMode,
    this.isExpired = false,
    this.isInGracePeriod = false,
    this.remainingDays,
    this.startsAt,
    this.endsAt,
    this.graceEndsAt,
    this.billingPeriod,
    this.durationQuantity,
    this.nextCycle,
    this.balanceUsd = 0,
    this.balanceAmounts = const [],
  });

  factory SubscriptionStatusModel.fromJson(Map<String, dynamic> json) {
    final plan = json['plan'] as Map<String, dynamic>?;

    return SubscriptionStatusModel(
      planId: plan?['id'] as String?,
      planName: (plan?['name'] ?? '').toString(),
      status: (json['status'] ?? '').toString(),
      accessMode: json['access_mode'] as String?,
      isExpired: json['is_expired'] as bool? ?? false,
      isInGracePeriod: json['is_in_grace_period'] as bool? ?? false,
      remainingDays: (json['remaining_days'] as num?)?.toInt(),
      startsAt: _parseDate(json['starts_at']),
      endsAt: _parseDate(json['subscription_ends']),
      graceEndsAt: _parseDate(json['grace_ends_at']),
      billingPeriod: json['billing_period'] as String?,
      durationQuantity: (json['duration_quantity'] as num?)?.toInt(),
      nextCycle: _nextCycle(json['next_cycle']),
      balanceUsd: (json['balance_usd'] as num?)?.toDouble() ?? 0,
      balanceAmounts: PriceModel.listFromJson(json['balance_amounts']),
    );
  }

  static NextCycleEntity? _nextCycle(dynamic json) {
    if (json is! Map<String, dynamic>) return null;
    final plan = json['plan'] as Map<String, dynamic>? ?? const {};
    final addons = json['addons'];
    return NextCycleEntity(
      planId: plan['id'] as String?,
      planVersionId: plan['version_id'] as String?,
      planName: (plan['name'] ?? '').toString(),
      billingPeriod: json['billing_period'] as String?,
      durationQuantity: (json['duration_quantity'] as num?)?.toInt() ?? 1,
      startsAt: _parseDate(json['starts_at']),
      endsAt: _parseDate(json['ends_at']),
      addons: [
        if (addons is List)
          for (final a in addons.whereType<Map<String, dynamic>>())
            (
              name: (a['name'] ?? '').toString(),
              quantity: (a['quantity'] as num?)?.toInt() ?? 0,
            ),
      ],
      paidUsd: (json['paid_usd'] as num?)?.toDouble(),
      invoiceId: json['invoice_id'] as String?,
    );
  }

  SubscriptionStatusEntity toEntity() => SubscriptionStatusEntity(
        planId: planId,
        planName: planName,
        status: status,
        accessMode: AccessMode.fromApi(accessMode),
        isExpired: isExpired,
        isInGracePeriod: isInGracePeriod,
        remainingDays: remainingDays,
        startsAt: startsAt,
        endsAt: endsAt,
        graceEndsAt: graceEndsAt,
        billingPeriod: billingPeriod,
        durationQuantity: durationQuantity,
        nextCycle: nextCycle,
        balanceUsd: balanceUsd,
        balanceAmounts: balanceAmounts,
      );

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }
}
