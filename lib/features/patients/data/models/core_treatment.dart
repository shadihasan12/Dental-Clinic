class CoreTreatment {
  final String id;
  final String standardName;
  final String category;
  final bool isActive;

  const CoreTreatment({
    required this.id,
    required this.standardName,
    required this.category,
    required this.isActive,
  });

  factory CoreTreatment.fromJson(Map<String, dynamic> json) {
    return CoreTreatment(
      id: json['id'] as String,
      standardName: json['standard_name'] as String,
      category: json['category'] as String,
      isActive: json['is_active'] as bool? ?? true,
    );
  }

  /// Formats "ROOT_CANAL" → "Root Canal" for display
  String get displayName {
    return standardName
        .split('_')
        .map((w) => w[0].toUpperCase() + w.substring(1).toLowerCase())
        .join(' ');
  }
}
