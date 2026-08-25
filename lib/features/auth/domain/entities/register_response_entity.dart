import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/user_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';

part 'register_response_entity.freezed.dart';

/// Nested specialty information in register response
@freezed
class RegisterSpecialtyEntity with _$RegisterSpecialtyEntity {
  const factory RegisterSpecialtyEntity({
    required String id,
    required String name,
  }) = _RegisterSpecialtyEntity;
}

/// Nested location information in register response
@freezed
class RegisterLocationEntity with _$RegisterLocationEntity {
  const factory RegisterLocationEntity({
    required String id,
    required String name,
    required String fullName,
    required String countryCode,
  }) = _RegisterLocationEntity;
}

/// Nested clinic information in register response
@freezed
class RegisterClinicEntity with _$RegisterClinicEntity {
  const factory RegisterClinicEntity({
    required String id,
    required String name,
    required String type,
    required RegisterLocationEntity location,
    required String detailedAddress,
  }) = _RegisterClinicEntity;
}

/// Clinic membership with roles in register response
@freezed
class RegisterClinicMembershipEntity with _$RegisterClinicMembershipEntity {
  const factory RegisterClinicMembershipEntity({
    required RegisterClinicEntity clinic,
    required List<String> roles,
    // True when the user is the original owner of the clinic — drives
    // the "cannot be removed by other admins" rule downstream.
    @Default(false) bool isOwner,
  }) = _RegisterClinicMembershipEntity;
}

/// Complete register response entity
@freezed
class RegisterResponseEntity with _$RegisterResponseEntity {
  const factory RegisterResponseEntity({
    required String id,
    String? image,
    required String name,
    required String email,
    required bool emailVerified,
    required String mobileNumber,
    required bool isSuperAdmin,
    required RegisterSpecialtyEntity specialty,
    required List<RegisterClinicMembershipEntity> clinics,
  }) = _RegisterResponseEntity;

  const RegisterResponseEntity._();

  /// Convert to UserEntity for auth state
  UserEntity toUserEntity() {
    return UserEntity(
      id: id,
      email: email,
      name: name,
      phone: mobileNumber,
      avatarUrl: image,
      specialization: specialty.name,
      ownedClinicId: clinics.isNotEmpty ? clinics.first.clinic.id : null,
    );
  }

  /// Convert first clinic membership to ClinicMembershipEntity
  ClinicMembershipEntity toClinicMembership() {
    if (clinics.isEmpty) {
      throw StateError('No clinic memberships in register response');
    }

    final clinicData = clinics.first;
    final clinic = clinicData.clinic;

    // Determine primary role (ADMIN if present, otherwise first role)
    final role = clinicData.roles.contains('ADMIN')
        ? ClinicRole.admin
        : clinicData.roles.contains('DENTIST')
            ? ClinicRole.dentist
            : ClinicRole.receptionist;

    return ClinicMembershipEntity(
      id: '${id}_${clinic.id}', // Generated membership ID
      userId: id,
      clinicId: clinic.id,
      clinicName: clinic.name,
      role: role,
      status: MembershipStatus.active,
      isOwner: clinicData.isOwner,
      userName: name,
      userEmail: email,
      userAvatarUrl: image,
      joinedAt: DateTime.now(),
    );
  }
}
