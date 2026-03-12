class TreatmentCategory {
  final String id;
  final String slug;
  final String name;
  final String? specialty;

  const TreatmentCategory({
    required this.id,
    required this.slug,
    required this.name,
    this.specialty,
  });

  factory TreatmentCategory.fromJson(Map<String, dynamic> json) {
    return TreatmentCategory(
      id: json['id'] as String,
      slug: json['slug'] as String? ?? '',
      name: json['name'] as String,
      specialty: json['specialty'] as String?,
    );
  }
}

class CoreTreatment {
  final String id;
  final String name;
  final String? icon;
  final TreatmentCategory category;

  const CoreTreatment({
    required this.id,
    required this.name,
    this.icon,
    required this.category,
  });

  factory CoreTreatment.fromJson(Map<String, dynamic> json) {
    return CoreTreatment(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String?,
      category: TreatmentCategory.fromJson(
        json['category'] as Map<String, dynamic>,
      ),
    );
  }

  String get displayName => name;
}
