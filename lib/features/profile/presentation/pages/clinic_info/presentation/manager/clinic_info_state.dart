part of 'clinic_info_bloc.dart';

@freezed
class ClinicInfoState with _$ClinicInfoState {
  const factory ClinicInfoState.initial() = _Initial;
  const factory ClinicInfoState.loading() = _Loading;
  const factory ClinicInfoState.loaded(ClinicInfoEntity clinicInfo) = _Loaded;
  const factory ClinicInfoState.saving(ClinicInfoEntity clinicInfo) = _Saving;
  const factory ClinicInfoState.saved(ClinicInfoEntity clinicInfo) = _Saved;
  /// Loading failed - there is no form to show.
  const factory ClinicInfoState.error(String message) = _Error;

  /// A save was refused. The form, and the edits in it, stay on screen.
  const factory ClinicInfoState.saveFailed(String message) = _SaveFailed;
}
