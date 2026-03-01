// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'support_conversations_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SupportConversationsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadConversations,
    required TResult Function() createConversation,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadConversations,
    TResult? Function()? createConversation,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadConversations,
    TResult Function()? createConversation,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadConversations value) loadConversations,
    required TResult Function(_CreateConversation value) createConversation,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadConversations value)? loadConversations,
    TResult? Function(_CreateConversation value)? createConversation,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadConversations value)? loadConversations,
    TResult Function(_CreateConversation value)? createConversation,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SupportConversationsEventCopyWith<$Res> {
  factory $SupportConversationsEventCopyWith(
    SupportConversationsEvent value,
    $Res Function(SupportConversationsEvent) then,
  ) = _$SupportConversationsEventCopyWithImpl<$Res, SupportConversationsEvent>;
}

/// @nodoc
class _$SupportConversationsEventCopyWithImpl<
  $Res,
  $Val extends SupportConversationsEvent
>
    implements $SupportConversationsEventCopyWith<$Res> {
  _$SupportConversationsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SupportConversationsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadConversationsImplCopyWith<$Res> {
  factory _$$LoadConversationsImplCopyWith(
    _$LoadConversationsImpl value,
    $Res Function(_$LoadConversationsImpl) then,
  ) = __$$LoadConversationsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadConversationsImplCopyWithImpl<$Res>
    extends
        _$SupportConversationsEventCopyWithImpl<$Res, _$LoadConversationsImpl>
    implements _$$LoadConversationsImplCopyWith<$Res> {
  __$$LoadConversationsImplCopyWithImpl(
    _$LoadConversationsImpl _value,
    $Res Function(_$LoadConversationsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SupportConversationsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadConversationsImpl implements _LoadConversations {
  const _$LoadConversationsImpl();

  @override
  String toString() {
    return 'SupportConversationsEvent.loadConversations()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadConversationsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadConversations,
    required TResult Function() createConversation,
  }) {
    return loadConversations();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadConversations,
    TResult? Function()? createConversation,
  }) {
    return loadConversations?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadConversations,
    TResult Function()? createConversation,
    required TResult orElse(),
  }) {
    if (loadConversations != null) {
      return loadConversations();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadConversations value) loadConversations,
    required TResult Function(_CreateConversation value) createConversation,
  }) {
    return loadConversations(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadConversations value)? loadConversations,
    TResult? Function(_CreateConversation value)? createConversation,
  }) {
    return loadConversations?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadConversations value)? loadConversations,
    TResult Function(_CreateConversation value)? createConversation,
    required TResult orElse(),
  }) {
    if (loadConversations != null) {
      return loadConversations(this);
    }
    return orElse();
  }
}

abstract class _LoadConversations implements SupportConversationsEvent {
  const factory _LoadConversations() = _$LoadConversationsImpl;
}

/// @nodoc
abstract class _$$CreateConversationImplCopyWith<$Res> {
  factory _$$CreateConversationImplCopyWith(
    _$CreateConversationImpl value,
    $Res Function(_$CreateConversationImpl) then,
  ) = __$$CreateConversationImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CreateConversationImplCopyWithImpl<$Res>
    extends
        _$SupportConversationsEventCopyWithImpl<$Res, _$CreateConversationImpl>
    implements _$$CreateConversationImplCopyWith<$Res> {
  __$$CreateConversationImplCopyWithImpl(
    _$CreateConversationImpl _value,
    $Res Function(_$CreateConversationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SupportConversationsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CreateConversationImpl implements _CreateConversation {
  const _$CreateConversationImpl();

  @override
  String toString() {
    return 'SupportConversationsEvent.createConversation()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CreateConversationImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadConversations,
    required TResult Function() createConversation,
  }) {
    return createConversation();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadConversations,
    TResult? Function()? createConversation,
  }) {
    return createConversation?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadConversations,
    TResult Function()? createConversation,
    required TResult orElse(),
  }) {
    if (createConversation != null) {
      return createConversation();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadConversations value) loadConversations,
    required TResult Function(_CreateConversation value) createConversation,
  }) {
    return createConversation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadConversations value)? loadConversations,
    TResult? Function(_CreateConversation value)? createConversation,
  }) {
    return createConversation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadConversations value)? loadConversations,
    TResult Function(_CreateConversation value)? createConversation,
    required TResult orElse(),
  }) {
    if (createConversation != null) {
      return createConversation(this);
    }
    return orElse();
  }
}

abstract class _CreateConversation implements SupportConversationsEvent {
  const factory _CreateConversation() = _$CreateConversationImpl;
}

/// @nodoc
mixin _$SupportConversationsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<SupportConversationEntity> conversations)
    loaded,
    required TResult Function(
      SupportConversationEntity newConversation,
      List<SupportConversationEntity> conversations,
    )
    created,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<SupportConversationEntity> conversations)? loaded,
    TResult? Function(
      SupportConversationEntity newConversation,
      List<SupportConversationEntity> conversations,
    )?
    created,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<SupportConversationEntity> conversations)? loaded,
    TResult Function(
      SupportConversationEntity newConversation,
      List<SupportConversationEntity> conversations,
    )?
    created,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Created value) created,
    required TResult Function(_Error value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Created value)? created,
    TResult? Function(_Error value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Created value)? created,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SupportConversationsStateCopyWith<$Res> {
  factory $SupportConversationsStateCopyWith(
    SupportConversationsState value,
    $Res Function(SupportConversationsState) then,
  ) = _$SupportConversationsStateCopyWithImpl<$Res, SupportConversationsState>;
}

/// @nodoc
class _$SupportConversationsStateCopyWithImpl<
  $Res,
  $Val extends SupportConversationsState
>
    implements $SupportConversationsStateCopyWith<$Res> {
  _$SupportConversationsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SupportConversationsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
    _$InitialImpl value,
    $Res Function(_$InitialImpl) then,
  ) = __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$SupportConversationsStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SupportConversationsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'SupportConversationsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<SupportConversationEntity> conversations)
    loaded,
    required TResult Function(
      SupportConversationEntity newConversation,
      List<SupportConversationEntity> conversations,
    )
    created,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<SupportConversationEntity> conversations)? loaded,
    TResult? Function(
      SupportConversationEntity newConversation,
      List<SupportConversationEntity> conversations,
    )?
    created,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<SupportConversationEntity> conversations)? loaded,
    TResult Function(
      SupportConversationEntity newConversation,
      List<SupportConversationEntity> conversations,
    )?
    created,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Created value) created,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Created value)? created,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Created value)? created,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements SupportConversationsState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
    _$LoadingImpl value,
    $Res Function(_$LoadingImpl) then,
  ) = __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$SupportConversationsStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SupportConversationsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'SupportConversationsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<SupportConversationEntity> conversations)
    loaded,
    required TResult Function(
      SupportConversationEntity newConversation,
      List<SupportConversationEntity> conversations,
    )
    created,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<SupportConversationEntity> conversations)? loaded,
    TResult? Function(
      SupportConversationEntity newConversation,
      List<SupportConversationEntity> conversations,
    )?
    created,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<SupportConversationEntity> conversations)? loaded,
    TResult Function(
      SupportConversationEntity newConversation,
      List<SupportConversationEntity> conversations,
    )?
    created,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Created value) created,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Created value)? created,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Created value)? created,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements SupportConversationsState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
    _$LoadedImpl value,
    $Res Function(_$LoadedImpl) then,
  ) = __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<SupportConversationEntity> conversations});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$SupportConversationsStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
    _$LoadedImpl _value,
    $Res Function(_$LoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SupportConversationsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? conversations = null}) {
    return _then(
      _$LoadedImpl(
        null == conversations
            ? _value._conversations
            : conversations // ignore: cast_nullable_to_non_nullable
                  as List<SupportConversationEntity>,
      ),
    );
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(final List<SupportConversationEntity> conversations)
    : _conversations = conversations;

  final List<SupportConversationEntity> _conversations;
  @override
  List<SupportConversationEntity> get conversations {
    if (_conversations is EqualUnmodifiableListView) return _conversations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conversations);
  }

  @override
  String toString() {
    return 'SupportConversationsState.loaded(conversations: $conversations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(
              other._conversations,
              _conversations,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_conversations),
  );

  /// Create a copy of SupportConversationsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<SupportConversationEntity> conversations)
    loaded,
    required TResult Function(
      SupportConversationEntity newConversation,
      List<SupportConversationEntity> conversations,
    )
    created,
    required TResult Function(String message) error,
  }) {
    return loaded(conversations);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<SupportConversationEntity> conversations)? loaded,
    TResult? Function(
      SupportConversationEntity newConversation,
      List<SupportConversationEntity> conversations,
    )?
    created,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(conversations);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<SupportConversationEntity> conversations)? loaded,
    TResult Function(
      SupportConversationEntity newConversation,
      List<SupportConversationEntity> conversations,
    )?
    created,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(conversations);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Created value) created,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Created value)? created,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Created value)? created,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements SupportConversationsState {
  const factory _Loaded(final List<SupportConversationEntity> conversations) =
      _$LoadedImpl;

  List<SupportConversationEntity> get conversations;

  /// Create a copy of SupportConversationsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreatedImplCopyWith<$Res> {
  factory _$$CreatedImplCopyWith(
    _$CreatedImpl value,
    $Res Function(_$CreatedImpl) then,
  ) = __$$CreatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    SupportConversationEntity newConversation,
    List<SupportConversationEntity> conversations,
  });

  $SupportConversationEntityCopyWith<$Res> get newConversation;
}

/// @nodoc
class __$$CreatedImplCopyWithImpl<$Res>
    extends _$SupportConversationsStateCopyWithImpl<$Res, _$CreatedImpl>
    implements _$$CreatedImplCopyWith<$Res> {
  __$$CreatedImplCopyWithImpl(
    _$CreatedImpl _value,
    $Res Function(_$CreatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SupportConversationsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? newConversation = null, Object? conversations = null}) {
    return _then(
      _$CreatedImpl(
        null == newConversation
            ? _value.newConversation
            : newConversation // ignore: cast_nullable_to_non_nullable
                  as SupportConversationEntity,
        null == conversations
            ? _value._conversations
            : conversations // ignore: cast_nullable_to_non_nullable
                  as List<SupportConversationEntity>,
      ),
    );
  }

  /// Create a copy of SupportConversationsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SupportConversationEntityCopyWith<$Res> get newConversation {
    return $SupportConversationEntityCopyWith<$Res>(_value.newConversation, (
      value,
    ) {
      return _then(_value.copyWith(newConversation: value));
    });
  }
}

/// @nodoc

class _$CreatedImpl implements _Created {
  const _$CreatedImpl(
    this.newConversation,
    final List<SupportConversationEntity> conversations,
  ) : _conversations = conversations;

  @override
  final SupportConversationEntity newConversation;
  final List<SupportConversationEntity> _conversations;
  @override
  List<SupportConversationEntity> get conversations {
    if (_conversations is EqualUnmodifiableListView) return _conversations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conversations);
  }

  @override
  String toString() {
    return 'SupportConversationsState.created(newConversation: $newConversation, conversations: $conversations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatedImpl &&
            (identical(other.newConversation, newConversation) ||
                other.newConversation == newConversation) &&
            const DeepCollectionEquality().equals(
              other._conversations,
              _conversations,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    newConversation,
    const DeepCollectionEquality().hash(_conversations),
  );

  /// Create a copy of SupportConversationsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatedImplCopyWith<_$CreatedImpl> get copyWith =>
      __$$CreatedImplCopyWithImpl<_$CreatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<SupportConversationEntity> conversations)
    loaded,
    required TResult Function(
      SupportConversationEntity newConversation,
      List<SupportConversationEntity> conversations,
    )
    created,
    required TResult Function(String message) error,
  }) {
    return created(newConversation, conversations);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<SupportConversationEntity> conversations)? loaded,
    TResult? Function(
      SupportConversationEntity newConversation,
      List<SupportConversationEntity> conversations,
    )?
    created,
    TResult? Function(String message)? error,
  }) {
    return created?.call(newConversation, conversations);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<SupportConversationEntity> conversations)? loaded,
    TResult Function(
      SupportConversationEntity newConversation,
      List<SupportConversationEntity> conversations,
    )?
    created,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (created != null) {
      return created(newConversation, conversations);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Created value) created,
    required TResult Function(_Error value) error,
  }) {
    return created(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Created value)? created,
    TResult? Function(_Error value)? error,
  }) {
    return created?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Created value)? created,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (created != null) {
      return created(this);
    }
    return orElse();
  }
}

abstract class _Created implements SupportConversationsState {
  const factory _Created(
    final SupportConversationEntity newConversation,
    final List<SupportConversationEntity> conversations,
  ) = _$CreatedImpl;

  SupportConversationEntity get newConversation;
  List<SupportConversationEntity> get conversations;

  /// Create a copy of SupportConversationsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreatedImplCopyWith<_$CreatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
    _$ErrorImpl value,
    $Res Function(_$ErrorImpl) then,
  ) = __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$SupportConversationsStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SupportConversationsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'SupportConversationsState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of SupportConversationsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<SupportConversationEntity> conversations)
    loaded,
    required TResult Function(
      SupportConversationEntity newConversation,
      List<SupportConversationEntity> conversations,
    )
    created,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<SupportConversationEntity> conversations)? loaded,
    TResult? Function(
      SupportConversationEntity newConversation,
      List<SupportConversationEntity> conversations,
    )?
    created,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<SupportConversationEntity> conversations)? loaded,
    TResult Function(
      SupportConversationEntity newConversation,
      List<SupportConversationEntity> conversations,
    )?
    created,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Created value) created,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Created value)? created,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Created value)? created,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements SupportConversationsState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of SupportConversationsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
