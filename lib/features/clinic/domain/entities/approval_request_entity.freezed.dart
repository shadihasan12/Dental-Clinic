// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'approval_request_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ApprovalRequestEntity {
  String get id => throw _privateConstructorUsedError;
  String get clinicId => throw _privateConstructorUsedError;
  String get requesterId =>
      throw _privateConstructorUsedError; // User who made the request
  String get requesterName => throw _privateConstructorUsedError;
  ApprovalType get type => throw _privateConstructorUsedError;
  ApprovalStatus get status => throw _privateConstructorUsedError;
  Map<String, dynamic> get payload =>
      throw _privateConstructorUsedError; // Action-specific data
  String? get requesterAvatarUrl => throw _privateConstructorUsedError;
  String? get reviewedByUserId => throw _privateConstructorUsedError;
  String? get reviewerName => throw _privateConstructorUsedError;
  String? get reviewerComment => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get reviewedAt => throw _privateConstructorUsedError;

  /// Create a copy of ApprovalRequestEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApprovalRequestEntityCopyWith<ApprovalRequestEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApprovalRequestEntityCopyWith<$Res> {
  factory $ApprovalRequestEntityCopyWith(
    ApprovalRequestEntity value,
    $Res Function(ApprovalRequestEntity) then,
  ) = _$ApprovalRequestEntityCopyWithImpl<$Res, ApprovalRequestEntity>;
  @useResult
  $Res call({
    String id,
    String clinicId,
    String requesterId,
    String requesterName,
    ApprovalType type,
    ApprovalStatus status,
    Map<String, dynamic> payload,
    String? requesterAvatarUrl,
    String? reviewedByUserId,
    String? reviewerName,
    String? reviewerComment,
    DateTime? createdAt,
    DateTime? reviewedAt,
  });
}

/// @nodoc
class _$ApprovalRequestEntityCopyWithImpl<
  $Res,
  $Val extends ApprovalRequestEntity
>
    implements $ApprovalRequestEntityCopyWith<$Res> {
  _$ApprovalRequestEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApprovalRequestEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clinicId = null,
    Object? requesterId = null,
    Object? requesterName = null,
    Object? type = null,
    Object? status = null,
    Object? payload = null,
    Object? requesterAvatarUrl = freezed,
    Object? reviewedByUserId = freezed,
    Object? reviewerName = freezed,
    Object? reviewerComment = freezed,
    Object? createdAt = freezed,
    Object? reviewedAt = freezed,
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
            requesterId: null == requesterId
                ? _value.requesterId
                : requesterId // ignore: cast_nullable_to_non_nullable
                      as String,
            requesterName: null == requesterName
                ? _value.requesterName
                : requesterName // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as ApprovalType,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ApprovalStatus,
            payload: null == payload
                ? _value.payload
                : payload // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            requesterAvatarUrl: freezed == requesterAvatarUrl
                ? _value.requesterAvatarUrl
                : requesterAvatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            reviewedByUserId: freezed == reviewedByUserId
                ? _value.reviewedByUserId
                : reviewedByUserId // ignore: cast_nullable_to_non_nullable
                      as String?,
            reviewerName: freezed == reviewerName
                ? _value.reviewerName
                : reviewerName // ignore: cast_nullable_to_non_nullable
                      as String?,
            reviewerComment: freezed == reviewerComment
                ? _value.reviewerComment
                : reviewerComment // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            reviewedAt: freezed == reviewedAt
                ? _value.reviewedAt
                : reviewedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ApprovalRequestEntityImplCopyWith<$Res>
    implements $ApprovalRequestEntityCopyWith<$Res> {
  factory _$$ApprovalRequestEntityImplCopyWith(
    _$ApprovalRequestEntityImpl value,
    $Res Function(_$ApprovalRequestEntityImpl) then,
  ) = __$$ApprovalRequestEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String clinicId,
    String requesterId,
    String requesterName,
    ApprovalType type,
    ApprovalStatus status,
    Map<String, dynamic> payload,
    String? requesterAvatarUrl,
    String? reviewedByUserId,
    String? reviewerName,
    String? reviewerComment,
    DateTime? createdAt,
    DateTime? reviewedAt,
  });
}

/// @nodoc
class __$$ApprovalRequestEntityImplCopyWithImpl<$Res>
    extends
        _$ApprovalRequestEntityCopyWithImpl<$Res, _$ApprovalRequestEntityImpl>
    implements _$$ApprovalRequestEntityImplCopyWith<$Res> {
  __$$ApprovalRequestEntityImplCopyWithImpl(
    _$ApprovalRequestEntityImpl _value,
    $Res Function(_$ApprovalRequestEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApprovalRequestEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clinicId = null,
    Object? requesterId = null,
    Object? requesterName = null,
    Object? type = null,
    Object? status = null,
    Object? payload = null,
    Object? requesterAvatarUrl = freezed,
    Object? reviewedByUserId = freezed,
    Object? reviewerName = freezed,
    Object? reviewerComment = freezed,
    Object? createdAt = freezed,
    Object? reviewedAt = freezed,
  }) {
    return _then(
      _$ApprovalRequestEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        clinicId: null == clinicId
            ? _value.clinicId
            : clinicId // ignore: cast_nullable_to_non_nullable
                  as String,
        requesterId: null == requesterId
            ? _value.requesterId
            : requesterId // ignore: cast_nullable_to_non_nullable
                  as String,
        requesterName: null == requesterName
            ? _value.requesterName
            : requesterName // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as ApprovalType,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ApprovalStatus,
        payload: null == payload
            ? _value._payload
            : payload // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        requesterAvatarUrl: freezed == requesterAvatarUrl
            ? _value.requesterAvatarUrl
            : requesterAvatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        reviewedByUserId: freezed == reviewedByUserId
            ? _value.reviewedByUserId
            : reviewedByUserId // ignore: cast_nullable_to_non_nullable
                  as String?,
        reviewerName: freezed == reviewerName
            ? _value.reviewerName
            : reviewerName // ignore: cast_nullable_to_non_nullable
                  as String?,
        reviewerComment: freezed == reviewerComment
            ? _value.reviewerComment
            : reviewerComment // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        reviewedAt: freezed == reviewedAt
            ? _value.reviewedAt
            : reviewedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$ApprovalRequestEntityImpl implements _ApprovalRequestEntity {
  const _$ApprovalRequestEntityImpl({
    required this.id,
    required this.clinicId,
    required this.requesterId,
    required this.requesterName,
    required this.type,
    required this.status,
    required final Map<String, dynamic> payload,
    this.requesterAvatarUrl,
    this.reviewedByUserId,
    this.reviewerName,
    this.reviewerComment,
    this.createdAt,
    this.reviewedAt,
  }) : _payload = payload;

  @override
  final String id;
  @override
  final String clinicId;
  @override
  final String requesterId;
  // User who made the request
  @override
  final String requesterName;
  @override
  final ApprovalType type;
  @override
  final ApprovalStatus status;
  final Map<String, dynamic> _payload;
  @override
  Map<String, dynamic> get payload {
    if (_payload is EqualUnmodifiableMapView) return _payload;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_payload);
  }

  // Action-specific data
  @override
  final String? requesterAvatarUrl;
  @override
  final String? reviewedByUserId;
  @override
  final String? reviewerName;
  @override
  final String? reviewerComment;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? reviewedAt;

  @override
  String toString() {
    return 'ApprovalRequestEntity(id: $id, clinicId: $clinicId, requesterId: $requesterId, requesterName: $requesterName, type: $type, status: $status, payload: $payload, requesterAvatarUrl: $requesterAvatarUrl, reviewedByUserId: $reviewedByUserId, reviewerName: $reviewerName, reviewerComment: $reviewerComment, createdAt: $createdAt, reviewedAt: $reviewedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApprovalRequestEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clinicId, clinicId) ||
                other.clinicId == clinicId) &&
            (identical(other.requesterId, requesterId) ||
                other.requesterId == requesterId) &&
            (identical(other.requesterName, requesterName) ||
                other.requesterName == requesterName) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._payload, _payload) &&
            (identical(other.requesterAvatarUrl, requesterAvatarUrl) ||
                other.requesterAvatarUrl == requesterAvatarUrl) &&
            (identical(other.reviewedByUserId, reviewedByUserId) ||
                other.reviewedByUserId == reviewedByUserId) &&
            (identical(other.reviewerName, reviewerName) ||
                other.reviewerName == reviewerName) &&
            (identical(other.reviewerComment, reviewerComment) ||
                other.reviewerComment == reviewerComment) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.reviewedAt, reviewedAt) ||
                other.reviewedAt == reviewedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    clinicId,
    requesterId,
    requesterName,
    type,
    status,
    const DeepCollectionEquality().hash(_payload),
    requesterAvatarUrl,
    reviewedByUserId,
    reviewerName,
    reviewerComment,
    createdAt,
    reviewedAt,
  );

  /// Create a copy of ApprovalRequestEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApprovalRequestEntityImplCopyWith<_$ApprovalRequestEntityImpl>
  get copyWith =>
      __$$ApprovalRequestEntityImplCopyWithImpl<_$ApprovalRequestEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _ApprovalRequestEntity implements ApprovalRequestEntity {
  const factory _ApprovalRequestEntity({
    required final String id,
    required final String clinicId,
    required final String requesterId,
    required final String requesterName,
    required final ApprovalType type,
    required final ApprovalStatus status,
    required final Map<String, dynamic> payload,
    final String? requesterAvatarUrl,
    final String? reviewedByUserId,
    final String? reviewerName,
    final String? reviewerComment,
    final DateTime? createdAt,
    final DateTime? reviewedAt,
  }) = _$ApprovalRequestEntityImpl;

  @override
  String get id;
  @override
  String get clinicId;
  @override
  String get requesterId; // User who made the request
  @override
  String get requesterName;
  @override
  ApprovalType get type;
  @override
  ApprovalStatus get status;
  @override
  Map<String, dynamic> get payload; // Action-specific data
  @override
  String? get requesterAvatarUrl;
  @override
  String? get reviewedByUserId;
  @override
  String? get reviewerName;
  @override
  String? get reviewerComment;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get reviewedAt;

  /// Create a copy of ApprovalRequestEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApprovalRequestEntityImplCopyWith<_$ApprovalRequestEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}
