/// What one plan includes, from `GET /plans/{id}/features`.
///
/// Both halves are maps of group key -> entries, the same grouping the
/// permissions list uses. Render each group as a section, titled by
/// [groupTitle].
class PlanFeaturesEntity {
  const PlanFeaturesEntity({
    required this.features,
    required this.limits,
    this.groupNames = const {},
  });

  final Map<String, List<PlanFeatureEntity>> features;

  /// Same shape, each entry carrying [PlanFeatureEntity.limitValue].
  final Map<String, List<PlanFeatureEntity>> limits;

  /// Group key -> its name in the reader's language.
  final Map<String, String> groupNames;

  /// The section title for a group: its translated name, else the key.
  String groupTitle(String key) => groupNames[key] ?? key;

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

  /// Already formatted, in the reader's language. Displayed, never parsed.
  final String? limitValue;
}
