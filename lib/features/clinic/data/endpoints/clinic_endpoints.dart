class ClinicEndpoints {
  ClinicEndpoints._();

  static const String myClinics = '/users/clinics';
  static const String clinicUsers = '/clinics/users';
  static String clinicUserRoles(String userId) =>
      '/clinics/users/$userId/roles';
  static String clinicUser(String userId) => '/clinics/users/$userId';
}
