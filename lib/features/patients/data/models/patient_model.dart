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
  final String? allergies;
  final String? insuranceProvider;
  final String? insuranceNumber;
  final String? emergencyContact;
  final String status;
  final String? avatarUrl;
  final String? nextVisit;
  final double balance;

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
    this.allergies,
    this.insuranceProvider,
    this.insuranceNumber,
    this.emergencyContact,
    this.status = 'active',
    this.avatarUrl,
    this.nextVisit,
    this.balance = 0,
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
      allergies: json['allergies'] as String?,
      insuranceProvider: json['insurance_provider'] as String?,
      insuranceNumber: json['insurance_number'] as String?,
      emergencyContact: json['emergency_contact'] as String?,
      status: json['status'] as String? ?? 'active',
      avatarUrl: json['avatar_url'] as String?,
      nextVisit: json['next_visit'] as String?,
      balance: (json['balance'] as num?)?.toDouble() ?? 0,
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
      allergies: allergies,
      insuranceProvider: insuranceProvider,
      insuranceNumber: insuranceNumber,
      emergencyContact: emergencyContact,
      status: status,
      avatarUrl: avatarUrl,
      nextVisit: nextVisit,
      balance: balance,
    );
  }

  static PatientModel fromEntity(PatientEntity entity) {
    return PatientModel(
      id: entity.id,
      name: entity.name,
      age: entity.age,
      gender: entity.gender,
      phone: entity.phone,
      email: entity.email,
      address: entity.address,
      dateOfBirth: entity.dateOfBirth.toIso8601String(),
      medicalHistory: entity.medicalHistory,
      allergies: entity.allergies,
      insuranceProvider: entity.insuranceProvider,
      insuranceNumber: entity.insuranceNumber,
      emergencyContact: entity.emergencyContact,
      status: entity.status,
      avatarUrl: entity.avatarUrl,
      nextVisit: entity.nextVisit,
      balance: entity.balance,
    );
  }
}
