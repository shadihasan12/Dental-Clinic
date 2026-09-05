import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/data/models/working_days_models.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/domain/repositories/working_days_repository.dart';
import 'package:injectable/injectable.dart';

part 'working_days_bloc.freezed.dart';
part 'working_days_event.dart';
part 'working_days_state.dart';

@injectable
class WorkingDaysBloc extends Bloc<WorkingDaysEvent, WorkingDaysState> {
  final WorkingDaysRepository _repository;

  WorkingDaysBloc({required WorkingDaysRepository repository})
      : _repository = repository,
        super(const WorkingDaysState.initial()) {
    on<_Load>(_onLoad);
    on<_SaveAll>(_onSaveAll);
  }

  Future<void> _onLoad(_Load event, Emitter<WorkingDaysState> emit) async {
    emit(const WorkingDaysState.loading());

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
      emit(WorkingDaysState.error(error));
      return;
    }

    final holidaysResult = await _repository.getHolidays();

    holidaysResult.fold(
      (e) => emit(WorkingDaysState.error(NetworkExceptions.getErrorMessage(e))),
      (holidays) => emit(
        WorkingDaysState.loaded(workingDays: workingDays, holidays: holidays),
      ),
    );
  }

  Future<void> _onSaveAll(
    _SaveAll event,
    Emitter<WorkingDaysState> emit,
  ) async {
    emit(const WorkingDaysState.saving());

    final daysResult = await _repository.upsertWorkingDays(event.workingDays);

    final daysError = daysResult.fold(
      (e) => NetworkExceptions.getErrorMessage(e),
      (_) => null,
    );

    if (daysError != null) {
      emit(WorkingDaysState.error(daysError));
      return;
    }

    final holidaysResult = await _repository.upsertHolidays(event.holidays);

    holidaysResult.fold(
      (e) => emit(WorkingDaysState.error(NetworkExceptions.getErrorMessage(e))),
      (_) => emit(const WorkingDaysState.saved()),
    );
  }
}
