part of 'working_hours_bloc.dart';

@freezed
class WorkingHoursEvent with _$WorkingHoursEvent {
  const factory WorkingHoursEvent.load() = _Load;
  const factory WorkingHoursEvent.saveAll({
    required List<WorkingDayApiModel> workingDays,
    required List<HolidayApiModel> holidays,
  }) = _SaveAll;
}
