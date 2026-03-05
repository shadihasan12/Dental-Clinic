part of 'working_hours_bloc.dart';

@freezed
class WorkingHoursState with _$WorkingHoursState {
  const factory WorkingHoursState.initial() = _WHInitial;
  const factory WorkingHoursState.loading() = _WHLoading;
  const factory WorkingHoursState.loaded({
    required List<WorkingDayApiModel> workingDays,
    required List<HolidayApiModel> holidays,
  }) = _WHLoaded;
  const factory WorkingHoursState.saving() = _WHSaving;
  const factory WorkingHoursState.saved() = _WHSaved;
  const factory WorkingHoursState.error(String message) = _WHError;
}
