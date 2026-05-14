class ClinicEndpoints {
  ClinicEndpoints._();

  static const String myClinics = '/users/clinics';
  static const String clinicUsers = '/clinics/users';
  static const String receivedInvitations =
      '/clinics/users/invitations/received';
  static const String sentInvitations = '/clinics/users/invitations/sent';
  static const String sendInvitation = '/clinics/users/invitations/send';
  static String acceptInvitation(String id) =>
      '/clinics/users/invitations/$id/accept';
  static String declineInvitation(String id) =>
      '/clinics/users/invitations/$id/decline';
  static String clinicUserRoles(String userId) =>
      '/clinics/users/$userId/roles';
  static String clinicUser(String userId) => '/clinics/users/$userId';
}
