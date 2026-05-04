import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/data/models/working_hours_models.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/domain/repositories/working_hours_repository.dart';
import 'package:injectable/injectable.dart';

part 'working_hours_bloc.freezed.dart';
part 'working_hours_event.dart';
part 'working_hours_state.dart';

@injectable
class WorkingHoursBloc extends Bloc<WorkingHoursEvent, WorkingHoursState> {
  final WorkingHoursRepository _repository;

  WorkingHoursBloc({required WorkingHoursRepository repository})
      : _repository = repository,
        super(const WorkingHoursState.initial()) {
    on<_Load>(_onLoad);
    on<_SaveAll>(_onSaveAll);
  }

  Future<void> _onLoad(
    _Load event,
    Emitter<WorkingHoursState> emit,
  ) async {
    emit(const WorkingHoursState.loading());

    final workingDaysResult = await _repository.getWorkingDays();

    late List<WorkingDayApiModel> workingDays;
    final error = workingDaysResult.fold(
      (e) => NetworkExceptions.getErrorMessage(e),
      (data) {
        workingDays = data;
        return null;
      },
    );

    if (error != null) {
      emit(WorkingHoursState.error(error));
      return;
    }

    final holidaysResult = await _repository.getHolidays();

    holidaysResult.fold(
      (e) => emit(
        WorkingHoursState.error(NetworkExceptions.getErrorMessage(e)),
      ),
      (holidays) => emit(
        WorkingHoursState.loaded(
          workingDays: workingDays,
          holidays: holidays,
        ),
      ),
    );
  }

  Future<void> _onSaveAll(
    _SaveAll event,
    Emitter<WorkingHoursState> emit,
  ) async {
    emit(const WorkingHoursState.saving());

    final daysResult = await _repository.upsertWorkingDays(event.workingDays);

    final daysError = daysResult.fold(
      (e) => NetworkExceptions.getErrorMessage(e),
      (_) => null,
    );

    if (daysError != null) {
      emit(WorkingHoursState.error(daysError));
      return;
    }

    final holidaysResult = await _repository.upsertHolidays(event.holidays);

    holidaysResult.fold(
      (e) => emit(
        WorkingHoursState.error(NetworkExceptions.getErrorMessage(e)),
      ),
      (_) => emit(const WorkingHoursState.saved()),
    );
  }
}
