import 'package:dental_clinic_app/features/profile/presentation/pages/edit_profile/domain/entities/user_profile_entity.dart';

class UserProfileModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String? specialtyId;
  final String? specialtyName;
  final String? imageId;
  final String? imageUrl;

  const UserProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    this.specialtyId,
    this.specialtyName,
    this.imageId,
    this.imageUrl,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    final specialty = json['specialty'] as Map<String, dynamic>?;
    return UserProfileModel(
      id: json['id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      phone: json['mobile_number'] as String? ?? '',
      specialtyId: specialty?['id'] as String?,
      specialtyName: specialty?['name'] as String?,
      imageUrl: json['image'] as String?,
    );
  }

  Map<String, dynamic> toUpdateJson() {
    final body = <String, dynamic>{
      'first_name': firstName,
      'last_name': lastName,
      'mobile_number': phone,
    };
    if (specialtyId != null) {
      body['specialty_id'] = specialtyId;
    }
    if (imageId != null) {
      body['image_id'] = imageId;
    }
    return body;
  }

  factory UserProfileModel.fromEntity(UserProfileEntity entity) {
    return UserProfileModel(
      id: entity.id,
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      phone: entity.phone,
      specialtyId: entity.specialtyId,
      specialtyName: entity.specialtyName,
      imageId: entity.imageId,
      imageUrl: entity.imageUrl,
    );
  }

  UserProfileEntity toEntity() {
    return UserProfileEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      specialtyId: specialtyId,
      specialtyName: specialtyName,
      imageId: imageId,
      imageUrl: imageUrl,
    );
  }
}
