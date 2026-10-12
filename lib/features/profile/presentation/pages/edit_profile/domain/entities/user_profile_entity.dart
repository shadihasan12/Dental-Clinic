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

    /// Whether [phone] differs from the number the profile was loaded with.
    /// Only an edited number is sent on save: an account older than the
    /// server's rule for a number may hold one it would now refuse, and
    /// sending it back untouched would fail a save that never touched it.
    @Default(true) bool phoneEdited,
    String? specialtyId,
    String? specialtyName,
    String? imageId,
    String? imageUrl,
  }) = _UserProfileEntity;
}
