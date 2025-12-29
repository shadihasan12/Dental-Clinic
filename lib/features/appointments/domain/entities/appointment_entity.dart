import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment_entity.freezed.dart';

/// Appointment status enum
enum AppointmentStatus {
  pending,
  confirmed,
  completed,
  cancelled,
  noShow,
}

/// Appointment entity representing a scheduled appointment
@freezed
class AppointmentEntity with _$AppointmentEntity {
  const factory AppointmentEntity({
    required String id,
    required String patientId,
    required String patientName,
    required String doctorId,
    required String doctorName,
    required DateTime dateTime,
    required int durationMinutes,
    required String treatmentType,
    required AppointmentStatus status,
    String? notes,
    String? clinicId,
  }) = _AppointmentEntity;

  const AppointmentEntity._();

  /// Get formatted time (e.g., "09:00")
  String get formattedTime {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  /// Get formatted date (e.g., "Dec 28, 2024")
  String get formattedDate {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year}';
  }

  /// Check if appointment is today
  bool get isToday {
    final now = DateTime.now();
    return dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;
  }

  /// Check if appointment is in the past
  bool get isPast => dateTime.isBefore(DateTime.now());

  /// Check if appointment can be cancelled
  bool get canBeCancelled {
    return status != AppointmentStatus.completed &&
        status != AppointmentStatus.cancelled &&
        !isPast;
  }
}
