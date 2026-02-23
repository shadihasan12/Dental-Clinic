import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/appointment_entity.dart';
import 'package:dental_clinic_app/features/appointments/domain/use_cases/create_appointment_use_case.dart';
import 'package:dental_clinic_app/features/appointments/domain/use_cases/get_all_appointments_use_case.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';
part 'appointment_bloc.freezed.dart';

@injectable
class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final GetAllAppointmentsUseCase _getAllAppointments;
  final CreateAppointmentUseCase _createAppointment;

  AppointmentBloc({
    required GetAllAppointmentsUseCase getAllAppointments,
    required CreateAppointmentUseCase createAppointment,
  })  : _getAllAppointments = getAllAppointments,
        _createAppointment = createAppointment,
        super(AppointmentState.initial()) {
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

    final result = await _getAllAppointments(NoParams());

    result.fold(
      (error) => emit(state.copyWith(
        isLoading: false,
        error: NetworkExceptions.getErrorMessage(error),
      )),
      (appointments) => emit(state.copyWith(
        isLoading: false,
        appointments: appointments,
        filteredAppointments: _filterAppointmentsByDate(
          appointments,
          state.selectedDate,
        ),
      )),
    );
  }

  void _onChangeViewMode(
    _ChangeViewMode event,
    Emitter<AppointmentState> emit,
  ) {
    emit(state.copyWith(viewMode: event.mode));
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

    final result = await _createAppointment(event.appointment);

    result.fold(
      (error) => emit(state.copyWith(
        isCreating: false,
        error: NetworkExceptions.getErrorMessage(error),
      )),
      (created) {
        final updatedAppointments = [...state.appointments, created];
        emit(state.copyWith(
          isCreating: false,
          appointments: updatedAppointments,
          filteredAppointments: _filterAppointmentsByDate(
            updatedAppointments,
            state.selectedDate,
          ),
        ));
      },
    );
  }

  Future<void> _onUpdateAppointmentStatus(
    _UpdateAppointmentStatus event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(state.copyWith(isUpdating: true, error: null));

    // TODO: Replace with repository call when backend is ready
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
  }

  Future<void> _onCancelAppointment(
    _CancelAppointment event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(state.copyWith(isUpdating: true, error: null));

    // TODO: Replace with repository call when backend is ready
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
  }

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
      final startOfWeek = date.subtract(Duration(days: date.weekday - 1));
      final endOfWeek = startOfWeek.add(const Duration(days: 6));
      return appointments.where((appointment) {
        return appointment.dateTime.isAfter(startOfWeek) &&
            appointment.dateTime
                .isBefore(endOfWeek.add(const Duration(days: 1)));
      }).toList();
    }
  }
}
