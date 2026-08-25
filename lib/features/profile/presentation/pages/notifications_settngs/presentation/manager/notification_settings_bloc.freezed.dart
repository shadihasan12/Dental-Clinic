// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_settings_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$NotificationSettingsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(String key, bool enabled) toggle,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(String key, bool enabled)? toggle,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(String key, bool enabled)? toggle,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_Toggle value) toggle,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_Toggle value)? toggle,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_Toggle value)? toggle,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationSettingsEventCopyWith<$Res> {
  factory $NotificationSettingsEventCopyWith(
    NotificationSettingsEvent value,
    $Res Function(NotificationSettingsEvent) then,
  ) = _$NotificationSettingsEventCopyWithImpl<$Res, NotificationSettingsEvent>;
}

/// @nodoc
class _$NotificationSettingsEventCopyWithImpl<
  $Res,
  $Val extends NotificationSettingsEvent
>
    implements $NotificationSettingsEventCopyWith<$Res> {
  _$NotificationSettingsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationSettingsEvent
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
    extends _$NotificationSettingsEventCopyWithImpl<$Res, _$LoadImpl>
    implements _$$LoadImplCopyWith<$Res> {
  __$$LoadImplCopyWithImpl(_$LoadImpl _value, $Res Function(_$LoadImpl) _then)
    : super(_value, _then);

  /// Create a copy of NotificationSettingsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadImpl implements _Load {
  const _$LoadImpl();

  @override
  String toString() {
    return 'NotificationSettingsEvent.load()';
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
    required TResult Function(String key, bool enabled) toggle,
  }) {
    return load();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(String key, bool enabled)? toggle,
  }) {
    return load?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(String key, bool enabled)? toggle,
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
    required TResult Function(_Toggle value) toggle,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_Toggle value)? toggle,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_Toggle value)? toggle,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class _Load implements NotificationSettingsEvent {
  const factory _Load() = _$LoadImpl;
}

/// @nodoc
abstract class _$$ToggleImplCopyWith<$Res> {
  factory _$$ToggleImplCopyWith(
    _$ToggleImpl value,
    $Res Function(_$ToggleImpl) then,
  ) = __$$ToggleImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String key, bool enabled});
}

/// @nodoc
class __$$ToggleImplCopyWithImpl<$Res>
    extends _$NotificationSettingsEventCopyWithImpl<$Res, _$ToggleImpl>
    implements _$$ToggleImplCopyWith<$Res> {
  __$$ToggleImplCopyWithImpl(
    _$ToggleImpl _value,
    $Res Function(_$ToggleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationSettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? key = null, Object? enabled = null}) {
    return _then(
      _$ToggleImpl(
        key: null == key
            ? _value.key
            : key // ignore: cast_nullable_to_non_nullable
                  as String,
        enabled: null == enabled
            ? _value.enabled
            : enabled // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$ToggleImpl implements _Toggle {
  const _$ToggleImpl({required this.key, required this.enabled});

  @override
  final String key;
  @override
  final bool enabled;

  @override
  String toString() {
    return 'NotificationSettingsEvent.toggle(key: $key, enabled: $enabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToggleImpl &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @override
  int get hashCode => Object.hash(runtimeType, key, enabled);

  /// Create a copy of NotificationSettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ToggleImplCopyWith<_$ToggleImpl> get copyWith =>
      __$$ToggleImplCopyWithImpl<_$ToggleImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(String key, bool enabled) toggle,
  }) {
    return toggle(key, enabled);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(String key, bool enabled)? toggle,
  }) {
    return toggle?.call(key, enabled);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(String key, bool enabled)? toggle,
    required TResult orElse(),
  }) {
    if (toggle != null) {
      return toggle(key, enabled);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_Toggle value) toggle,
  }) {
    return toggle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_Toggle value)? toggle,
  }) {
    return toggle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_Toggle value)? toggle,
    required TResult orElse(),
  }) {
    if (toggle != null) {
      return toggle(this);
    }
    return orElse();
  }
}

abstract class _Toggle implements NotificationSettingsEvent {
  const factory _Toggle({
    required final String key,
    required final bool enabled,
  }) = _$ToggleImpl;

  String get key;
  bool get enabled;

  /// Create a copy of NotificationSettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ToggleImplCopyWith<_$ToggleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$NotificationSettingsState {
  NotificationSettingsStatus get status => throw _privateConstructorUsedError;

  /// Rendered as a flat list in exactly this order. There are no sections,
  /// and nothing here is hardcoded client-side.
  List<NotificationSettingEntity> get settings =>
      throw _privateConstructorUsedError;

  /// Keys whose PATCH is still in flight - their switch is disabled so a
  /// second tap can't race the first.
  Set<String> get pendingKeys => throw _privateConstructorUsedError;

  /// Set when a toggle was rejected and rolled back; shown once, then
  /// cleared by the next successful action.
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of NotificationSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationSettingsStateCopyWith<NotificationSettingsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationSettingsStateCopyWith<$Res> {
  factory $NotificationSettingsStateCopyWith(
    NotificationSettingsState value,
    $Res Function(NotificationSettingsState) then,
  ) = _$NotificationSettingsStateCopyWithImpl<$Res, NotificationSettingsState>;
  @useResult
  $Res call({
    NotificationSettingsStatus status,
    List<NotificationSettingEntity> settings,
    Set<String> pendingKeys,
    String? errorMessage,
  });
}

/// @nodoc
class _$NotificationSettingsStateCopyWithImpl<
  $Res,
  $Val extends NotificationSettingsState
>
    implements $NotificationSettingsStateCopyWith<$Res> {
  _$NotificationSettingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? settings = null,
    Object? pendingKeys = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as NotificationSettingsStatus,
            settings: null == settings
                ? _value.settings
                : settings // ignore: cast_nullable_to_non_nullable
                      as List<NotificationSettingEntity>,
            pendingKeys: null == pendingKeys
                ? _value.pendingKeys
                : pendingKeys // ignore: cast_nullable_to_non_nullable
                      as Set<String>,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NotificationSettingsStateImplCopyWith<$Res>
    implements $NotificationSettingsStateCopyWith<$Res> {
  factory _$$NotificationSettingsStateImplCopyWith(
    _$NotificationSettingsStateImpl value,
    $Res Function(_$NotificationSettingsStateImpl) then,
  ) = __$$NotificationSettingsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    NotificationSettingsStatus status,
    List<NotificationSettingEntity> settings,
    Set<String> pendingKeys,
    String? errorMessage,
  });
}

/// @nodoc
class __$$NotificationSettingsStateImplCopyWithImpl<$Res>
    extends
        _$NotificationSettingsStateCopyWithImpl<
          $Res,
          _$NotificationSettingsStateImpl
        >
    implements _$$NotificationSettingsStateImplCopyWith<$Res> {
  __$$NotificationSettingsStateImplCopyWithImpl(
    _$NotificationSettingsStateImpl _value,
    $Res Function(_$NotificationSettingsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? settings = null,
    Object? pendingKeys = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$NotificationSettingsStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as NotificationSettingsStatus,
        settings: null == settings
            ? _value._settings
            : settings // ignore: cast_nullable_to_non_nullable
                  as List<NotificationSettingEntity>,
        pendingKeys: null == pendingKeys
            ? _value._pendingKeys
            : pendingKeys // ignore: cast_nullable_to_non_nullable
                  as Set<String>,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$NotificationSettingsStateImpl extends _NotificationSettingsState {
  const _$NotificationSettingsStateImpl({
    this.status = NotificationSettingsStatus.initial,
    final List<NotificationSettingEntity> settings =
        const <NotificationSettingEntity>[],
    final Set<String> pendingKeys = const <String>{},
    this.errorMessage,
  }) : _settings = settings,
       _pendingKeys = pendingKeys,
       super._();

  @override
  @JsonKey()
  final NotificationSettingsStatus status;

  /// Rendered as a flat list in exactly this order. There are no sections,
  /// and nothing here is hardcoded client-side.
  final List<NotificationSettingEntity> _settings;

  /// Rendered as a flat list in exactly this order. There are no sections,
  /// and nothing here is hardcoded client-side.
  @override
  @JsonKey()
  List<NotificationSettingEntity> get settings {
    if (_settings is EqualUnmodifiableListView) return _settings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_settings);
  }

  /// Keys whose PATCH is still in flight - their switch is disabled so a
  /// second tap can't race the first.
  final Set<String> _pendingKeys;

  /// Keys whose PATCH is still in flight - their switch is disabled so a
  /// second tap can't race the first.
  @override
  @JsonKey()
  Set<String> get pendingKeys {
    if (_pendingKeys is EqualUnmodifiableSetView) return _pendingKeys;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_pendingKeys);
  }

  /// Set when a toggle was rejected and rolled back; shown once, then
  /// cleared by the next successful action.
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'NotificationSettingsState(status: $status, settings: $settings, pendingKeys: $pendingKeys, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationSettingsStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._settings, _settings) &&
            const DeepCollectionEquality().equals(
              other._pendingKeys,
              _pendingKeys,
            ) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    const DeepCollectionEquality().hash(_settings),
    const DeepCollectionEquality().hash(_pendingKeys),
    errorMessage,
  );

  /// Create a copy of NotificationSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationSettingsStateImplCopyWith<_$NotificationSettingsStateImpl>
  get copyWith =>
      __$$NotificationSettingsStateImplCopyWithImpl<
        _$NotificationSettingsStateImpl
      >(this, _$identity);
}

abstract class _NotificationSettingsState extends NotificationSettingsState {
  const factory _NotificationSettingsState({
    final NotificationSettingsStatus status,
    final List<NotificationSettingEntity> settings,
    final Set<String> pendingKeys,
    final String? errorMessage,
  }) = _$NotificationSettingsStateImpl;
  const _NotificationSettingsState._() : super._();

  @override
  NotificationSettingsStatus get status;

  /// Rendered as a flat list in exactly this order. There are no sections,
  /// and nothing here is hardcoded client-side.
  @override
  List<NotificationSettingEntity> get settings;

  /// Keys whose PATCH is still in flight - their switch is disabled so a
  /// second tap can't race the first.
  @override
  Set<String> get pendingKeys;

  /// Set when a toggle was rejected and rolled back; shown once, then
  /// cleared by the next successful action.
  @override
  String? get errorMessage;

  /// Create a copy of NotificationSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationSettingsStateImplCopyWith<_$NotificationSettingsStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
