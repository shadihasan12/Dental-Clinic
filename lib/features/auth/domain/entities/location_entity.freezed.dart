// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$LocationEntity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String get countryCode => throw _privateConstructorUsedError;

  /// Create a copy of LocationEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocationEntityCopyWith<LocationEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationEntityCopyWith<$Res> {
  factory $LocationEntityCopyWith(
    LocationEntity value,
    $Res Function(LocationEntity) then,
  ) = _$LocationEntityCopyWithImpl<$Res, LocationEntity>;
  @useResult
  $Res call({String id, String name, String fullName, String countryCode});
}

/// @nodoc
class _$LocationEntityCopyWithImpl<$Res, $Val extends LocationEntity>
    implements $LocationEntityCopyWith<$Res> {
  _$LocationEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocationEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? fullName = null,
    Object? countryCode = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            fullName: null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String,
            countryCode: null == countryCode
                ? _value.countryCode
                : countryCode // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LocationEntityImplCopyWith<$Res>
    implements $LocationEntityCopyWith<$Res> {
  factory _$$LocationEntityImplCopyWith(
    _$LocationEntityImpl value,
    $Res Function(_$LocationEntityImpl) then,
  ) = __$$LocationEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String fullName, String countryCode});
}

/// @nodoc
class __$$LocationEntityImplCopyWithImpl<$Res>
    extends _$LocationEntityCopyWithImpl<$Res, _$LocationEntityImpl>
    implements _$$LocationEntityImplCopyWith<$Res> {
  __$$LocationEntityImplCopyWithImpl(
    _$LocationEntityImpl _value,
    $Res Function(_$LocationEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocationEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? fullName = null,
    Object? countryCode = null,
  }) {
    return _then(
      _$LocationEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        fullName: null == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String,
        countryCode: null == countryCode
            ? _value.countryCode
            : countryCode // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LocationEntityImpl implements _LocationEntity {
  const _$LocationEntityImpl({
    required this.id,
    required this.name,
    required this.fullName,
    required this.countryCode,
  });

  @override
  final String id;
  @override
  final String name;
  @override
  final String fullName;
  @override
  final String countryCode;

  @override
  String toString() {
    return 'LocationEntity(id: $id, name: $name, fullName: $fullName, countryCode: $countryCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.countryCode, countryCode) ||
                other.countryCode == countryCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, fullName, countryCode);

  /// Create a copy of LocationEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationEntityImplCopyWith<_$LocationEntityImpl> get copyWith =>
      __$$LocationEntityImplCopyWithImpl<_$LocationEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _LocationEntity implements LocationEntity {
  const factory _LocationEntity({
    required final String id,
    required final String name,
    required final String fullName,
    required final String countryCode,
  }) = _$LocationEntityImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  String get fullName;
  @override
  String get countryCode;

  /// Create a copy of LocationEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationEntityImplCopyWith<_$LocationEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
