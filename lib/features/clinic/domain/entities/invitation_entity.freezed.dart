// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invitation_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$InvitationEntity {
  String get id => throw _privateConstructorUsedError;
  String get clinicId => throw _privateConstructorUsedError;
  String get clinicName =>
      throw _privateConstructorUsedError; // Denormalized for display
  String get inviteeEmail => throw _privateConstructorUsedError;
  ClinicRole get role => throw _privateConstructorUsedError;
  InvitationStatus get status => throw _privateConstructorUsedError;
  String get invitedByUserId => throw _privateConstructorUsedError;
  List<ClinicRole> get roles => throw _privateConstructorUsedError;
  String? get inviteeName =>
      throw _privateConstructorUsedError; // Set on /sent — the invitee's full name
  String? get inviteeImageUrl => throw _privateConstructorUsedError;
  String? get inviteeSpecialty => throw _privateConstructorUsedError;
  String? get invitedByName =>
      throw _privateConstructorUsedError; // Denormalized for display
  String? get message =>
      throw _privateConstructorUsedError; // Optional personal message
  String? get clinicLogoUrl => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  DateTime? get respondedAt => throw _privateConstructorUsedError;
  List<AuditEntry> get audits => throw _privateConstructorUsedError;

  /// Create a copy of InvitationEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InvitationEntityCopyWith<InvitationEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvitationEntityCopyWith<$Res> {
  factory $InvitationEntityCopyWith(
    InvitationEntity value,
    $Res Function(InvitationEntity) then,
  ) = _$InvitationEntityCopyWithImpl<$Res, InvitationEntity>;
  @useResult
  $Res call({
    String id,
    String clinicId,
    String clinicName,
    String inviteeEmail,
    ClinicRole role,
    InvitationStatus status,
    String invitedByUserId,
    List<ClinicRole> roles,
    String? inviteeName,
    String? inviteeImageUrl,
    String? inviteeSpecialty,
    String? invitedByName,
    String? message,
    String? clinicLogoUrl,
    DateTime? createdAt,
    DateTime? expiresAt,
    DateTime? respondedAt,
    List<AuditEntry> audits,
  });
}

/// @nodoc
class _$InvitationEntityCopyWithImpl<$Res, $Val extends InvitationEntity>
    implements $InvitationEntityCopyWith<$Res> {
  _$InvitationEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InvitationEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clinicId = null,
    Object? clinicName = null,
    Object? inviteeEmail = null,
    Object? role = null,
    Object? status = null,
    Object? invitedByUserId = null,
    Object? roles = null,
    Object? inviteeName = freezed,
    Object? inviteeImageUrl = freezed,
    Object? inviteeSpecialty = freezed,
    Object? invitedByName = freezed,
    Object? message = freezed,
    Object? clinicLogoUrl = freezed,
    Object? createdAt = freezed,
    Object? expiresAt = freezed,
    Object? respondedAt = freezed,
    Object? audits = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            clinicId: null == clinicId
                ? _value.clinicId
                : clinicId // ignore: cast_nullable_to_non_nullable
                      as String,
            clinicName: null == clinicName
                ? _value.clinicName
                : clinicName // ignore: cast_nullable_to_non_nullable
                      as String,
            inviteeEmail: null == inviteeEmail
                ? _value.inviteeEmail
                : inviteeEmail // ignore: cast_nullable_to_non_nullable
                      as String,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as ClinicRole,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as InvitationStatus,
            invitedByUserId: null == invitedByUserId
                ? _value.invitedByUserId
                : invitedByUserId // ignore: cast_nullable_to_non_nullable
                      as String,
            roles: null == roles
                ? _value.roles
                : roles // ignore: cast_nullable_to_non_nullable
                      as List<ClinicRole>,
            inviteeName: freezed == inviteeName
                ? _value.inviteeName
                : inviteeName // ignore: cast_nullable_to_non_nullable
                      as String?,
            inviteeImageUrl: freezed == inviteeImageUrl
                ? _value.inviteeImageUrl
                : inviteeImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            inviteeSpecialty: freezed == inviteeSpecialty
                ? _value.inviteeSpecialty
                : inviteeSpecialty // ignore: cast_nullable_to_non_nullable
                      as String?,
            invitedByName: freezed == invitedByName
                ? _value.invitedByName
                : invitedByName // ignore: cast_nullable_to_non_nullable
                      as String?,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            clinicLogoUrl: freezed == clinicLogoUrl
                ? _value.clinicLogoUrl
                : clinicLogoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            expiresAt: freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            respondedAt: freezed == respondedAt
                ? _value.respondedAt
                : respondedAt // ignore: cast_nullable_to_non_nullable
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
abstract class _$$InvitationEntityImplCopyWith<$Res>
    implements $InvitationEntityCopyWith<$Res> {
  factory _$$InvitationEntityImplCopyWith(
    _$InvitationEntityImpl value,
    $Res Function(_$InvitationEntityImpl) then,
  ) = __$$InvitationEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String clinicId,
    String clinicName,
    String inviteeEmail,
    ClinicRole role,
    InvitationStatus status,
    String invitedByUserId,
    List<ClinicRole> roles,
    String? inviteeName,
    String? inviteeImageUrl,
    String? inviteeSpecialty,
    String? invitedByName,
    String? message,
    String? clinicLogoUrl,
    DateTime? createdAt,
    DateTime? expiresAt,
    DateTime? respondedAt,
    List<AuditEntry> audits,
  });
}

/// @nodoc
class __$$InvitationEntityImplCopyWithImpl<$Res>
    extends _$InvitationEntityCopyWithImpl<$Res, _$InvitationEntityImpl>
    implements _$$InvitationEntityImplCopyWith<$Res> {
  __$$InvitationEntityImplCopyWithImpl(
    _$InvitationEntityImpl _value,
    $Res Function(_$InvitationEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InvitationEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clinicId = null,
    Object? clinicName = null,
    Object? inviteeEmail = null,
    Object? role = null,
    Object? status = null,
    Object? invitedByUserId = null,
    Object? roles = null,
    Object? inviteeName = freezed,
    Object? inviteeImageUrl = freezed,
    Object? inviteeSpecialty = freezed,
    Object? invitedByName = freezed,
    Object? message = freezed,
    Object? clinicLogoUrl = freezed,
    Object? createdAt = freezed,
    Object? expiresAt = freezed,
    Object? respondedAt = freezed,
    Object? audits = null,
  }) {
    return _then(
      _$InvitationEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        clinicId: null == clinicId
            ? _value.clinicId
            : clinicId // ignore: cast_nullable_to_non_nullable
                  as String,
        clinicName: null == clinicName
            ? _value.clinicName
            : clinicName // ignore: cast_nullable_to_non_nullable
                  as String,
        inviteeEmail: null == inviteeEmail
            ? _value.inviteeEmail
            : inviteeEmail // ignore: cast_nullable_to_non_nullable
                  as String,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as ClinicRole,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as InvitationStatus,
        invitedByUserId: null == invitedByUserId
            ? _value.invitedByUserId
            : invitedByUserId // ignore: cast_nullable_to_non_nullable
                  as String,
        roles: null == roles
            ? _value._roles
            : roles // ignore: cast_nullable_to_non_nullable
                  as List<ClinicRole>,
        inviteeName: freezed == inviteeName
            ? _value.inviteeName
            : inviteeName // ignore: cast_nullable_to_non_nullable
                  as String?,
        inviteeImageUrl: freezed == inviteeImageUrl
            ? _value.inviteeImageUrl
            : inviteeImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        inviteeSpecialty: freezed == inviteeSpecialty
            ? _value.inviteeSpecialty
            : inviteeSpecialty // ignore: cast_nullable_to_non_nullable
                  as String?,
        invitedByName: freezed == invitedByName
            ? _value.invitedByName
            : invitedByName // ignore: cast_nullable_to_non_nullable
                  as String?,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        clinicLogoUrl: freezed == clinicLogoUrl
            ? _value.clinicLogoUrl
            : clinicLogoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        respondedAt: freezed == respondedAt
            ? _value.respondedAt
            : respondedAt // ignore: cast_nullable_to_non_nullable
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

class _$InvitationEntityImpl implements _InvitationEntity {
  const _$InvitationEntityImpl({
    required this.id,
    required this.clinicId,
    required this.clinicName,
    required this.inviteeEmail,
    required this.role,
    required this.status,
    required this.invitedByUserId,
    final List<ClinicRole> roles = const <ClinicRole>[],
    this.inviteeName,
    this.inviteeImageUrl,
    this.inviteeSpecialty,
    this.invitedByName,
    this.message,
    this.clinicLogoUrl,
    this.createdAt,
    this.expiresAt,
    this.respondedAt,
    final List<AuditEntry> audits = const [],
  }) : _roles = roles,
       _audits = audits;

  @override
  final String id;
  @override
  final String clinicId;
  @override
  final String clinicName;
  // Denormalized for display
  @override
  final String inviteeEmail;
  @override
  final ClinicRole role;
  @override
  final InvitationStatus status;
  @override
  final String invitedByUserId;
  final List<ClinicRole> _roles;
  @override
  @JsonKey()
  List<ClinicRole> get roles {
    if (_roles is EqualUnmodifiableListView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roles);
  }

  @override
  final String? inviteeName;
  // Set on /sent — the invitee's full name
  @override
  final String? inviteeImageUrl;
  @override
  final String? inviteeSpecialty;
  @override
  final String? invitedByName;
  // Denormalized for display
  @override
  final String? message;
  // Optional personal message
  @override
  final String? clinicLogoUrl;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? expiresAt;
  @override
  final DateTime? respondedAt;
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
    return 'InvitationEntity(id: $id, clinicId: $clinicId, clinicName: $clinicName, inviteeEmail: $inviteeEmail, role: $role, status: $status, invitedByUserId: $invitedByUserId, roles: $roles, inviteeName: $inviteeName, inviteeImageUrl: $inviteeImageUrl, inviteeSpecialty: $inviteeSpecialty, invitedByName: $invitedByName, message: $message, clinicLogoUrl: $clinicLogoUrl, createdAt: $createdAt, expiresAt: $expiresAt, respondedAt: $respondedAt, audits: $audits)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvitationEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clinicId, clinicId) ||
                other.clinicId == clinicId) &&
            (identical(other.clinicName, clinicName) ||
                other.clinicName == clinicName) &&
            (identical(other.inviteeEmail, inviteeEmail) ||
                other.inviteeEmail == inviteeEmail) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.invitedByUserId, invitedByUserId) ||
                other.invitedByUserId == invitedByUserId) &&
            const DeepCollectionEquality().equals(other._roles, _roles) &&
            (identical(other.inviteeName, inviteeName) ||
                other.inviteeName == inviteeName) &&
            (identical(other.inviteeImageUrl, inviteeImageUrl) ||
                other.inviteeImageUrl == inviteeImageUrl) &&
            (identical(other.inviteeSpecialty, inviteeSpecialty) ||
                other.inviteeSpecialty == inviteeSpecialty) &&
            (identical(other.invitedByName, invitedByName) ||
                other.invitedByName == invitedByName) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.clinicLogoUrl, clinicLogoUrl) ||
                other.clinicLogoUrl == clinicLogoUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.respondedAt, respondedAt) ||
                other.respondedAt == respondedAt) &&
            const DeepCollectionEquality().equals(other._audits, _audits));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    clinicId,
    clinicName,
    inviteeEmail,
    role,
    status,
    invitedByUserId,
    const DeepCollectionEquality().hash(_roles),
    inviteeName,
    inviteeImageUrl,
    inviteeSpecialty,
    invitedByName,
    message,
    clinicLogoUrl,
    createdAt,
    expiresAt,
    respondedAt,
    const DeepCollectionEquality().hash(_audits),
  );

  /// Create a copy of InvitationEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvitationEntityImplCopyWith<_$InvitationEntityImpl> get copyWith =>
      __$$InvitationEntityImplCopyWithImpl<_$InvitationEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _InvitationEntity implements InvitationEntity {
  const factory _InvitationEntity({
    required final String id,
    required final String clinicId,
    required final String clinicName,
    required final String inviteeEmail,
    required final ClinicRole role,
    required final InvitationStatus status,
    required final String invitedByUserId,
    final List<ClinicRole> roles,
    final String? inviteeName,
    final String? inviteeImageUrl,
    final String? inviteeSpecialty,
    final String? invitedByName,
    final String? message,
    final String? clinicLogoUrl,
    final DateTime? createdAt,
    final DateTime? expiresAt,
    final DateTime? respondedAt,
    final List<AuditEntry> audits,
  }) = _$InvitationEntityImpl;

  @override
  String get id;
  @override
  String get clinicId;
  @override
  String get clinicName; // Denormalized for display
  @override
  String get inviteeEmail;
  @override
  ClinicRole get role;
  @override
  InvitationStatus get status;
  @override
  String get invitedByUserId;
  @override
  List<ClinicRole> get roles;
  @override
  String? get inviteeName; // Set on /sent — the invitee's full name
  @override
  String? get inviteeImageUrl;
  @override
  String? get inviteeSpecialty;
  @override
  String? get invitedByName; // Denormalized for display
  @override
  String? get message; // Optional personal message
  @override
  String? get clinicLogoUrl;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get expiresAt;
  @override
  DateTime? get respondedAt;
  @override
  List<AuditEntry> get audits;

  /// Create a copy of InvitationEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvitationEntityImplCopyWith<_$InvitationEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
