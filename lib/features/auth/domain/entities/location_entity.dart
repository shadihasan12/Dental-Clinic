import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_entity.freezed.dart';

/// Domain entity representing a geographic location
@freezed
class LocationEntity with _$LocationEntity {
  const factory LocationEntity({
    required String id,
    required String name,
    required String fullName,
    required String countryCode,
  }) = _LocationEntity;
}
