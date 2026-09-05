part of 'appointment_bloc.dart';

@freezed
class AppointmentEvent with _$AppointmentEvent {
  /// Load appointments from repository
  const factory AppointmentEvent.loadAppointments() = _LoadAppointments;

  /// Change view mode (day/week)
  const factory AppointmentEvent.changeViewMode(AppointmentViewMode mode) = _ChangeViewMode;

  /// Select a specific date
  const factory AppointmentEvent.selectDate(DateTime date) = _SelectDate;

  /// Filter appointments
  const factory AppointmentEvent.filterAppointments() = _FilterAppointments;

  /// Create a new appointment
  const factory AppointmentEvent.createAppointment(CreateAppointmentParams params) = _CreateAppointment;

  /// Update appointment status
  const factory AppointmentEvent.updateAppointmentStatus(
    String appointmentId,
    AppointmentStatus status,
  ) = _UpdateAppointmentStatus;

  /// Cancel an appointment
  const factory AppointmentEvent.cancelAppointment(String appointmentId) = _CancelAppointment;

  /// Drops [AppointmentState.actionError] once it has been shown, so the same
  /// failure cannot be raised twice by a later rebuild.
  const factory AppointmentEvent.clearActionError() = _ClearActionError;
}
