import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

/// User entity representing an authenticated user in the system
/// All users are dental professionals who can:
/// - Work independently (solo practice)
/// - Create and manage their own clinic(s)
/// - Join other clinics as staff
@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    required String email,
    required String name,
    String? phone,
    String? avatarUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    // Professional fields (optional at signup)
    String? licenseNumber,
    String? specialization,
    // Primary clinic they own (if any)
    String? ownedClinicId,
  }) = _UserEntity;

  const UserEntity._();

  /// Whether this user owns a clinic
  bool get ownsClinic => ownedClinicId != null;
}
