import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/appointment_entity.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';
part 'appointment_bloc.freezed.dart';

/// BLoC for managing appointments
class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  AppointmentBloc() : super(AppointmentState.initial()) {
    on<_LoadAppointments>(_onLoadAppointments);
    on<_ChangeViewMode>(_onChangeViewMode);
    on<_SelectDate>(_onSelectDate);
    on<_FilterAppointments>(_onFilterAppointments);
    on<_CreateAppointment>(_onCreateAppointment);
    on<_UpdateAppointmentStatus>(_onUpdateAppointmentStatus);
    on<_CancelAppointment>(_onCancelAppointment);
  }

  Future<void> _onLoadAppointments(
    _LoadAppointments event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      // TODO: Replace with actual repository call
      await Future.delayed(const Duration(milliseconds: 500));

      final appointments = _getMockAppointments();

      emit(state.copyWith(
        isLoading: false,
        appointments: appointments,
        filteredAppointments: _filterAppointmentsByDate(
          appointments,
          state.selectedDate,
        ),
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to load appointments: ${e.toString()}',
      ));
    }
  }

  void _onChangeViewMode(
    _ChangeViewMode event,
    Emitter<AppointmentState> emit,
  ) {
    emit(state.copyWith(viewMode: event.mode));

    // Refilter appointments based on new view mode
    final filtered = _filterAppointmentsByDate(
      state.appointments,
      state.selectedDate,
    );

    emit(state.copyWith(filteredAppointments: filtered));
  }

  void _onSelectDate(
    _SelectDate event,
    Emitter<AppointmentState> emit,
  ) {
    emit(state.copyWith(selectedDate: event.date));

    // Filter appointments for selected date
    final filtered = _filterAppointmentsByDate(
      state.appointments,
      event.date,
    );

    emit(state.copyWith(filteredAppointments: filtered));
  }

  void _onFilterAppointments(
    _FilterAppointments event,
    Emitter<AppointmentState> emit,
  ) {
    final filtered = _filterAppointmentsByDate(
      state.appointments,
      state.selectedDate,
    );

    emit(state.copyWith(filteredAppointments: filtered));
  }

  Future<void> _onCreateAppointment(
    _CreateAppointment event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(state.copyWith(isCreating: true, error: null));

    try {
      // TODO: Replace with actual repository call
      await Future.delayed(const Duration(seconds: 1));

      final updatedAppointments = [...state.appointments, event.appointment];

      emit(state.copyWith(
        isCreating: false,
        appointments: updatedAppointments,
        filteredAppointments: _filterAppointmentsByDate(
          updatedAppointments,
          state.selectedDate,
        ),
      ));
    } catch (e) {
      emit(state.copyWith(
        isCreating: false,
        error: 'Failed to create appointment: ${e.toString()}',
      ));
    }
  }

  Future<void> _onUpdateAppointmentStatus(
    _UpdateAppointmentStatus event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(state.copyWith(isUpdating: true, error: null));

    try {
      // TODO: Replace with actual repository call
      await Future.delayed(const Duration(milliseconds: 500));

      final updatedAppointments = state.appointments.map((appointment) {
        if (appointment.id == event.appointmentId) {
          return appointment.copyWith(status: event.status);
        }
        return appointment;
      }).toList();

      emit(state.copyWith(
        isUpdating: false,
        appointments: updatedAppointments,
        filteredAppointments: _filterAppointmentsByDate(
          updatedAppointments,
          state.selectedDate,
        ),
      ));
    } catch (e) {
      emit(state.copyWith(
        isUpdating: false,
        error: 'Failed to update appointment: ${e.toString()}',
      ));
    }
  }

  Future<void> _onCancelAppointment(
    _CancelAppointment event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(state.copyWith(isUpdating: true, error: null));

    try {
      // TODO: Replace with actual repository call
      await Future.delayed(const Duration(milliseconds: 500));

      final updatedAppointments = state.appointments.map((appointment) {
        if (appointment.id == event.appointmentId) {
          return appointment.copyWith(status: AppointmentStatus.cancelled);
        }
        return appointment;
      }).toList();

      emit(state.copyWith(
        isUpdating: false,
        appointments: updatedAppointments,
        filteredAppointments: _filterAppointmentsByDate(
          updatedAppointments,
          state.selectedDate,
        ),
      ));
    } catch (e) {
      emit(state.copyWith(
        isUpdating: false,
        error: 'Failed to cancel appointment: ${e.toString()}',
      ));
    }
  }

  /// Filter appointments by selected date and view mode
  List<AppointmentEntity> _filterAppointmentsByDate(
    List<AppointmentEntity> appointments,
    DateTime date,
  ) {
    if (state.viewMode == AppointmentViewMode.day) {
      return appointments.where((appointment) {
        return appointment.dateTime.year == date.year &&
            appointment.dateTime.month == date.month &&
            appointment.dateTime.day == date.day;
      }).toList();
    } else {
      // Week view - show appointments for the whole week
      final startOfWeek = date.subtract(Duration(days: date.weekday - 1));
      final endOfWeek = startOfWeek.add(const Duration(days: 6));

      return appointments.where((appointment) {
        return appointment.dateTime.isAfter(startOfWeek) &&
            appointment.dateTime.isBefore(endOfWeek.add(const Duration(days: 1)));
      }).toList();
    }
  }

  /// Mock appointments data - TODO: Replace with repository
  List<AppointmentEntity> _getMockAppointments() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return [
      AppointmentEntity(
        id: '1',
        patientId: 'p1',
        patientName: 'John Smith',
        doctorId: 'd1',
        doctorName: 'Dr. Sarah Johnson',
        dateTime: today.add(const Duration(hours: 9)),
        durationMinutes: 30,
        treatmentType: 'Regular Checkup',
        status: AppointmentStatus.confirmed,
      ),
      AppointmentEntity(
        id: '2',
        patientId: 'p2',
        patientName: 'Emma Wilson',
        doctorId: 'd1',
        doctorName: 'Dr. Sarah Johnson',
        dateTime: today.add(const Duration(hours: 10)),
        durationMinutes: 60,
        treatmentType: 'Teeth Cleaning',
        status: AppointmentStatus.confirmed,
      ),
      AppointmentEntity(
        id: '3',
        patientId: 'p3',
        patientName: 'Michael Brown',
        doctorId: 'd1',
        doctorName: 'Dr. Sarah Johnson',
        dateTime: today.add(const Duration(hours: 11, minutes: 30)),
        durationMinutes: 45,
        treatmentType: 'Cavity Filling',
        status: AppointmentStatus.pending,
      ),
      AppointmentEntity(
        id: '4',
        patientId: 'p4',
        patientName: 'Sarah Davis',
        doctorId: 'd1',
        doctorName: 'Dr. Sarah Johnson',
        dateTime: today.add(const Duration(hours: 14)),
        durationMinutes: 90,
        treatmentType: 'Root Canal',
        status: AppointmentStatus.confirmed,
      ),
      AppointmentEntity(
        id: '5',
        patientId: 'p5',
        patientName: 'James Wilson',
        doctorId: 'd1',
        doctorName: 'Dr. Sarah Johnson',
        dateTime: today.add(const Duration(hours: 16)),
        durationMinutes: 30,
        treatmentType: 'Consultation',
        status: AppointmentStatus.completed,
      ),
    ];
  }
}
