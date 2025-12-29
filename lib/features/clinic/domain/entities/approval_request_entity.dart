import 'package:freezed_annotation/freezed_annotation.dart';

part 'approval_request_entity.freezed.dart';

/// Type of action requiring approval
enum ApprovalType {
  deletePatient,
  // Future: other actions that need admin approval
}

/// Status of an approval request
enum ApprovalStatus {
  pending,
  approved,
  rejected,
}

/// Represents a request that needs admin approval (e.g., patient deletion)
@freezed
class ApprovalRequestEntity with _$ApprovalRequestEntity {
  const factory ApprovalRequestEntity({
    required String id,
    required String clinicId,
    required String requesterId, // User who made the request
    required String requesterName,
    required ApprovalType type,
    required ApprovalStatus status,
    required Map<String, dynamic> payload, // Action-specific data
    String? requesterAvatarUrl,
    String? reviewedByUserId,
    String? reviewerName,
    String? reviewerComment,
    DateTime? createdAt,
    DateTime? reviewedAt,
  }) = _ApprovalRequestEntity;
}
