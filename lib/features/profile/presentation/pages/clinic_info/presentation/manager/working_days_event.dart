part of 'working_days_bloc.dart';

@freezed
class WorkingDaysEvent with _$WorkingDaysEvent {
  const factory WorkingDaysEvent.load() = _Load;
  const factory WorkingDaysEvent.saveAll({
    required List<WorkingDayApiModel> workingDays,
    required List<HolidayApiModel> holidays,
  }) = _SaveAll;
}
