// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_profile_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$EditProfileEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadProfile,
    required TResult Function(UserProfileEntity profile) updateProfile,
    required TResult Function(File imageFile) uploadImage,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadProfile,
    TResult? Function(UserProfileEntity profile)? updateProfile,
    TResult? Function(File imageFile)? uploadImage,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadProfile,
    TResult Function(UserProfileEntity profile)? updateProfile,
    TResult Function(File imageFile)? uploadImage,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadProfile value) loadProfile,
    required TResult Function(_UpdateProfile value) updateProfile,
    required TResult Function(_UploadImage value) uploadImage,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadProfile value)? loadProfile,
    TResult? Function(_UpdateProfile value)? updateProfile,
    TResult? Function(_UploadImage value)? uploadImage,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadProfile value)? loadProfile,
    TResult Function(_UpdateProfile value)? updateProfile,
    TResult Function(_UploadImage value)? uploadImage,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditProfileEventCopyWith<$Res> {
  factory $EditProfileEventCopyWith(
    EditProfileEvent value,
    $Res Function(EditProfileEvent) then,
  ) = _$EditProfileEventCopyWithImpl<$Res, EditProfileEvent>;
}

/// @nodoc
class _$EditProfileEventCopyWithImpl<$Res, $Val extends EditProfileEvent>
    implements $EditProfileEventCopyWith<$Res> {
  _$EditProfileEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EditProfileEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadProfileImplCopyWith<$Res> {
  factory _$$LoadProfileImplCopyWith(
    _$LoadProfileImpl value,
    $Res Function(_$LoadProfileImpl) then,
  ) = __$$LoadProfileImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadProfileImplCopyWithImpl<$Res>
    extends _$EditProfileEventCopyWithImpl<$Res, _$LoadProfileImpl>
    implements _$$LoadProfileImplCopyWith<$Res> {
  __$$LoadProfileImplCopyWithImpl(
    _$LoadProfileImpl _value,
    $Res Function(_$LoadProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EditProfileEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadProfileImpl implements _LoadProfile {
  const _$LoadProfileImpl();

  @override
  String toString() {
    return 'EditProfileEvent.loadProfile()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadProfileImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadProfile,
    required TResult Function(UserProfileEntity profile) updateProfile,
    required TResult Function(File imageFile) uploadImage,
  }) {
    return loadProfile();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadProfile,
    TResult? Function(UserProfileEntity profile)? updateProfile,
    TResult? Function(File imageFile)? uploadImage,
  }) {
    return loadProfile?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadProfile,
    TResult Function(UserProfileEntity profile)? updateProfile,
    TResult Function(File imageFile)? uploadImage,
    required TResult orElse(),
  }) {
    if (loadProfile != null) {
      return loadProfile();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadProfile value) loadProfile,
    required TResult Function(_UpdateProfile value) updateProfile,
    required TResult Function(_UploadImage value) uploadImage,
  }) {
    return loadProfile(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadProfile value)? loadProfile,
    TResult? Function(_UpdateProfile value)? updateProfile,
    TResult? Function(_UploadImage value)? uploadImage,
  }) {
    return loadProfile?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadProfile value)? loadProfile,
    TResult Function(_UpdateProfile value)? updateProfile,
    TResult Function(_UploadImage value)? uploadImage,
    required TResult orElse(),
  }) {
    if (loadProfile != null) {
      return loadProfile(this);
    }
    return orElse();
  }
}

abstract class _LoadProfile implements EditProfileEvent {
  const factory _LoadProfile() = _$LoadProfileImpl;
}

/// @nodoc
abstract class _$$UpdateProfileImplCopyWith<$Res> {
  factory _$$UpdateProfileImplCopyWith(
    _$UpdateProfileImpl value,
    $Res Function(_$UpdateProfileImpl) then,
  ) = __$$UpdateProfileImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UserProfileEntity profile});

  $UserProfileEntityCopyWith<$Res> get profile;
}

/// @nodoc
class __$$UpdateProfileImplCopyWithImpl<$Res>
    extends _$EditProfileEventCopyWithImpl<$Res, _$UpdateProfileImpl>
    implements _$$UpdateProfileImplCopyWith<$Res> {
  __$$UpdateProfileImplCopyWithImpl(
    _$UpdateProfileImpl _value,
    $Res Function(_$UpdateProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EditProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? profile = null}) {
    return _then(
      _$UpdateProfileImpl(
        null == profile
            ? _value.profile
            : profile // ignore: cast_nullable_to_non_nullable
                  as UserProfileEntity,
      ),
    );
  }

  /// Create a copy of EditProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserProfileEntityCopyWith<$Res> get profile {
    return $UserProfileEntityCopyWith<$Res>(_value.profile, (value) {
      return _then(_value.copyWith(profile: value));
    });
  }
}

/// @nodoc

class _$UpdateProfileImpl implements _UpdateProfile {
  const _$UpdateProfileImpl(this.profile);

  @override
  final UserProfileEntity profile;

  @override
  String toString() {
    return 'EditProfileEvent.updateProfile(profile: $profile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateProfileImpl &&
            (identical(other.profile, profile) || other.profile == profile));
  }

  @override
  int get hashCode => Object.hash(runtimeType, profile);

  /// Create a copy of EditProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateProfileImplCopyWith<_$UpdateProfileImpl> get copyWith =>
      __$$UpdateProfileImplCopyWithImpl<_$UpdateProfileImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadProfile,
    required TResult Function(UserProfileEntity profile) updateProfile,
    required TResult Function(File imageFile) uploadImage,
  }) {
    return updateProfile(profile);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadProfile,
    TResult? Function(UserProfileEntity profile)? updateProfile,
    TResult? Function(File imageFile)? uploadImage,
  }) {
    return updateProfile?.call(profile);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadProfile,
    TResult Function(UserProfileEntity profile)? updateProfile,
    TResult Function(File imageFile)? uploadImage,
    required TResult orElse(),
  }) {
    if (updateProfile != null) {
      return updateProfile(profile);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadProfile value) loadProfile,
    required TResult Function(_UpdateProfile value) updateProfile,
    required TResult Function(_UploadImage value) uploadImage,
  }) {
    return updateProfile(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadProfile value)? loadProfile,
    TResult? Function(_UpdateProfile value)? updateProfile,
    TResult? Function(_UploadImage value)? uploadImage,
  }) {
    return updateProfile?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadProfile value)? loadProfile,
    TResult Function(_UpdateProfile value)? updateProfile,
    TResult Function(_UploadImage value)? uploadImage,
    required TResult orElse(),
  }) {
    if (updateProfile != null) {
      return updateProfile(this);
    }
    return orElse();
  }
}

abstract class _UpdateProfile implements EditProfileEvent {
  const factory _UpdateProfile(final UserProfileEntity profile) =
      _$UpdateProfileImpl;

  UserProfileEntity get profile;

  /// Create a copy of EditProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateProfileImplCopyWith<_$UpdateProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UploadImageImplCopyWith<$Res> {
  factory _$$UploadImageImplCopyWith(
    _$UploadImageImpl value,
    $Res Function(_$UploadImageImpl) then,
  ) = __$$UploadImageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({File imageFile});
}

/// @nodoc
class __$$UploadImageImplCopyWithImpl<$Res>
    extends _$EditProfileEventCopyWithImpl<$Res, _$UploadImageImpl>
    implements _$$UploadImageImplCopyWith<$Res> {
  __$$UploadImageImplCopyWithImpl(
    _$UploadImageImpl _value,
    $Res Function(_$UploadImageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EditProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? imageFile = null}) {
    return _then(
      _$UploadImageImpl(
        null == imageFile
            ? _value.imageFile
            : imageFile // ignore: cast_nullable_to_non_nullable
                  as File,
      ),
    );
  }
}

/// @nodoc

class _$UploadImageImpl implements _UploadImage {
  const _$UploadImageImpl(this.imageFile);

  @override
  final File imageFile;

  @override
  String toString() {
    return 'EditProfileEvent.uploadImage(imageFile: $imageFile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UploadImageImpl &&
            (identical(other.imageFile, imageFile) ||
                other.imageFile == imageFile));
  }

  @override
  int get hashCode => Object.hash(runtimeType, imageFile);

  /// Create a copy of EditProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UploadImageImplCopyWith<_$UploadImageImpl> get copyWith =>
      __$$UploadImageImplCopyWithImpl<_$UploadImageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadProfile,
    required TResult Function(UserProfileEntity profile) updateProfile,
    required TResult Function(File imageFile) uploadImage,
  }) {
    return uploadImage(imageFile);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadProfile,
    TResult? Function(UserProfileEntity profile)? updateProfile,
    TResult? Function(File imageFile)? uploadImage,
  }) {
    return uploadImage?.call(imageFile);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadProfile,
    TResult Function(UserProfileEntity profile)? updateProfile,
    TResult Function(File imageFile)? uploadImage,
    required TResult orElse(),
  }) {
    if (uploadImage != null) {
      return uploadImage(imageFile);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadProfile value) loadProfile,
    required TResult Function(_UpdateProfile value) updateProfile,
    required TResult Function(_UploadImage value) uploadImage,
  }) {
    return uploadImage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadProfile value)? loadProfile,
    TResult? Function(_UpdateProfile value)? updateProfile,
    TResult? Function(_UploadImage value)? uploadImage,
  }) {
    return uploadImage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadProfile value)? loadProfile,
    TResult Function(_UpdateProfile value)? updateProfile,
    TResult Function(_UploadImage value)? uploadImage,
    required TResult orElse(),
  }) {
    if (uploadImage != null) {
      return uploadImage(this);
    }
    return orElse();
  }
}

abstract class _UploadImage implements EditProfileEvent {
  const factory _UploadImage(final File imageFile) = _$UploadImageImpl;

  File get imageFile;

  /// Create a copy of EditProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UploadImageImplCopyWith<_$UploadImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$EditProfileState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserProfileEntity profile) loaded,
    required TResult Function(UserProfileEntity profile) saving,
    required TResult Function(UserProfileEntity profile) saved,
    required TResult Function(UserProfileEntity profile) imageUploading,
    required TResult Function(
      UserProfileEntity profile,
      String imageId,
      String imageUrl,
    )
    imageUploaded,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserProfileEntity profile)? loaded,
    TResult? Function(UserProfileEntity profile)? saving,
    TResult? Function(UserProfileEntity profile)? saved,
    TResult? Function(UserProfileEntity profile)? imageUploading,
    TResult? Function(
      UserProfileEntity profile,
      String imageId,
      String imageUrl,
    )?
    imageUploaded,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserProfileEntity profile)? loaded,
    TResult Function(UserProfileEntity profile)? saving,
    TResult Function(UserProfileEntity profile)? saved,
    TResult Function(UserProfileEntity profile)? imageUploading,
    TResult Function(
      UserProfileEntity profile,
      String imageId,
      String imageUrl,
    )?
    imageUploaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Saving value) saving,
    required TResult Function(_Saved value) saved,
    required TResult Function(_ImageUploading value) imageUploading,
    required TResult Function(_ImageUploaded value) imageUploaded,
    required TResult Function(_Error value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Saving value)? saving,
    TResult? Function(_Saved value)? saved,
    TResult? Function(_ImageUploading value)? imageUploading,
    TResult? Function(_ImageUploaded value)? imageUploaded,
    TResult? Function(_Error value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Saving value)? saving,
    TResult Function(_Saved value)? saved,
    TResult Function(_ImageUploading value)? imageUploading,
    TResult Function(_ImageUploaded value)? imageUploaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditProfileStateCopyWith<$Res> {
  factory $EditProfileStateCopyWith(
    EditProfileState value,
    $Res Function(EditProfileState) then,
  ) = _$EditProfileStateCopyWithImpl<$Res, EditProfileState>;
}

/// @nodoc
class _$EditProfileStateCopyWithImpl<$Res, $Val extends EditProfileState>
    implements $EditProfileStateCopyWith<$Res> {
  _$EditProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
    _$InitialImpl value,
    $Res Function(_$InitialImpl) then,
  ) = __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$EditProfileStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'EditProfileState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserProfileEntity profile) loaded,
    required TResult Function(UserProfileEntity profile) saving,
    required TResult Function(UserProfileEntity profile) saved,
    required TResult Function(UserProfileEntity profile) imageUploading,
    required TResult Function(
      UserProfileEntity profile,
      String imageId,
      String imageUrl,
    )
    imageUploaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserProfileEntity profile)? loaded,
    TResult? Function(UserProfileEntity profile)? saving,
    TResult? Function(UserProfileEntity profile)? saved,
    TResult? Function(UserProfileEntity profile)? imageUploading,
    TResult? Function(
      UserProfileEntity profile,
      String imageId,
      String imageUrl,
    )?
    imageUploaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserProfileEntity profile)? loaded,
    TResult Function(UserProfileEntity profile)? saving,
    TResult Function(UserProfileEntity profile)? saved,
    TResult Function(UserProfileEntity profile)? imageUploading,
    TResult Function(
      UserProfileEntity profile,
      String imageId,
      String imageUrl,
    )?
    imageUploaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Saving value) saving,
    required TResult Function(_Saved value) saved,
    required TResult Function(_ImageUploading value) imageUploading,
    required TResult Function(_ImageUploaded value) imageUploaded,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Saving value)? saving,
    TResult? Function(_Saved value)? saved,
    TResult? Function(_ImageUploading value)? imageUploading,
    TResult? Function(_ImageUploaded value)? imageUploaded,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Saving value)? saving,
    TResult Function(_Saved value)? saved,
    TResult Function(_ImageUploading value)? imageUploading,
    TResult Function(_ImageUploaded value)? imageUploaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements EditProfileState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
    _$LoadingImpl value,
    $Res Function(_$LoadingImpl) then,
  ) = __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$EditProfileStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'EditProfileState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserProfileEntity profile) loaded,
    required TResult Function(UserProfileEntity profile) saving,
    required TResult Function(UserProfileEntity profile) saved,
    required TResult Function(UserProfileEntity profile) imageUploading,
    required TResult Function(
      UserProfileEntity profile,
      String imageId,
      String imageUrl,
    )
    imageUploaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserProfileEntity profile)? loaded,
    TResult? Function(UserProfileEntity profile)? saving,
    TResult? Function(UserProfileEntity profile)? saved,
    TResult? Function(UserProfileEntity profile)? imageUploading,
    TResult? Function(
      UserProfileEntity profile,
      String imageId,
      String imageUrl,
    )?
    imageUploaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserProfileEntity profile)? loaded,
    TResult Function(UserProfileEntity profile)? saving,
    TResult Function(UserProfileEntity profile)? saved,
    TResult Function(UserProfileEntity profile)? imageUploading,
    TResult Function(
      UserProfileEntity profile,
      String imageId,
      String imageUrl,
    )?
    imageUploaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Saving value) saving,
    required TResult Function(_Saved value) saved,
    required TResult Function(_ImageUploading value) imageUploading,
    required TResult Function(_ImageUploaded value) imageUploaded,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Saving value)? saving,
    TResult? Function(_Saved value)? saved,
    TResult? Function(_ImageUploading value)? imageUploading,
    TResult? Function(_ImageUploaded value)? imageUploaded,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Saving value)? saving,
    TResult Function(_Saved value)? saved,
    TResult Function(_ImageUploading value)? imageUploading,
    TResult Function(_ImageUploaded value)? imageUploaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements EditProfileState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
    _$LoadedImpl value,
    $Res Function(_$LoadedImpl) then,
  ) = __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UserProfileEntity profile});

  $UserProfileEntityCopyWith<$Res> get profile;
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$EditProfileStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
    _$LoadedImpl _value,
    $Res Function(_$LoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? profile = null}) {
    return _then(
      _$LoadedImpl(
        null == profile
            ? _value.profile
            : profile // ignore: cast_nullable_to_non_nullable
                  as UserProfileEntity,
      ),
    );
  }

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserProfileEntityCopyWith<$Res> get profile {
    return $UserProfileEntityCopyWith<$Res>(_value.profile, (value) {
      return _then(_value.copyWith(profile: value));
    });
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(this.profile);

  @override
  final UserProfileEntity profile;

  @override
  String toString() {
    return 'EditProfileState.loaded(profile: $profile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.profile, profile) || other.profile == profile));
  }

  @override
  int get hashCode => Object.hash(runtimeType, profile);

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserProfileEntity profile) loaded,
    required TResult Function(UserProfileEntity profile) saving,
    required TResult Function(UserProfileEntity profile) saved,
    required TResult Function(UserProfileEntity profile) imageUploading,
    required TResult Function(
      UserProfileEntity profile,
      String imageId,
      String imageUrl,
    )
    imageUploaded,
    required TResult Function(String message) error,
  }) {
    return loaded(profile);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserProfileEntity profile)? loaded,
    TResult? Function(UserProfileEntity profile)? saving,
    TResult? Function(UserProfileEntity profile)? saved,
    TResult? Function(UserProfileEntity profile)? imageUploading,
    TResult? Function(
      UserProfileEntity profile,
      String imageId,
      String imageUrl,
    )?
    imageUploaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(profile);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserProfileEntity profile)? loaded,
    TResult Function(UserProfileEntity profile)? saving,
    TResult Function(UserProfileEntity profile)? saved,
    TResult Function(UserProfileEntity profile)? imageUploading,
    TResult Function(
      UserProfileEntity profile,
      String imageId,
      String imageUrl,
    )?
    imageUploaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(profile);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Saving value) saving,
    required TResult Function(_Saved value) saved,
    required TResult Function(_ImageUploading value) imageUploading,
    required TResult Function(_ImageUploaded value) imageUploaded,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Saving value)? saving,
    TResult? Function(_Saved value)? saved,
    TResult? Function(_ImageUploading value)? imageUploading,
    TResult? Function(_ImageUploaded value)? imageUploaded,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Saving value)? saving,
    TResult Function(_Saved value)? saved,
    TResult Function(_ImageUploading value)? imageUploading,
    TResult Function(_ImageUploaded value)? imageUploaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements EditProfileState {
  const factory _Loaded(final UserProfileEntity profile) = _$LoadedImpl;

  UserProfileEntity get profile;

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SavingImplCopyWith<$Res> {
  factory _$$SavingImplCopyWith(
    _$SavingImpl value,
    $Res Function(_$SavingImpl) then,
  ) = __$$SavingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UserProfileEntity profile});

  $UserProfileEntityCopyWith<$Res> get profile;
}

/// @nodoc
class __$$SavingImplCopyWithImpl<$Res>
    extends _$EditProfileStateCopyWithImpl<$Res, _$SavingImpl>
    implements _$$SavingImplCopyWith<$Res> {
  __$$SavingImplCopyWithImpl(
    _$SavingImpl _value,
    $Res Function(_$SavingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? profile = null}) {
    return _then(
      _$SavingImpl(
        null == profile
            ? _value.profile
            : profile // ignore: cast_nullable_to_non_nullable
                  as UserProfileEntity,
      ),
    );
  }

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserProfileEntityCopyWith<$Res> get profile {
    return $UserProfileEntityCopyWith<$Res>(_value.profile, (value) {
      return _then(_value.copyWith(profile: value));
    });
  }
}

/// @nodoc

class _$SavingImpl implements _Saving {
  const _$SavingImpl(this.profile);

  @override
  final UserProfileEntity profile;

  @override
  String toString() {
    return 'EditProfileState.saving(profile: $profile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SavingImpl &&
            (identical(other.profile, profile) || other.profile == profile));
  }

  @override
  int get hashCode => Object.hash(runtimeType, profile);

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SavingImplCopyWith<_$SavingImpl> get copyWith =>
      __$$SavingImplCopyWithImpl<_$SavingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserProfileEntity profile) loaded,
    required TResult Function(UserProfileEntity profile) saving,
    required TResult Function(UserProfileEntity profile) saved,
    required TResult Function(UserProfileEntity profile) imageUploading,
    required TResult Function(
      UserProfileEntity profile,
      String imageId,
      String imageUrl,
    )
    imageUploaded,
    required TResult Function(String message) error,
  }) {
    return saving(profile);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserProfileEntity profile)? loaded,
    TResult? Function(UserProfileEntity profile)? saving,
    TResult? Function(UserProfileEntity profile)? saved,
    TResult? Function(UserProfileEntity profile)? imageUploading,
    TResult? Function(
      UserProfileEntity profile,
      String imageId,
      String imageUrl,
    )?
    imageUploaded,
    TResult? Function(String message)? error,
  }) {
    return saving?.call(profile);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserProfileEntity profile)? loaded,
    TResult Function(UserProfileEntity profile)? saving,
    TResult Function(UserProfileEntity profile)? saved,
    TResult Function(UserProfileEntity profile)? imageUploading,
    TResult Function(
      UserProfileEntity profile,
      String imageId,
      String imageUrl,
    )?
    imageUploaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (saving != null) {
      return saving(profile);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Saving value) saving,
    required TResult Function(_Saved value) saved,
    required TResult Function(_ImageUploading value) imageUploading,
    required TResult Function(_ImageUploaded value) imageUploaded,
    required TResult Function(_Error value) error,
  }) {
    return saving(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Saving value)? saving,
    TResult? Function(_Saved value)? saved,
    TResult? Function(_ImageUploading value)? imageUploading,
    TResult? Function(_ImageUploaded value)? imageUploaded,
    TResult? Function(_Error value)? error,
  }) {
    return saving?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Saving value)? saving,
    TResult Function(_Saved value)? saved,
    TResult Function(_ImageUploading value)? imageUploading,
    TResult Function(_ImageUploaded value)? imageUploaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (saving != null) {
      return saving(this);
    }
    return orElse();
  }
}

abstract class _Saving implements EditProfileState {
  const factory _Saving(final UserProfileEntity profile) = _$SavingImpl;

  UserProfileEntity get profile;

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SavingImplCopyWith<_$SavingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SavedImplCopyWith<$Res> {
  factory _$$SavedImplCopyWith(
    _$SavedImpl value,
    $Res Function(_$SavedImpl) then,
  ) = __$$SavedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UserProfileEntity profile});

  $UserProfileEntityCopyWith<$Res> get profile;
}

/// @nodoc
class __$$SavedImplCopyWithImpl<$Res>
    extends _$EditProfileStateCopyWithImpl<$Res, _$SavedImpl>
    implements _$$SavedImplCopyWith<$Res> {
  __$$SavedImplCopyWithImpl(
    _$SavedImpl _value,
    $Res Function(_$SavedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? profile = null}) {
    return _then(
      _$SavedImpl(
        null == profile
            ? _value.profile
            : profile // ignore: cast_nullable_to_non_nullable
                  as UserProfileEntity,
      ),
    );
  }

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserProfileEntityCopyWith<$Res> get profile {
    return $UserProfileEntityCopyWith<$Res>(_value.profile, (value) {
      return _then(_value.copyWith(profile: value));
    });
  }
}

/// @nodoc

class _$SavedImpl implements _Saved {
  const _$SavedImpl(this.profile);

  @override
  final UserProfileEntity profile;

  @override
  String toString() {
    return 'EditProfileState.saved(profile: $profile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SavedImpl &&
            (identical(other.profile, profile) || other.profile == profile));
  }

  @override
  int get hashCode => Object.hash(runtimeType, profile);

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SavedImplCopyWith<_$SavedImpl> get copyWith =>
      __$$SavedImplCopyWithImpl<_$SavedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserProfileEntity profile) loaded,
    required TResult Function(UserProfileEntity profile) saving,
    required TResult Function(UserProfileEntity profile) saved,
    required TResult Function(UserProfileEntity profile) imageUploading,
    required TResult Function(
      UserProfileEntity profile,
      String imageId,
      String imageUrl,
    )
    imageUploaded,
    required TResult Function(String message) error,
  }) {
    return saved(profile);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserProfileEntity profile)? loaded,
    TResult? Function(UserProfileEntity profile)? saving,
    TResult? Function(UserProfileEntity profile)? saved,
    TResult? Function(UserProfileEntity profile)? imageUploading,
    TResult? Function(
      UserProfileEntity profile,
      String imageId,
      String imageUrl,
    )?
    imageUploaded,
    TResult? Function(String message)? error,
  }) {
    return saved?.call(profile);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserProfileEntity profile)? loaded,
    TResult Function(UserProfileEntity profile)? saving,
    TResult Function(UserProfileEntity profile)? saved,
    TResult Function(UserProfileEntity profile)? imageUploading,
    TResult Function(
      UserProfileEntity profile,
      String imageId,
      String imageUrl,
    )?
    imageUploaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (saved != null) {
      return saved(profile);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Saving value) saving,
    required TResult Function(_Saved value) saved,
    required TResult Function(_ImageUploading value) imageUploading,
    required TResult Function(_ImageUploaded value) imageUploaded,
    required TResult Function(_Error value) error,
  }) {
    return saved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Saving value)? saving,
    TResult? Function(_Saved value)? saved,
    TResult? Function(_ImageUploading value)? imageUploading,
    TResult? Function(_ImageUploaded value)? imageUploaded,
    TResult? Function(_Error value)? error,
  }) {
    return saved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Saving value)? saving,
    TResult Function(_Saved value)? saved,
    TResult Function(_ImageUploading value)? imageUploading,
    TResult Function(_ImageUploaded value)? imageUploaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (saved != null) {
      return saved(this);
    }
    return orElse();
  }
}

abstract class _Saved implements EditProfileState {
  const factory _Saved(final UserProfileEntity profile) = _$SavedImpl;

  UserProfileEntity get profile;

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SavedImplCopyWith<_$SavedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ImageUploadingImplCopyWith<$Res> {
  factory _$$ImageUploadingImplCopyWith(
    _$ImageUploadingImpl value,
    $Res Function(_$ImageUploadingImpl) then,
  ) = __$$ImageUploadingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UserProfileEntity profile});

  $UserProfileEntityCopyWith<$Res> get profile;
}

/// @nodoc
class __$$ImageUploadingImplCopyWithImpl<$Res>
    extends _$EditProfileStateCopyWithImpl<$Res, _$ImageUploadingImpl>
    implements _$$ImageUploadingImplCopyWith<$Res> {
  __$$ImageUploadingImplCopyWithImpl(
    _$ImageUploadingImpl _value,
    $Res Function(_$ImageUploadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? profile = null}) {
    return _then(
      _$ImageUploadingImpl(
        null == profile
            ? _value.profile
            : profile // ignore: cast_nullable_to_non_nullable
                  as UserProfileEntity,
      ),
    );
  }

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserProfileEntityCopyWith<$Res> get profile {
    return $UserProfileEntityCopyWith<$Res>(_value.profile, (value) {
      return _then(_value.copyWith(profile: value));
    });
  }
}

/// @nodoc

class _$ImageUploadingImpl implements _ImageUploading {
  const _$ImageUploadingImpl(this.profile);

  @override
  final UserProfileEntity profile;

  @override
  String toString() {
    return 'EditProfileState.imageUploading(profile: $profile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageUploadingImpl &&
            (identical(other.profile, profile) || other.profile == profile));
  }

  @override
  int get hashCode => Object.hash(runtimeType, profile);

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageUploadingImplCopyWith<_$ImageUploadingImpl> get copyWith =>
      __$$ImageUploadingImplCopyWithImpl<_$ImageUploadingImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserProfileEntity profile) loaded,
    required TResult Function(UserProfileEntity profile) saving,
    required TResult Function(UserProfileEntity profile) saved,
    required TResult Function(UserProfileEntity profile) imageUploading,
    required TResult Function(
      UserProfileEntity profile,
      String imageId,
      String imageUrl,
    )
    imageUploaded,
    required TResult Function(String message) error,
  }) {
    return imageUploading(profile);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserProfileEntity profile)? loaded,
    TResult? Function(UserProfileEntity profile)? saving,
    TResult? Function(UserProfileEntity profile)? saved,
    TResult? Function(UserProfileEntity profile)? imageUploading,
    TResult? Function(
      UserProfileEntity profile,
      String imageId,
      String imageUrl,
    )?
    imageUploaded,
    TResult? Function(String message)? error,
  }) {
    return imageUploading?.call(profile);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserProfileEntity profile)? loaded,
    TResult Function(UserProfileEntity profile)? saving,
    TResult Function(UserProfileEntity profile)? saved,
    TResult Function(UserProfileEntity profile)? imageUploading,
    TResult Function(
      UserProfileEntity profile,
      String imageId,
      String imageUrl,
    )?
    imageUploaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (imageUploading != null) {
      return imageUploading(profile);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Saving value) saving,
    required TResult Function(_Saved value) saved,
    required TResult Function(_ImageUploading value) imageUploading,
    required TResult Function(_ImageUploaded value) imageUploaded,
    required TResult Function(_Error value) error,
  }) {
    return imageUploading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Saving value)? saving,
    TResult? Function(_Saved value)? saved,
    TResult? Function(_ImageUploading value)? imageUploading,
    TResult? Function(_ImageUploaded value)? imageUploaded,
    TResult? Function(_Error value)? error,
  }) {
    return imageUploading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Saving value)? saving,
    TResult Function(_Saved value)? saved,
    TResult Function(_ImageUploading value)? imageUploading,
    TResult Function(_ImageUploaded value)? imageUploaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (imageUploading != null) {
      return imageUploading(this);
    }
    return orElse();
  }
}

abstract class _ImageUploading implements EditProfileState {
  const factory _ImageUploading(final UserProfileEntity profile) =
      _$ImageUploadingImpl;

  UserProfileEntity get profile;

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImageUploadingImplCopyWith<_$ImageUploadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ImageUploadedImplCopyWith<$Res> {
  factory _$$ImageUploadedImplCopyWith(
    _$ImageUploadedImpl value,
    $Res Function(_$ImageUploadedImpl) then,
  ) = __$$ImageUploadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UserProfileEntity profile, String imageId, String imageUrl});

  $UserProfileEntityCopyWith<$Res> get profile;
}

/// @nodoc
class __$$ImageUploadedImplCopyWithImpl<$Res>
    extends _$EditProfileStateCopyWithImpl<$Res, _$ImageUploadedImpl>
    implements _$$ImageUploadedImplCopyWith<$Res> {
  __$$ImageUploadedImplCopyWithImpl(
    _$ImageUploadedImpl _value,
    $Res Function(_$ImageUploadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profile = null,
    Object? imageId = null,
    Object? imageUrl = null,
  }) {
    return _then(
      _$ImageUploadedImpl(
        null == profile
            ? _value.profile
            : profile // ignore: cast_nullable_to_non_nullable
                  as UserProfileEntity,
        null == imageId
            ? _value.imageId
            : imageId // ignore: cast_nullable_to_non_nullable
                  as String,
        null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserProfileEntityCopyWith<$Res> get profile {
    return $UserProfileEntityCopyWith<$Res>(_value.profile, (value) {
      return _then(_value.copyWith(profile: value));
    });
  }
}

/// @nodoc

class _$ImageUploadedImpl implements _ImageUploaded {
  const _$ImageUploadedImpl(this.profile, this.imageId, this.imageUrl);

  @override
  final UserProfileEntity profile;
  @override
  final String imageId;
  @override
  final String imageUrl;

  @override
  String toString() {
    return 'EditProfileState.imageUploaded(profile: $profile, imageId: $imageId, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageUploadedImpl &&
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.imageId, imageId) || other.imageId == imageId) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, profile, imageId, imageUrl);

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageUploadedImplCopyWith<_$ImageUploadedImpl> get copyWith =>
      __$$ImageUploadedImplCopyWithImpl<_$ImageUploadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserProfileEntity profile) loaded,
    required TResult Function(UserProfileEntity profile) saving,
    required TResult Function(UserProfileEntity profile) saved,
    required TResult Function(UserProfileEntity profile) imageUploading,
    required TResult Function(
      UserProfileEntity profile,
      String imageId,
      String imageUrl,
    )
    imageUploaded,
    required TResult Function(String message) error,
  }) {
    return imageUploaded(profile, imageId, imageUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserProfileEntity profile)? loaded,
    TResult? Function(UserProfileEntity profile)? saving,
    TResult? Function(UserProfileEntity profile)? saved,
    TResult? Function(UserProfileEntity profile)? imageUploading,
    TResult? Function(
      UserProfileEntity profile,
      String imageId,
      String imageUrl,
    )?
    imageUploaded,
    TResult? Function(String message)? error,
  }) {
    return imageUploaded?.call(profile, imageId, imageUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserProfileEntity profile)? loaded,
    TResult Function(UserProfileEntity profile)? saving,
    TResult Function(UserProfileEntity profile)? saved,
    TResult Function(UserProfileEntity profile)? imageUploading,
    TResult Function(
      UserProfileEntity profile,
      String imageId,
      String imageUrl,
    )?
    imageUploaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (imageUploaded != null) {
      return imageUploaded(profile, imageId, imageUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Saving value) saving,
    required TResult Function(_Saved value) saved,
    required TResult Function(_ImageUploading value) imageUploading,
    required TResult Function(_ImageUploaded value) imageUploaded,
    required TResult Function(_Error value) error,
  }) {
    return imageUploaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Saving value)? saving,
    TResult? Function(_Saved value)? saved,
    TResult? Function(_ImageUploading value)? imageUploading,
    TResult? Function(_ImageUploaded value)? imageUploaded,
    TResult? Function(_Error value)? error,
  }) {
    return imageUploaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Saving value)? saving,
    TResult Function(_Saved value)? saved,
    TResult Function(_ImageUploading value)? imageUploading,
    TResult Function(_ImageUploaded value)? imageUploaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (imageUploaded != null) {
      return imageUploaded(this);
    }
    return orElse();
  }
}

abstract class _ImageUploaded implements EditProfileState {
  const factory _ImageUploaded(
    final UserProfileEntity profile,
    final String imageId,
    final String imageUrl,
  ) = _$ImageUploadedImpl;

  UserProfileEntity get profile;
  String get imageId;
  String get imageUrl;

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImageUploadedImplCopyWith<_$ImageUploadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
    _$ErrorImpl value,
    $Res Function(_$ErrorImpl) then,
  ) = __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$EditProfileStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'EditProfileState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserProfileEntity profile) loaded,
    required TResult Function(UserProfileEntity profile) saving,
    required TResult Function(UserProfileEntity profile) saved,
    required TResult Function(UserProfileEntity profile) imageUploading,
    required TResult Function(
      UserProfileEntity profile,
      String imageId,
      String imageUrl,
    )
    imageUploaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserProfileEntity profile)? loaded,
    TResult? Function(UserProfileEntity profile)? saving,
    TResult? Function(UserProfileEntity profile)? saved,
    TResult? Function(UserProfileEntity profile)? imageUploading,
    TResult? Function(
      UserProfileEntity profile,
      String imageId,
      String imageUrl,
    )?
    imageUploaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserProfileEntity profile)? loaded,
    TResult Function(UserProfileEntity profile)? saving,
    TResult Function(UserProfileEntity profile)? saved,
    TResult Function(UserProfileEntity profile)? imageUploading,
    TResult Function(
      UserProfileEntity profile,
      String imageId,
      String imageUrl,
    )?
    imageUploaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Saving value) saving,
    required TResult Function(_Saved value) saved,
    required TResult Function(_ImageUploading value) imageUploading,
    required TResult Function(_ImageUploaded value) imageUploaded,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Saving value)? saving,
    TResult? Function(_Saved value)? saved,
    TResult? Function(_ImageUploading value)? imageUploading,
    TResult? Function(_ImageUploaded value)? imageUploaded,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Saving value)? saving,
    TResult Function(_Saved value)? saved,
    TResult Function(_ImageUploading value)? imageUploading,
    TResult Function(_ImageUploaded value)? imageUploaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements EditProfileState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
