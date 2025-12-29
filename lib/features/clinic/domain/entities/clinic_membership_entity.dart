import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinic_membership_entity.freezed.dart';

/// Role a user can have within a clinic
enum ClinicRole {
  admin, // Full clinic management (owner)
  dentist, // Invited dentist - can see clinic patients
  receptionist, // Staff - can add patients, deletions need approval
}

/// Status of a membership
enum MembershipStatus {
  pending, // Invitation sent, not yet accepted
  active, // Active member
  suspended, // Temporarily disabled
  rejected, // Invitation was rejected
  left, // User left the clinic
}

/// Represents a user's membership in a clinic with their role
@freezed
class ClinicMembershipEntity with _$ClinicMembershipEntity {
  const factory ClinicMembershipEntity({
    required String id,
    required String userId,
    required String clinicId,
    required String clinicName, // Denormalized for display
    required ClinicRole role,
    required MembershipStatus status,
    String? userName, // Denormalized for display
    String? userEmail, // Denormalized for display
    String? userAvatarUrl,
    DateTime? joinedAt,
    DateTime? invitedAt,
    String? invitedByUserId,
  }) = _ClinicMembershipEntity;
}
