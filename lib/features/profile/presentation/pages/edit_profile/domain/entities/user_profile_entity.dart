import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_entity.freezed.dart';

@freezed
class UserProfileEntity with _$UserProfileEntity {
  const factory UserProfileEntity({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    @Default('') String phone,
    String? specialtyId,
    String? specialtyName,
    String? imageId,
    String? imageUrl,
  }) = _UserProfileEntity;
}
