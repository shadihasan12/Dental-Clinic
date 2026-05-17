import 'package:dental_clinic_app/core/models/audit_entry.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

export 'package:dental_clinic_app/core/models/audit_entry.dart';

part 'clinic_user_entity.freezed.dart';

@freezed
class ClinicUserEntity with _$ClinicUserEntity {
  const ClinicUserEntity._();

  const factory ClinicUserEntity({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    String? mobileNumber,
    String? specialtyName,
    String? imageUrl,
    @Default([]) List<ClinicRole> roles,
    // True when this user is the original owner of the clinic.
    // Drives the "can't be removed by another admin" rule on the
    // clinic users page.
    @Default(false) bool isOwner,
    DateTime? createdAt,
    @Default([]) List<AuditEntry> audits,
  }) = _ClinicUserEntity;

  String get fullName => '$firstName $lastName'.trim();
}
