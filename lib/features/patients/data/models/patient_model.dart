import 'package:dental_clinic_app/features/patients/domain/entities/patient_entity.dart';

class PatientModel {
  final String id;
  final String name;
  final int age;
  final String gender;
  final String phone;
  final String email;
  final String address;
  final String dateOfBirth;
  final String? medicalHistory;
  final String? insuranceProvider;
  final String? insuranceNumber;
  final String? emergencyContact;
  final String status;
  final String? avatarUrl;

  const PatientModel({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.phone,
    required this.email,
    required this.address,
    required this.dateOfBirth,
    this.medicalHistory,
    this.insuranceProvider,
    this.insuranceNumber,
    this.emergencyContact,
    this.status = 'active',
    this.avatarUrl,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'] as String,
      name: json['name'] as String,
      age: json['age'] as int,
      gender: json['gender'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      dateOfBirth: json['date_of_birth'] as String,
      medicalHistory: json['medical_history'] as String?,
      insuranceProvider: json['insurance_provider'] as String?,
      insuranceNumber: json['insurance_number'] as String?,
      emergencyContact: json['emergency_contact'] as String?,
      status: json['status'] as String? ?? 'active',
      avatarUrl: json['avatar_url'] as String?,
    );
  }

  PatientEntity toEntity() {
    return PatientEntity(
      id: id,
      name: name,
      age: age,
      gender: gender,
      phone: phone,
      email: email,
      address: address,
      dateOfBirth: DateTime.parse(dateOfBirth),
      medicalHistory: medicalHistory,
      insuranceProvider: insuranceProvider,
      insuranceNumber: insuranceNumber,
      emergencyContact: emergencyContact,
      status: status,
      avatarUrl: avatarUrl,
    );
  }
}
