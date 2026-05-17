// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clinic_membership_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ClinicMembershipEntity {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get clinicId => throw _privateConstructorUsedError;
  String get clinicName => throw _privateConstructorUsedError;
  ClinicRole get role => throw _privateConstructorUsedError;
  MembershipStatus get status => throw _privateConstructorUsedError;
  List<ClinicRole> get roles =>
      throw _privateConstructorUsedError; // True when the user is the original owner of this clinic. Owners
  // cannot be deleted from the staff list by other admins.
  bool get isOwner => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get locationName => throw _privateConstructorUsedError;
  String? get userName => throw _privateConstructorUsedError;
  String? get userEmail => throw _privateConstructorUsedError;
  String? get userAvatarUrl => throw _privateConstructorUsedError;
  DateTime? get joinedAt => throw _privateConstructorUsedError;
  DateTime? get invitedAt => throw _privateConstructorUsedError;
  String? get invitedByUserId => throw _privateConstructorUsedError;

  /// Create a copy of ClinicMembershipEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClinicMembershipEntityCopyWith<ClinicMembershipEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClinicMembershipEntityCopyWith<$Res> {
  factory $ClinicMembershipEntityCopyWith(
    ClinicMembershipEntity value,
    $Res Function(ClinicMembershipEntity) then,
  ) = _$ClinicMembershipEntityCopyWithImpl<$Res, ClinicMembershipEntity>;
  @useResult
  $Res call({
    String id,
    String userId,
    String clinicId,
    String clinicName,
    ClinicRole role,
    MembershipStatus status,
    List<ClinicRole> roles,
    bool isOwner,
    String? address,
    String? locationName,
    String? userName,
    String? userEmail,
    String? userAvatarUrl,
    DateTime? joinedAt,
    DateTime? invitedAt,
    String? invitedByUserId,
  });
}

/// @nodoc
class _$ClinicMembershipEntityCopyWithImpl<
  $Res,
  $Val extends ClinicMembershipEntity
>
    implements $ClinicMembershipEntityCopyWith<$Res> {
  _$ClinicMembershipEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClinicMembershipEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? clinicId = null,
    Object? clinicName = null,
    Object? role = null,
    Object? status = null,
    Object? roles = null,
    Object? isOwner = null,
    Object? address = freezed,
    Object? locationName = freezed,
    Object? userName = freezed,
    Object? userEmail = freezed,
    Object? userAvatarUrl = freezed,
    Object? joinedAt = freezed,
    Object? invitedAt = freezed,
    Object? invitedByUserId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            clinicId: null == clinicId
                ? _value.clinicId
                : clinicId // ignore: cast_nullable_to_non_nullable
                      as String,
            clinicName: null == clinicName
                ? _value.clinicName
                : clinicName // ignore: cast_nullable_to_non_nullable
                      as String,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as ClinicRole,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as MembershipStatus,
            roles: null == roles
                ? _value.roles
                : roles // ignore: cast_nullable_to_non_nullable
                      as List<ClinicRole>,
            isOwner: null == isOwner
                ? _value.isOwner
                : isOwner // ignore: cast_nullable_to_non_nullable
                      as bool,
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String?,
            locationName: freezed == locationName
                ? _value.locationName
                : locationName // ignore: cast_nullable_to_non_nullable
                      as String?,
            userName: freezed == userName
                ? _value.userName
                : userName // ignore: cast_nullable_to_non_nullable
                      as String?,
            userEmail: freezed == userEmail
                ? _value.userEmail
                : userEmail // ignore: cast_nullable_to_non_nullable
                      as String?,
            userAvatarUrl: freezed == userAvatarUrl
                ? _value.userAvatarUrl
                : userAvatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            joinedAt: freezed == joinedAt
                ? _value.joinedAt
                : joinedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            invitedAt: freezed == invitedAt
                ? _value.invitedAt
                : invitedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            invitedByUserId: freezed == invitedByUserId
                ? _value.invitedByUserId
                : invitedByUserId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClinicMembershipEntityImplCopyWith<$Res>
    implements $ClinicMembershipEntityCopyWith<$Res> {
  factory _$$ClinicMembershipEntityImplCopyWith(
    _$ClinicMembershipEntityImpl value,
    $Res Function(_$ClinicMembershipEntityImpl) then,
  ) = __$$ClinicMembershipEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String clinicId,
    String clinicName,
    ClinicRole role,
    MembershipStatus status,
    List<ClinicRole> roles,
    bool isOwner,
    String? address,
    String? locationName,
    String? userName,
    String? userEmail,
    String? userAvatarUrl,
    DateTime? joinedAt,
    DateTime? invitedAt,
    String? invitedByUserId,
  });
}

/// @nodoc
class __$$ClinicMembershipEntityImplCopyWithImpl<$Res>
    extends
        _$ClinicMembershipEntityCopyWithImpl<$Res, _$ClinicMembershipEntityImpl>
    implements _$$ClinicMembershipEntityImplCopyWith<$Res> {
  __$$ClinicMembershipEntityImplCopyWithImpl(
    _$ClinicMembershipEntityImpl _value,
    $Res Function(_$ClinicMembershipEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClinicMembershipEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? clinicId = null,
    Object? clinicName = null,
    Object? role = null,
    Object? status = null,
    Object? roles = null,
    Object? isOwner = null,
    Object? address = freezed,
    Object? locationName = freezed,
    Object? userName = freezed,
    Object? userEmail = freezed,
    Object? userAvatarUrl = freezed,
    Object? joinedAt = freezed,
    Object? invitedAt = freezed,
    Object? invitedByUserId = freezed,
  }) {
    return _then(
      _$ClinicMembershipEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        clinicId: null == clinicId
            ? _value.clinicId
            : clinicId // ignore: cast_nullable_to_non_nullable
                  as String,
        clinicName: null == clinicName
            ? _value.clinicName
            : clinicName // ignore: cast_nullable_to_non_nullable
                  as String,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as ClinicRole,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as MembershipStatus,
        roles: null == roles
            ? _value._roles
            : roles // ignore: cast_nullable_to_non_nullable
                  as List<ClinicRole>,
        isOwner: null == isOwner
            ? _value.isOwner
            : isOwner // ignore: cast_nullable_to_non_nullable
                  as bool,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String?,
        locationName: freezed == locationName
            ? _value.locationName
            : locationName // ignore: cast_nullable_to_non_nullable
                  as String?,
        userName: freezed == userName
            ? _value.userName
            : userName // ignore: cast_nullable_to_non_nullable
                  as String?,
        userEmail: freezed == userEmail
            ? _value.userEmail
            : userEmail // ignore: cast_nullable_to_non_nullable
                  as String?,
        userAvatarUrl: freezed == userAvatarUrl
            ? _value.userAvatarUrl
            : userAvatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        joinedAt: freezed == joinedAt
            ? _value.joinedAt
            : joinedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        invitedAt: freezed == invitedAt
            ? _value.invitedAt
            : invitedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        invitedByUserId: freezed == invitedByUserId
            ? _value.invitedByUserId
            : invitedByUserId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ClinicMembershipEntityImpl implements _ClinicMembershipEntity {
  const _$ClinicMembershipEntityImpl({
    required this.id,
    required this.userId,
    required this.clinicId,
    required this.clinicName,
    required this.role,
    required this.status,
    final List<ClinicRole> roles = const [],
    this.isOwner = false,
    this.address,
    this.locationName,
    this.userName,
    this.userEmail,
    this.userAvatarUrl,
    this.joinedAt,
    this.invitedAt,
    this.invitedByUserId,
  }) : _roles = roles;

  @override
  final String id;
  @override
  final String userId;
  @override
  final String clinicId;
  @override
  final String clinicName;
  @override
  final ClinicRole role;
  @override
  final MembershipStatus status;
  final List<ClinicRole> _roles;
  @override
  @JsonKey()
  List<ClinicRole> get roles {
    if (_roles is EqualUnmodifiableListView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roles);
  }

  // True when the user is the original owner of this clinic. Owners
  // cannot be deleted from the staff list by other admins.
  @override
  @JsonKey()
  final bool isOwner;
  @override
  final String? address;
  @override
  final String? locationName;
  @override
  final String? userName;
  @override
  final String? userEmail;
  @override
  final String? userAvatarUrl;
  @override
  final DateTime? joinedAt;
  @override
  final DateTime? invitedAt;
  @override
  final String? invitedByUserId;

  @override
  String toString() {
    return 'ClinicMembershipEntity(id: $id, userId: $userId, clinicId: $clinicId, clinicName: $clinicName, role: $role, status: $status, roles: $roles, isOwner: $isOwner, address: $address, locationName: $locationName, userName: $userName, userEmail: $userEmail, userAvatarUrl: $userAvatarUrl, joinedAt: $joinedAt, invitedAt: $invitedAt, invitedByUserId: $invitedByUserId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClinicMembershipEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.clinicId, clinicId) ||
                other.clinicId == clinicId) &&
            (identical(other.clinicName, clinicName) ||
                other.clinicName == clinicName) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._roles, _roles) &&
            (identical(other.isOwner, isOwner) || other.isOwner == isOwner) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.locationName, locationName) ||
                other.locationName == locationName) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userEmail, userEmail) ||
                other.userEmail == userEmail) &&
            (identical(other.userAvatarUrl, userAvatarUrl) ||
                other.userAvatarUrl == userAvatarUrl) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt) &&
            (identical(other.invitedAt, invitedAt) ||
                other.invitedAt == invitedAt) &&
            (identical(other.invitedByUserId, invitedByUserId) ||
                other.invitedByUserId == invitedByUserId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    clinicId,
    clinicName,
    role,
    status,
    const DeepCollectionEquality().hash(_roles),
    isOwner,
    address,
    locationName,
    userName,
    userEmail,
    userAvatarUrl,
    joinedAt,
    invitedAt,
    invitedByUserId,
  );

  /// Create a copy of ClinicMembershipEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClinicMembershipEntityImplCopyWith<_$ClinicMembershipEntityImpl>
  get copyWith =>
      __$$ClinicMembershipEntityImplCopyWithImpl<_$ClinicMembershipEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _ClinicMembershipEntity implements ClinicMembershipEntity {
  const factory _ClinicMembershipEntity({
    required final String id,
    required final String userId,
    required final String clinicId,
    required final String clinicName,
    required final ClinicRole role,
    required final MembershipStatus status,
    final List<ClinicRole> roles,
    final bool isOwner,
    final String? address,
    final String? locationName,
    final String? userName,
    final String? userEmail,
    final String? userAvatarUrl,
    final DateTime? joinedAt,
    final DateTime? invitedAt,
    final String? invitedByUserId,
  }) = _$ClinicMembershipEntityImpl;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get clinicId;
  @override
  String get clinicName;
  @override
  ClinicRole get role;
  @override
  MembershipStatus get status;
  @override
  List<ClinicRole> get roles; // True when the user is the original owner of this clinic. Owners
  // cannot be deleted from the staff list by other admins.
  @override
  bool get isOwner;
  @override
  String? get address;
  @override
  String? get locationName;
  @override
  String? get userName;
  @override
  String? get userEmail;
  @override
  String? get userAvatarUrl;
  @override
  DateTime? get joinedAt;
  @override
  DateTime? get invitedAt;
  @override
  String? get invitedByUserId;

  /// Create a copy of ClinicMembershipEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClinicMembershipEntityImplCopyWith<_$ClinicMembershipEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}
