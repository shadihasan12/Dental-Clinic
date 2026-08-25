// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'issue_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$IssueEntity {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  IssueStatus get status => throw _privateConstructorUsedError;

  /// Absent until the server starts sending it; the card simply drops the
  /// date line rather than inventing one.
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Create a copy of IssueEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IssueEntityCopyWith<IssueEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IssueEntityCopyWith<$Res> {
  factory $IssueEntityCopyWith(
    IssueEntity value,
    $Res Function(IssueEntity) then,
  ) = _$IssueEntityCopyWithImpl<$Res, IssueEntity>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    IssueStatus status,
    DateTime? createdAt,
  });
}

/// @nodoc
class _$IssueEntityCopyWithImpl<$Res, $Val extends IssueEntity>
    implements $IssueEntityCopyWith<$Res> {
  _$IssueEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IssueEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? status = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as IssueStatus,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$IssueEntityImplCopyWith<$Res>
    implements $IssueEntityCopyWith<$Res> {
  factory _$$IssueEntityImplCopyWith(
    _$IssueEntityImpl value,
    $Res Function(_$IssueEntityImpl) then,
  ) = __$$IssueEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    IssueStatus status,
    DateTime? createdAt,
  });
}

/// @nodoc
class __$$IssueEntityImplCopyWithImpl<$Res>
    extends _$IssueEntityCopyWithImpl<$Res, _$IssueEntityImpl>
    implements _$$IssueEntityImplCopyWith<$Res> {
  __$$IssueEntityImplCopyWithImpl(
    _$IssueEntityImpl _value,
    $Res Function(_$IssueEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IssueEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? status = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$IssueEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as IssueStatus,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$IssueEntityImpl implements _IssueEntity {
  const _$IssueEntityImpl({
    required this.id,
    required this.title,
    required this.description,
    this.status = IssueStatus.pending,
    this.createdAt,
  });

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  @JsonKey()
  final IssueStatus status;

  /// Absent until the server starts sending it; the card simply drops the
  /// date line rather than inventing one.
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'IssueEntity(id: $id, title: $title, description: $description, status: $status, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IssueEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, description, status, createdAt);

  /// Create a copy of IssueEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IssueEntityImplCopyWith<_$IssueEntityImpl> get copyWith =>
      __$$IssueEntityImplCopyWithImpl<_$IssueEntityImpl>(this, _$identity);
}

abstract class _IssueEntity implements IssueEntity {
  const factory _IssueEntity({
    required final String id,
    required final String title,
    required final String description,
    final IssueStatus status,
    final DateTime? createdAt,
  }) = _$IssueEntityImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  IssueStatus get status;

  /// Absent until the server starts sending it; the card simply drops the
  /// date line rather than inventing one.
  @override
  DateTime? get createdAt;

  /// Create a copy of IssueEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IssueEntityImplCopyWith<_$IssueEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
