import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinic_entity.freezed.dart';

/// Clinic entity representing a dental clinic/practice
@freezed
class ClinicEntity with _$ClinicEntity {
  const factory ClinicEntity({
    required String id,
    required String name,
    required String adminUserId, // User who owns/manages this clinic
    String? address,
    String? phone,
    String? email,
    String? logoUrl,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ClinicEntity;
}
