import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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
  }) = _ClinicUserEntity;

  String get fullName => '$firstName $lastName'.trim();
}
