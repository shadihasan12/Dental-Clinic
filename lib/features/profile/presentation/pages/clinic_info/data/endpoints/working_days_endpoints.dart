class WorkingDaysEndpoints {
  static const String workingDays = '/clinics/working-days';
  static const String upsertWorkingDays = '/clinics/working-days/upsert';
  static const String holidays = '/clinics/holidays';
  static const String upsertHolidays = '/clinics/holidays/upsert';

  static String userHours(String userId) => '/clinics/users/$userId/hours';
}
