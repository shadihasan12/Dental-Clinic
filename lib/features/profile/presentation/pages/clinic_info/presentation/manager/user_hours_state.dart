part of 'user_hours_bloc.dart';

@freezed
class UserHoursState with _$UserHoursState {
  const factory UserHoursState.initial() = _UHInitial;
  const factory UserHoursState.loading() = _UHLoading;

  /// [isSeed] is true when [days] came from the clinic-hours seed (the
  /// user has no working hours saved yet, but we pre-filled the form
  /// from the clinic's working days so they can save in one tap). The
  /// page uses this to keep the "Save" button enabled on first render.
  const factory UserHoursState.loaded(
    List<UserWorkingDayApiModel> days, {
    @Default(false) bool isSeed,
  }) = _UHLoaded;

  /// Emitted when the user has no working hours AND the clinic itself
  /// has no working days set up. The page renders a CTA instead of
  /// the form — admins go to the clinic-working-days page; non-admins
  /// see a "ask your admin" message because the user-hours upsert
  /// requires `clinic_working_day_id`s the admin hasn't created yet.
  const factory UserHoursState.needsClinicHours({required bool isAdmin}) =
      _UHNeedsClinicHours;

  const factory UserHoursState.saving() = _UHSaving;
  const factory UserHoursState.saved() = _UHSaved;
  const factory UserHoursState.error(String message) = _UHError;
}
