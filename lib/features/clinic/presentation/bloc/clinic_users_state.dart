part of 'clinic_users_bloc.dart';

@freezed
class ClinicUsersState with _$ClinicUsersState {
  const factory ClinicUsersState.initial() = _Initial;
  const factory ClinicUsersState.loading() = _Loading;
  const factory ClinicUsersState.loaded(List<ClinicUserEntity> users) = _Loaded;
  const factory ClinicUsersState.error(String message) = _Error;
  const factory ClinicUsersState.submitting(List<ClinicUserEntity> users) =
      _Submitting;
  /// [createdUser] is set only by the add-user flow, and is the user the API
  /// just created. The add form hands it back to the roster so the required
  /// working-hours step can be opened for the right id - reading "the last
  /// entry in [users]" instead would break the moment a reload reorders them.
  const factory ClinicUsersState.submitSuccess(
    List<ClinicUserEntity> users,
    String message, {
    ClinicUserEntity? createdUser,
  }) = _SubmitSuccess;
  const factory ClinicUsersState.submitError(
    List<ClinicUserEntity> users,
    String message,
  ) = _SubmitError;
}
