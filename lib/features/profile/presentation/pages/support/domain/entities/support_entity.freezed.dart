// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'support_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SupportConversationEntity {
  String get id => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  List<SupportMessageEntity> get messages => throw _privateConstructorUsedError;
  bool get isRead => throw _privateConstructorUsedError;

  /// Create a copy of SupportConversationEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SupportConversationEntityCopyWith<SupportConversationEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SupportConversationEntityCopyWith<$Res> {
  factory $SupportConversationEntityCopyWith(
    SupportConversationEntity value,
    $Res Function(SupportConversationEntity) then,
  ) = _$SupportConversationEntityCopyWithImpl<$Res, SupportConversationEntity>;
  @useResult
  $Res call({
    String id,
    String subject,
    List<SupportMessageEntity> messages,
    bool isRead,
  });
}

/// @nodoc
class _$SupportConversationEntityCopyWithImpl<
  $Res,
  $Val extends SupportConversationEntity
>
    implements $SupportConversationEntityCopyWith<$Res> {
  _$SupportConversationEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SupportConversationEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? subject = null,
    Object? messages = null,
    Object? isRead = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            subject: null == subject
                ? _value.subject
                : subject // ignore: cast_nullable_to_non_nullable
                      as String,
            messages: null == messages
                ? _value.messages
                : messages // ignore: cast_nullable_to_non_nullable
                      as List<SupportMessageEntity>,
            isRead: null == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SupportConversationEntityImplCopyWith<$Res>
    implements $SupportConversationEntityCopyWith<$Res> {
  factory _$$SupportConversationEntityImplCopyWith(
    _$SupportConversationEntityImpl value,
    $Res Function(_$SupportConversationEntityImpl) then,
  ) = __$$SupportConversationEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String subject,
    List<SupportMessageEntity> messages,
    bool isRead,
  });
}

/// @nodoc
class __$$SupportConversationEntityImplCopyWithImpl<$Res>
    extends
        _$SupportConversationEntityCopyWithImpl<
          $Res,
          _$SupportConversationEntityImpl
        >
    implements _$$SupportConversationEntityImplCopyWith<$Res> {
  __$$SupportConversationEntityImplCopyWithImpl(
    _$SupportConversationEntityImpl _value,
    $Res Function(_$SupportConversationEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SupportConversationEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? subject = null,
    Object? messages = null,
    Object? isRead = null,
  }) {
    return _then(
      _$SupportConversationEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        subject: null == subject
            ? _value.subject
            : subject // ignore: cast_nullable_to_non_nullable
                  as String,
        messages: null == messages
            ? _value._messages
            : messages // ignore: cast_nullable_to_non_nullable
                  as List<SupportMessageEntity>,
        isRead: null == isRead
            ? _value.isRead
            : isRead // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$SupportConversationEntityImpl implements _SupportConversationEntity {
  const _$SupportConversationEntityImpl({
    required this.id,
    required this.subject,
    final List<SupportMessageEntity> messages = const [],
    this.isRead = true,
  }) : _messages = messages;

  @override
  final String id;
  @override
  final String subject;
  final List<SupportMessageEntity> _messages;
  @override
  @JsonKey()
  List<SupportMessageEntity> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  @JsonKey()
  final bool isRead;

  @override
  String toString() {
    return 'SupportConversationEntity(id: $id, subject: $subject, messages: $messages, isRead: $isRead)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SupportConversationEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.isRead, isRead) || other.isRead == isRead));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    subject,
    const DeepCollectionEquality().hash(_messages),
    isRead,
  );

  /// Create a copy of SupportConversationEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SupportConversationEntityImplCopyWith<_$SupportConversationEntityImpl>
  get copyWith =>
      __$$SupportConversationEntityImplCopyWithImpl<
        _$SupportConversationEntityImpl
      >(this, _$identity);
}

abstract class _SupportConversationEntity implements SupportConversationEntity {
  const factory _SupportConversationEntity({
    required final String id,
    required final String subject,
    final List<SupportMessageEntity> messages,
    final bool isRead,
  }) = _$SupportConversationEntityImpl;

  @override
  String get id;
  @override
  String get subject;
  @override
  List<SupportMessageEntity> get messages;
  @override
  bool get isRead;

  /// Create a copy of SupportConversationEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SupportConversationEntityImplCopyWith<_$SupportConversationEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}
