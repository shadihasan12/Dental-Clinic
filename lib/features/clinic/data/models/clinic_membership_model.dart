import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';

class ClinicMembershipModel {
  final String clinicId;
  final String clinicName;
  final String? address;
  final ClinicRole role;
  final List<ClinicRole> roles;
  final bool isOwner;

  const ClinicMembershipModel({
    required this.clinicId,
    required this.clinicName,
    this.address,
    required this.role,
    required this.roles,
    this.isOwner = false,
  });

  factory ClinicMembershipModel.fromJson(Map<String, dynamic> json) {
    final clinic = json['clinic'] as Map<String, dynamic>? ?? {};
    final location = clinic['location'] as Map<String, dynamic>?;
    final rawRoles = (json['roles'] as List?)?.cast<String>() ?? [];
    final parsedRoles = rawRoles.map(_parseRole).toList();

    return ClinicMembershipModel(
      clinicId: clinic['id'] as String? ?? '',
      clinicName: clinic['name'] as String? ?? '',
      address: location?['name'] as String? ??
          clinic['detailed_address'] as String?,
      role: _pickHighestRole(parsedRoles),
      roles: parsedRoles,
      isOwner: json['is_owner'] as bool? ?? false,
    );
  }

  ClinicMembershipEntity toEntity() {
    return ClinicMembershipEntity(
      id: clinicId,
      userId: '',
      clinicId: clinicId,
      clinicName: clinicName,
      role: role,
      roles: roles,
      address: address,
      status: MembershipStatus.active,
      isOwner: isOwner,
    );
  }

  static ClinicRole _pickHighestRole(List<ClinicRole> roles) {
    if (roles.contains(ClinicRole.admin)) return ClinicRole.admin;
    if (roles.contains(ClinicRole.dentist)) return ClinicRole.dentist;
    if (roles.contains(ClinicRole.secretary)) return ClinicRole.secretary;
    return ClinicRole.receptionist;
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
