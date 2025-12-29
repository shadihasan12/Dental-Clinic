// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clinic_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ClinicEntity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get adminUserId =>
      throw _privateConstructorUsedError; // User who owns/manages this clinic
  String? get address => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get logoUrl => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of ClinicEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClinicEntityCopyWith<ClinicEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClinicEntityCopyWith<$Res> {
  factory $ClinicEntityCopyWith(
    ClinicEntity value,
    $Res Function(ClinicEntity) then,
  ) = _$ClinicEntityCopyWithImpl<$Res, ClinicEntity>;
  @useResult
  $Res call({
    String id,
    String name,
    String adminUserId,
    String? address,
    String? phone,
    String? email,
    String? logoUrl,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$ClinicEntityCopyWithImpl<$Res, $Val extends ClinicEntity>
    implements $ClinicEntityCopyWith<$Res> {
  _$ClinicEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClinicEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? adminUserId = null,
    Object? address = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? logoUrl = freezed,
    Object? description = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
            adminUserId: null == adminUserId
                ? _value.adminUserId
                : adminUserId // ignore: cast_nullable_to_non_nullable
                      as String,
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String?,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            logoUrl: freezed == logoUrl
                ? _value.logoUrl
                : logoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClinicEntityImplCopyWith<$Res>
    implements $ClinicEntityCopyWith<$Res> {
  factory _$$ClinicEntityImplCopyWith(
    _$ClinicEntityImpl value,
    $Res Function(_$ClinicEntityImpl) then,
  ) = __$$ClinicEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String adminUserId,
    String? address,
    String? phone,
    String? email,
    String? logoUrl,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$ClinicEntityImplCopyWithImpl<$Res>
    extends _$ClinicEntityCopyWithImpl<$Res, _$ClinicEntityImpl>
    implements _$$ClinicEntityImplCopyWith<$Res> {
  __$$ClinicEntityImplCopyWithImpl(
    _$ClinicEntityImpl _value,
    $Res Function(_$ClinicEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClinicEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? adminUserId = null,
    Object? address = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? logoUrl = freezed,
    Object? description = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$ClinicEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        adminUserId: null == adminUserId
            ? _value.adminUserId
            : adminUserId // ignore: cast_nullable_to_non_nullable
                  as String,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String?,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        logoUrl: freezed == logoUrl
            ? _value.logoUrl
            : logoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$ClinicEntityImpl implements _ClinicEntity {
  const _$ClinicEntityImpl({
    required this.id,
    required this.name,
    required this.adminUserId,
    this.address,
    this.phone,
    this.email,
    this.logoUrl,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  @override
  final String id;
  @override
  final String name;
  @override
  final String adminUserId;
  // User who owns/manages this clinic
  @override
  final String? address;
  @override
  final String? phone;
  @override
  final String? email;
  @override
  final String? logoUrl;
  @override
  final String? description;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'ClinicEntity(id: $id, name: $name, adminUserId: $adminUserId, address: $address, phone: $phone, email: $email, logoUrl: $logoUrl, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClinicEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.adminUserId, adminUserId) ||
                other.adminUserId == adminUserId) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    adminUserId,
    address,
    phone,
    email,
    logoUrl,
    description,
    createdAt,
    updatedAt,
  );

  /// Create a copy of ClinicEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClinicEntityImplCopyWith<_$ClinicEntityImpl> get copyWith =>
      __$$ClinicEntityImplCopyWithImpl<_$ClinicEntityImpl>(this, _$identity);
}

abstract class _ClinicEntity implements ClinicEntity {
  const factory _ClinicEntity({
    required final String id,
    required final String name,
    required final String adminUserId,
    final String? address,
    final String? phone,
    final String? email,
    final String? logoUrl,
    final String? description,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$ClinicEntityImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  String get adminUserId; // User who owns/manages this clinic
  @override
  String? get address;
  @override
  String? get phone;
  @override
  String? get email;
  @override
  String? get logoUrl;
  @override
  String? get description;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of ClinicEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClinicEntityImplCopyWith<_$ClinicEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
