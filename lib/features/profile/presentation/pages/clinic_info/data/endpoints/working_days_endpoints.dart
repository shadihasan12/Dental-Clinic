class WorkingDaysEndpoints {
  static const String workingDays = '/clinics/working-days';
  static const String upsertWorkingDays = '/clinics/working-days/upsert';
  static const String holidays = '/clinics/holidays';
  static const String upsertHolidays = '/clinics/holidays/upsert';

  static String userHours(String userId) => '/clinics/users/$userId/hours';
  // Current-user hours — derived from the bearer token + selected
  // clinic header on the server, so no userId in the path.
  static const String myHours = '/clinics/users/my-hours';
}
