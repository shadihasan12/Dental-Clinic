part of 'clinic_users_bloc.dart';

@freezed
class ClinicUsersState with _$ClinicUsersState {
  const factory ClinicUsersState.initial() = _Initial;
  const factory ClinicUsersState.loading() = _Loading;
  const factory ClinicUsersState.loaded(List<ClinicUserEntity> users) = _Loaded;
  const factory ClinicUsersState.error(String message) = _Error;
  const factory ClinicUsersState.submitting(List<ClinicUserEntity> users) =
      _Submitting;
  const factory ClinicUsersState.submitSuccess(
    List<ClinicUserEntity> users,
    String message,
  ) = _SubmitSuccess;
  const factory ClinicUsersState.submitError(
    List<ClinicUserEntity> users,
    String message,
  ) = _SubmitError;
}
