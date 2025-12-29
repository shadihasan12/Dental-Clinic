import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/approval_request_entity.dart';
import 'package:dental_clinic_app/features/clinic/presentation/bloc/approvals_bloc.dart';

class PendingApprovalsPage extends StatelessWidget {
  final String clinicId;

  const PendingApprovalsPage({
    super.key,
    required this.clinicId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ApprovalsBloc()
        ..add(ApprovalsEvent.loadPendingApprovals(clinicId)),
      child: _PendingApprovalsContent(clinicId: clinicId),
    );
  }
}

class _PendingApprovalsContent extends StatelessWidget {
  final String clinicId;

  const _PendingApprovalsContent({required this.clinicId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      body: BlocConsumer<ApprovalsBloc, ApprovalsState>(
        listener: (context, state) {
          if (state.approveSuccess) {
            AppSnackbar.showSuccess(
              context,
              title: 'Request Approved',
              message: 'The request has been approved',
            );
          }
          if (state.rejectSuccess) {
            AppSnackbar.showSuccess(
              context,
              title: 'Request Rejected',
              message: 'The request has been rejected',
            );
          }
          if (state.error != null) {
            AppSnackbar.showError(
              context,
              title: 'Error',
              message: state.error,
            );
          }
        },
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              // Header
              SliverToBoxAdapter(
                child: GradientHeader(
                  title: 'Pending Approvals',
                  subtitle: 'Review and approve requests',
                  height: 160.h,
                  showBackButton: true,
                  onBackPressed: () => context.pop(),
                ),
              ),

              // Content
              if (state.isLoading)
                const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (state.pendingApprovals.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          size: 64.w,
                          color: ColorManager.success,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'All caught up!',
                          style: TextStyleManager.titleMedium.copyWith(
                            color: ColorManager.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'No pending approval requests',
                          style: TextStyleManager.bodyMedium.copyWith(
                            color: ColorManager.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: EdgeInsets.all(16.w),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final request = state.pendingApprovals[index];
                        return _ApprovalRequestCard(
                          request: request,
                          isProcessing: state.isProcessing,
                          onApprove: () {
                            context.read<ApprovalsBloc>().add(
                              ApprovalsEvent.approveRequest(request.id),
                            );
                          },
                          onReject: () {
                            _showRejectDialog(context, request);
                          },
                        );
                      },
                      childCount: state.pendingApprovals.length,
                    ),
                  ),
                ),

              SliverToBoxAdapter(
                child: SizedBox(height: 24.h),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showRejectDialog(BuildContext context, ApprovalRequestEntity request) {
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Reject Request'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Are you sure you want to reject this request?'),
            SizedBox(height: 16.h),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                hintText: 'Reason (optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<ApprovalsBloc>().add(
                ApprovalsEvent.rejectRequest(
                  requestId: request.id,
                  rejectionReason: reasonController.text.isNotEmpty
                      ? reasonController.text
                      : null,
                ),
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: ColorManager.error,
            ),
            child: const Text('Reject'),
          ),
        ],
      ),
    );
  }
}

class _ApprovalRequestCard extends StatelessWidget {
  final ApprovalRequestEntity request;
  final bool isProcessing;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const _ApprovalRequestCard({
    required this.request,
    required this.isProcessing,
    required this.onApprove,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final patientName = request.payload['patientName'] as String? ?? 'Unknown';
    final reason = request.payload['reason'] as String?;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: ColorManager.error.withValues(alpha: 0.05),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: ColorManager.error.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.delete_outline,
                    color: ColorManager.error,
                    size: 20.w,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Delete Patient Request',
                        style: TextStyleManager.titleSmall.copyWith(
                          fontWeight: FontWeight.bold,
                          color: ColorManager.error,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'From ${request.requesterName}',
                        style: TextStyleManager.bodySmall.copyWith(
                          color: ColorManager.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  _formatTimeAgo(request.createdAt),
                  style: TextStyleManager.labelSmall.copyWith(
                    color: ColorManager.textTertiary,
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Patient Info
                Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: 18.w,
                      color: ColorManager.textSecondary,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Patient: ',
                      style: TextStyleManager.bodyMedium.copyWith(
                        color: ColorManager.textSecondary,
                      ),
                    ),
                    Text(
                      patientName,
                      style: TextStyleManager.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                if (reason != null && reason.isNotEmpty) ...[
                  SizedBox(height: 12.h),
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: ColorManager.gray50,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.notes,
                          size: 18.w,
                          color: ColorManager.textSecondary,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            reason,
                            style: TextStyleManager.bodySmall.copyWith(
                              color: ColorManager.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                SizedBox(height: 16.h),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: isProcessing ? null : onReject,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: ColorManager.error,
                          side: const BorderSide(color: ColorManager.error),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: const Text('Reject'),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: isProcessing ? null : onApprove,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.success,
                          foregroundColor: ColorManager.white,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: const Text('Approve'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimeAgo(DateTime? dateTime) {
    if (dateTime == null) return '';

    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    }
    return 'Just now';
  }
}
