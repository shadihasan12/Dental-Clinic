part of 'approvals_bloc.dart';

@freezed
class ApprovalsEvent with _$ApprovalsEvent {
  /// Load pending approval requests for a clinic
  const factory ApprovalsEvent.loadPendingApprovals(String clinicId) = _LoadPendingApprovals;

  /// Approve a pending request
  const factory ApprovalsEvent.approveRequest(String requestId) = _ApproveRequest;

  /// Reject a pending request
  const factory ApprovalsEvent.rejectRequest({
    required String requestId,
    String? rejectionReason,
  }) = _RejectRequest;

  /// Submit a request to delete a patient (for non-admin users)
  const factory ApprovalsEvent.requestPatientDeletion({
    required String clinicId,
    required String patientId,
    required String patientName,
    String? reason,
  }) = _RequestPatientDeletion;
}
