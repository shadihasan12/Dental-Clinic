part of 'invitation_bloc.dart';

@freezed
class InvitationEvent with _$InvitationEvent {
  /// Load invitations sent by the current user (admin).
  const factory InvitationEvent.loadSentInvitations() = _LoadSentInvitations;

  /// Load invitations received by the user (uses current state filter).
  const factory InvitationEvent.loadReceivedInvitations() =
      _LoadReceivedInvitations;

  /// Change the status filter for received invitations and refetch.
  const factory InvitationEvent.filterReceivedByStatus(
    InvitationStatus status,
  ) = _FilterReceivedByStatus;

  /// Change the status filter for sent invitations and refetch.
  const factory InvitationEvent.filterSentByStatus(InvitationStatus status) =
      _FilterSentByStatus;

  /// Send a new invitation via POST /clinics/users/invitations/send.
  const factory InvitationEvent.sendInvitation({
    required String email,
    required List<String> roles,
  }) = _SendInvitation;

  /// Cancel a sent invitation (still mocked — wire when endpoint exists).
  const factory InvitationEvent.cancelInvitation(String invitationId) =
      _CancelInvitation;

  /// Accept a received invitation.
  const factory InvitationEvent.acceptInvitation(String invitationId) =
      _AcceptInvitation;

  /// Decline a received invitation.
  const factory InvitationEvent.rejectInvitation(String invitationId) =
      _RejectInvitation;
}
