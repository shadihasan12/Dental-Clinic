part of 'clinic_users_bloc.dart';

@freezed
class ClinicUsersEvent with _$ClinicUsersEvent {
  const factory ClinicUsersEvent.load() = _Load;
  const factory ClinicUsersEvent.addUser({
    required String firstName,
    required String lastName,
    required String email,
    required String mobileNumber,
    required String password,
    required String passwordConfirmation,
    required List<String> roles,
    String? specialtyId,
  }) = _AddUser;
  const factory ClinicUsersEvent.updateRoles({
    required String userId,
    required List<String> roles,
  }) = _UpdateRoles;
  const factory ClinicUsersEvent.removeUser(String userId) = _RemoveUser;
}
