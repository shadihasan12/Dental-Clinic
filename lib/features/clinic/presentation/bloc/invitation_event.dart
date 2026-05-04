part of 'invitation_bloc.dart';

@freezed
class InvitationEvent with _$InvitationEvent {
  /// Load invitations sent by the clinic
  const factory InvitationEvent.loadSentInvitations(String clinicId) = _LoadSentInvitations;

  /// Load invitations received by the user (uses current state filter)
  const factory InvitationEvent.loadReceivedInvitations() = _LoadReceivedInvitations;

  /// Change the status filter for received invitations and refetch
  const factory InvitationEvent.filterReceivedByStatus(InvitationStatus status) = _FilterReceivedByStatus;

  /// Send a new invitation
  const factory InvitationEvent.sendInvitation({
    required String clinicId,
    required String clinicName,
  }) = _SendInvitation;

  /// Cancel a sent invitation
  const factory InvitationEvent.cancelInvitation(String invitationId) = _CancelInvitation;

  /// Accept a received invitation
  const factory InvitationEvent.acceptInvitation(String invitationId) = _AcceptInvitation;

  /// Reject a received invitation
  const factory InvitationEvent.rejectInvitation(String invitationId) = _RejectInvitation;

  /// Update invite form fields
  const factory InvitationEvent.updateInviteeEmail(String email) = _UpdateInviteeEmail;
  const factory InvitationEvent.updateInviteeRole(ClinicRole role) = _UpdateInviteeRole;
  const factory InvitationEvent.updateInviteMessage(String message) = _UpdateInviteMessage;

  /// Reset the invite form
  const factory InvitationEvent.resetInviteForm() = _ResetInviteForm;
}
