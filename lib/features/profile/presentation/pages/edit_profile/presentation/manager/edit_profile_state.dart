part of 'edit_profile_bloc.dart';

@freezed
class EditProfileState with _$EditProfileState {
  const factory EditProfileState.initial() = _Initial;
  const factory EditProfileState.loading() = _Loading;
  const factory EditProfileState.loaded(UserProfileEntity profile) = _Loaded;
  const factory EditProfileState.saving(UserProfileEntity profile) = _Saving;
  const factory EditProfileState.saved(UserProfileEntity profile) = _Saved;
  const factory EditProfileState.error(String message) = _Error;
}
