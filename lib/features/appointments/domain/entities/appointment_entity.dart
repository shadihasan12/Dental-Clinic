import 'package:dental_clinic_app/core/models/audit_entry.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

export 'package:dental_clinic_app/core/models/audit_entry.dart';

part 'appointment_entity.freezed.dart';

/// Appointment status. Mirrors the backend enum exactly:
///   SCHEDULED, CONFIRMED, CANCELLED_BY_CLINIC, CANCELLED_BY_PATIENT,
///   NO_SHOW, COMPLETED.
enum AppointmentStatus {
  scheduled,
  confirmed,
  cancelledByClinic,
  cancelledByPatient,
  noShow,
  completed,
}

/// Where an appointment may go from each status.
///
/// The backend runs a one-way workflow and rejects anything that walks it
/// backwards - confirmed → scheduled, or any move off completed - with a 400.
/// Mirroring the rule here lets the picker offer only the moves that can
/// actually succeed, rather than letting the user choose one and then
/// explaining why it failed.
///
/// Keep this in step with the API. A status missing from the map is read as
/// final, so a new backend status shows up as unchangeable rather than as a
/// move that silently fails.
const Map<AppointmentStatus, List<AppointmentStatus>> _statusTransitions = {
  // An outcome is only recorded against a confirmed booking, so completed and
  // no-show are deliberately absent here: the API refuses both from SCHEDULED
  // with a 400, and offering them put the user one tap from a failure.
  AppointmentStatus.scheduled: [
    AppointmentStatus.confirmed,
    AppointmentStatus.cancelledByClinic,
    AppointmentStatus.cancelledByPatient,
  ],
  AppointmentStatus.confirmed: [
    AppointmentStatus.completed,
    AppointmentStatus.noShow,
    AppointmentStatus.cancelledByClinic,
    AppointmentStatus.cancelledByPatient,
  ],
  // Everything below is an outcome, and an outcome is not revised from the
  // appointment - a patient who returns after a no-show gets a new booking.
  AppointmentStatus.completed: [],
  AppointmentStatus.noShow: [],
  AppointmentStatus.cancelledByClinic: [],
  AppointmentStatus.cancelledByPatient: [],
};

extension AppointmentStatusFlow on AppointmentStatus {
  /// The statuses this one may be changed to, in workflow order.
  List<AppointmentStatus> get nextStatuses =>
      _statusTransitions[this] ?? const [];

  /// Nothing follows this status - it is where the appointment ends.
  bool get isFinal => nextStatuses.isEmpty;

  bool canMoveTo(AppointmentStatus target) => nextStatuses.contains(target);
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
    DateTime? createdAt,
    @Default([]) List<AuditEntry> audits,
  }) = _AppointmentEntity;

  const AppointmentEntity._();

  /// Check if appointment is today
  bool get isToday {
    final now = DateTime.now();
    return dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;
  }

  /// Check if appointment is in the past
  bool get isPast => dateTime.isBefore(DateTime.now());

  /// Whether the clinic can still cancel this appointment.
  ///
  /// Reads the transition map rather than listing statuses again, so there is
  /// one copy of the workflow. The earlier second copy had already drifted -
  /// it treated a no-show as cancellable, though the API counts it terminal -
  /// and it also refused anything in the past, a rule the server does not
  /// have. Both are gone: what the API allows is what this allows.
  bool get canBeCancelled =>
      status.canMoveTo(AppointmentStatus.cancelledByClinic);
}
