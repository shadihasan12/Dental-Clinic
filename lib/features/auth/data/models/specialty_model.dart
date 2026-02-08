import 'package:dental_clinic_app/features/auth/domain/entities/specialty_entity.dart';

/// Data model for specialty with JSON serialization
class SpecialtyModel {
  final String id;
  final String name;

  SpecialtyModel({
    required this.id,
    required this.name,
  });

  /// Create model from JSON
  factory SpecialtyModel.fromJson(Map<String, dynamic> json) {
    return SpecialtyModel(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  /// Convert model to domain entity
  SpecialtyEntity toEntity() {
    return SpecialtyEntity(
      id: id,
      name: name,
    );
  }

  /// Create model from domain entity
  factory SpecialtyModel.fromEntity(SpecialtyEntity entity) {
    return SpecialtyModel(
      id: entity.id,
      name: entity.name,
    );
  }
}
