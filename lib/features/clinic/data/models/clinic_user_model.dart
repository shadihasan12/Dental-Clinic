import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_user_entity.dart';

class ClinicUserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? mobileNumber;
  final String? specialtyName;
  final String? imageUrl;
  final List<ClinicRole> roles;
  final DateTime? createdAt;
  final List<AuditEntry> audits;

  const ClinicUserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.mobileNumber,
    this.specialtyName,
    this.imageUrl,
    required this.roles,
    this.createdAt,
    this.audits = const [],
  });

  factory ClinicUserModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>? ?? json;
    final rawRoles = (json['roles'] as List?)?.cast<String>() ?? [];
    final specialty = user['specialty'] as Map<String, dynamic>?;

    return ClinicUserModel(
      id: user['id'] as String? ?? '',
      firstName: user['first_name'] as String? ?? '',
      lastName: user['last_name'] as String? ?? '',
      email: user['email'] as String? ?? '',
      mobileNumber: user['mobile_number'] as String?,
      specialtyName: specialty?['name'] as String?,
      imageUrl: user['image'] as String?,
      roles: rawRoles.map(_parseRole).toList(),
      createdAt: _parseNullableDate(json['created_at']),
      audits: AuditEntry.listFromJson(json['audits']),
    );
  }

  static DateTime? _parseNullableDate(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }

  ClinicUserEntity toEntity() {
    return ClinicUserEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      mobileNumber: mobileNumber,
      specialtyName: specialtyName,
      imageUrl: imageUrl,
      roles: roles,
      createdAt: createdAt,
      audits: audits,
    );
  }

  static ClinicRole _parseRole(String raw) {
    switch (raw.toUpperCase()) {
      case 'ADMIN':
        return ClinicRole.admin;
      case 'DENTIST':
        return ClinicRole.dentist;
      case 'SECRETARY':
        return ClinicRole.secretary;
      default:
        return ClinicRole.receptionist;
    }
  }
}
