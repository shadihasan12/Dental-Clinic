import 'package:dental_clinic_app/features/auth/domain/entities/plan_entity.dart';

/// One add-on on sale - an extra seat, or 1 GB of storage - with the units
/// the clinic holds, from `GET /subscriptions/addons`.
class AddonEntity {
  const AddonEntity({
    required this.planId,
    required this.versionId,
    required this.slug,
    required this.name,
    required this.limit,
    required this.unitValue,
    required this.priceMonthly,
    required this.priceYearly,
    required this.priceMonthlyUsd,
    required this.priceYearlyUsd,
    required this.ownedUnits,
    required this.canBuy,
    this.description,
    this.nextCycleUnits,
    this.reason,
  });

  final String planId;

  /// What is bought, and sent as `plan_version_id`.
  final String versionId;

  /// Stable: `seats-addon`, `storage-addon`.
  final String slug;
  final String name;
  final String? description;

  /// The ceiling one unit raises: `max-users` or `max-storage-mb`.
  final String limit;

  /// What one unit adds to [limit]: one seat, or 1024 MB.
  final int unitValue;

  /// Per unit, in every currency the app offers. Placeholders today - read,
  /// never hard-coded.
  final List<PriceEntity> priceMonthly;
  final List<PriceEntity> priceYearly;
  final double priceMonthlyUsd;
  final double priceYearlyUsd;

  /// Units held now.
  final int ownedUnits;

  /// Units the next cycle was bought with; null when none is paid for.
  final int? nextCycleUnits;

  /// Whether units can be bought now, and - when not - why.
  final bool canBuy;
  final String? reason;

  bool get isSeats => limit == 'max-users';
}
