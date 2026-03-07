import 'package:dental_clinic_app/features/auth/domain/entities/register_response_entity.dart';

/// Data model for nested specialty in register response
class RegisterSpecialtyModel {
  final String id;
  final String name;

  RegisterSpecialtyModel({
    required this.id,
    required this.name,
  });

  factory RegisterSpecialtyModel.fromJson(Map<String, dynamic> json) {
    return RegisterSpecialtyModel(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  RegisterSpecialtyEntity toEntity() {
    return RegisterSpecialtyEntity(
      id: id,
      name: name,
    );
  }
}

/// Data model for nested location in register response
class RegisterLocationModel {
  final String id;
  final String name;
  final String fullName;
  final String countryCode;

  RegisterLocationModel({
    required this.id,
    required this.name,
    required this.fullName,
    required this.countryCode,
  });

  factory RegisterLocationModel.fromJson(Map<String, dynamic> json) {
    return RegisterLocationModel(
      id: json['id'] as String,
      name: json['name'] as String,
      fullName: json['full_name'] as String,
      countryCode: json['country_code'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'full_name': fullName,
      'country_code': countryCode,
    };
  }

  RegisterLocationEntity toEntity() {
    return RegisterLocationEntity(
      id: id,
      name: name,
      fullName: fullName,
      countryCode: countryCode,
    );
  }
}

/// Data model for nested clinic in register response
class RegisterClinicModel {
  final String id;
  final String name;
  final String type;
  final RegisterLocationModel location;
  final String detailedAddress;

  RegisterClinicModel({
    required this.id,
    required this.name,
    required this.type,
    required this.location,
    required this.detailedAddress,
  });

  factory RegisterClinicModel.fromJson(Map<String, dynamic> json) {
    return RegisterClinicModel(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      location: RegisterLocationModel.fromJson(
        json['location'] as Map<String, dynamic>,
      ),
      detailedAddress: json['detailed_address'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'location': location.toJson(),
      'detailed_address': detailedAddress,
    };
  }

  RegisterClinicEntity toEntity() {
    return RegisterClinicEntity(
      id: id,
      name: name,
      type: type,
      location: location.toEntity(),
      detailedAddress: detailedAddress,
    );
  }
}

/// Data model for clinic membership with roles
class RegisterClinicMembershipModel {
  final RegisterClinicModel clinic;
  final List<String> roles;

  RegisterClinicMembershipModel({
    required this.clinic,
    required this.roles,
  });

  factory RegisterClinicMembershipModel.fromJson(Map<String, dynamic> json) {
    return RegisterClinicMembershipModel(
      clinic: RegisterClinicModel.fromJson(
        json['clinic'] as Map<String, dynamic>,
      ),
      roles: (json['roles'] as List).map((e) => e as String).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clinic': clinic.toJson(),
      'roles': roles,
    };
  }

  RegisterClinicMembershipEntity toEntity() {
    return RegisterClinicMembershipEntity(
      clinic: clinic.toEntity(),
      roles: roles,
    );
  }
}

/// Complete register response data model
class RegisterResponseModel {
  final String id;
  final String? image;
  final String firstName;
  final String lastName;
  final String email;
  final bool emailVerified;
  final String mobileNumber;
  final bool isSuperAdmin;
  final RegisterSpecialtyModel specialty;
  final List<RegisterClinicMembershipModel> clinics;

  RegisterResponseModel({
    required this.id,
    this.image,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.emailVerified,
    required this.mobileNumber,
    required this.isSuperAdmin,
    required this.specialty,
    required this.clinics,
  });

  String get fullName => '$firstName $lastName'.trim();

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      id: json['id'] as String,
      image: json['image'] as String?,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      emailVerified: json['email_verified'] as bool,
      mobileNumber: json['mobile_number'] as String,
      isSuperAdmin: json['is_super_admin'] as bool,
      specialty: RegisterSpecialtyModel.fromJson(
        json['specialty'] as Map<String, dynamic>,
      ),
      clinics: (json['clinics'] as List)
          .map((e) =>
              RegisterClinicMembershipModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'email_verified': emailVerified,
      'mobile_number': mobileNumber,
      'is_super_admin': isSuperAdmin,
      'specialty': specialty.toJson(),
      'clinics': clinics.map((e) => e.toJson()).toList(),
    };
  }

  RegisterResponseEntity toEntity() {
    return RegisterResponseEntity(
      id: id,
      image: image,
      name: fullName,
      email: email,
      emailVerified: emailVerified,
      mobileNumber: mobileNumber,
      isSuperAdmin: isSuperAdmin,
      specialty: specialty.toEntity(),
      clinics: clinics.map((e) => e.toEntity()).toList(),
    );
  }
}
