// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'working_days_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WorkingDaysEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(
      List<WorkingDayApiModel> workingDays,
      List<HolidayApiModel> holidays,
    )
    saveAll,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(
      List<WorkingDayApiModel> workingDays,
      List<HolidayApiModel> holidays,
    )?
    saveAll,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(
      List<WorkingDayApiModel> workingDays,
      List<HolidayApiModel> holidays,
    )?
    saveAll,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_SaveAll value) saveAll,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_SaveAll value)? saveAll,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_SaveAll value)? saveAll,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkingDaysEventCopyWith<$Res> {
  factory $WorkingDaysEventCopyWith(
    WorkingDaysEvent value,
    $Res Function(WorkingDaysEvent) then,
  ) = _$WorkingDaysEventCopyWithImpl<$Res, WorkingDaysEvent>;
}

/// @nodoc
class _$WorkingDaysEventCopyWithImpl<$Res, $Val extends WorkingDaysEvent>
    implements $WorkingDaysEventCopyWith<$Res> {
  _$WorkingDaysEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkingDaysEvent
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
    extends _$WorkingDaysEventCopyWithImpl<$Res, _$LoadImpl>
    implements _$$LoadImplCopyWith<$Res> {
  __$$LoadImplCopyWithImpl(_$LoadImpl _value, $Res Function(_$LoadImpl) _then)
    : super(_value, _then);

  /// Create a copy of WorkingDaysEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadImpl implements _Load {
  const _$LoadImpl();

  @override
  String toString() {
    return 'WorkingDaysEvent.load()';
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
    required TResult Function(
      List<WorkingDayApiModel> workingDays,
      List<HolidayApiModel> holidays,
    )
    saveAll,
  }) {
    return load();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(
      List<WorkingDayApiModel> workingDays,
      List<HolidayApiModel> holidays,
    )?
    saveAll,
  }) {
    return load?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(
      List<WorkingDayApiModel> workingDays,
      List<HolidayApiModel> holidays,
    )?
    saveAll,
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
    required TResult Function(_SaveAll value) saveAll,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_SaveAll value)? saveAll,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_SaveAll value)? saveAll,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class _Load implements WorkingDaysEvent {
  const factory _Load() = _$LoadImpl;
}

/// @nodoc
abstract class _$$SaveAllImplCopyWith<$Res> {
  factory _$$SaveAllImplCopyWith(
    _$SaveAllImpl value,
    $Res Function(_$SaveAllImpl) then,
  ) = __$$SaveAllImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<WorkingDayApiModel> workingDays,
    List<HolidayApiModel> holidays,
  });
}

/// @nodoc
class __$$SaveAllImplCopyWithImpl<$Res>
    extends _$WorkingDaysEventCopyWithImpl<$Res, _$SaveAllImpl>
    implements _$$SaveAllImplCopyWith<$Res> {
  __$$SaveAllImplCopyWithImpl(
    _$SaveAllImpl _value,
    $Res Function(_$SaveAllImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkingDaysEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? workingDays = null, Object? holidays = null}) {
    return _then(
      _$SaveAllImpl(
        workingDays: null == workingDays
            ? _value._workingDays
            : workingDays // ignore: cast_nullable_to_non_nullable
                  as List<WorkingDayApiModel>,
        holidays: null == holidays
            ? _value._holidays
            : holidays // ignore: cast_nullable_to_non_nullable
                  as List<HolidayApiModel>,
      ),
    );
  }
}

/// @nodoc

class _$SaveAllImpl implements _SaveAll {
  const _$SaveAllImpl({
    required final List<WorkingDayApiModel> workingDays,
    required final List<HolidayApiModel> holidays,
  }) : _workingDays = workingDays,
       _holidays = holidays;

  final List<WorkingDayApiModel> _workingDays;
  @override
  List<WorkingDayApiModel> get workingDays {
    if (_workingDays is EqualUnmodifiableListView) return _workingDays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_workingDays);
  }

  final List<HolidayApiModel> _holidays;
  @override
  List<HolidayApiModel> get holidays {
    if (_holidays is EqualUnmodifiableListView) return _holidays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_holidays);
  }

  @override
  String toString() {
    return 'WorkingDaysEvent.saveAll(workingDays: $workingDays, holidays: $holidays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaveAllImpl &&
            const DeepCollectionEquality().equals(
              other._workingDays,
              _workingDays,
            ) &&
            const DeepCollectionEquality().equals(other._holidays, _holidays));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_workingDays),
    const DeepCollectionEquality().hash(_holidays),
  );

  /// Create a copy of WorkingDaysEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaveAllImplCopyWith<_$SaveAllImpl> get copyWith =>
      __$$SaveAllImplCopyWithImpl<_$SaveAllImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(
      List<WorkingDayApiModel> workingDays,
      List<HolidayApiModel> holidays,
    )
    saveAll,
  }) {
    return saveAll(workingDays, holidays);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(
      List<WorkingDayApiModel> workingDays,
      List<HolidayApiModel> holidays,
    )?
    saveAll,
  }) {
    return saveAll?.call(workingDays, holidays);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(
      List<WorkingDayApiModel> workingDays,
      List<HolidayApiModel> holidays,
    )?
    saveAll,
    required TResult orElse(),
  }) {
    if (saveAll != null) {
      return saveAll(workingDays, holidays);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_SaveAll value) saveAll,
  }) {
    return saveAll(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_SaveAll value)? saveAll,
  }) {
    return saveAll?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_SaveAll value)? saveAll,
    required TResult orElse(),
  }) {
    if (saveAll != null) {
      return saveAll(this);
    }
    return orElse();
  }
}

abstract class _SaveAll implements WorkingDaysEvent {
  const factory _SaveAll({
    required final List<WorkingDayApiModel> workingDays,
    required final List<HolidayApiModel> holidays,
  }) = _$SaveAllImpl;

  List<WorkingDayApiModel> get workingDays;
  List<HolidayApiModel> get holidays;

  /// Create a copy of WorkingDaysEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaveAllImplCopyWith<_$SaveAllImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$WorkingDaysState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<WorkingDayApiModel> workingDays,
      List<HolidayApiModel> holidays,
    )
    loaded,
    required TResult Function() saving,
    required TResult Function() saved,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<WorkingDayApiModel> workingDays,
      List<HolidayApiModel> holidays,
    )?
    loaded,
    TResult? Function()? saving,
    TResult? Function()? saved,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<WorkingDayApiModel> workingDays,
      List<HolidayApiModel> holidays,
    )?
    loaded,
    TResult Function()? saving,
    TResult Function()? saved,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WDInitial value) initial,
    required TResult Function(_WDLoading value) loading,
    required TResult Function(_WDLoaded value) loaded,
    required TResult Function(_WDSaving value) saving,
    required TResult Function(_WDSaved value) saved,
    required TResult Function(_WDError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WDInitial value)? initial,
    TResult? Function(_WDLoading value)? loading,
    TResult? Function(_WDLoaded value)? loaded,
    TResult? Function(_WDSaving value)? saving,
    TResult? Function(_WDSaved value)? saved,
    TResult? Function(_WDError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WDInitial value)? initial,
    TResult Function(_WDLoading value)? loading,
    TResult Function(_WDLoaded value)? loaded,
    TResult Function(_WDSaving value)? saving,
    TResult Function(_WDSaved value)? saved,
    TResult Function(_WDError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkingDaysStateCopyWith<$Res> {
  factory $WorkingDaysStateCopyWith(
    WorkingDaysState value,
    $Res Function(WorkingDaysState) then,
  ) = _$WorkingDaysStateCopyWithImpl<$Res, WorkingDaysState>;
}

/// @nodoc
class _$WorkingDaysStateCopyWithImpl<$Res, $Val extends WorkingDaysState>
    implements $WorkingDaysStateCopyWith<$Res> {
  _$WorkingDaysStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkingDaysState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$WDInitialImplCopyWith<$Res> {
  factory _$$WDInitialImplCopyWith(
    _$WDInitialImpl value,
    $Res Function(_$WDInitialImpl) then,
  ) = __$$WDInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WDInitialImplCopyWithImpl<$Res>
    extends _$WorkingDaysStateCopyWithImpl<$Res, _$WDInitialImpl>
    implements _$$WDInitialImplCopyWith<$Res> {
  __$$WDInitialImplCopyWithImpl(
    _$WDInitialImpl _value,
    $Res Function(_$WDInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkingDaysState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$WDInitialImpl implements _WDInitial {
  const _$WDInitialImpl();

  @override
  String toString() {
    return 'WorkingDaysState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$WDInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<WorkingDayApiModel> workingDays,
      List<HolidayApiModel> holidays,
    )
    loaded,
    required TResult Function() saving,
    required TResult Function() saved,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<WorkingDayApiModel> workingDays,
      List<HolidayApiModel> holidays,
    )?
    loaded,
    TResult? Function()? saving,
    TResult? Function()? saved,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<WorkingDayApiModel> workingDays,
      List<HolidayApiModel> holidays,
    )?
    loaded,
    TResult Function()? saving,
    TResult Function()? saved,
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
    required TResult Function(_WDInitial value) initial,
    required TResult Function(_WDLoading value) loading,
    required TResult Function(_WDLoaded value) loaded,
    required TResult Function(_WDSaving value) saving,
    required TResult Function(_WDSaved value) saved,
    required TResult Function(_WDError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WDInitial value)? initial,
    TResult? Function(_WDLoading value)? loading,
    TResult? Function(_WDLoaded value)? loaded,
    TResult? Function(_WDSaving value)? saving,
    TResult? Function(_WDSaved value)? saved,
    TResult? Function(_WDError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WDInitial value)? initial,
    TResult Function(_WDLoading value)? loading,
    TResult Function(_WDLoaded value)? loaded,
    TResult Function(_WDSaving value)? saving,
    TResult Function(_WDSaved value)? saved,
    TResult Function(_WDError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _WDInitial implements WorkingDaysState {
  const factory _WDInitial() = _$WDInitialImpl;
}

/// @nodoc
abstract class _$$WDLoadingImplCopyWith<$Res> {
  factory _$$WDLoadingImplCopyWith(
    _$WDLoadingImpl value,
    $Res Function(_$WDLoadingImpl) then,
  ) = __$$WDLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WDLoadingImplCopyWithImpl<$Res>
    extends _$WorkingDaysStateCopyWithImpl<$Res, _$WDLoadingImpl>
    implements _$$WDLoadingImplCopyWith<$Res> {
  __$$WDLoadingImplCopyWithImpl(
    _$WDLoadingImpl _value,
    $Res Function(_$WDLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkingDaysState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$WDLoadingImpl implements _WDLoading {
  const _$WDLoadingImpl();

  @override
  String toString() {
    return 'WorkingDaysState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$WDLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<WorkingDayApiModel> workingDays,
      List<HolidayApiModel> holidays,
    )
    loaded,
    required TResult Function() saving,
    required TResult Function() saved,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<WorkingDayApiModel> workingDays,
      List<HolidayApiModel> holidays,
    )?
    loaded,
    TResult? Function()? saving,
    TResult? Function()? saved,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<WorkingDayApiModel> workingDays,
      List<HolidayApiModel> holidays,
    )?
    loaded,
    TResult Function()? saving,
    TResult Function()? saved,
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
    required TResult Function(_WDInitial value) initial,
    required TResult Function(_WDLoading value) loading,
    required TResult Function(_WDLoaded value) loaded,
    required TResult Function(_WDSaving value) saving,
    required TResult Function(_WDSaved value) saved,
    required TResult Function(_WDError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WDInitial value)? initial,
    TResult? Function(_WDLoading value)? loading,
    TResult? Function(_WDLoaded value)? loaded,
    TResult? Function(_WDSaving value)? saving,
    TResult? Function(_WDSaved value)? saved,
    TResult? Function(_WDError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WDInitial value)? initial,
    TResult Function(_WDLoading value)? loading,
    TResult Function(_WDLoaded value)? loaded,
    TResult Function(_WDSaving value)? saving,
    TResult Function(_WDSaved value)? saved,
    TResult Function(_WDError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _WDLoading implements WorkingDaysState {
  const factory _WDLoading() = _$WDLoadingImpl;
}

/// @nodoc
abstract class _$$WDLoadedImplCopyWith<$Res> {
  factory _$$WDLoadedImplCopyWith(
    _$WDLoadedImpl value,
    $Res Function(_$WDLoadedImpl) then,
  ) = __$$WDLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<WorkingDayApiModel> workingDays,
    List<HolidayApiModel> holidays,
  });
}

/// @nodoc
class __$$WDLoadedImplCopyWithImpl<$Res>
    extends _$WorkingDaysStateCopyWithImpl<$Res, _$WDLoadedImpl>
    implements _$$WDLoadedImplCopyWith<$Res> {
  __$$WDLoadedImplCopyWithImpl(
    _$WDLoadedImpl _value,
    $Res Function(_$WDLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkingDaysState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? workingDays = null, Object? holidays = null}) {
    return _then(
      _$WDLoadedImpl(
        workingDays: null == workingDays
            ? _value._workingDays
            : workingDays // ignore: cast_nullable_to_non_nullable
                  as List<WorkingDayApiModel>,
        holidays: null == holidays
            ? _value._holidays
            : holidays // ignore: cast_nullable_to_non_nullable
                  as List<HolidayApiModel>,
      ),
    );
  }
}

/// @nodoc

class _$WDLoadedImpl implements _WDLoaded {
  const _$WDLoadedImpl({
    required final List<WorkingDayApiModel> workingDays,
    required final List<HolidayApiModel> holidays,
  }) : _workingDays = workingDays,
       _holidays = holidays;

  final List<WorkingDayApiModel> _workingDays;
  @override
  List<WorkingDayApiModel> get workingDays {
    if (_workingDays is EqualUnmodifiableListView) return _workingDays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_workingDays);
  }

  final List<HolidayApiModel> _holidays;
  @override
  List<HolidayApiModel> get holidays {
    if (_holidays is EqualUnmodifiableListView) return _holidays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_holidays);
  }

  @override
  String toString() {
    return 'WorkingDaysState.loaded(workingDays: $workingDays, holidays: $holidays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WDLoadedImpl &&
            const DeepCollectionEquality().equals(
              other._workingDays,
              _workingDays,
            ) &&
            const DeepCollectionEquality().equals(other._holidays, _holidays));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_workingDays),
    const DeepCollectionEquality().hash(_holidays),
  );

  /// Create a copy of WorkingDaysState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WDLoadedImplCopyWith<_$WDLoadedImpl> get copyWith =>
      __$$WDLoadedImplCopyWithImpl<_$WDLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<WorkingDayApiModel> workingDays,
      List<HolidayApiModel> holidays,
    )
    loaded,
    required TResult Function() saving,
    required TResult Function() saved,
    required TResult Function(String message) error,
  }) {
    return loaded(workingDays, holidays);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<WorkingDayApiModel> workingDays,
      List<HolidayApiModel> holidays,
    )?
    loaded,
    TResult? Function()? saving,
    TResult? Function()? saved,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(workingDays, holidays);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<WorkingDayApiModel> workingDays,
      List<HolidayApiModel> holidays,
    )?
    loaded,
    TResult Function()? saving,
    TResult Function()? saved,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(workingDays, holidays);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WDInitial value) initial,
    required TResult Function(_WDLoading value) loading,
    required TResult Function(_WDLoaded value) loaded,
    required TResult Function(_WDSaving value) saving,
    required TResult Function(_WDSaved value) saved,
    required TResult Function(_WDError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WDInitial value)? initial,
    TResult? Function(_WDLoading value)? loading,
    TResult? Function(_WDLoaded value)? loaded,
    TResult? Function(_WDSaving value)? saving,
    TResult? Function(_WDSaved value)? saved,
    TResult? Function(_WDError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WDInitial value)? initial,
    TResult Function(_WDLoading value)? loading,
    TResult Function(_WDLoaded value)? loaded,
    TResult Function(_WDSaving value)? saving,
    TResult Function(_WDSaved value)? saved,
    TResult Function(_WDError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _WDLoaded implements WorkingDaysState {
  const factory _WDLoaded({
    required final List<WorkingDayApiModel> workingDays,
    required final List<HolidayApiModel> holidays,
  }) = _$WDLoadedImpl;

  List<WorkingDayApiModel> get workingDays;
  List<HolidayApiModel> get holidays;

  /// Create a copy of WorkingDaysState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WDLoadedImplCopyWith<_$WDLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WDSavingImplCopyWith<$Res> {
  factory _$$WDSavingImplCopyWith(
    _$WDSavingImpl value,
    $Res Function(_$WDSavingImpl) then,
  ) = __$$WDSavingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WDSavingImplCopyWithImpl<$Res>
    extends _$WorkingDaysStateCopyWithImpl<$Res, _$WDSavingImpl>
    implements _$$WDSavingImplCopyWith<$Res> {
  __$$WDSavingImplCopyWithImpl(
    _$WDSavingImpl _value,
    $Res Function(_$WDSavingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkingDaysState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$WDSavingImpl implements _WDSaving {
  const _$WDSavingImpl();

  @override
  String toString() {
    return 'WorkingDaysState.saving()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$WDSavingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<WorkingDayApiModel> workingDays,
      List<HolidayApiModel> holidays,
    )
    loaded,
    required TResult Function() saving,
    required TResult Function() saved,
    required TResult Function(String message) error,
  }) {
    return saving();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<WorkingDayApiModel> workingDays,
      List<HolidayApiModel> holidays,
    )?
    loaded,
    TResult? Function()? saving,
    TResult? Function()? saved,
    TResult? Function(String message)? error,
  }) {
    return saving?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<WorkingDayApiModel> workingDays,
      List<HolidayApiModel> holidays,
    )?
    loaded,
    TResult Function()? saving,
    TResult Function()? saved,
    TResult Function(String message)? error,
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
    required TResult Function(_WDInitial value) initial,
    required TResult Function(_WDLoading value) loading,
    required TResult Function(_WDLoaded value) loaded,
    required TResult Function(_WDSaving value) saving,
    required TResult Function(_WDSaved value) saved,
    required TResult Function(_WDError value) error,
  }) {
    return saving(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WDInitial value)? initial,
    TResult? Function(_WDLoading value)? loading,
    TResult? Function(_WDLoaded value)? loaded,
    TResult? Function(_WDSaving value)? saving,
    TResult? Function(_WDSaved value)? saved,
    TResult? Function(_WDError value)? error,
  }) {
    return saving?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WDInitial value)? initial,
    TResult Function(_WDLoading value)? loading,
    TResult Function(_WDLoaded value)? loaded,
    TResult Function(_WDSaving value)? saving,
    TResult Function(_WDSaved value)? saved,
    TResult Function(_WDError value)? error,
    required TResult orElse(),
  }) {
    if (saving != null) {
      return saving(this);
    }
    return orElse();
  }
}

abstract class _WDSaving implements WorkingDaysState {
  const factory _WDSaving() = _$WDSavingImpl;
}

/// @nodoc
abstract class _$$WDSavedImplCopyWith<$Res> {
  factory _$$WDSavedImplCopyWith(
    _$WDSavedImpl value,
    $Res Function(_$WDSavedImpl) then,
  ) = __$$WDSavedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WDSavedImplCopyWithImpl<$Res>
    extends _$WorkingDaysStateCopyWithImpl<$Res, _$WDSavedImpl>
    implements _$$WDSavedImplCopyWith<$Res> {
  __$$WDSavedImplCopyWithImpl(
    _$WDSavedImpl _value,
    $Res Function(_$WDSavedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkingDaysState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$WDSavedImpl implements _WDSaved {
  const _$WDSavedImpl();

  @override
  String toString() {
    return 'WorkingDaysState.saved()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$WDSavedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<WorkingDayApiModel> workingDays,
      List<HolidayApiModel> holidays,
    )
    loaded,
    required TResult Function() saving,
    required TResult Function() saved,
    required TResult Function(String message) error,
  }) {
    return saved();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<WorkingDayApiModel> workingDays,
      List<HolidayApiModel> holidays,
    )?
    loaded,
    TResult? Function()? saving,
    TResult? Function()? saved,
    TResult? Function(String message)? error,
  }) {
    return saved?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<WorkingDayApiModel> workingDays,
      List<HolidayApiModel> holidays,
    )?
    loaded,
    TResult Function()? saving,
    TResult Function()? saved,
    TResult Function(String message)? error,
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
    required TResult Function(_WDInitial value) initial,
    required TResult Function(_WDLoading value) loading,
    required TResult Function(_WDLoaded value) loaded,
    required TResult Function(_WDSaving value) saving,
    required TResult Function(_WDSaved value) saved,
    required TResult Function(_WDError value) error,
  }) {
    return saved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WDInitial value)? initial,
    TResult? Function(_WDLoading value)? loading,
    TResult? Function(_WDLoaded value)? loaded,
    TResult? Function(_WDSaving value)? saving,
    TResult? Function(_WDSaved value)? saved,
    TResult? Function(_WDError value)? error,
  }) {
    return saved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WDInitial value)? initial,
    TResult Function(_WDLoading value)? loading,
    TResult Function(_WDLoaded value)? loaded,
    TResult Function(_WDSaving value)? saving,
    TResult Function(_WDSaved value)? saved,
    TResult Function(_WDError value)? error,
    required TResult orElse(),
  }) {
    if (saved != null) {
      return saved(this);
    }
    return orElse();
  }
}

abstract class _WDSaved implements WorkingDaysState {
  const factory _WDSaved() = _$WDSavedImpl;
}

/// @nodoc
abstract class _$$WDErrorImplCopyWith<$Res> {
  factory _$$WDErrorImplCopyWith(
    _$WDErrorImpl value,
    $Res Function(_$WDErrorImpl) then,
  ) = __$$WDErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$WDErrorImplCopyWithImpl<$Res>
    extends _$WorkingDaysStateCopyWithImpl<$Res, _$WDErrorImpl>
    implements _$$WDErrorImplCopyWith<$Res> {
  __$$WDErrorImplCopyWithImpl(
    _$WDErrorImpl _value,
    $Res Function(_$WDErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkingDaysState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$WDErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$WDErrorImpl implements _WDError {
  const _$WDErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'WorkingDaysState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WDErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of WorkingDaysState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WDErrorImplCopyWith<_$WDErrorImpl> get copyWith =>
      __$$WDErrorImplCopyWithImpl<_$WDErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<WorkingDayApiModel> workingDays,
      List<HolidayApiModel> holidays,
    )
    loaded,
    required TResult Function() saving,
    required TResult Function() saved,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<WorkingDayApiModel> workingDays,
      List<HolidayApiModel> holidays,
    )?
    loaded,
    TResult? Function()? saving,
    TResult? Function()? saved,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<WorkingDayApiModel> workingDays,
      List<HolidayApiModel> holidays,
    )?
    loaded,
    TResult Function()? saving,
    TResult Function()? saved,
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
    required TResult Function(_WDInitial value) initial,
    required TResult Function(_WDLoading value) loading,
    required TResult Function(_WDLoaded value) loaded,
    required TResult Function(_WDSaving value) saving,
    required TResult Function(_WDSaved value) saved,
    required TResult Function(_WDError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WDInitial value)? initial,
    TResult? Function(_WDLoading value)? loading,
    TResult? Function(_WDLoaded value)? loaded,
    TResult? Function(_WDSaving value)? saving,
    TResult? Function(_WDSaved value)? saved,
    TResult? Function(_WDError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WDInitial value)? initial,
    TResult Function(_WDLoading value)? loading,
    TResult Function(_WDLoaded value)? loaded,
    TResult Function(_WDSaving value)? saving,
    TResult Function(_WDSaved value)? saved,
    TResult Function(_WDError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _WDError implements WorkingDaysState {
  const factory _WDError(final String message) = _$WDErrorImpl;

  String get message;

  /// Create a copy of WorkingDaysState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WDErrorImplCopyWith<_$WDErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
