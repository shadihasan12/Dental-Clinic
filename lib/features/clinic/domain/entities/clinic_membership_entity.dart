import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinic_membership_entity.freezed.dart';

enum ClinicRole {
  admin,
  dentist,
  receptionist,
  secretary,
}

enum MembershipStatus {
  pending,
  active,
  suspended,
  rejected,
  left,
}

@freezed
class ClinicMembershipEntity with _$ClinicMembershipEntity {
  const factory ClinicMembershipEntity({
    required String id,
    required String userId,
    required String clinicId,
    required String clinicName,
    required ClinicRole role,
    required MembershipStatus status,
    @Default([]) List<ClinicRole> roles,
    // True when the user is the original owner of this clinic. Owners
    // cannot be deleted from the staff list by other admins.
    @Default(false) bool isOwner,
    String? address,
    String? locationName,
    String? userName,
    String? userEmail,
    String? userAvatarUrl,
    DateTime? joinedAt,
    DateTime? invitedAt,
    String? invitedByUserId,
  }) = _ClinicMembershipEntity;
}
