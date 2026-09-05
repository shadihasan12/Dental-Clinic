part of 'user_hours_bloc.dart';

@freezed
class UserHoursState with _$UserHoursState {
  const factory UserHoursState.initial() = _UHInitial;
  const factory UserHoursState.loading() = _UHLoading;

  /// [isSeed] is true when [days] came from the clinic-hours seed (the
  /// user has no working hours saved yet, but we pre-filled the form
  /// from the clinic's working days so they can save in one tap). The
  /// page uses this to keep the "Save" button enabled on first render.
  ///
  /// [clinicDays] is the clinic's own schedule, carried alongside so the form
  /// can do three things without a second round trip: fill a full-time day
  /// with the clinic's real ranges, seed a new shift with sensible times, and
  /// check an edit against the clinic's hours *before* sending it. It is empty
  /// when the schedule could not be read (a non-admin cannot), in which case
  /// the form simply skips those checks and lets the server have the last
  /// word.
  const factory UserHoursState.loaded(
    List<UserWorkingDayApiModel> days, {
    @Default(false) bool isSeed,
    @Default(<WorkingDayApiModel>[]) List<WorkingDayApiModel> clinicDays,
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

  /// The **load** failed and there is nothing to show. The page replaces the
  /// whole body with a retry card.
  const factory UserHoursState.error(String message) = _UHError;

  /// The **save** failed. Deliberately distinct from [error]: the form on
  /// screen is still the user's own unsaved work, so replacing it with a
  /// "could not load working hours" card threw away their edits and told them
  /// the wrong thing. The page keeps the form and reports this in a snackbar.
  const factory UserHoursState.saveFailed(String message) = _UHSaveFailed;
}
