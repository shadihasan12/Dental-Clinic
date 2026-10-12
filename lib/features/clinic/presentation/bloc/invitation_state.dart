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
    @Default(InvitationStatus.pending) InvitationStatus sentFilter,
    /// A list could not be loaded. The lists show it in place of their rows.
    String? error,

    /// Sending, accepting or declining was refused - already answered, the
    /// seats are full, too many invitations this hour. Shown once, as the
    /// server wrote it, and kept apart from [error] so a refused action
    /// never blanks the lists.
    String? actionError,

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
