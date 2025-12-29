import 'package:freezed_annotation/freezed_annotation.dart';
import 'clinic_membership_entity.dart';

part 'invitation_entity.freezed.dart';

/// Status of an invitation
enum InvitationStatus {
  pending,
  accepted,
  rejected,
  expired,
  cancelled,
}

/// Represents an invitation sent from a clinic to a dentist
@freezed
class InvitationEntity with _$InvitationEntity {
  const factory InvitationEntity({
    required String id,
    required String clinicId,
    required String clinicName, // Denormalized for display
    required String inviteeEmail,
    required ClinicRole role,
    required InvitationStatus status,
    required String invitedByUserId,
    String? invitedByName, // Denormalized for display
    String? message, // Optional personal message
    String? clinicLogoUrl,
    DateTime? createdAt,
    DateTime? expiresAt,
    DateTime? respondedAt,
  }) = _InvitationEntity;
}
