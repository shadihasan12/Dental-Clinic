// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_hours_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$UserHoursEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(List<UserWorkingDayApiModel> days) save,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(List<UserWorkingDayApiModel> days)? save,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(List<UserWorkingDayApiModel> days)? save,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_Save value) save,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_Save value)? save,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_Save value)? save,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserHoursEventCopyWith<$Res> {
  factory $UserHoursEventCopyWith(
    UserHoursEvent value,
    $Res Function(UserHoursEvent) then,
  ) = _$UserHoursEventCopyWithImpl<$Res, UserHoursEvent>;
}

/// @nodoc
class _$UserHoursEventCopyWithImpl<$Res, $Val extends UserHoursEvent>
    implements $UserHoursEventCopyWith<$Res> {
  _$UserHoursEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserHoursEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadImplCopyWith<$Res> {
  factory _$$LoadImplCopyWith(
    _$LoadImpl value,
    $Res Function(_$LoadImpl) then,
  ) = __$$LoadImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadImplCopyWithImpl<$Res>
    extends _$UserHoursEventCopyWithImpl<$Res, _$LoadImpl>
    implements _$$LoadImplCopyWith<$Res> {
  __$$LoadImplCopyWithImpl(_$LoadImpl _value, $Res Function(_$LoadImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserHoursEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadImpl implements _Load {
  const _$LoadImpl();

  @override
  String toString() {
    return 'UserHoursEvent.load()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(List<UserWorkingDayApiModel> days) save,
  }) {
    return load();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(List<UserWorkingDayApiModel> days)? save,
  }) {
    return load?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(List<UserWorkingDayApiModel> days)? save,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_Save value) save,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_Save value)? save,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_Save value)? save,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class _Load implements UserHoursEvent {
  const factory _Load() = _$LoadImpl;
}

/// @nodoc
abstract class _$$SaveImplCopyWith<$Res> {
  factory _$$SaveImplCopyWith(
    _$SaveImpl value,
    $Res Function(_$SaveImpl) then,
  ) = __$$SaveImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<UserWorkingDayApiModel> days});
}

/// @nodoc
class __$$SaveImplCopyWithImpl<$Res>
    extends _$UserHoursEventCopyWithImpl<$Res, _$SaveImpl>
    implements _$$SaveImplCopyWith<$Res> {
  __$$SaveImplCopyWithImpl(_$SaveImpl _value, $Res Function(_$SaveImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserHoursEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? days = null}) {
    return _then(
      _$SaveImpl(
        null == days
            ? _value._days
            : days // ignore: cast_nullable_to_non_nullable
                as List<UserWorkingDayApiModel>,
      ),
    );
  }
}

/// @nodoc

class _$SaveImpl implements _Save {
  const _$SaveImpl(final List<UserWorkingDayApiModel> days) : _days = days;

  final List<UserWorkingDayApiModel> _days;
  @override
  List<UserWorkingDayApiModel> get days {
    if (_days is EqualUnmodifiableListView) return _days;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_days);
  }

  @override
  String toString() {
    return 'UserHoursEvent.save(days: $days)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaveImpl &&
            const DeepCollectionEquality().equals(other._days, _days));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_days));

  /// Create a copy of UserHoursEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaveImplCopyWith<_$SaveImpl> get copyWith =>
      __$$SaveImplCopyWithImpl<_$SaveImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(List<UserWorkingDayApiModel> days) save,
  }) {
    return save(days);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(List<UserWorkingDayApiModel> days)? save,
  }) {
    return save?.call(days);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(List<UserWorkingDayApiModel> days)? save,
    required TResult orElse(),
  }) {
    if (save != null) {
      return save(days);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_Save value) save,
  }) {
    return save(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_Save value)? save,
  }) {
    return save?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_Save value)? save,
    required TResult orElse(),
  }) {
    if (save != null) {
      return save(this);
    }
    return orElse();
  }
}

abstract class _Save implements UserHoursEvent {
  const factory _Save(final List<UserWorkingDayApiModel> days) = _$SaveImpl;

  List<UserWorkingDayApiModel> get days;

  /// Create a copy of UserHoursEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaveImplCopyWith<_$SaveImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UserHoursState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<UserWorkingDayApiModel> days,
      bool isSeed,
      List<WorkingDayApiModel> clinicDays,
    ) loaded,
    required TResult Function(bool isAdmin) needsClinicHours,
    required TResult Function() saving,
    required TResult Function() saved,
    required TResult Function(String message) error,
    required TResult Function(String message) saveFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<UserWorkingDayApiModel> days,
      bool isSeed,
      List<WorkingDayApiModel> clinicDays,
    )? loaded,
    TResult? Function(bool isAdmin)? needsClinicHours,
    TResult? Function()? saving,
    TResult? Function()? saved,
    TResult? Function(String message)? error,
    TResult? Function(String message)? saveFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<UserWorkingDayApiModel> days,
      bool isSeed,
      List<WorkingDayApiModel> clinicDays,
    )? loaded,
    TResult Function(bool isAdmin)? needsClinicHours,
    TResult Function()? saving,
    TResult Function()? saved,
    TResult Function(String message)? error,
    TResult Function(String message)? saveFailed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UHInitial value) initial,
    required TResult Function(_UHLoading value) loading,
    required TResult Function(_UHLoaded value) loaded,
    required TResult Function(_UHNeedsClinicHours value) needsClinicHours,
    required TResult Function(_UHSaving value) saving,
    required TResult Function(_UHSaved value) saved,
    required TResult Function(_UHError value) error,
    required TResult Function(_UHSaveFailed value) saveFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UHInitial value)? initial,
    TResult? Function(_UHLoading value)? loading,
    TResult? Function(_UHLoaded value)? loaded,
    TResult? Function(_UHNeedsClinicHours value)? needsClinicHours,
    TResult? Function(_UHSaving value)? saving,
    TResult? Function(_UHSaved value)? saved,
    TResult? Function(_UHError value)? error,
    TResult? Function(_UHSaveFailed value)? saveFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UHInitial value)? initial,
    TResult Function(_UHLoading value)? loading,
    TResult Function(_UHLoaded value)? loaded,
    TResult Function(_UHNeedsClinicHours value)? needsClinicHours,
    TResult Function(_UHSaving value)? saving,
    TResult Function(_UHSaved value)? saved,
    TResult Function(_UHError value)? error,
    TResult Function(_UHSaveFailed value)? saveFailed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserHoursStateCopyWith<$Res> {
  factory $UserHoursStateCopyWith(
    UserHoursState value,
    $Res Function(UserHoursState) then,
  ) = _$UserHoursStateCopyWithImpl<$Res, UserHoursState>;
}

/// @nodoc
class _$UserHoursStateCopyWithImpl<$Res, $Val extends UserHoursState>
    implements $UserHoursStateCopyWith<$Res> {
  _$UserHoursStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserHoursState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$UHInitialImplCopyWith<$Res> {
  factory _$$UHInitialImplCopyWith(
    _$UHInitialImpl value,
    $Res Function(_$UHInitialImpl) then,
  ) = __$$UHInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UHInitialImplCopyWithImpl<$Res>
    extends _$UserHoursStateCopyWithImpl<$Res, _$UHInitialImpl>
    implements _$$UHInitialImplCopyWith<$Res> {
  __$$UHInitialImplCopyWithImpl(
    _$UHInitialImpl _value,
    $Res Function(_$UHInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserHoursState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UHInitialImpl implements _UHInitial {
  const _$UHInitialImpl();

  @override
  String toString() {
    return 'UserHoursState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UHInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<UserWorkingDayApiModel> days,
      bool isSeed,
      List<WorkingDayApiModel> clinicDays,
    ) loaded,
    required TResult Function(bool isAdmin) needsClinicHours,
    required TResult Function() saving,
    required TResult Function() saved,
    required TResult Function(String message) error,
    required TResult Function(String message) saveFailed,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<UserWorkingDayApiModel> days,
      bool isSeed,
      List<WorkingDayApiModel> clinicDays,
    )? loaded,
    TResult? Function(bool isAdmin)? needsClinicHours,
    TResult? Function()? saving,
    TResult? Function()? saved,
    TResult? Function(String message)? error,
    TResult? Function(String message)? saveFailed,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<UserWorkingDayApiModel> days,
      bool isSeed,
      List<WorkingDayApiModel> clinicDays,
    )? loaded,
    TResult Function(bool isAdmin)? needsClinicHours,
    TResult Function()? saving,
    TResult Function()? saved,
    TResult Function(String message)? error,
    TResult Function(String message)? saveFailed,
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
    required TResult Function(_UHInitial value) initial,
    required TResult Function(_UHLoading value) loading,
    required TResult Function(_UHLoaded value) loaded,
    required TResult Function(_UHNeedsClinicHours value) needsClinicHours,
    required TResult Function(_UHSaving value) saving,
    required TResult Function(_UHSaved value) saved,
    required TResult Function(_UHError value) error,
    required TResult Function(_UHSaveFailed value) saveFailed,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UHInitial value)? initial,
    TResult? Function(_UHLoading value)? loading,
    TResult? Function(_UHLoaded value)? loaded,
    TResult? Function(_UHNeedsClinicHours value)? needsClinicHours,
    TResult? Function(_UHSaving value)? saving,
    TResult? Function(_UHSaved value)? saved,
    TResult? Function(_UHError value)? error,
    TResult? Function(_UHSaveFailed value)? saveFailed,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UHInitial value)? initial,
    TResult Function(_UHLoading value)? loading,
    TResult Function(_UHLoaded value)? loaded,
    TResult Function(_UHNeedsClinicHours value)? needsClinicHours,
    TResult Function(_UHSaving value)? saving,
    TResult Function(_UHSaved value)? saved,
    TResult Function(_UHError value)? error,
    TResult Function(_UHSaveFailed value)? saveFailed,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _UHInitial implements UserHoursState {
  const factory _UHInitial() = _$UHInitialImpl;
}

/// @nodoc
abstract class _$$UHLoadingImplCopyWith<$Res> {
  factory _$$UHLoadingImplCopyWith(
    _$UHLoadingImpl value,
    $Res Function(_$UHLoadingImpl) then,
  ) = __$$UHLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UHLoadingImplCopyWithImpl<$Res>
    extends _$UserHoursStateCopyWithImpl<$Res, _$UHLoadingImpl>
    implements _$$UHLoadingImplCopyWith<$Res> {
  __$$UHLoadingImplCopyWithImpl(
    _$UHLoadingImpl _value,
    $Res Function(_$UHLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserHoursState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UHLoadingImpl implements _UHLoading {
  const _$UHLoadingImpl();

  @override
  String toString() {
    return 'UserHoursState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UHLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<UserWorkingDayApiModel> days,
      bool isSeed,
      List<WorkingDayApiModel> clinicDays,
    ) loaded,
    required TResult Function(bool isAdmin) needsClinicHours,
    required TResult Function() saving,
    required TResult Function() saved,
    required TResult Function(String message) error,
    required TResult Function(String message) saveFailed,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<UserWorkingDayApiModel> days,
      bool isSeed,
      List<WorkingDayApiModel> clinicDays,
    )? loaded,
    TResult? Function(bool isAdmin)? needsClinicHours,
    TResult? Function()? saving,
    TResult? Function()? saved,
    TResult? Function(String message)? error,
    TResult? Function(String message)? saveFailed,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<UserWorkingDayApiModel> days,
      bool isSeed,
      List<WorkingDayApiModel> clinicDays,
    )? loaded,
    TResult Function(bool isAdmin)? needsClinicHours,
    TResult Function()? saving,
    TResult Function()? saved,
    TResult Function(String message)? error,
    TResult Function(String message)? saveFailed,
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
    required TResult Function(_UHInitial value) initial,
    required TResult Function(_UHLoading value) loading,
    required TResult Function(_UHLoaded value) loaded,
    required TResult Function(_UHNeedsClinicHours value) needsClinicHours,
    required TResult Function(_UHSaving value) saving,
    required TResult Function(_UHSaved value) saved,
    required TResult Function(_UHError value) error,
    required TResult Function(_UHSaveFailed value) saveFailed,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UHInitial value)? initial,
    TResult? Function(_UHLoading value)? loading,
    TResult? Function(_UHLoaded value)? loaded,
    TResult? Function(_UHNeedsClinicHours value)? needsClinicHours,
    TResult? Function(_UHSaving value)? saving,
    TResult? Function(_UHSaved value)? saved,
    TResult? Function(_UHError value)? error,
    TResult? Function(_UHSaveFailed value)? saveFailed,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UHInitial value)? initial,
    TResult Function(_UHLoading value)? loading,
    TResult Function(_UHLoaded value)? loaded,
    TResult Function(_UHNeedsClinicHours value)? needsClinicHours,
    TResult Function(_UHSaving value)? saving,
    TResult Function(_UHSaved value)? saved,
    TResult Function(_UHError value)? error,
    TResult Function(_UHSaveFailed value)? saveFailed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _UHLoading implements UserHoursState {
  const factory _UHLoading() = _$UHLoadingImpl;
}

/// @nodoc
abstract class _$$UHLoadedImplCopyWith<$Res> {
  factory _$$UHLoadedImplCopyWith(
    _$UHLoadedImpl value,
    $Res Function(_$UHLoadedImpl) then,
  ) = __$$UHLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<UserWorkingDayApiModel> days,
    bool isSeed,
    List<WorkingDayApiModel> clinicDays,
  });
}

/// @nodoc
class __$$UHLoadedImplCopyWithImpl<$Res>
    extends _$UserHoursStateCopyWithImpl<$Res, _$UHLoadedImpl>
    implements _$$UHLoadedImplCopyWith<$Res> {
  __$$UHLoadedImplCopyWithImpl(
    _$UHLoadedImpl _value,
    $Res Function(_$UHLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserHoursState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? days = null,
    Object? isSeed = null,
    Object? clinicDays = null,
  }) {
    return _then(
      _$UHLoadedImpl(
        null == days
            ? _value._days
            : days // ignore: cast_nullable_to_non_nullable
                as List<UserWorkingDayApiModel>,
        isSeed: null == isSeed
            ? _value.isSeed
            : isSeed // ignore: cast_nullable_to_non_nullable
                as bool,
        clinicDays: null == clinicDays
            ? _value._clinicDays
            : clinicDays // ignore: cast_nullable_to_non_nullable
                as List<WorkingDayApiModel>,
      ),
    );
  }
}

/// @nodoc

class _$UHLoadedImpl implements _UHLoaded {
  const _$UHLoadedImpl(
    final List<UserWorkingDayApiModel> days, {
    this.isSeed = false,
    final List<WorkingDayApiModel> clinicDays = const <WorkingDayApiModel>[],
  })  : _days = days,
        _clinicDays = clinicDays;

  final List<UserWorkingDayApiModel> _days;
  @override
  List<UserWorkingDayApiModel> get days {
    if (_days is EqualUnmodifiableListView) return _days;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_days);
  }

  @override
  @JsonKey()
  final bool isSeed;
  final List<WorkingDayApiModel> _clinicDays;
  @override
  @JsonKey()
  List<WorkingDayApiModel> get clinicDays {
    if (_clinicDays is EqualUnmodifiableListView) return _clinicDays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_clinicDays);
  }

  @override
  String toString() {
    return 'UserHoursState.loaded(days: $days, isSeed: $isSeed, clinicDays: $clinicDays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UHLoadedImpl &&
            const DeepCollectionEquality().equals(other._days, _days) &&
            (identical(other.isSeed, isSeed) || other.isSeed == isSeed) &&
            const DeepCollectionEquality().equals(
              other._clinicDays,
              _clinicDays,
            ));
  }

  @override
  int get hashCode => Object.hash(
        runtimeType,
        const DeepCollectionEquality().hash(_days),
        isSeed,
        const DeepCollectionEquality().hash(_clinicDays),
      );

  /// Create a copy of UserHoursState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UHLoadedImplCopyWith<_$UHLoadedImpl> get copyWith =>
      __$$UHLoadedImplCopyWithImpl<_$UHLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<UserWorkingDayApiModel> days,
      bool isSeed,
      List<WorkingDayApiModel> clinicDays,
    ) loaded,
    required TResult Function(bool isAdmin) needsClinicHours,
    required TResult Function() saving,
    required TResult Function() saved,
    required TResult Function(String message) error,
    required TResult Function(String message) saveFailed,
  }) {
    return loaded(days, isSeed, clinicDays);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<UserWorkingDayApiModel> days,
      bool isSeed,
      List<WorkingDayApiModel> clinicDays,
    )? loaded,
    TResult? Function(bool isAdmin)? needsClinicHours,
    TResult? Function()? saving,
    TResult? Function()? saved,
    TResult? Function(String message)? error,
    TResult? Function(String message)? saveFailed,
  }) {
    return loaded?.call(days, isSeed, clinicDays);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<UserWorkingDayApiModel> days,
      bool isSeed,
      List<WorkingDayApiModel> clinicDays,
    )? loaded,
    TResult Function(bool isAdmin)? needsClinicHours,
    TResult Function()? saving,
    TResult Function()? saved,
    TResult Function(String message)? error,
    TResult Function(String message)? saveFailed,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(days, isSeed, clinicDays);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UHInitial value) initial,
    required TResult Function(_UHLoading value) loading,
    required TResult Function(_UHLoaded value) loaded,
    required TResult Function(_UHNeedsClinicHours value) needsClinicHours,
    required TResult Function(_UHSaving value) saving,
    required TResult Function(_UHSaved value) saved,
    required TResult Function(_UHError value) error,
    required TResult Function(_UHSaveFailed value) saveFailed,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UHInitial value)? initial,
    TResult? Function(_UHLoading value)? loading,
    TResult? Function(_UHLoaded value)? loaded,
    TResult? Function(_UHNeedsClinicHours value)? needsClinicHours,
    TResult? Function(_UHSaving value)? saving,
    TResult? Function(_UHSaved value)? saved,
    TResult? Function(_UHError value)? error,
    TResult? Function(_UHSaveFailed value)? saveFailed,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UHInitial value)? initial,
    TResult Function(_UHLoading value)? loading,
    TResult Function(_UHLoaded value)? loaded,
    TResult Function(_UHNeedsClinicHours value)? needsClinicHours,
    TResult Function(_UHSaving value)? saving,
    TResult Function(_UHSaved value)? saved,
    TResult Function(_UHError value)? error,
    TResult Function(_UHSaveFailed value)? saveFailed,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _UHLoaded implements UserHoursState {
  const factory _UHLoaded(
    final List<UserWorkingDayApiModel> days, {
    final bool isSeed,
    final List<WorkingDayApiModel> clinicDays,
  }) = _$UHLoadedImpl;

  List<UserWorkingDayApiModel> get days;
  bool get isSeed;
  List<WorkingDayApiModel> get clinicDays;

  /// Create a copy of UserHoursState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UHLoadedImplCopyWith<_$UHLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UHNeedsClinicHoursImplCopyWith<$Res> {
  factory _$$UHNeedsClinicHoursImplCopyWith(
    _$UHNeedsClinicHoursImpl value,
    $Res Function(_$UHNeedsClinicHoursImpl) then,
  ) = __$$UHNeedsClinicHoursImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool isAdmin});
}

/// @nodoc
class __$$UHNeedsClinicHoursImplCopyWithImpl<$Res>
    extends _$UserHoursStateCopyWithImpl<$Res, _$UHNeedsClinicHoursImpl>
    implements _$$UHNeedsClinicHoursImplCopyWith<$Res> {
  __$$UHNeedsClinicHoursImplCopyWithImpl(
    _$UHNeedsClinicHoursImpl _value,
    $Res Function(_$UHNeedsClinicHoursImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserHoursState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? isAdmin = null}) {
    return _then(
      _$UHNeedsClinicHoursImpl(
        isAdmin: null == isAdmin
            ? _value.isAdmin
            : isAdmin // ignore: cast_nullable_to_non_nullable
                as bool,
      ),
    );
  }
}

/// @nodoc

class _$UHNeedsClinicHoursImpl implements _UHNeedsClinicHours {
  const _$UHNeedsClinicHoursImpl({required this.isAdmin});

  @override
  final bool isAdmin;

  @override
  String toString() {
    return 'UserHoursState.needsClinicHours(isAdmin: $isAdmin)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UHNeedsClinicHoursImpl &&
            (identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isAdmin);

  /// Create a copy of UserHoursState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UHNeedsClinicHoursImplCopyWith<_$UHNeedsClinicHoursImpl> get copyWith =>
      __$$UHNeedsClinicHoursImplCopyWithImpl<_$UHNeedsClinicHoursImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<UserWorkingDayApiModel> days,
      bool isSeed,
      List<WorkingDayApiModel> clinicDays,
    ) loaded,
    required TResult Function(bool isAdmin) needsClinicHours,
    required TResult Function() saving,
    required TResult Function() saved,
    required TResult Function(String message) error,
    required TResult Function(String message) saveFailed,
  }) {
    return needsClinicHours(isAdmin);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<UserWorkingDayApiModel> days,
      bool isSeed,
      List<WorkingDayApiModel> clinicDays,
    )? loaded,
    TResult? Function(bool isAdmin)? needsClinicHours,
    TResult? Function()? saving,
    TResult? Function()? saved,
    TResult? Function(String message)? error,
    TResult? Function(String message)? saveFailed,
  }) {
    return needsClinicHours?.call(isAdmin);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<UserWorkingDayApiModel> days,
      bool isSeed,
      List<WorkingDayApiModel> clinicDays,
    )? loaded,
    TResult Function(bool isAdmin)? needsClinicHours,
    TResult Function()? saving,
    TResult Function()? saved,
    TResult Function(String message)? error,
    TResult Function(String message)? saveFailed,
    required TResult orElse(),
  }) {
    if (needsClinicHours != null) {
      return needsClinicHours(isAdmin);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UHInitial value) initial,
    required TResult Function(_UHLoading value) loading,
    required TResult Function(_UHLoaded value) loaded,
    required TResult Function(_UHNeedsClinicHours value) needsClinicHours,
    required TResult Function(_UHSaving value) saving,
    required TResult Function(_UHSaved value) saved,
    required TResult Function(_UHError value) error,
    required TResult Function(_UHSaveFailed value) saveFailed,
  }) {
    return needsClinicHours(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UHInitial value)? initial,
    TResult? Function(_UHLoading value)? loading,
    TResult? Function(_UHLoaded value)? loaded,
    TResult? Function(_UHNeedsClinicHours value)? needsClinicHours,
    TResult? Function(_UHSaving value)? saving,
    TResult? Function(_UHSaved value)? saved,
    TResult? Function(_UHError value)? error,
    TResult? Function(_UHSaveFailed value)? saveFailed,
  }) {
    return needsClinicHours?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UHInitial value)? initial,
    TResult Function(_UHLoading value)? loading,
    TResult Function(_UHLoaded value)? loaded,
    TResult Function(_UHNeedsClinicHours value)? needsClinicHours,
    TResult Function(_UHSaving value)? saving,
    TResult Function(_UHSaved value)? saved,
    TResult Function(_UHError value)? error,
    TResult Function(_UHSaveFailed value)? saveFailed,
    required TResult orElse(),
  }) {
    if (needsClinicHours != null) {
      return needsClinicHours(this);
    }
    return orElse();
  }
}

abstract class _UHNeedsClinicHours implements UserHoursState {
  const factory _UHNeedsClinicHours({required final bool isAdmin}) =
      _$UHNeedsClinicHoursImpl;

  bool get isAdmin;

  /// Create a copy of UserHoursState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UHNeedsClinicHoursImplCopyWith<_$UHNeedsClinicHoursImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UHSavingImplCopyWith<$Res> {
  factory _$$UHSavingImplCopyWith(
    _$UHSavingImpl value,
    $Res Function(_$UHSavingImpl) then,
  ) = __$$UHSavingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UHSavingImplCopyWithImpl<$Res>
    extends _$UserHoursStateCopyWithImpl<$Res, _$UHSavingImpl>
    implements _$$UHSavingImplCopyWith<$Res> {
  __$$UHSavingImplCopyWithImpl(
    _$UHSavingImpl _value,
    $Res Function(_$UHSavingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserHoursState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UHSavingImpl implements _UHSaving {
  const _$UHSavingImpl();

  @override
  String toString() {
    return 'UserHoursState.saving()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UHSavingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<UserWorkingDayApiModel> days,
      bool isSeed,
      List<WorkingDayApiModel> clinicDays,
    ) loaded,
    required TResult Function(bool isAdmin) needsClinicHours,
    required TResult Function() saving,
    required TResult Function() saved,
    required TResult Function(String message) error,
    required TResult Function(String message) saveFailed,
  }) {
    return saving();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<UserWorkingDayApiModel> days,
      bool isSeed,
      List<WorkingDayApiModel> clinicDays,
    )? loaded,
    TResult? Function(bool isAdmin)? needsClinicHours,
    TResult? Function()? saving,
    TResult? Function()? saved,
    TResult? Function(String message)? error,
    TResult? Function(String message)? saveFailed,
  }) {
    return saving?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<UserWorkingDayApiModel> days,
      bool isSeed,
      List<WorkingDayApiModel> clinicDays,
    )? loaded,
    TResult Function(bool isAdmin)? needsClinicHours,
    TResult Function()? saving,
    TResult Function()? saved,
    TResult Function(String message)? error,
    TResult Function(String message)? saveFailed,
    required TResult orElse(),
  }) {
    if (saving != null) {
      return saving();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UHInitial value) initial,
    required TResult Function(_UHLoading value) loading,
    required TResult Function(_UHLoaded value) loaded,
    required TResult Function(_UHNeedsClinicHours value) needsClinicHours,
    required TResult Function(_UHSaving value) saving,
    required TResult Function(_UHSaved value) saved,
    required TResult Function(_UHError value) error,
    required TResult Function(_UHSaveFailed value) saveFailed,
  }) {
    return saving(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UHInitial value)? initial,
    TResult? Function(_UHLoading value)? loading,
    TResult? Function(_UHLoaded value)? loaded,
    TResult? Function(_UHNeedsClinicHours value)? needsClinicHours,
    TResult? Function(_UHSaving value)? saving,
    TResult? Function(_UHSaved value)? saved,
    TResult? Function(_UHError value)? error,
    TResult? Function(_UHSaveFailed value)? saveFailed,
  }) {
    return saving?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UHInitial value)? initial,
    TResult Function(_UHLoading value)? loading,
    TResult Function(_UHLoaded value)? loaded,
    TResult Function(_UHNeedsClinicHours value)? needsClinicHours,
    TResult Function(_UHSaving value)? saving,
    TResult Function(_UHSaved value)? saved,
    TResult Function(_UHError value)? error,
    TResult Function(_UHSaveFailed value)? saveFailed,
    required TResult orElse(),
  }) {
    if (saving != null) {
      return saving(this);
    }
    return orElse();
  }
}

abstract class _UHSaving implements UserHoursState {
  const factory _UHSaving() = _$UHSavingImpl;
}

/// @nodoc
abstract class _$$UHSavedImplCopyWith<$Res> {
  factory _$$UHSavedImplCopyWith(
    _$UHSavedImpl value,
    $Res Function(_$UHSavedImpl) then,
  ) = __$$UHSavedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UHSavedImplCopyWithImpl<$Res>
    extends _$UserHoursStateCopyWithImpl<$Res, _$UHSavedImpl>
    implements _$$UHSavedImplCopyWith<$Res> {
  __$$UHSavedImplCopyWithImpl(
    _$UHSavedImpl _value,
    $Res Function(_$UHSavedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserHoursState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UHSavedImpl implements _UHSaved {
  const _$UHSavedImpl();

  @override
  String toString() {
    return 'UserHoursState.saved()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UHSavedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<UserWorkingDayApiModel> days,
      bool isSeed,
      List<WorkingDayApiModel> clinicDays,
    ) loaded,
    required TResult Function(bool isAdmin) needsClinicHours,
    required TResult Function() saving,
    required TResult Function() saved,
    required TResult Function(String message) error,
    required TResult Function(String message) saveFailed,
  }) {
    return saved();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<UserWorkingDayApiModel> days,
      bool isSeed,
      List<WorkingDayApiModel> clinicDays,
    )? loaded,
    TResult? Function(bool isAdmin)? needsClinicHours,
    TResult? Function()? saving,
    TResult? Function()? saved,
    TResult? Function(String message)? error,
    TResult? Function(String message)? saveFailed,
  }) {
    return saved?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<UserWorkingDayApiModel> days,
      bool isSeed,
      List<WorkingDayApiModel> clinicDays,
    )? loaded,
    TResult Function(bool isAdmin)? needsClinicHours,
    TResult Function()? saving,
    TResult Function()? saved,
    TResult Function(String message)? error,
    TResult Function(String message)? saveFailed,
    required TResult orElse(),
  }) {
    if (saved != null) {
      return saved();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UHInitial value) initial,
    required TResult Function(_UHLoading value) loading,
    required TResult Function(_UHLoaded value) loaded,
    required TResult Function(_UHNeedsClinicHours value) needsClinicHours,
    required TResult Function(_UHSaving value) saving,
    required TResult Function(_UHSaved value) saved,
    required TResult Function(_UHError value) error,
    required TResult Function(_UHSaveFailed value) saveFailed,
  }) {
    return saved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UHInitial value)? initial,
    TResult? Function(_UHLoading value)? loading,
    TResult? Function(_UHLoaded value)? loaded,
    TResult? Function(_UHNeedsClinicHours value)? needsClinicHours,
    TResult? Function(_UHSaving value)? saving,
    TResult? Function(_UHSaved value)? saved,
    TResult? Function(_UHError value)? error,
    TResult? Function(_UHSaveFailed value)? saveFailed,
  }) {
    return saved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UHInitial value)? initial,
    TResult Function(_UHLoading value)? loading,
    TResult Function(_UHLoaded value)? loaded,
    TResult Function(_UHNeedsClinicHours value)? needsClinicHours,
    TResult Function(_UHSaving value)? saving,
    TResult Function(_UHSaved value)? saved,
    TResult Function(_UHError value)? error,
    TResult Function(_UHSaveFailed value)? saveFailed,
    required TResult orElse(),
  }) {
    if (saved != null) {
      return saved(this);
    }
    return orElse();
  }
}

abstract class _UHSaved implements UserHoursState {
  const factory _UHSaved() = _$UHSavedImpl;
}

/// @nodoc
abstract class _$$UHErrorImplCopyWith<$Res> {
  factory _$$UHErrorImplCopyWith(
    _$UHErrorImpl value,
    $Res Function(_$UHErrorImpl) then,
  ) = __$$UHErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$UHErrorImplCopyWithImpl<$Res>
    extends _$UserHoursStateCopyWithImpl<$Res, _$UHErrorImpl>
    implements _$$UHErrorImplCopyWith<$Res> {
  __$$UHErrorImplCopyWithImpl(
    _$UHErrorImpl _value,
    $Res Function(_$UHErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserHoursState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$UHErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$UHErrorImpl implements _UHError {
  const _$UHErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'UserHoursState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UHErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of UserHoursState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UHErrorImplCopyWith<_$UHErrorImpl> get copyWith =>
      __$$UHErrorImplCopyWithImpl<_$UHErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<UserWorkingDayApiModel> days,
      bool isSeed,
      List<WorkingDayApiModel> clinicDays,
    ) loaded,
    required TResult Function(bool isAdmin) needsClinicHours,
    required TResult Function() saving,
    required TResult Function() saved,
    required TResult Function(String message) error,
    required TResult Function(String message) saveFailed,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<UserWorkingDayApiModel> days,
      bool isSeed,
      List<WorkingDayApiModel> clinicDays,
    )? loaded,
    TResult? Function(bool isAdmin)? needsClinicHours,
    TResult? Function()? saving,
    TResult? Function()? saved,
    TResult? Function(String message)? error,
    TResult? Function(String message)? saveFailed,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<UserWorkingDayApiModel> days,
      bool isSeed,
      List<WorkingDayApiModel> clinicDays,
    )? loaded,
    TResult Function(bool isAdmin)? needsClinicHours,
    TResult Function()? saving,
    TResult Function()? saved,
    TResult Function(String message)? error,
    TResult Function(String message)? saveFailed,
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
    required TResult Function(_UHInitial value) initial,
    required TResult Function(_UHLoading value) loading,
    required TResult Function(_UHLoaded value) loaded,
    required TResult Function(_UHNeedsClinicHours value) needsClinicHours,
    required TResult Function(_UHSaving value) saving,
    required TResult Function(_UHSaved value) saved,
    required TResult Function(_UHError value) error,
    required TResult Function(_UHSaveFailed value) saveFailed,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UHInitial value)? initial,
    TResult? Function(_UHLoading value)? loading,
    TResult? Function(_UHLoaded value)? loaded,
    TResult? Function(_UHNeedsClinicHours value)? needsClinicHours,
    TResult? Function(_UHSaving value)? saving,
    TResult? Function(_UHSaved value)? saved,
    TResult? Function(_UHError value)? error,
    TResult? Function(_UHSaveFailed value)? saveFailed,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UHInitial value)? initial,
    TResult Function(_UHLoading value)? loading,
    TResult Function(_UHLoaded value)? loaded,
    TResult Function(_UHNeedsClinicHours value)? needsClinicHours,
    TResult Function(_UHSaving value)? saving,
    TResult Function(_UHSaved value)? saved,
    TResult Function(_UHError value)? error,
    TResult Function(_UHSaveFailed value)? saveFailed,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _UHError implements UserHoursState {
  const factory _UHError(final String message) = _$UHErrorImpl;

  String get message;

  /// Create a copy of UserHoursState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UHErrorImplCopyWith<_$UHErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UHSaveFailedImplCopyWith<$Res> {
  factory _$$UHSaveFailedImplCopyWith(
    _$UHSaveFailedImpl value,
    $Res Function(_$UHSaveFailedImpl) then,
  ) = __$$UHSaveFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$UHSaveFailedImplCopyWithImpl<$Res>
    extends _$UserHoursStateCopyWithImpl<$Res, _$UHSaveFailedImpl>
    implements _$$UHSaveFailedImplCopyWith<$Res> {
  __$$UHSaveFailedImplCopyWithImpl(
    _$UHSaveFailedImpl _value,
    $Res Function(_$UHSaveFailedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserHoursState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$UHSaveFailedImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$UHSaveFailedImpl implements _UHSaveFailed {
  const _$UHSaveFailedImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'UserHoursState.saveFailed(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UHSaveFailedImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of UserHoursState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UHSaveFailedImplCopyWith<_$UHSaveFailedImpl> get copyWith =>
      __$$UHSaveFailedImplCopyWithImpl<_$UHSaveFailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<UserWorkingDayApiModel> days,
      bool isSeed,
      List<WorkingDayApiModel> clinicDays,
    ) loaded,
    required TResult Function(bool isAdmin) needsClinicHours,
    required TResult Function() saving,
    required TResult Function() saved,
    required TResult Function(String message) error,
    required TResult Function(String message) saveFailed,
  }) {
    return saveFailed(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<UserWorkingDayApiModel> days,
      bool isSeed,
      List<WorkingDayApiModel> clinicDays,
    )? loaded,
    TResult? Function(bool isAdmin)? needsClinicHours,
    TResult? Function()? saving,
    TResult? Function()? saved,
    TResult? Function(String message)? error,
    TResult? Function(String message)? saveFailed,
  }) {
    return saveFailed?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<UserWorkingDayApiModel> days,
      bool isSeed,
      List<WorkingDayApiModel> clinicDays,
    )? loaded,
    TResult Function(bool isAdmin)? needsClinicHours,
    TResult Function()? saving,
    TResult Function()? saved,
    TResult Function(String message)? error,
    TResult Function(String message)? saveFailed,
    required TResult orElse(),
  }) {
    if (saveFailed != null) {
      return saveFailed(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UHInitial value) initial,
    required TResult Function(_UHLoading value) loading,
    required TResult Function(_UHLoaded value) loaded,
    required TResult Function(_UHNeedsClinicHours value) needsClinicHours,
    required TResult Function(_UHSaving value) saving,
    required TResult Function(_UHSaved value) saved,
    required TResult Function(_UHError value) error,
    required TResult Function(_UHSaveFailed value) saveFailed,
  }) {
    return saveFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UHInitial value)? initial,
    TResult? Function(_UHLoading value)? loading,
    TResult? Function(_UHLoaded value)? loaded,
    TResult? Function(_UHNeedsClinicHours value)? needsClinicHours,
    TResult? Function(_UHSaving value)? saving,
    TResult? Function(_UHSaved value)? saved,
    TResult? Function(_UHError value)? error,
    TResult? Function(_UHSaveFailed value)? saveFailed,
  }) {
    return saveFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UHInitial value)? initial,
    TResult Function(_UHLoading value)? loading,
    TResult Function(_UHLoaded value)? loaded,
    TResult Function(_UHNeedsClinicHours value)? needsClinicHours,
    TResult Function(_UHSaving value)? saving,
    TResult Function(_UHSaved value)? saved,
    TResult Function(_UHError value)? error,
    TResult Function(_UHSaveFailed value)? saveFailed,
    required TResult orElse(),
  }) {
    if (saveFailed != null) {
      return saveFailed(this);
    }
    return orElse();
  }
}

abstract class _UHSaveFailed implements UserHoursState {
  const factory _UHSaveFailed(final String message) = _$UHSaveFailedImpl;

  String get message;

  /// Create a copy of UserHoursState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UHSaveFailedImplCopyWith<_$UHSaveFailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
