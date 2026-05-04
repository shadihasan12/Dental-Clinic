part of 'invitation_bloc.dart';

@freezed
class InvitationState with _$InvitationState {
  const factory InvitationState({
    @Default(false) bool isLoading,
    @Default(false) bool isSending,
    @Default(false) bool isUpdating,
    @Default([]) List<InvitationEntity> sentInvitations,
    @Default([]) List<InvitationEntity> receivedInvitations,
    @Default(InvitationStatus.pending) InvitationStatus receivedFilter,
    String? error,

    // Invite form fields
    @Default('') String inviteeEmail,
    @Default(ClinicRole.dentist) ClinicRole inviteeRole,
    @Default('') String inviteMessage,

    // Success flags
    @Default(false) bool sendSuccess,
    @Default(false) bool cancelSuccess,
    @Default(false) bool acceptSuccess,
    @Default(false) bool rejectSuccess,
  }) = _InvitationState;
}
