part of 'clinic_bloc.dart';

@freezed
class ClinicEvent with _$ClinicEvent {
  /// Load clinic details
  const factory ClinicEvent.loadClinic(String clinicId) = _LoadClinic;

  /// Load clinic members
  const factory ClinicEvent.loadMembers(String clinicId) = _LoadMembers;

  /// Update clinic info (name, address, phone, etc.)
  const factory ClinicEvent.updateClinicInfo(ClinicEntity clinic) = _UpdateClinicInfo;

  /// Update a member's role
  const factory ClinicEvent.updateMemberRole({
    required String membershipId,
    required ClinicRole newRole,
  }) = _UpdateMemberRole;

  /// Remove a member from the clinic
  const factory ClinicEvent.removeMember(String membershipId) = _RemoveMember;

  /// Leave the clinic (for non-admin members)
  const factory ClinicEvent.leaveClinic(String clinicId) = _LeaveClinic;
}
