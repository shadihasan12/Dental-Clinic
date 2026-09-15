// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clinic_info_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ClinicInfoEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadClinicInfo,
    required TResult Function(ClinicInfoEntity clinicInfo) updateClinicInfo,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadClinicInfo,
    TResult? Function(ClinicInfoEntity clinicInfo)? updateClinicInfo,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadClinicInfo,
    TResult Function(ClinicInfoEntity clinicInfo)? updateClinicInfo,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadClinicInfo value) loadClinicInfo,
    required TResult Function(_UpdateClinicInfo value) updateClinicInfo,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadClinicInfo value)? loadClinicInfo,
    TResult? Function(_UpdateClinicInfo value)? updateClinicInfo,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadClinicInfo value)? loadClinicInfo,
    TResult Function(_UpdateClinicInfo value)? updateClinicInfo,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClinicInfoEventCopyWith<$Res> {
  factory $ClinicInfoEventCopyWith(
    ClinicInfoEvent value,
    $Res Function(ClinicInfoEvent) then,
  ) = _$ClinicInfoEventCopyWithImpl<$Res, ClinicInfoEvent>;
}

/// @nodoc
class _$ClinicInfoEventCopyWithImpl<$Res, $Val extends ClinicInfoEvent>
    implements $ClinicInfoEventCopyWith<$Res> {
  _$ClinicInfoEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClinicInfoEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadClinicInfoImplCopyWith<$Res> {
  factory _$$LoadClinicInfoImplCopyWith(
    _$LoadClinicInfoImpl value,
    $Res Function(_$LoadClinicInfoImpl) then,
  ) = __$$LoadClinicInfoImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadClinicInfoImplCopyWithImpl<$Res>
    extends _$ClinicInfoEventCopyWithImpl<$Res, _$LoadClinicInfoImpl>
    implements _$$LoadClinicInfoImplCopyWith<$Res> {
  __$$LoadClinicInfoImplCopyWithImpl(
    _$LoadClinicInfoImpl _value,
    $Res Function(_$LoadClinicInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClinicInfoEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadClinicInfoImpl implements _LoadClinicInfo {
  const _$LoadClinicInfoImpl();

  @override
  String toString() {
    return 'ClinicInfoEvent.loadClinicInfo()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadClinicInfoImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadClinicInfo,
    required TResult Function(ClinicInfoEntity clinicInfo) updateClinicInfo,
  }) {
    return loadClinicInfo();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadClinicInfo,
    TResult? Function(ClinicInfoEntity clinicInfo)? updateClinicInfo,
  }) {
    return loadClinicInfo?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadClinicInfo,
    TResult Function(ClinicInfoEntity clinicInfo)? updateClinicInfo,
    required TResult orElse(),
  }) {
    if (loadClinicInfo != null) {
      return loadClinicInfo();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadClinicInfo value) loadClinicInfo,
    required TResult Function(_UpdateClinicInfo value) updateClinicInfo,
  }) {
    return loadClinicInfo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadClinicInfo value)? loadClinicInfo,
    TResult? Function(_UpdateClinicInfo value)? updateClinicInfo,
  }) {
    return loadClinicInfo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadClinicInfo value)? loadClinicInfo,
    TResult Function(_UpdateClinicInfo value)? updateClinicInfo,
    required TResult orElse(),
  }) {
    if (loadClinicInfo != null) {
      return loadClinicInfo(this);
    }
    return orElse();
  }
}

abstract class _LoadClinicInfo implements ClinicInfoEvent {
  const factory _LoadClinicInfo() = _$LoadClinicInfoImpl;
}

/// @nodoc
abstract class _$$UpdateClinicInfoImplCopyWith<$Res> {
  factory _$$UpdateClinicInfoImplCopyWith(
    _$UpdateClinicInfoImpl value,
    $Res Function(_$UpdateClinicInfoImpl) then,
  ) = __$$UpdateClinicInfoImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ClinicInfoEntity clinicInfo});

  $ClinicInfoEntityCopyWith<$Res> get clinicInfo;
}

/// @nodoc
class __$$UpdateClinicInfoImplCopyWithImpl<$Res>
    extends _$ClinicInfoEventCopyWithImpl<$Res, _$UpdateClinicInfoImpl>
    implements _$$UpdateClinicInfoImplCopyWith<$Res> {
  __$$UpdateClinicInfoImplCopyWithImpl(
    _$UpdateClinicInfoImpl _value,
    $Res Function(_$UpdateClinicInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClinicInfoEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? clinicInfo = null}) {
    return _then(
      _$UpdateClinicInfoImpl(
        null == clinicInfo
            ? _value.clinicInfo
            : clinicInfo // ignore: cast_nullable_to_non_nullable
                  as ClinicInfoEntity,
      ),
    );
  }

  /// Create a copy of ClinicInfoEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ClinicInfoEntityCopyWith<$Res> get clinicInfo {
    return $ClinicInfoEntityCopyWith<$Res>(_value.clinicInfo, (value) {
      return _then(_value.copyWith(clinicInfo: value));
    });
  }
}

/// @nodoc

class _$UpdateClinicInfoImpl implements _UpdateClinicInfo {
  const _$UpdateClinicInfoImpl(this.clinicInfo);

  @override
  final ClinicInfoEntity clinicInfo;

  @override
  String toString() {
    return 'ClinicInfoEvent.updateClinicInfo(clinicInfo: $clinicInfo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateClinicInfoImpl &&
            (identical(other.clinicInfo, clinicInfo) ||
                other.clinicInfo == clinicInfo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, clinicInfo);

  /// Create a copy of ClinicInfoEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateClinicInfoImplCopyWith<_$UpdateClinicInfoImpl> get copyWith =>
      __$$UpdateClinicInfoImplCopyWithImpl<_$UpdateClinicInfoImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadClinicInfo,
    required TResult Function(ClinicInfoEntity clinicInfo) updateClinicInfo,
  }) {
    return updateClinicInfo(clinicInfo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadClinicInfo,
    TResult? Function(ClinicInfoEntity clinicInfo)? updateClinicInfo,
  }) {
    return updateClinicInfo?.call(clinicInfo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadClinicInfo,
    TResult Function(ClinicInfoEntity clinicInfo)? updateClinicInfo,
    required TResult orElse(),
  }) {
    if (updateClinicInfo != null) {
      return updateClinicInfo(clinicInfo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadClinicInfo value) loadClinicInfo,
    required TResult Function(_UpdateClinicInfo value) updateClinicInfo,
  }) {
    return updateClinicInfo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadClinicInfo value)? loadClinicInfo,
    TResult? Function(_UpdateClinicInfo value)? updateClinicInfo,
  }) {
    return updateClinicInfo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadClinicInfo value)? loadClinicInfo,
    TResult Function(_UpdateClinicInfo value)? updateClinicInfo,
    required TResult orElse(),
  }) {
    if (updateClinicInfo != null) {
      return updateClinicInfo(this);
    }
    return orElse();
  }
}

abstract class _UpdateClinicInfo implements ClinicInfoEvent {
  const factory _UpdateClinicInfo(final ClinicInfoEntity clinicInfo) =
      _$UpdateClinicInfoImpl;

  ClinicInfoEntity get clinicInfo;

  /// Create a copy of ClinicInfoEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateClinicInfoImplCopyWith<_$UpdateClinicInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ClinicInfoState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ClinicInfoEntity clinicInfo) loaded,
    required TResult Function(ClinicInfoEntity clinicInfo) saving,
    required TResult Function(ClinicInfoEntity clinicInfo) saved,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ClinicInfoEntity clinicInfo)? loaded,
    TResult? Function(ClinicInfoEntity clinicInfo)? saving,
    TResult? Function(ClinicInfoEntity clinicInfo)? saved,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ClinicInfoEntity clinicInfo)? loaded,
    TResult Function(ClinicInfoEntity clinicInfo)? saving,
    TResult Function(ClinicInfoEntity clinicInfo)? saved,
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
    required TResult Function(_Error value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Saving value)? saving,
    TResult? Function(_Saved value)? saved,
    TResult? Function(_Error value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Saving value)? saving,
    TResult Function(_Saved value)? saved,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClinicInfoStateCopyWith<$Res> {
  factory $ClinicInfoStateCopyWith(
    ClinicInfoState value,
    $Res Function(ClinicInfoState) then,
  ) = _$ClinicInfoStateCopyWithImpl<$Res, ClinicInfoState>;
}

/// @nodoc
class _$ClinicInfoStateCopyWithImpl<$Res, $Val extends ClinicInfoState>
    implements $ClinicInfoStateCopyWith<$Res> {
  _$ClinicInfoStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClinicInfoState
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
    extends _$ClinicInfoStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClinicInfoState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'ClinicInfoState.initial()';
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
    required TResult Function(ClinicInfoEntity clinicInfo) loaded,
    required TResult Function(ClinicInfoEntity clinicInfo) saving,
    required TResult Function(ClinicInfoEntity clinicInfo) saved,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ClinicInfoEntity clinicInfo)? loaded,
    TResult? Function(ClinicInfoEntity clinicInfo)? saving,
    TResult? Function(ClinicInfoEntity clinicInfo)? saved,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ClinicInfoEntity clinicInfo)? loaded,
    TResult Function(ClinicInfoEntity clinicInfo)? saving,
    TResult Function(ClinicInfoEntity clinicInfo)? saved,
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
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements ClinicInfoState {
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
    extends _$ClinicInfoStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClinicInfoState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'ClinicInfoState.loading()';
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
    required TResult Function(ClinicInfoEntity clinicInfo) loaded,
    required TResult Function(ClinicInfoEntity clinicInfo) saving,
    required TResult Function(ClinicInfoEntity clinicInfo) saved,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ClinicInfoEntity clinicInfo)? loaded,
    TResult? Function(ClinicInfoEntity clinicInfo)? saving,
    TResult? Function(ClinicInfoEntity clinicInfo)? saved,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ClinicInfoEntity clinicInfo)? loaded,
    TResult Function(ClinicInfoEntity clinicInfo)? saving,
    TResult Function(ClinicInfoEntity clinicInfo)? saved,
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
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements ClinicInfoState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
    _$LoadedImpl value,
    $Res Function(_$LoadedImpl) then,
  ) = __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ClinicInfoEntity clinicInfo});

  $ClinicInfoEntityCopyWith<$Res> get clinicInfo;
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$ClinicInfoStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
    _$LoadedImpl _value,
    $Res Function(_$LoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClinicInfoState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? clinicInfo = null}) {
    return _then(
      _$LoadedImpl(
        null == clinicInfo
            ? _value.clinicInfo
            : clinicInfo // ignore: cast_nullable_to_non_nullable
                  as ClinicInfoEntity,
      ),
    );
  }

  /// Create a copy of ClinicInfoState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ClinicInfoEntityCopyWith<$Res> get clinicInfo {
    return $ClinicInfoEntityCopyWith<$Res>(_value.clinicInfo, (value) {
      return _then(_value.copyWith(clinicInfo: value));
    });
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(this.clinicInfo);

  @override
  final ClinicInfoEntity clinicInfo;

  @override
  String toString() {
    return 'ClinicInfoState.loaded(clinicInfo: $clinicInfo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.clinicInfo, clinicInfo) ||
                other.clinicInfo == clinicInfo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, clinicInfo);

  /// Create a copy of ClinicInfoState
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
    required TResult Function(ClinicInfoEntity clinicInfo) loaded,
    required TResult Function(ClinicInfoEntity clinicInfo) saving,
    required TResult Function(ClinicInfoEntity clinicInfo) saved,
    required TResult Function(String message) error,
  }) {
    return loaded(clinicInfo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ClinicInfoEntity clinicInfo)? loaded,
    TResult? Function(ClinicInfoEntity clinicInfo)? saving,
    TResult? Function(ClinicInfoEntity clinicInfo)? saved,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(clinicInfo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ClinicInfoEntity clinicInfo)? loaded,
    TResult Function(ClinicInfoEntity clinicInfo)? saving,
    TResult Function(ClinicInfoEntity clinicInfo)? saved,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(clinicInfo);
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
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements ClinicInfoState {
  const factory _Loaded(final ClinicInfoEntity clinicInfo) = _$LoadedImpl;

  ClinicInfoEntity get clinicInfo;

  /// Create a copy of ClinicInfoState
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
  $Res call({ClinicInfoEntity clinicInfo});

  $ClinicInfoEntityCopyWith<$Res> get clinicInfo;
}

/// @nodoc
class __$$SavingImplCopyWithImpl<$Res>
    extends _$ClinicInfoStateCopyWithImpl<$Res, _$SavingImpl>
    implements _$$SavingImplCopyWith<$Res> {
  __$$SavingImplCopyWithImpl(
    _$SavingImpl _value,
    $Res Function(_$SavingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClinicInfoState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? clinicInfo = null}) {
    return _then(
      _$SavingImpl(
        null == clinicInfo
            ? _value.clinicInfo
            : clinicInfo // ignore: cast_nullable_to_non_nullable
                  as ClinicInfoEntity,
      ),
    );
  }

  /// Create a copy of ClinicInfoState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ClinicInfoEntityCopyWith<$Res> get clinicInfo {
    return $ClinicInfoEntityCopyWith<$Res>(_value.clinicInfo, (value) {
      return _then(_value.copyWith(clinicInfo: value));
    });
  }
}

/// @nodoc

class _$SavingImpl implements _Saving {
  const _$SavingImpl(this.clinicInfo);

  @override
  final ClinicInfoEntity clinicInfo;

  @override
  String toString() {
    return 'ClinicInfoState.saving(clinicInfo: $clinicInfo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SavingImpl &&
            (identical(other.clinicInfo, clinicInfo) ||
                other.clinicInfo == clinicInfo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, clinicInfo);

  /// Create a copy of ClinicInfoState
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
    required TResult Function(ClinicInfoEntity clinicInfo) loaded,
    required TResult Function(ClinicInfoEntity clinicInfo) saving,
    required TResult Function(ClinicInfoEntity clinicInfo) saved,
    required TResult Function(String message) error,
  }) {
    return saving(clinicInfo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ClinicInfoEntity clinicInfo)? loaded,
    TResult? Function(ClinicInfoEntity clinicInfo)? saving,
    TResult? Function(ClinicInfoEntity clinicInfo)? saved,
    TResult? Function(String message)? error,
  }) {
    return saving?.call(clinicInfo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ClinicInfoEntity clinicInfo)? loaded,
    TResult Function(ClinicInfoEntity clinicInfo)? saving,
    TResult Function(ClinicInfoEntity clinicInfo)? saved,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (saving != null) {
      return saving(clinicInfo);
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
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (saving != null) {
      return saving(this);
    }
    return orElse();
  }
}

abstract class _Saving implements ClinicInfoState {
  const factory _Saving(final ClinicInfoEntity clinicInfo) = _$SavingImpl;

  ClinicInfoEntity get clinicInfo;

  /// Create a copy of ClinicInfoState
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
  $Res call({ClinicInfoEntity clinicInfo});

  $ClinicInfoEntityCopyWith<$Res> get clinicInfo;
}

/// @nodoc
class __$$SavedImplCopyWithImpl<$Res>
    extends _$ClinicInfoStateCopyWithImpl<$Res, _$SavedImpl>
    implements _$$SavedImplCopyWith<$Res> {
  __$$SavedImplCopyWithImpl(
    _$SavedImpl _value,
    $Res Function(_$SavedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClinicInfoState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? clinicInfo = null}) {
    return _then(
      _$SavedImpl(
        null == clinicInfo
            ? _value.clinicInfo
            : clinicInfo // ignore: cast_nullable_to_non_nullable
                  as ClinicInfoEntity,
      ),
    );
  }

  /// Create a copy of ClinicInfoState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ClinicInfoEntityCopyWith<$Res> get clinicInfo {
    return $ClinicInfoEntityCopyWith<$Res>(_value.clinicInfo, (value) {
      return _then(_value.copyWith(clinicInfo: value));
    });
  }
}

/// @nodoc

class _$SavedImpl implements _Saved {
  const _$SavedImpl(this.clinicInfo);

  @override
  final ClinicInfoEntity clinicInfo;

  @override
  String toString() {
    return 'ClinicInfoState.saved(clinicInfo: $clinicInfo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SavedImpl &&
            (identical(other.clinicInfo, clinicInfo) ||
                other.clinicInfo == clinicInfo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, clinicInfo);

  /// Create a copy of ClinicInfoState
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
    required TResult Function(ClinicInfoEntity clinicInfo) loaded,
    required TResult Function(ClinicInfoEntity clinicInfo) saving,
    required TResult Function(ClinicInfoEntity clinicInfo) saved,
    required TResult Function(String message) error,
  }) {
    return saved(clinicInfo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ClinicInfoEntity clinicInfo)? loaded,
    TResult? Function(ClinicInfoEntity clinicInfo)? saving,
    TResult? Function(ClinicInfoEntity clinicInfo)? saved,
    TResult? Function(String message)? error,
  }) {
    return saved?.call(clinicInfo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ClinicInfoEntity clinicInfo)? loaded,
    TResult Function(ClinicInfoEntity clinicInfo)? saving,
    TResult Function(ClinicInfoEntity clinicInfo)? saved,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (saved != null) {
      return saved(clinicInfo);
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
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (saved != null) {
      return saved(this);
    }
    return orElse();
  }
}

abstract class _Saved implements ClinicInfoState {
  const factory _Saved(final ClinicInfoEntity clinicInfo) = _$SavedImpl;

  ClinicInfoEntity get clinicInfo;

  /// Create a copy of ClinicInfoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SavedImplCopyWith<_$SavedImpl> get copyWith =>
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
    extends _$ClinicInfoStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClinicInfoState
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
    return 'ClinicInfoState.error(message: $message)';
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

  /// Create a copy of ClinicInfoState
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
    required TResult Function(ClinicInfoEntity clinicInfo) loaded,
    required TResult Function(ClinicInfoEntity clinicInfo) saving,
    required TResult Function(ClinicInfoEntity clinicInfo) saved,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ClinicInfoEntity clinicInfo)? loaded,
    TResult? Function(ClinicInfoEntity clinicInfo)? saving,
    TResult? Function(ClinicInfoEntity clinicInfo)? saved,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ClinicInfoEntity clinicInfo)? loaded,
    TResult Function(ClinicInfoEntity clinicInfo)? saving,
    TResult Function(ClinicInfoEntity clinicInfo)? saved,
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
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements ClinicInfoState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of ClinicInfoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
