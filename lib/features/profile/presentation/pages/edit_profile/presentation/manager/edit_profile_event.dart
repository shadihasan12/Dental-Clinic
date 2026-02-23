part of 'edit_profile_bloc.dart';

@freezed
class EditProfileEvent with _$EditProfileEvent {
  const factory EditProfileEvent.loadProfile() = _LoadProfile;
  const factory EditProfileEvent.updateProfile(
    UserProfileEntity profile,
  ) = _UpdateProfile;
}
