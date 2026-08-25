import 'package:dental_clinic_app/features/appointments/domain/entities/clinic_doctor_entity.dart';

class ClinicDoctorModel {
  final String id;
  final String name;
  final String? specialty;
  final String? avatarUrl;

  const ClinicDoctorModel({
    required this.id,
    required this.name,
    this.specialty,
    this.avatarUrl,
  });

  /// Defensive — adapts to a few common shapes since we don't have the
  /// `/clinics/clinic-doctors` response locked down yet:
  ///   - flat `{ id, name, ... }`
  ///   - nested `{ user: { id, first_name, last_name, ... } }`
  ///   - separated first_name / last_name fields
  factory ClinicDoctorModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>?;
    final source = user ?? json;

    return ClinicDoctorModel(
      id: (json['id'] ?? source['id'] ?? '').toString(),
      name: _composeName(source) ??
          (source['name'] ?? json['name'] ?? '').toString(),
      specialty: (json['specialty']?['name'] as String?) ??
          (source['specialty']?['name'] as String?) ??
          (source['specialty'] is String
              ? source['specialty'] as String
              : null),
      avatarUrl: (source['avatar_url'] ?? source['image'] ?? source['photo'])
          as String?,
    );
  }

  ClinicDoctorEntity toEntity() => ClinicDoctorEntity(
        id: id,
        name: name,
        specialty: specialty,
        avatarUrl: avatarUrl,
      );

  static String? _composeName(Map<String, dynamic> json) {
    final full = json['name'] as String?;
    if (full != null && full.isNotEmpty) return full;
    final first = (json['first_name'] ?? '').toString();
    final last = (json['last_name'] ?? '').toString();
    final composed = '$first $last'.trim();
    return composed.isEmpty ? null : composed;
  }
}
