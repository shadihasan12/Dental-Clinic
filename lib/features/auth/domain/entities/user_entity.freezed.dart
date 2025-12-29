// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$UserEntity {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt =>
      throw _privateConstructorUsedError; // Professional fields (optional at signup)
  String? get licenseNumber => throw _privateConstructorUsedError;
  String? get specialization =>
      throw _privateConstructorUsedError; // Primary clinic they own (if any)
  String? get ownedClinicId => throw _privateConstructorUsedError;

  /// Create a copy of UserEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserEntityCopyWith<UserEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserEntityCopyWith<$Res> {
  factory $UserEntityCopyWith(
    UserEntity value,
    $Res Function(UserEntity) then,
  ) = _$UserEntityCopyWithImpl<$Res, UserEntity>;
  @useResult
  $Res call({
    String id,
    String email,
    String name,
    String? phone,
    String? avatarUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? licenseNumber,
    String? specialization,
    String? ownedClinicId,
  });
}

/// @nodoc
class _$UserEntityCopyWithImpl<$Res, $Val extends UserEntity>
    implements $UserEntityCopyWith<$Res> {
  _$UserEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = null,
    Object? phone = freezed,
    Object? avatarUrl = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? licenseNumber = freezed,
    Object? specialization = freezed,
    Object? ownedClinicId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            licenseNumber: freezed == licenseNumber
                ? _value.licenseNumber
                : licenseNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            specialization: freezed == specialization
                ? _value.specialization
                : specialization // ignore: cast_nullable_to_non_nullable
                      as String?,
            ownedClinicId: freezed == ownedClinicId
                ? _value.ownedClinicId
                : ownedClinicId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserEntityImplCopyWith<$Res>
    implements $UserEntityCopyWith<$Res> {
  factory _$$UserEntityImplCopyWith(
    _$UserEntityImpl value,
    $Res Function(_$UserEntityImpl) then,
  ) = __$$UserEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String email,
    String name,
    String? phone,
    String? avatarUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? licenseNumber,
    String? specialization,
    String? ownedClinicId,
  });
}

/// @nodoc
class __$$UserEntityImplCopyWithImpl<$Res>
    extends _$UserEntityCopyWithImpl<$Res, _$UserEntityImpl>
    implements _$$UserEntityImplCopyWith<$Res> {
  __$$UserEntityImplCopyWithImpl(
    _$UserEntityImpl _value,
    $Res Function(_$UserEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = null,
    Object? phone = freezed,
    Object? avatarUrl = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? licenseNumber = freezed,
    Object? specialization = freezed,
    Object? ownedClinicId = freezed,
  }) {
    return _then(
      _$UserEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        licenseNumber: freezed == licenseNumber
            ? _value.licenseNumber
            : licenseNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        specialization: freezed == specialization
            ? _value.specialization
            : specialization // ignore: cast_nullable_to_non_nullable
                  as String?,
        ownedClinicId: freezed == ownedClinicId
            ? _value.ownedClinicId
            : ownedClinicId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$UserEntityImpl extends _UserEntity {
  const _$UserEntityImpl({
    required this.id,
    required this.email,
    required this.name,
    this.phone,
    this.avatarUrl,
    this.createdAt,
    this.updatedAt,
    this.licenseNumber,
    this.specialization,
    this.ownedClinicId,
  }) : super._();

  @override
  final String id;
  @override
  final String email;
  @override
  final String name;
  @override
  final String? phone;
  @override
  final String? avatarUrl;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  // Professional fields (optional at signup)
  @override
  final String? licenseNumber;
  @override
  final String? specialization;
  // Primary clinic they own (if any)
  @override
  final String? ownedClinicId;

  @override
  String toString() {
    return 'UserEntity(id: $id, email: $email, name: $name, phone: $phone, avatarUrl: $avatarUrl, createdAt: $createdAt, updatedAt: $updatedAt, licenseNumber: $licenseNumber, specialization: $specialization, ownedClinicId: $ownedClinicId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.licenseNumber, licenseNumber) ||
                other.licenseNumber == licenseNumber) &&
            (identical(other.specialization, specialization) ||
                other.specialization == specialization) &&
            (identical(other.ownedClinicId, ownedClinicId) ||
                other.ownedClinicId == ownedClinicId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    email,
    name,
    phone,
    avatarUrl,
    createdAt,
    updatedAt,
    licenseNumber,
    specialization,
    ownedClinicId,
  );

  /// Create a copy of UserEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserEntityImplCopyWith<_$UserEntityImpl> get copyWith =>
      __$$UserEntityImplCopyWithImpl<_$UserEntityImpl>(this, _$identity);
}

abstract class _UserEntity extends UserEntity {
  const factory _UserEntity({
    required final String id,
    required final String email,
    required final String name,
    final String? phone,
    final String? avatarUrl,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final String? licenseNumber,
    final String? specialization,
    final String? ownedClinicId,
  }) = _$UserEntityImpl;
  const _UserEntity._() : super._();

  @override
  String get id;
  @override
  String get email;
  @override
  String get name;
  @override
  String? get phone;
  @override
  String? get avatarUrl;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt; // Professional fields (optional at signup)
  @override
  String? get licenseNumber;
  @override
  String? get specialization; // Primary clinic they own (if any)
  @override
  String? get ownedClinicId;

  /// Create a copy of UserEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserEntityImplCopyWith<_$UserEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
