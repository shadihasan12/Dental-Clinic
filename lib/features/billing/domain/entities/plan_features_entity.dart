/// What one plan includes, from `GET /plans/{id}/features`.
///
/// Both halves are maps of group name -> entries, the same grouping the
/// permissions list uses. Render each group as a section.
class PlanFeaturesEntity {
  const PlanFeaturesEntity({required this.features, required this.limits});

  final Map<String, List<PlanFeatureEntity>> features;

  /// Same shape, each entry carrying [PlanFeatureEntity.limitValue].
  final Map<String, List<PlanFeatureEntity>> limits;

  bool get isEmpty => features.isEmpty && limits.isEmpty;
}

class PlanFeatureEntity {
  const PlanFeatureEntity({
    required this.slug,
    required this.name,
    required this.isTrialFeature,
    required this.sortOrder,
    this.description,
    this.limitValue,
  });

  final String slug;
  final String name;
  final String? description;

  /// False: the plan includes it, but a clinic on trial cannot use it yet.
  final bool isTrialFeature;
  final int sortOrder;

  /// Already formatted - `"8 Members"`, `"5120 MB"`. Displayed, never parsed.
  final String? limitValue;
}
