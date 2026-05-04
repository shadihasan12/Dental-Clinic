import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/appointment_entity.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/create_appointment_params.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/get_appointments_params.dart';
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
    await _fetch(state.selectedDate, state.viewMode, emit);
  }

  Future<void> _onChangeViewMode(
    _ChangeViewMode event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(state.copyWith(viewMode: event.mode));
    await _fetch(state.selectedDate, event.mode, emit);
  }

  Future<void> _onSelectDate(
    _SelectDate event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(state.copyWith(selectedDate: event.date));
    await _fetch(event.date, state.viewMode, emit);
  }

  void _onFilterAppointments(
    _FilterAppointments event,
    Emitter<AppointmentState> emit,
  ) {
    emit(state.copyWith(filteredAppointments: state.appointments));
  }

  Future<void> _fetch(
    DateTime date,
    AppointmentViewMode mode,
    Emitter<AppointmentState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    final params = mode == AppointmentViewMode.day
        ? GetAppointmentsParams.day(date)
        : GetAppointmentsParams.weekContaining(date);

    final result = await _getAllAppointments(params);

    result.fold(
      (error) => emit(state.copyWith(
        isLoading: false,
        error: NetworkExceptions.getErrorMessage(error),
      )),
      (appointments) => emit(state.copyWith(
        isLoading: false,
        appointments: appointments,
        filteredAppointments: appointments,
      )),
    );
  }

  Future<void> _onCreateAppointment(
    _CreateAppointment event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(state.copyWith(isCreating: true, error: null));

    final result = await _createAppointment(event.params);

    result.fold(
      (error) => emit(state.copyWith(
        isCreating: false,
        error: NetworkExceptions.getErrorMessage(error),
      )),
      (created) {
        final updated = [...state.appointments, created];
        emit(state.copyWith(
          isCreating: false,
          appointments: updated,
          filteredAppointments: updated,
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

    final updated = state.appointments.map((a) {
      return a.id == event.appointmentId
          ? a.copyWith(status: event.status)
          : a;
    }).toList();

    emit(state.copyWith(
      isUpdating: false,
      appointments: updated,
      filteredAppointments: updated,
    ));
  }

  Future<void> _onCancelAppointment(
    _CancelAppointment event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(state.copyWith(isUpdating: true, error: null));

    // TODO: Replace with repository call when backend is ready
    await Future.delayed(const Duration(milliseconds: 500));

    final updated = state.appointments.map((a) {
      return a.id == event.appointmentId
          ? a.copyWith(status: AppointmentStatus.cancelled)
          : a;
    }).toList();

    emit(state.copyWith(
      isUpdating: false,
      appointments: updated,
      filteredAppointments: updated,
    ));
  }
}
