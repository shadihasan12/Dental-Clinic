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
    return AppointmentModel(
      id: json['id'] as String,
      patientId: json['patient_id'] as String,
      patientName: json['patient_name'] as String,
      doctorId: json['doctor_id'] as String,
      doctorName: json['doctor_name'] as String,
      dateTime: DateTime.parse(json['date_time'] as String),
      durationMinutes: json['duration_minutes'] as int,
      treatmentType: json['treatment_type'] as String,
      status: json['status'] as String,
      notes: json['notes'] as String?,
      clinicId: json['clinic_id'] as String?,
    );
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
    switch (status) {
      case 'confirmed':
        return AppointmentStatus.confirmed;
      case 'completed':
        return AppointmentStatus.completed;
      case 'cancelled':
        return AppointmentStatus.cancelled;
      case 'noShow':
        return AppointmentStatus.noShow;
      default:
        return AppointmentStatus.pending;
    }
  }
}
