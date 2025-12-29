part of 'approvals_bloc.dart';

@freezed
class ApprovalsState with _$ApprovalsState {
  const factory ApprovalsState({
    @Default(false) bool isLoading,
    @Default(false) bool isProcessing,
    @Default(false) bool isSubmitting,
    @Default([]) List<ApprovalRequestEntity> pendingApprovals,
    String? error,

    // Success flags
    @Default(false) bool approveSuccess,
    @Default(false) bool rejectSuccess,
    @Default(false) bool submitSuccess,
  }) = _ApprovalsState;
}
