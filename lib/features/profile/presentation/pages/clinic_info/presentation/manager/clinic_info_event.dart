part of 'clinic_info_bloc.dart';

@freezed
class ClinicInfoEvent with _$ClinicInfoEvent {
  const factory ClinicInfoEvent.loadClinicInfo() = _LoadClinicInfo;
  const factory ClinicInfoEvent.updateClinicInfo(
    ClinicInfoEntity clinicInfo,
  ) = _UpdateClinicInfo;
}
