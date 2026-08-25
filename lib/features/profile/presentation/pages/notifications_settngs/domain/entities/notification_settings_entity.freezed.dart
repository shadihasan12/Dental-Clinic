// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_settings_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$NotificationSettingEntity {
  /// Send this back when toggling. Never shown to the user.
  String get key => throw _privateConstructorUsedError;

  /// The switch label, already translated by the server.
  String get name => throw _privateConstructorUsedError;

  /// Sub-label. May be absent entirely — check before rendering.
  String? get description => throw _privateConstructorUsedError;
  bool get enabled => throw _privateConstructorUsedError;

  /// Present only for broadcast categories, and the **only** source of
  /// Firebase topic names in this app. Today: `announcement_ar` /
  /// `announcement_en`, and the server decides which. Subscribe to the exact
  /// string, only while [enabled] is true; never build the name.
  String? get audience => throw _privateConstructorUsedError;

  /// Create a copy of NotificationSettingEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationSettingEntityCopyWith<NotificationSettingEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationSettingEntityCopyWith<$Res> {
  factory $NotificationSettingEntityCopyWith(
    NotificationSettingEntity value,
    $Res Function(NotificationSettingEntity) then,
  ) = _$NotificationSettingEntityCopyWithImpl<$Res, NotificationSettingEntity>;
  @useResult
  $Res call({
    String key,
    String name,
    String? description,
    bool enabled,
    String? audience,
  });
}

/// @nodoc
class _$NotificationSettingEntityCopyWithImpl<
  $Res,
  $Val extends NotificationSettingEntity
>
    implements $NotificationSettingEntityCopyWith<$Res> {
  _$NotificationSettingEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationSettingEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? name = null,
    Object? description = freezed,
    Object? enabled = null,
    Object? audience = freezed,
  }) {
    return _then(
      _value.copyWith(
            key: null == key
                ? _value.key
                : key // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            enabled: null == enabled
                ? _value.enabled
                : enabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            audience: freezed == audience
                ? _value.audience
                : audience // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NotificationSettingEntityImplCopyWith<$Res>
    implements $NotificationSettingEntityCopyWith<$Res> {
  factory _$$NotificationSettingEntityImplCopyWith(
    _$NotificationSettingEntityImpl value,
    $Res Function(_$NotificationSettingEntityImpl) then,
  ) = __$$NotificationSettingEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String key,
    String name,
    String? description,
    bool enabled,
    String? audience,
  });
}

/// @nodoc
class __$$NotificationSettingEntityImplCopyWithImpl<$Res>
    extends
        _$NotificationSettingEntityCopyWithImpl<
          $Res,
          _$NotificationSettingEntityImpl
        >
    implements _$$NotificationSettingEntityImplCopyWith<$Res> {
  __$$NotificationSettingEntityImplCopyWithImpl(
    _$NotificationSettingEntityImpl _value,
    $Res Function(_$NotificationSettingEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationSettingEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? name = null,
    Object? description = freezed,
    Object? enabled = null,
    Object? audience = freezed,
  }) {
    return _then(
      _$NotificationSettingEntityImpl(
        key: null == key
            ? _value.key
            : key // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        enabled: null == enabled
            ? _value.enabled
            : enabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        audience: freezed == audience
            ? _value.audience
            : audience // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$NotificationSettingEntityImpl extends _NotificationSettingEntity {
  const _$NotificationSettingEntityImpl({
    required this.key,
    required this.name,
    this.description,
    this.enabled = true,
    this.audience,
  }) : super._();

  /// Send this back when toggling. Never shown to the user.
  @override
  final String key;

  /// The switch label, already translated by the server.
  @override
  final String name;

  /// Sub-label. May be absent entirely — check before rendering.
  @override
  final String? description;
  @override
  @JsonKey()
  final bool enabled;

  /// Present only for broadcast categories, and the **only** source of
  /// Firebase topic names in this app. Today: `announcement_ar` /
  /// `announcement_en`, and the server decides which. Subscribe to the exact
  /// string, only while [enabled] is true; never build the name.
  @override
  final String? audience;

  @override
  String toString() {
    return 'NotificationSettingEntity(key: $key, name: $name, description: $description, enabled: $enabled, audience: $audience)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationSettingEntityImpl &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.audience, audience) ||
                other.audience == audience));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, key, name, description, enabled, audience);

  /// Create a copy of NotificationSettingEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationSettingEntityImplCopyWith<_$NotificationSettingEntityImpl>
  get copyWith =>
      __$$NotificationSettingEntityImplCopyWithImpl<
        _$NotificationSettingEntityImpl
      >(this, _$identity);
}

abstract class _NotificationSettingEntity extends NotificationSettingEntity {
  const factory _NotificationSettingEntity({
    required final String key,
    required final String name,
    final String? description,
    final bool enabled,
    final String? audience,
  }) = _$NotificationSettingEntityImpl;
  const _NotificationSettingEntity._() : super._();

  /// Send this back when toggling. Never shown to the user.
  @override
  String get key;

  /// The switch label, already translated by the server.
  @override
  String get name;

  /// Sub-label. May be absent entirely — check before rendering.
  @override
  String? get description;
  @override
  bool get enabled;

  /// Present only for broadcast categories, and the **only** source of
  /// Firebase topic names in this app. Today: `announcement_ar` /
  /// `announcement_en`, and the server decides which. Subscribe to the exact
  /// string, only while [enabled] is true; never build the name.
  @override
  String? get audience;

  /// Create a copy of NotificationSettingEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationSettingEntityImplCopyWith<_$NotificationSettingEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}
