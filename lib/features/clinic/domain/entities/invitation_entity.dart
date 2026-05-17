import 'package:dental_clinic_app/core/models/audit_entry.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'clinic_membership_entity.dart';

export 'package:dental_clinic_app/core/models/audit_entry.dart';

part 'invitation_entity.freezed.dart';

/// Status of an invitation. Mirrors the backend values.
enum InvitationStatus {
  pending,
  accepted,
  declined,
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
    @Default(<ClinicRole>[]) List<ClinicRole> roles,
    String? inviteeName, // Set on /sent — the invitee's full name
    String? inviteeImageUrl,
    String? inviteeSpecialty,
    String? invitedByName, // Denormalized for display
    String? message, // Optional personal message
    String? clinicLogoUrl,
    DateTime? createdAt,
    DateTime? expiresAt,
    DateTime? respondedAt,
    @Default([]) List<AuditEntry> audits,
  }) = _InvitationEntity;
}
