part of 'user_hours_bloc.dart';

@freezed
class UserHoursState with _$UserHoursState {
  const factory UserHoursState.initial() = _UHInitial;
  const factory UserHoursState.loading() = _UHLoading;
  const factory UserHoursState.loaded(List<UserWorkingDayApiModel> days) =
      _UHLoaded;
  const factory UserHoursState.saving() = _UHSaving;
  const factory UserHoursState.saved() = _UHSaved;
  const factory UserHoursState.error(String message) = _UHError;
}
