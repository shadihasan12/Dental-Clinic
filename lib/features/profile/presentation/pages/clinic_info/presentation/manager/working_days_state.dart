part of 'working_days_bloc.dart';

@freezed
class WorkingDaysState with _$WorkingDaysState {
  const factory WorkingDaysState.initial() = _WDInitial;
  const factory WorkingDaysState.loading() = _WDLoading;
  const factory WorkingDaysState.loaded({
    required List<WorkingDayApiModel> workingDays,
    required List<HolidayApiModel> holidays,
  }) = _WDLoaded;
  const factory WorkingDaysState.saving() = _WDSaving;
  const factory WorkingDaysState.saved() = _WDSaved;
  const factory WorkingDaysState.error(String message) = _WDError;
}
