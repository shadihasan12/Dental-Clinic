import 'package:dental_clinic_app/features/auth/data/models/register_response_model.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/user_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';

/// Data model for the login API response data object
class LoginResponseModel {
  final String id;
  final String? image;
  final String firstName;
  final String lastName;
  final String email;
  final bool emailVerified;
  final String mobileNumber;
  final bool isSuperAdmin;
  final RegisterSpecialtyModel? specialty;
  final List<RegisterClinicMembershipModel> clinics;

  LoginResponseModel({
    required this.id,
    this.image,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.emailVerified,
    required this.mobileNumber,
    required this.isSuperAdmin,
    this.specialty,
    required this.clinics,
  });

  String get fullName => '$firstName $lastName'.trim();

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      id: json['id'] as String,
      image: json['image'] as String?,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      emailVerified: json['email_verified'] as bool,
      mobileNumber: json['mobile_number'] as String,
      isSuperAdmin: json['is_super_admin'] as bool,
      specialty: json['specialty'] != null
          ? RegisterSpecialtyModel.fromJson(
              json['specialty'] as Map<String, dynamic>,
            )
          : null,
      clinics: (json['clinics'] as List)
          .map(
            (e) => RegisterClinicMembershipModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }

  /// Convert to domain UserEntity
  UserEntity toUserEntity() {
    return UserEntity(
      id: id,
      email: email,
      name: fullName,
      phone: mobileNumber,
      avatarUrl: image,
      specialization: specialty?.name,
      ownedClinicId: clinics.isNotEmpty ? clinics.first.clinic.id : null,
    );
  }

  /// Convert clinics to ClinicMembershipEntity list
  List<ClinicMembershipEntity> toMemberships() {
    return clinics.map((membership) {
      final role = membership.roles.contains('ADMIN')
          ? ClinicRole.admin
          : membership.roles.contains('DENTIST')
              ? ClinicRole.dentist
              : ClinicRole.receptionist;

      return ClinicMembershipEntity(
        id: '${id}_${membership.clinic.id}',
        userId: id,
        clinicId: membership.clinic.id,
        clinicName: membership.clinic.name,
        role: role,
        status: MembershipStatus.active,
        userName: fullName,
        userEmail: email,
        userAvatarUrl: image,
        joinedAt: DateTime.now(),
      );
    }).toList();
  }
}
