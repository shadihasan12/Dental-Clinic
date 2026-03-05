// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'working_hours_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WorkingHoursEvent {
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
abstract class $WorkingHoursEventCopyWith<$Res> {
  factory $WorkingHoursEventCopyWith(
    WorkingHoursEvent value,
    $Res Function(WorkingHoursEvent) then,
  ) = _$WorkingHoursEventCopyWithImpl<$Res, WorkingHoursEvent>;
}

/// @nodoc
class _$WorkingHoursEventCopyWithImpl<$Res, $Val extends WorkingHoursEvent>
    implements $WorkingHoursEventCopyWith<$Res> {
  _$WorkingHoursEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkingHoursEvent
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
    extends _$WorkingHoursEventCopyWithImpl<$Res, _$LoadImpl>
    implements _$$LoadImplCopyWith<$Res> {
  __$$LoadImplCopyWithImpl(_$LoadImpl _value, $Res Function(_$LoadImpl) _then)
    : super(_value, _then);

  /// Create a copy of WorkingHoursEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadImpl implements _Load {
  const _$LoadImpl();

  @override
  String toString() {
    return 'WorkingHoursEvent.load()';
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

abstract class _Load implements WorkingHoursEvent {
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
    extends _$WorkingHoursEventCopyWithImpl<$Res, _$SaveAllImpl>
    implements _$$SaveAllImplCopyWith<$Res> {
  __$$SaveAllImplCopyWithImpl(
    _$SaveAllImpl _value,
    $Res Function(_$SaveAllImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkingHoursEvent
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
    return 'WorkingHoursEvent.saveAll(workingDays: $workingDays, holidays: $holidays)';
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

  /// Create a copy of WorkingHoursEvent
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

abstract class _SaveAll implements WorkingHoursEvent {
  const factory _SaveAll({
    required final List<WorkingDayApiModel> workingDays,
    required final List<HolidayApiModel> holidays,
  }) = _$SaveAllImpl;

  List<WorkingDayApiModel> get workingDays;
  List<HolidayApiModel> get holidays;

  /// Create a copy of WorkingHoursEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaveAllImplCopyWith<_$SaveAllImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$WorkingHoursState {
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
    required TResult Function(_WHInitial value) initial,
    required TResult Function(_WHLoading value) loading,
    required TResult Function(_WHLoaded value) loaded,
    required TResult Function(_WHSaving value) saving,
    required TResult Function(_WHSaved value) saved,
    required TResult Function(_WHError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WHInitial value)? initial,
    TResult? Function(_WHLoading value)? loading,
    TResult? Function(_WHLoaded value)? loaded,
    TResult? Function(_WHSaving value)? saving,
    TResult? Function(_WHSaved value)? saved,
    TResult? Function(_WHError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WHInitial value)? initial,
    TResult Function(_WHLoading value)? loading,
    TResult Function(_WHLoaded value)? loaded,
    TResult Function(_WHSaving value)? saving,
    TResult Function(_WHSaved value)? saved,
    TResult Function(_WHError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkingHoursStateCopyWith<$Res> {
  factory $WorkingHoursStateCopyWith(
    WorkingHoursState value,
    $Res Function(WorkingHoursState) then,
  ) = _$WorkingHoursStateCopyWithImpl<$Res, WorkingHoursState>;
}

/// @nodoc
class _$WorkingHoursStateCopyWithImpl<$Res, $Val extends WorkingHoursState>
    implements $WorkingHoursStateCopyWith<$Res> {
  _$WorkingHoursStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkingHoursState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$WHInitialImplCopyWith<$Res> {
  factory _$$WHInitialImplCopyWith(
    _$WHInitialImpl value,
    $Res Function(_$WHInitialImpl) then,
  ) = __$$WHInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WHInitialImplCopyWithImpl<$Res>
    extends _$WorkingHoursStateCopyWithImpl<$Res, _$WHInitialImpl>
    implements _$$WHInitialImplCopyWith<$Res> {
  __$$WHInitialImplCopyWithImpl(
    _$WHInitialImpl _value,
    $Res Function(_$WHInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkingHoursState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$WHInitialImpl implements _WHInitial {
  const _$WHInitialImpl();

  @override
  String toString() {
    return 'WorkingHoursState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$WHInitialImpl);
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
    required TResult Function(_WHInitial value) initial,
    required TResult Function(_WHLoading value) loading,
    required TResult Function(_WHLoaded value) loaded,
    required TResult Function(_WHSaving value) saving,
    required TResult Function(_WHSaved value) saved,
    required TResult Function(_WHError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WHInitial value)? initial,
    TResult? Function(_WHLoading value)? loading,
    TResult? Function(_WHLoaded value)? loaded,
    TResult? Function(_WHSaving value)? saving,
    TResult? Function(_WHSaved value)? saved,
    TResult? Function(_WHError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WHInitial value)? initial,
    TResult Function(_WHLoading value)? loading,
    TResult Function(_WHLoaded value)? loaded,
    TResult Function(_WHSaving value)? saving,
    TResult Function(_WHSaved value)? saved,
    TResult Function(_WHError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _WHInitial implements WorkingHoursState {
  const factory _WHInitial() = _$WHInitialImpl;
}

/// @nodoc
abstract class _$$WHLoadingImplCopyWith<$Res> {
  factory _$$WHLoadingImplCopyWith(
    _$WHLoadingImpl value,
    $Res Function(_$WHLoadingImpl) then,
  ) = __$$WHLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WHLoadingImplCopyWithImpl<$Res>
    extends _$WorkingHoursStateCopyWithImpl<$Res, _$WHLoadingImpl>
    implements _$$WHLoadingImplCopyWith<$Res> {
  __$$WHLoadingImplCopyWithImpl(
    _$WHLoadingImpl _value,
    $Res Function(_$WHLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkingHoursState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$WHLoadingImpl implements _WHLoading {
  const _$WHLoadingImpl();

  @override
  String toString() {
    return 'WorkingHoursState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$WHLoadingImpl);
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
    required TResult Function(_WHInitial value) initial,
    required TResult Function(_WHLoading value) loading,
    required TResult Function(_WHLoaded value) loaded,
    required TResult Function(_WHSaving value) saving,
    required TResult Function(_WHSaved value) saved,
    required TResult Function(_WHError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WHInitial value)? initial,
    TResult? Function(_WHLoading value)? loading,
    TResult? Function(_WHLoaded value)? loaded,
    TResult? Function(_WHSaving value)? saving,
    TResult? Function(_WHSaved value)? saved,
    TResult? Function(_WHError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WHInitial value)? initial,
    TResult Function(_WHLoading value)? loading,
    TResult Function(_WHLoaded value)? loaded,
    TResult Function(_WHSaving value)? saving,
    TResult Function(_WHSaved value)? saved,
    TResult Function(_WHError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _WHLoading implements WorkingHoursState {
  const factory _WHLoading() = _$WHLoadingImpl;
}

/// @nodoc
abstract class _$$WHLoadedImplCopyWith<$Res> {
  factory _$$WHLoadedImplCopyWith(
    _$WHLoadedImpl value,
    $Res Function(_$WHLoadedImpl) then,
  ) = __$$WHLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<WorkingDayApiModel> workingDays,
    List<HolidayApiModel> holidays,
  });
}

/// @nodoc
class __$$WHLoadedImplCopyWithImpl<$Res>
    extends _$WorkingHoursStateCopyWithImpl<$Res, _$WHLoadedImpl>
    implements _$$WHLoadedImplCopyWith<$Res> {
  __$$WHLoadedImplCopyWithImpl(
    _$WHLoadedImpl _value,
    $Res Function(_$WHLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkingHoursState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? workingDays = null, Object? holidays = null}) {
    return _then(
      _$WHLoadedImpl(
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

class _$WHLoadedImpl implements _WHLoaded {
  const _$WHLoadedImpl({
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
    return 'WorkingHoursState.loaded(workingDays: $workingDays, holidays: $holidays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WHLoadedImpl &&
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

  /// Create a copy of WorkingHoursState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WHLoadedImplCopyWith<_$WHLoadedImpl> get copyWith =>
      __$$WHLoadedImplCopyWithImpl<_$WHLoadedImpl>(this, _$identity);

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
    required TResult Function(_WHInitial value) initial,
    required TResult Function(_WHLoading value) loading,
    required TResult Function(_WHLoaded value) loaded,
    required TResult Function(_WHSaving value) saving,
    required TResult Function(_WHSaved value) saved,
    required TResult Function(_WHError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WHInitial value)? initial,
    TResult? Function(_WHLoading value)? loading,
    TResult? Function(_WHLoaded value)? loaded,
    TResult? Function(_WHSaving value)? saving,
    TResult? Function(_WHSaved value)? saved,
    TResult? Function(_WHError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WHInitial value)? initial,
    TResult Function(_WHLoading value)? loading,
    TResult Function(_WHLoaded value)? loaded,
    TResult Function(_WHSaving value)? saving,
    TResult Function(_WHSaved value)? saved,
    TResult Function(_WHError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _WHLoaded implements WorkingHoursState {
  const factory _WHLoaded({
    required final List<WorkingDayApiModel> workingDays,
    required final List<HolidayApiModel> holidays,
  }) = _$WHLoadedImpl;

  List<WorkingDayApiModel> get workingDays;
  List<HolidayApiModel> get holidays;

  /// Create a copy of WorkingHoursState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WHLoadedImplCopyWith<_$WHLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WHSavingImplCopyWith<$Res> {
  factory _$$WHSavingImplCopyWith(
    _$WHSavingImpl value,
    $Res Function(_$WHSavingImpl) then,
  ) = __$$WHSavingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WHSavingImplCopyWithImpl<$Res>
    extends _$WorkingHoursStateCopyWithImpl<$Res, _$WHSavingImpl>
    implements _$$WHSavingImplCopyWith<$Res> {
  __$$WHSavingImplCopyWithImpl(
    _$WHSavingImpl _value,
    $Res Function(_$WHSavingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkingHoursState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$WHSavingImpl implements _WHSaving {
  const _$WHSavingImpl();

  @override
  String toString() {
    return 'WorkingHoursState.saving()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$WHSavingImpl);
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
    required TResult Function(_WHInitial value) initial,
    required TResult Function(_WHLoading value) loading,
    required TResult Function(_WHLoaded value) loaded,
    required TResult Function(_WHSaving value) saving,
    required TResult Function(_WHSaved value) saved,
    required TResult Function(_WHError value) error,
  }) {
    return saving(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WHInitial value)? initial,
    TResult? Function(_WHLoading value)? loading,
    TResult? Function(_WHLoaded value)? loaded,
    TResult? Function(_WHSaving value)? saving,
    TResult? Function(_WHSaved value)? saved,
    TResult? Function(_WHError value)? error,
  }) {
    return saving?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WHInitial value)? initial,
    TResult Function(_WHLoading value)? loading,
    TResult Function(_WHLoaded value)? loaded,
    TResult Function(_WHSaving value)? saving,
    TResult Function(_WHSaved value)? saved,
    TResult Function(_WHError value)? error,
    required TResult orElse(),
  }) {
    if (saving != null) {
      return saving(this);
    }
    return orElse();
  }
}

abstract class _WHSaving implements WorkingHoursState {
  const factory _WHSaving() = _$WHSavingImpl;
}

/// @nodoc
abstract class _$$WHSavedImplCopyWith<$Res> {
  factory _$$WHSavedImplCopyWith(
    _$WHSavedImpl value,
    $Res Function(_$WHSavedImpl) then,
  ) = __$$WHSavedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WHSavedImplCopyWithImpl<$Res>
    extends _$WorkingHoursStateCopyWithImpl<$Res, _$WHSavedImpl>
    implements _$$WHSavedImplCopyWith<$Res> {
  __$$WHSavedImplCopyWithImpl(
    _$WHSavedImpl _value,
    $Res Function(_$WHSavedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkingHoursState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$WHSavedImpl implements _WHSaved {
  const _$WHSavedImpl();

  @override
  String toString() {
    return 'WorkingHoursState.saved()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$WHSavedImpl);
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
    required TResult Function(_WHInitial value) initial,
    required TResult Function(_WHLoading value) loading,
    required TResult Function(_WHLoaded value) loaded,
    required TResult Function(_WHSaving value) saving,
    required TResult Function(_WHSaved value) saved,
    required TResult Function(_WHError value) error,
  }) {
    return saved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WHInitial value)? initial,
    TResult? Function(_WHLoading value)? loading,
    TResult? Function(_WHLoaded value)? loaded,
    TResult? Function(_WHSaving value)? saving,
    TResult? Function(_WHSaved value)? saved,
    TResult? Function(_WHError value)? error,
  }) {
    return saved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WHInitial value)? initial,
    TResult Function(_WHLoading value)? loading,
    TResult Function(_WHLoaded value)? loaded,
    TResult Function(_WHSaving value)? saving,
    TResult Function(_WHSaved value)? saved,
    TResult Function(_WHError value)? error,
    required TResult orElse(),
  }) {
    if (saved != null) {
      return saved(this);
    }
    return orElse();
  }
}

abstract class _WHSaved implements WorkingHoursState {
  const factory _WHSaved() = _$WHSavedImpl;
}

/// @nodoc
abstract class _$$WHErrorImplCopyWith<$Res> {
  factory _$$WHErrorImplCopyWith(
    _$WHErrorImpl value,
    $Res Function(_$WHErrorImpl) then,
  ) = __$$WHErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$WHErrorImplCopyWithImpl<$Res>
    extends _$WorkingHoursStateCopyWithImpl<$Res, _$WHErrorImpl>
    implements _$$WHErrorImplCopyWith<$Res> {
  __$$WHErrorImplCopyWithImpl(
    _$WHErrorImpl _value,
    $Res Function(_$WHErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkingHoursState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$WHErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$WHErrorImpl implements _WHError {
  const _$WHErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'WorkingHoursState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WHErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of WorkingHoursState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WHErrorImplCopyWith<_$WHErrorImpl> get copyWith =>
      __$$WHErrorImplCopyWithImpl<_$WHErrorImpl>(this, _$identity);

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
    required TResult Function(_WHInitial value) initial,
    required TResult Function(_WHLoading value) loading,
    required TResult Function(_WHLoaded value) loaded,
    required TResult Function(_WHSaving value) saving,
    required TResult Function(_WHSaved value) saved,
    required TResult Function(_WHError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WHInitial value)? initial,
    TResult? Function(_WHLoading value)? loading,
    TResult? Function(_WHLoaded value)? loaded,
    TResult? Function(_WHSaving value)? saving,
    TResult? Function(_WHSaved value)? saved,
    TResult? Function(_WHError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WHInitial value)? initial,
    TResult Function(_WHLoading value)? loading,
    TResult Function(_WHLoaded value)? loaded,
    TResult Function(_WHSaving value)? saving,
    TResult Function(_WHSaved value)? saved,
    TResult Function(_WHError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _WHError implements WorkingHoursState {
  const factory _WHError(final String message) = _$WHErrorImpl;

  String get message;

  /// Create a copy of WorkingHoursState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WHErrorImplCopyWith<_$WHErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
