part of 'clinic_bloc.dart';

@freezed
class ClinicState with _$ClinicState {
  const factory ClinicState({
    @Default(false) bool isLoading,
    @Default(false) bool isMembersLoading,
    @Default(false) bool isUpdating,
    ClinicEntity? clinic,
    @Default([]) List<ClinicMembershipEntity> members,
    String? error,
    @Default(false) bool updateSuccess,
    @Default(false) bool removeSuccess,
    @Default(false) bool leaveSuccess,
  }) = _ClinicState;
}
