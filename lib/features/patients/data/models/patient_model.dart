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

  /// Currency of [balance], from the case it was derived from. Null when the
  /// server sent none - the amount is then shown bare rather than guessed at.
  final String? balanceCurrencyCode;
  final DateTime? createdAt;
  final List<AuditEntry> audits;

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
    this.balanceCurrencyCode,
    this.createdAt,
    this.audits = const [],
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    // Support both combined 'name' and separate 'first_name'/'last_name' from API
    final name = json['name'] as String? ??
        '${json['first_name'] ?? ''} ${json['last_name'] ?? ''}'.trim();

    // Calculate age from date_of_birth if not provided
    final dob = json['date_of_birth'] as String? ?? '';
    int age = json['age'] as int? ?? 0;
    if (age == 0 && dob.isNotEmpty) {
      final birthDate = DateTime.tryParse(dob);
      if (birthDate != null) {
        final now = DateTime.now();
        age = now.year - birthDate.year -
            ((now.month < birthDate.month ||
                    (now.month == birthDate.month && now.day < birthDate.day))
                ? 1
                : 0);
      }
    }

    return PatientModel(
      id: json['id'] as String,
      name: name,
      age: age,
      gender: json['gender'] as String? ?? '',
      phone: json['phone'] as String? ?? json['phone_number'] as String? ?? '',
      email: json['email'] as String? ?? '',
      address: json['address'] as String? ?? '',
      dateOfBirth: dob,
      medicalHistory: json['medical_history'] as String? ??
          json['medical_history_notes'] as String?,
      allergies:
          json['allergies'] as String? ?? json['allergy_notes'] as String?,
      insuranceProvider: json['insurance_provider'] as String?,
      insuranceNumber: json['insurance_number'] as String?,
      emergencyContact: json['emergency_contact'] as String?,
      status: json['status'] as String? ?? 'active',
      avatarUrl: json['avatar_url'] as String?,
      nextVisit: json['next_visit_date'] as String? ??
          json['next_visit'] as String?,
      balance: _balanceFrom(json),
      balanceCurrencyCode: _currencyCodeFrom(json),
      createdAt: _parseNullableDate(json['created_at']),
      audits: AuditEntry.listFromJson(json['audits']),
    );
  }

  static DateTime? _parseNullableDate(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }

  /// What the patient still owes.
  ///
  /// `outstanding_balance` is the field to trust, but the API currently sends
  /// 0 for every patient while their own cases report a non-zero
  /// `pending_amount` - so the list showed nothing owed on a patient the
  /// details screen showed as owing. Until the server aggregates it, the
  /// cases are added up here. A real non-zero `outstanding_balance` still
  /// wins, so this heals itself when the backend is fixed.
  static double _balanceFrom(Map<String, dynamic> json) {
    final reported = (json['outstanding_balance'] as num?)?.toDouble() ??
        (json['balance'] as num?)?.toDouble();
    if (reported != null && reported > 0) return reported;

    var pending = 0.0;
    for (final c in _cases(json)) {
      final v = c['pending_amount'];
      if (v is num) pending += v.toDouble();
      if (v is String) pending += double.tryParse(v) ?? 0;
    }
    return pending > 0 ? pending : (reported ?? 0);
  }

  /// The currency the balance is denominated in, taken from the case it came
  /// from. Never defaulted: a clinic billing in SYP must not have its total
  /// rendered with a dollar sign, so a missing code means the amount is shown
  /// without one.
  static String? _currencyCodeFrom(Map<String, dynamic> json) {
    for (final c in _cases(json)) {
      final currency = c['total_cost_currency'];
      if (currency is Map && currency['currency_code'] is String) {
        return currency['currency_code'] as String;
      }
    }
    return null;
  }

  /// The open case first, then any others - the open one is what a balance on
  /// the list is almost always about.
  static List<Map<String, dynamic>> _cases(Map<String, dynamic> json) {
    return [
      if (json['opened_case'] is Map<String, dynamic>)
        json['opened_case'] as Map<String, dynamic>,
      for (final c in (json['other_cases'] as List? ?? const []))
        if (c is Map<String, dynamic>) c,
    ];
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
      // Optional: an empty string is a patient with no date of birth.
      dateOfBirth: DateTime.tryParse(dateOfBirth),
      medicalHistory: medicalHistory,
      allergies: allergies,
      insuranceProvider: insuranceProvider,
      insuranceNumber: insuranceNumber,
      emergencyContact: emergencyContact,
      status: status,
      avatarUrl: avatarUrl,
      nextVisit: nextVisit,
      balance: balance,
      balanceCurrencyCode: balanceCurrencyCode,
      createdAt: createdAt,
      audits: audits,
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
      dateOfBirth: entity.dateOfBirth?.toIso8601String() ?? '',
      medicalHistory: entity.medicalHistory,
      allergies: entity.allergies,
      insuranceProvider: entity.insuranceProvider,
      insuranceNumber: entity.insuranceNumber,
      emergencyContact: entity.emergencyContact,
      status: entity.status,
      avatarUrl: entity.avatarUrl,
      nextVisit: entity.nextVisit,
      balance: entity.balance,
      balanceCurrencyCode: entity.balanceCurrencyCode,
    );
  }
}
