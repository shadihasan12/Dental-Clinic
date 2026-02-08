import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan_entity.freezed.dart';

/// Represents a single price in a specific currency
@freezed
class PriceEntity with _$PriceEntity {
  const factory PriceEntity({
    required double amount,
    required String currency,
    required String display,
  }) = _PriceEntity;

  const PriceEntity._();

  /// Format for UI display
  String get formattedDisplay => display;
}

/// Domain entity representing a subscription plan
@freezed
class PlanEntity with _$PlanEntity {
  const factory PlanEntity({
    required String id,
    required String versionId,
    required String name,
    required String description,
    required List<PriceEntity> priceMonthly,
    required List<PriceEntity> priceYearly,
    required bool supportsTrial,
    required int trialPeriodDays,
    required int gracePeriodDays,
    required String clinicType,
    required String type,
    required int sortOrder,
  }) = _PlanEntity;

  const PlanEntity._();

  /// Get monthly price for a specific currency (defaults to first currency)
  PriceEntity getMonthlyPrice([String? currency]) {
    if (currency == null) return priceMonthly.first;
    return priceMonthly.firstWhere(
      (price) => price.currency == currency,
      orElse: () => priceMonthly.first,
    );
  }

  /// Get yearly price for a specific currency (defaults to first currency)
  PriceEntity getYearlyPrice([String? currency]) {
    if (currency == null) return priceYearly.first;
    return priceYearly.firstWhere(
      (price) => price.currency == currency,
      orElse: () => priceYearly.first,
    );
  }

  /// Calculate yearly savings in specific currency
  double getYearlySavings([String? currency]) {
    final monthly = getMonthlyPrice(currency);
    final yearly = getYearlyPrice(currency);
    return (monthly.amount * 12) - yearly.amount;
  }

  /// Get trial description
  String get trialDescription =>
      supportsTrial ? '$trialPeriodDays-day free trial' : 'No trial';
}
