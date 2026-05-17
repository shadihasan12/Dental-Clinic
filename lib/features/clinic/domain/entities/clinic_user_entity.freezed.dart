// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clinic_user_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ClinicUserEntity {
  String get id => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get mobileNumber => throw _privateConstructorUsedError;
  String? get specialtyName => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  List<ClinicRole> get roles => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  List<AuditEntry> get audits => throw _privateConstructorUsedError;

  /// Create a copy of ClinicUserEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClinicUserEntityCopyWith<ClinicUserEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClinicUserEntityCopyWith<$Res> {
  factory $ClinicUserEntityCopyWith(
    ClinicUserEntity value,
    $Res Function(ClinicUserEntity) then,
  ) = _$ClinicUserEntityCopyWithImpl<$Res, ClinicUserEntity>;
  @useResult
  $Res call({
    String id,
    String firstName,
    String lastName,
    String email,
    String? mobileNumber,
    String? specialtyName,
    String? imageUrl,
    List<ClinicRole> roles,
    DateTime? createdAt,
    List<AuditEntry> audits,
  });
}

/// @nodoc
class _$ClinicUserEntityCopyWithImpl<$Res, $Val extends ClinicUserEntity>
    implements $ClinicUserEntityCopyWith<$Res> {
  _$ClinicUserEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClinicUserEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? mobileNumber = freezed,
    Object? specialtyName = freezed,
    Object? imageUrl = freezed,
    Object? roles = null,
    Object? createdAt = freezed,
    Object? audits = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            firstName: null == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String,
            lastName: null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            mobileNumber: freezed == mobileNumber
                ? _value.mobileNumber
                : mobileNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            specialtyName: freezed == specialtyName
                ? _value.specialtyName
                : specialtyName // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            roles: null == roles
                ? _value.roles
                : roles // ignore: cast_nullable_to_non_nullable
                      as List<ClinicRole>,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            audits: null == audits
                ? _value.audits
                : audits // ignore: cast_nullable_to_non_nullable
                      as List<AuditEntry>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClinicUserEntityImplCopyWith<$Res>
    implements $ClinicUserEntityCopyWith<$Res> {
  factory _$$ClinicUserEntityImplCopyWith(
    _$ClinicUserEntityImpl value,
    $Res Function(_$ClinicUserEntityImpl) then,
  ) = __$$ClinicUserEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String firstName,
    String lastName,
    String email,
    String? mobileNumber,
    String? specialtyName,
    String? imageUrl,
    List<ClinicRole> roles,
    DateTime? createdAt,
    List<AuditEntry> audits,
  });
}

/// @nodoc
class __$$ClinicUserEntityImplCopyWithImpl<$Res>
    extends _$ClinicUserEntityCopyWithImpl<$Res, _$ClinicUserEntityImpl>
    implements _$$ClinicUserEntityImplCopyWith<$Res> {
  __$$ClinicUserEntityImplCopyWithImpl(
    _$ClinicUserEntityImpl _value,
    $Res Function(_$ClinicUserEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClinicUserEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? mobileNumber = freezed,
    Object? specialtyName = freezed,
    Object? imageUrl = freezed,
    Object? roles = null,
    Object? createdAt = freezed,
    Object? audits = null,
  }) {
    return _then(
      _$ClinicUserEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        firstName: null == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String,
        lastName: null == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        mobileNumber: freezed == mobileNumber
            ? _value.mobileNumber
            : mobileNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        specialtyName: freezed == specialtyName
            ? _value.specialtyName
            : specialtyName // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        roles: null == roles
            ? _value._roles
            : roles // ignore: cast_nullable_to_non_nullable
                  as List<ClinicRole>,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        audits: null == audits
            ? _value._audits
            : audits // ignore: cast_nullable_to_non_nullable
                  as List<AuditEntry>,
      ),
    );
  }
}

/// @nodoc

class _$ClinicUserEntityImpl extends _ClinicUserEntity {
  const _$ClinicUserEntityImpl({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.mobileNumber,
    this.specialtyName,
    this.imageUrl,
    final List<ClinicRole> roles = const [],
    this.createdAt,
    final List<AuditEntry> audits = const [],
  }) : _roles = roles,
       _audits = audits,
       super._();

  @override
  final String id;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String email;
  @override
  final String? mobileNumber;
  @override
  final String? specialtyName;
  @override
  final String? imageUrl;
  final List<ClinicRole> _roles;
  @override
  @JsonKey()
  List<ClinicRole> get roles {
    if (_roles is EqualUnmodifiableListView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roles);
  }

  @override
  final DateTime? createdAt;
  final List<AuditEntry> _audits;
  @override
  @JsonKey()
  List<AuditEntry> get audits {
    if (_audits is EqualUnmodifiableListView) return _audits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_audits);
  }

  @override
  String toString() {
    return 'ClinicUserEntity(id: $id, firstName: $firstName, lastName: $lastName, email: $email, mobileNumber: $mobileNumber, specialtyName: $specialtyName, imageUrl: $imageUrl, roles: $roles, createdAt: $createdAt, audits: $audits)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClinicUserEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.mobileNumber, mobileNumber) ||
                other.mobileNumber == mobileNumber) &&
            (identical(other.specialtyName, specialtyName) ||
                other.specialtyName == specialtyName) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other._roles, _roles) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._audits, _audits));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    firstName,
    lastName,
    email,
    mobileNumber,
    specialtyName,
    imageUrl,
    const DeepCollectionEquality().hash(_roles),
    createdAt,
    const DeepCollectionEquality().hash(_audits),
  );

  /// Create a copy of ClinicUserEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClinicUserEntityImplCopyWith<_$ClinicUserEntityImpl> get copyWith =>
      __$$ClinicUserEntityImplCopyWithImpl<_$ClinicUserEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _ClinicUserEntity extends ClinicUserEntity {
  const factory _ClinicUserEntity({
    required final String id,
    required final String firstName,
    required final String lastName,
    required final String email,
    final String? mobileNumber,
    final String? specialtyName,
    final String? imageUrl,
    final List<ClinicRole> roles,
    final DateTime? createdAt,
    final List<AuditEntry> audits,
  }) = _$ClinicUserEntityImpl;
  const _ClinicUserEntity._() : super._();

  @override
  String get id;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get email;
  @override
  String? get mobileNumber;
  @override
  String? get specialtyName;
  @override
  String? get imageUrl;
  @override
  List<ClinicRole> get roles;
  @override
  DateTime? get createdAt;
  @override
  List<AuditEntry> get audits;

  /// Create a copy of ClinicUserEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClinicUserEntityImplCopyWith<_$ClinicUserEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
