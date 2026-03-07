part of 'edit_profile_bloc.dart';

@freezed
class EditProfileEvent with _$EditProfileEvent {
  const factory EditProfileEvent.loadProfile() = _LoadProfile;
  const factory EditProfileEvent.updateProfile(
    UserProfileEntity profile,
  ) = _UpdateProfile;
  const factory EditProfileEvent.uploadImage(File imageFile) = _UploadImage;
}
