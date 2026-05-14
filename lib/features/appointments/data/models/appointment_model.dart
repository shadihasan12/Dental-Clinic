import 'package:dental_clinic_app/features/appointments/domain/entities/appointment_entity.dart';

class AppointmentModel {
  final String id;
  final String patientId;
  final String patientName;
  final String doctorId;
  final String doctorName;
  final DateTime dateTime;
  final int durationMinutes;
  final String treatmentType;
  final String status;
  final String? notes;
  final String? clinicId;

  const AppointmentModel({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.doctorId,
    required this.doctorName,
    required this.dateTime,
    required this.durationMinutes,
    required this.treatmentType,
    required this.status,
    this.notes,
    this.clinicId,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    final patient = json['patient'] as Map<String, dynamic>?;
    // Tolerate a few aliases — backend may return any of these.
    final doctor = (json['doctor'] ??
            json['dentist'] ??
            json['clinic_doctor'] ??
            json['assigned_doctor']) as Map<String, dynamic>?;
    // Doctor block may itself nest a `user` (matches the
    // /clinics/clinic-doctors response shape). Try that level too.
    final doctorUser = doctor?['user'] as Map<String, dynamic>?;
    final coreTreatments = json['core_treatments'] as List?;
    final firstTreatment =
        coreTreatments != null && coreTreatments.isNotEmpty
            ? coreTreatments.first as Map<String, dynamic>
            : null;

    return AppointmentModel(
      id: (json['id'] ?? '').toString(),
      patientId: (patient?['id'] ?? json['patient_id'] ?? '').toString(),
      patientName: _composeName(patient) ??
          (json['patient_name'] ?? '').toString(),
      doctorId: (doctor?['id'] ?? json['doctor_id'] ?? '').toString(),
      doctorName: _composeName(doctor) ??
          _composeName(doctorUser) ??
          (json['doctor_name'] ?? '').toString(),
      dateTime: _parseDateTime(json),
      durationMinutes: (json['duration_minutes'] as num?)?.toInt() ?? 0,
      treatmentType:
          (firstTreatment?['name'] ?? json['treatment_type'] ?? '').toString(),
      status: (json['status'] ?? '').toString(),
      notes: json['notes'] as String?,
      clinicId: json['clinic_id'] as String?,
    );
  }

  static String? _composeName(Map<String, dynamic>? json) {
    if (json == null) return null;
    final full = json['name'] as String?;
    if (full != null && full.isNotEmpty) return full;
    final first = (json['first_name'] ?? '').toString();
    final last = (json['last_name'] ?? '').toString();
    final composed = '$first $last'.trim();
    return composed.isEmpty ? null : composed;
  }

  /// Combines `date` + `start_time` if present (POST /clinics/appointments
  /// returns them split), otherwise falls back to a single `date_time` field.
  static DateTime _parseDateTime(Map<String, dynamic> json) {
    final combined = json['date_time'] as String?;
    if (combined != null) {
      return DateTime.parse(combined);
    }
    final date = json['date'] as String?;
    final startTime = (json['start_time'] ?? '00:00:00').toString();
    if (date != null) {
      return DateTime.parse('${date}T$startTime');
    }
    return DateTime.now();
  }

  factory AppointmentModel.fromEntity(AppointmentEntity entity) {
    return AppointmentModel(
      id: entity.id,
      patientId: entity.patientId,
      patientName: entity.patientName,
      doctorId: entity.doctorId,
      doctorName: entity.doctorName,
      dateTime: entity.dateTime,
      durationMinutes: entity.durationMinutes,
      treatmentType: entity.treatmentType,
      status: entity.status.name,
      notes: entity.notes,
      clinicId: entity.clinicId,
    );
  }

  AppointmentEntity toEntity() {
    return AppointmentEntity(
      id: id,
      patientId: patientId,
      patientName: patientName,
      doctorId: doctorId,
      doctorName: doctorName,
      dateTime: dateTime,
      durationMinutes: durationMinutes,
      treatmentType: treatmentType,
      status: _parseStatus(status),
      notes: notes,
      clinicId: clinicId,
    );
  }

  static AppointmentStatus _parseStatus(String status) {
    switch (status.toUpperCase()) {
      case 'CONFIRMED':
        return AppointmentStatus.confirmed;
      case 'COMPLETED':
        return AppointmentStatus.completed;
      case 'CANCELLED_BY_CLINIC':
        return AppointmentStatus.cancelledByClinic;
      case 'CANCELLED_BY_PATIENT':
        return AppointmentStatus.cancelledByPatient;
      case 'NO_SHOW':
      case 'NOSHOW':
        return AppointmentStatus.noShow;
      case 'SCHEDULED':
      default:
        return AppointmentStatus.scheduled;
    }
  }

  /// API value for an [AppointmentStatus]. Used as the body for
  /// PATCH /clinics/appointments/{id}/status.
  static String apiValue(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.scheduled:
        return 'SCHEDULED';
      case AppointmentStatus.confirmed:
        return 'CONFIRMED';
      case AppointmentStatus.cancelledByClinic:
        return 'CANCELLED_BY_CLINIC';
      case AppointmentStatus.cancelledByPatient:
        return 'CANCELLED_BY_PATIENT';
      case AppointmentStatus.noShow:
        return 'NO_SHOW';
      case AppointmentStatus.completed:
        return 'COMPLETED';
    }
  }
}
