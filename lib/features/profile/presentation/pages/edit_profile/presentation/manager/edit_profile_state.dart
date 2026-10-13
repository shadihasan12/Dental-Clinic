part of 'edit_profile_bloc.dart';

@freezed
class EditProfileState with _$EditProfileState {
  const factory EditProfileState.initial() = _Initial;
  const factory EditProfileState.loading() = _Loading;
  const factory EditProfileState.loaded(UserProfileEntity profile) = _Loaded;
  const factory EditProfileState.saving(UserProfileEntity profile) = _Saving;
  const factory EditProfileState.saved(UserProfileEntity profile) = _Saved;
  const factory EditProfileState.imageUploading(UserProfileEntity profile) = _ImageUploading;
  const factory EditProfileState.imageUploaded(UserProfileEntity profile, String imageId, String imageUrl) = _ImageUploaded;
  /// The profile could not be loaded - there is no form to keep yet.
  const factory EditProfileState.error(String message) = _Error;

  /// A save was refused. [profile] is the last stored version, so the page
  /// keeps the form, and what was typed into it, on screen.
  const factory EditProfileState.saveFailed(UserProfileEntity profile, String message) = _SaveFailed;

  /// The photo did not upload; the profile still points at the old one.
  const factory EditProfileState.imageUploadFailed(UserProfileEntity profile, String message) = _ImageUploadFailed;
}
