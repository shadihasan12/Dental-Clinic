part of 'appointment_bloc.dart';

/// Appointment view mode enum
enum AppointmentViewMode {
  day,
  week,
}

@freezed
class AppointmentState with _$AppointmentState {
  const factory AppointmentState({
    @Default([]) List<AppointmentEntity> appointments,
    @Default([]) List<AppointmentEntity> filteredAppointments,
    @Default(AppointmentViewMode.day) AppointmentViewMode viewMode,
    required DateTime selectedDate,
    @Default(false) bool isLoading,
    @Default(false) bool isCreating,
    @Default(false) bool isUpdating,
    String? error,
  }) = _AppointmentState;

  const AppointmentState._();

  /// Initial state
  factory AppointmentState.initial() {
    final now = DateTime.now();
    return AppointmentState(
      selectedDate: DateTime(now.year, now.month, now.day),
    );
  }

  /// Get appointments for today
  List<AppointmentEntity> get todayAppointments {
    final now = DateTime.now();
    return appointments.where((appointment) {
      return appointment.dateTime.year == now.year &&
          appointment.dateTime.month == now.month &&
          appointment.dateTime.day == now.day;
    }).toList();
  }

  /// Get upcoming appointments
  List<AppointmentEntity> get upcomingAppointments {
    final now = DateTime.now();
    return appointments
        .where((appointment) => appointment.dateTime.isAfter(now))
        .toList()
      ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  /// Get appointment count by status
  int getAppointmentCountByStatus(AppointmentStatus status) {
    return appointments.where((a) => a.status == status).length;
  }
}
