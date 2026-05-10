part of 'user_hours_bloc.dart';

@freezed
class UserHoursEvent with _$UserHoursEvent {
  const factory UserHoursEvent.load() = _Load;
  const factory UserHoursEvent.save(List<UserWorkingDayApiModel> days) = _Save;
}
