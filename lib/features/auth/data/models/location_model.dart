import 'package:dental_clinic_app/features/auth/domain/entities/location_entity.dart';

/// Data model for location with JSON serialization
class LocationModel {
  final String id;
  final String name;
  final String fullName;
  final String countryCode;

  LocationModel({
    required this.id,
    required this.name,
    required this.fullName,
    required this.countryCode,
  });

  /// Create model from JSON
  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] as String,
      name: json['name'] as String,
      fullName: json['full_name'] as String,
      countryCode: json['country_code'] as String,
    );
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'full_name': fullName,
      'country_code': countryCode,
    };
  }

  /// Convert model to domain entity
  LocationEntity toEntity() {
    return LocationEntity(
      id: id,
      name: name,
      fullName: fullName,
      countryCode: countryCode,
    );
  }

  /// Create model from domain entity
  factory LocationModel.fromEntity(LocationEntity entity) {
    return LocationModel(
      id: entity.id,
      name: entity.name,
      fullName: entity.fullName,
      countryCode: entity.countryCode,
    );
  }
}
