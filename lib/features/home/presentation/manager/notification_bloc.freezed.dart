// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$NotificationEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() refresh,
    required TResult Function() loadMore,
    required TResult Function(String id) markAsRead,
    required TResult Function(String id) markAsUnread,
    required TResult Function() markAllAsRead,
    required TResult Function(NotificationEntity notification) pushReceived,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function()? refresh,
    TResult? Function()? loadMore,
    TResult? Function(String id)? markAsRead,
    TResult? Function(String id)? markAsUnread,
    TResult? Function()? markAllAsRead,
    TResult? Function(NotificationEntity notification)? pushReceived,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? refresh,
    TResult Function()? loadMore,
    TResult Function(String id)? markAsRead,
    TResult Function(String id)? markAsUnread,
    TResult Function()? markAllAsRead,
    TResult Function(NotificationEntity notification)? pushReceived,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_Refresh value) refresh,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_MarkAsUnread value) markAsUnread,
    required TResult Function(_MarkAllAsRead value) markAllAsRead,
    required TResult Function(_PushReceived value) pushReceived,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_Refresh value)? refresh,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_MarkAsUnread value)? markAsUnread,
    TResult? Function(_MarkAllAsRead value)? markAllAsRead,
    TResult? Function(_PushReceived value)? pushReceived,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_Refresh value)? refresh,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_MarkAsUnread value)? markAsUnread,
    TResult Function(_MarkAllAsRead value)? markAllAsRead,
    TResult Function(_PushReceived value)? pushReceived,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationEventCopyWith<$Res> {
  factory $NotificationEventCopyWith(
    NotificationEvent value,
    $Res Function(NotificationEvent) then,
  ) = _$NotificationEventCopyWithImpl<$Res, NotificationEvent>;
}

/// @nodoc
class _$NotificationEventCopyWithImpl<$Res, $Val extends NotificationEvent>
    implements $NotificationEventCopyWith<$Res> {
  _$NotificationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadImplCopyWith<$Res> {
  factory _$$LoadImplCopyWith(
    _$LoadImpl value,
    $Res Function(_$LoadImpl) then,
  ) = __$$LoadImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadImplCopyWithImpl<$Res>
    extends _$NotificationEventCopyWithImpl<$Res, _$LoadImpl>
    implements _$$LoadImplCopyWith<$Res> {
  __$$LoadImplCopyWithImpl(_$LoadImpl _value, $Res Function(_$LoadImpl) _then)
    : super(_value, _then);

  /// Create a copy of NotificationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadImpl implements _Load {
  const _$LoadImpl();

  @override
  String toString() {
    return 'NotificationEvent.load()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() refresh,
    required TResult Function() loadMore,
    required TResult Function(String id) markAsRead,
    required TResult Function(String id) markAsUnread,
    required TResult Function() markAllAsRead,
    required TResult Function(NotificationEntity notification) pushReceived,
  }) {
    return load();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function()? refresh,
    TResult? Function()? loadMore,
    TResult? Function(String id)? markAsRead,
    TResult? Function(String id)? markAsUnread,
    TResult? Function()? markAllAsRead,
    TResult? Function(NotificationEntity notification)? pushReceived,
  }) {
    return load?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? refresh,
    TResult Function()? loadMore,
    TResult Function(String id)? markAsRead,
    TResult Function(String id)? markAsUnread,
    TResult Function()? markAllAsRead,
    TResult Function(NotificationEntity notification)? pushReceived,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_Refresh value) refresh,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_MarkAsUnread value) markAsUnread,
    required TResult Function(_MarkAllAsRead value) markAllAsRead,
    required TResult Function(_PushReceived value) pushReceived,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_Refresh value)? refresh,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_MarkAsUnread value)? markAsUnread,
    TResult? Function(_MarkAllAsRead value)? markAllAsRead,
    TResult? Function(_PushReceived value)? pushReceived,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_Refresh value)? refresh,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_MarkAsUnread value)? markAsUnread,
    TResult Function(_MarkAllAsRead value)? markAllAsRead,
    TResult Function(_PushReceived value)? pushReceived,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class _Load implements NotificationEvent {
  const factory _Load() = _$LoadImpl;
}

/// @nodoc
abstract class _$$RefreshImplCopyWith<$Res> {
  factory _$$RefreshImplCopyWith(
    _$RefreshImpl value,
    $Res Function(_$RefreshImpl) then,
  ) = __$$RefreshImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RefreshImplCopyWithImpl<$Res>
    extends _$NotificationEventCopyWithImpl<$Res, _$RefreshImpl>
    implements _$$RefreshImplCopyWith<$Res> {
  __$$RefreshImplCopyWithImpl(
    _$RefreshImpl _value,
    $Res Function(_$RefreshImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RefreshImpl implements _Refresh {
  const _$RefreshImpl();

  @override
  String toString() {
    return 'NotificationEvent.refresh()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RefreshImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() refresh,
    required TResult Function() loadMore,
    required TResult Function(String id) markAsRead,
    required TResult Function(String id) markAsUnread,
    required TResult Function() markAllAsRead,
    required TResult Function(NotificationEntity notification) pushReceived,
  }) {
    return refresh();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function()? refresh,
    TResult? Function()? loadMore,
    TResult? Function(String id)? markAsRead,
    TResult? Function(String id)? markAsUnread,
    TResult? Function()? markAllAsRead,
    TResult? Function(NotificationEntity notification)? pushReceived,
  }) {
    return refresh?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? refresh,
    TResult Function()? loadMore,
    TResult Function(String id)? markAsRead,
    TResult Function(String id)? markAsUnread,
    TResult Function()? markAllAsRead,
    TResult Function(NotificationEntity notification)? pushReceived,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_Refresh value) refresh,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_MarkAsUnread value) markAsUnread,
    required TResult Function(_MarkAllAsRead value) markAllAsRead,
    required TResult Function(_PushReceived value) pushReceived,
  }) {
    return refresh(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_Refresh value)? refresh,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_MarkAsUnread value)? markAsUnread,
    TResult? Function(_MarkAllAsRead value)? markAllAsRead,
    TResult? Function(_PushReceived value)? pushReceived,
  }) {
    return refresh?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_Refresh value)? refresh,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_MarkAsUnread value)? markAsUnread,
    TResult Function(_MarkAllAsRead value)? markAllAsRead,
    TResult Function(_PushReceived value)? pushReceived,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh(this);
    }
    return orElse();
  }
}

abstract class _Refresh implements NotificationEvent {
  const factory _Refresh() = _$RefreshImpl;
}

/// @nodoc
abstract class _$$LoadMoreImplCopyWith<$Res> {
  factory _$$LoadMoreImplCopyWith(
    _$LoadMoreImpl value,
    $Res Function(_$LoadMoreImpl) then,
  ) = __$$LoadMoreImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadMoreImplCopyWithImpl<$Res>
    extends _$NotificationEventCopyWithImpl<$Res, _$LoadMoreImpl>
    implements _$$LoadMoreImplCopyWith<$Res> {
  __$$LoadMoreImplCopyWithImpl(
    _$LoadMoreImpl _value,
    $Res Function(_$LoadMoreImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadMoreImpl implements _LoadMore {
  const _$LoadMoreImpl();

  @override
  String toString() {
    return 'NotificationEvent.loadMore()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadMoreImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() refresh,
    required TResult Function() loadMore,
    required TResult Function(String id) markAsRead,
    required TResult Function(String id) markAsUnread,
    required TResult Function() markAllAsRead,
    required TResult Function(NotificationEntity notification) pushReceived,
  }) {
    return loadMore();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function()? refresh,
    TResult? Function()? loadMore,
    TResult? Function(String id)? markAsRead,
    TResult? Function(String id)? markAsUnread,
    TResult? Function()? markAllAsRead,
    TResult? Function(NotificationEntity notification)? pushReceived,
  }) {
    return loadMore?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? refresh,
    TResult Function()? loadMore,
    TResult Function(String id)? markAsRead,
    TResult Function(String id)? markAsUnread,
    TResult Function()? markAllAsRead,
    TResult Function(NotificationEntity notification)? pushReceived,
    required TResult orElse(),
  }) {
    if (loadMore != null) {
      return loadMore();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_Refresh value) refresh,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_MarkAsUnread value) markAsUnread,
    required TResult Function(_MarkAllAsRead value) markAllAsRead,
    required TResult Function(_PushReceived value) pushReceived,
  }) {
    return loadMore(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_Refresh value)? refresh,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_MarkAsUnread value)? markAsUnread,
    TResult? Function(_MarkAllAsRead value)? markAllAsRead,
    TResult? Function(_PushReceived value)? pushReceived,
  }) {
    return loadMore?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_Refresh value)? refresh,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_MarkAsUnread value)? markAsUnread,
    TResult Function(_MarkAllAsRead value)? markAllAsRead,
    TResult Function(_PushReceived value)? pushReceived,
    required TResult orElse(),
  }) {
    if (loadMore != null) {
      return loadMore(this);
    }
    return orElse();
  }
}

abstract class _LoadMore implements NotificationEvent {
  const factory _LoadMore() = _$LoadMoreImpl;
}

/// @nodoc
abstract class _$$MarkAsReadImplCopyWith<$Res> {
  factory _$$MarkAsReadImplCopyWith(
    _$MarkAsReadImpl value,
    $Res Function(_$MarkAsReadImpl) then,
  ) = __$$MarkAsReadImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$MarkAsReadImplCopyWithImpl<$Res>
    extends _$NotificationEventCopyWithImpl<$Res, _$MarkAsReadImpl>
    implements _$$MarkAsReadImplCopyWith<$Res> {
  __$$MarkAsReadImplCopyWithImpl(
    _$MarkAsReadImpl _value,
    $Res Function(_$MarkAsReadImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null}) {
    return _then(
      _$MarkAsReadImpl(
        null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$MarkAsReadImpl implements _MarkAsRead {
  const _$MarkAsReadImpl(this.id);

  @override
  final String id;

  @override
  String toString() {
    return 'NotificationEvent.markAsRead(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarkAsReadImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of NotificationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarkAsReadImplCopyWith<_$MarkAsReadImpl> get copyWith =>
      __$$MarkAsReadImplCopyWithImpl<_$MarkAsReadImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() refresh,
    required TResult Function() loadMore,
    required TResult Function(String id) markAsRead,
    required TResult Function(String id) markAsUnread,
    required TResult Function() markAllAsRead,
    required TResult Function(NotificationEntity notification) pushReceived,
  }) {
    return markAsRead(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function()? refresh,
    TResult? Function()? loadMore,
    TResult? Function(String id)? markAsRead,
    TResult? Function(String id)? markAsUnread,
    TResult? Function()? markAllAsRead,
    TResult? Function(NotificationEntity notification)? pushReceived,
  }) {
    return markAsRead?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? refresh,
    TResult Function()? loadMore,
    TResult Function(String id)? markAsRead,
    TResult Function(String id)? markAsUnread,
    TResult Function()? markAllAsRead,
    TResult Function(NotificationEntity notification)? pushReceived,
    required TResult orElse(),
  }) {
    if (markAsRead != null) {
      return markAsRead(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_Refresh value) refresh,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_MarkAsUnread value) markAsUnread,
    required TResult Function(_MarkAllAsRead value) markAllAsRead,
    required TResult Function(_PushReceived value) pushReceived,
  }) {
    return markAsRead(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_Refresh value)? refresh,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_MarkAsUnread value)? markAsUnread,
    TResult? Function(_MarkAllAsRead value)? markAllAsRead,
    TResult? Function(_PushReceived value)? pushReceived,
  }) {
    return markAsRead?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_Refresh value)? refresh,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_MarkAsUnread value)? markAsUnread,
    TResult Function(_MarkAllAsRead value)? markAllAsRead,
    TResult Function(_PushReceived value)? pushReceived,
    required TResult orElse(),
  }) {
    if (markAsRead != null) {
      return markAsRead(this);
    }
    return orElse();
  }
}

abstract class _MarkAsRead implements NotificationEvent {
  const factory _MarkAsRead(final String id) = _$MarkAsReadImpl;

  String get id;

  /// Create a copy of NotificationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarkAsReadImplCopyWith<_$MarkAsReadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MarkAsUnreadImplCopyWith<$Res> {
  factory _$$MarkAsUnreadImplCopyWith(
    _$MarkAsUnreadImpl value,
    $Res Function(_$MarkAsUnreadImpl) then,
  ) = __$$MarkAsUnreadImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$MarkAsUnreadImplCopyWithImpl<$Res>
    extends _$NotificationEventCopyWithImpl<$Res, _$MarkAsUnreadImpl>
    implements _$$MarkAsUnreadImplCopyWith<$Res> {
  __$$MarkAsUnreadImplCopyWithImpl(
    _$MarkAsUnreadImpl _value,
    $Res Function(_$MarkAsUnreadImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null}) {
    return _then(
      _$MarkAsUnreadImpl(
        null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$MarkAsUnreadImpl implements _MarkAsUnread {
  const _$MarkAsUnreadImpl(this.id);

  @override
  final String id;

  @override
  String toString() {
    return 'NotificationEvent.markAsUnread(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarkAsUnreadImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of NotificationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarkAsUnreadImplCopyWith<_$MarkAsUnreadImpl> get copyWith =>
      __$$MarkAsUnreadImplCopyWithImpl<_$MarkAsUnreadImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() refresh,
    required TResult Function() loadMore,
    required TResult Function(String id) markAsRead,
    required TResult Function(String id) markAsUnread,
    required TResult Function() markAllAsRead,
    required TResult Function(NotificationEntity notification) pushReceived,
  }) {
    return markAsUnread(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function()? refresh,
    TResult? Function()? loadMore,
    TResult? Function(String id)? markAsRead,
    TResult? Function(String id)? markAsUnread,
    TResult? Function()? markAllAsRead,
    TResult? Function(NotificationEntity notification)? pushReceived,
  }) {
    return markAsUnread?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? refresh,
    TResult Function()? loadMore,
    TResult Function(String id)? markAsRead,
    TResult Function(String id)? markAsUnread,
    TResult Function()? markAllAsRead,
    TResult Function(NotificationEntity notification)? pushReceived,
    required TResult orElse(),
  }) {
    if (markAsUnread != null) {
      return markAsUnread(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_Refresh value) refresh,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_MarkAsUnread value) markAsUnread,
    required TResult Function(_MarkAllAsRead value) markAllAsRead,
    required TResult Function(_PushReceived value) pushReceived,
  }) {
    return markAsUnread(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_Refresh value)? refresh,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_MarkAsUnread value)? markAsUnread,
    TResult? Function(_MarkAllAsRead value)? markAllAsRead,
    TResult? Function(_PushReceived value)? pushReceived,
  }) {
    return markAsUnread?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_Refresh value)? refresh,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_MarkAsUnread value)? markAsUnread,
    TResult Function(_MarkAllAsRead value)? markAllAsRead,
    TResult Function(_PushReceived value)? pushReceived,
    required TResult orElse(),
  }) {
    if (markAsUnread != null) {
      return markAsUnread(this);
    }
    return orElse();
  }
}

abstract class _MarkAsUnread implements NotificationEvent {
  const factory _MarkAsUnread(final String id) = _$MarkAsUnreadImpl;

  String get id;

  /// Create a copy of NotificationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarkAsUnreadImplCopyWith<_$MarkAsUnreadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MarkAllAsReadImplCopyWith<$Res> {
  factory _$$MarkAllAsReadImplCopyWith(
    _$MarkAllAsReadImpl value,
    $Res Function(_$MarkAllAsReadImpl) then,
  ) = __$$MarkAllAsReadImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MarkAllAsReadImplCopyWithImpl<$Res>
    extends _$NotificationEventCopyWithImpl<$Res, _$MarkAllAsReadImpl>
    implements _$$MarkAllAsReadImplCopyWith<$Res> {
  __$$MarkAllAsReadImplCopyWithImpl(
    _$MarkAllAsReadImpl _value,
    $Res Function(_$MarkAllAsReadImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$MarkAllAsReadImpl implements _MarkAllAsRead {
  const _$MarkAllAsReadImpl();

  @override
  String toString() {
    return 'NotificationEvent.markAllAsRead()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MarkAllAsReadImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() refresh,
    required TResult Function() loadMore,
    required TResult Function(String id) markAsRead,
    required TResult Function(String id) markAsUnread,
    required TResult Function() markAllAsRead,
    required TResult Function(NotificationEntity notification) pushReceived,
  }) {
    return markAllAsRead();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function()? refresh,
    TResult? Function()? loadMore,
    TResult? Function(String id)? markAsRead,
    TResult? Function(String id)? markAsUnread,
    TResult? Function()? markAllAsRead,
    TResult? Function(NotificationEntity notification)? pushReceived,
  }) {
    return markAllAsRead?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? refresh,
    TResult Function()? loadMore,
    TResult Function(String id)? markAsRead,
    TResult Function(String id)? markAsUnread,
    TResult Function()? markAllAsRead,
    TResult Function(NotificationEntity notification)? pushReceived,
    required TResult orElse(),
  }) {
    if (markAllAsRead != null) {
      return markAllAsRead();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_Refresh value) refresh,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_MarkAsUnread value) markAsUnread,
    required TResult Function(_MarkAllAsRead value) markAllAsRead,
    required TResult Function(_PushReceived value) pushReceived,
  }) {
    return markAllAsRead(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_Refresh value)? refresh,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_MarkAsUnread value)? markAsUnread,
    TResult? Function(_MarkAllAsRead value)? markAllAsRead,
    TResult? Function(_PushReceived value)? pushReceived,
  }) {
    return markAllAsRead?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_Refresh value)? refresh,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_MarkAsUnread value)? markAsUnread,
    TResult Function(_MarkAllAsRead value)? markAllAsRead,
    TResult Function(_PushReceived value)? pushReceived,
    required TResult orElse(),
  }) {
    if (markAllAsRead != null) {
      return markAllAsRead(this);
    }
    return orElse();
  }
}

abstract class _MarkAllAsRead implements NotificationEvent {
  const factory _MarkAllAsRead() = _$MarkAllAsReadImpl;
}

/// @nodoc
abstract class _$$PushReceivedImplCopyWith<$Res> {
  factory _$$PushReceivedImplCopyWith(
    _$PushReceivedImpl value,
    $Res Function(_$PushReceivedImpl) then,
  ) = __$$PushReceivedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({NotificationEntity notification});

  $NotificationEntityCopyWith<$Res> get notification;
}

/// @nodoc
class __$$PushReceivedImplCopyWithImpl<$Res>
    extends _$NotificationEventCopyWithImpl<$Res, _$PushReceivedImpl>
    implements _$$PushReceivedImplCopyWith<$Res> {
  __$$PushReceivedImplCopyWithImpl(
    _$PushReceivedImpl _value,
    $Res Function(_$PushReceivedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? notification = null}) {
    return _then(
      _$PushReceivedImpl(
        null == notification
            ? _value.notification
            : notification // ignore: cast_nullable_to_non_nullable
                  as NotificationEntity,
      ),
    );
  }

  /// Create a copy of NotificationEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NotificationEntityCopyWith<$Res> get notification {
    return $NotificationEntityCopyWith<$Res>(_value.notification, (value) {
      return _then(_value.copyWith(notification: value));
    });
  }
}

/// @nodoc

class _$PushReceivedImpl implements _PushReceived {
  const _$PushReceivedImpl(this.notification);

  @override
  final NotificationEntity notification;

  @override
  String toString() {
    return 'NotificationEvent.pushReceived(notification: $notification)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PushReceivedImpl &&
            (identical(other.notification, notification) ||
                other.notification == notification));
  }

  @override
  int get hashCode => Object.hash(runtimeType, notification);

  /// Create a copy of NotificationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PushReceivedImplCopyWith<_$PushReceivedImpl> get copyWith =>
      __$$PushReceivedImplCopyWithImpl<_$PushReceivedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() refresh,
    required TResult Function() loadMore,
    required TResult Function(String id) markAsRead,
    required TResult Function(String id) markAsUnread,
    required TResult Function() markAllAsRead,
    required TResult Function(NotificationEntity notification) pushReceived,
  }) {
    return pushReceived(notification);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function()? refresh,
    TResult? Function()? loadMore,
    TResult? Function(String id)? markAsRead,
    TResult? Function(String id)? markAsUnread,
    TResult? Function()? markAllAsRead,
    TResult? Function(NotificationEntity notification)? pushReceived,
  }) {
    return pushReceived?.call(notification);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? refresh,
    TResult Function()? loadMore,
    TResult Function(String id)? markAsRead,
    TResult Function(String id)? markAsUnread,
    TResult Function()? markAllAsRead,
    TResult Function(NotificationEntity notification)? pushReceived,
    required TResult orElse(),
  }) {
    if (pushReceived != null) {
      return pushReceived(notification);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_Refresh value) refresh,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_MarkAsUnread value) markAsUnread,
    required TResult Function(_MarkAllAsRead value) markAllAsRead,
    required TResult Function(_PushReceived value) pushReceived,
  }) {
    return pushReceived(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_Refresh value)? refresh,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_MarkAsUnread value)? markAsUnread,
    TResult? Function(_MarkAllAsRead value)? markAllAsRead,
    TResult? Function(_PushReceived value)? pushReceived,
  }) {
    return pushReceived?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_Refresh value)? refresh,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_MarkAsUnread value)? markAsUnread,
    TResult Function(_MarkAllAsRead value)? markAllAsRead,
    TResult Function(_PushReceived value)? pushReceived,
    required TResult orElse(),
  }) {
    if (pushReceived != null) {
      return pushReceived(this);
    }
    return orElse();
  }
}

abstract class _PushReceived implements NotificationEvent {
  const factory _PushReceived(final NotificationEntity notification) =
      _$PushReceivedImpl;

  NotificationEntity get notification;

  /// Create a copy of NotificationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PushReceivedImplCopyWith<_$PushReceivedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$NotificationState {
  NotificationStatus get status => throw _privateConstructorUsedError;
  List<NotificationEntity> get notifications =>
      throw _privateConstructorUsedError;

  /// Pass as `before` for the next page. `null` means there are no more —
  /// this is a cursor, never a page number: new notifications arrive at the
  /// top constantly, so an offset-based page 2 would repeat or skip rows.
  String? get nextCursor => throw _privateConstructorUsedError;
  int get unreadCount => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of NotificationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationStateCopyWith<NotificationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationStateCopyWith<$Res> {
  factory $NotificationStateCopyWith(
    NotificationState value,
    $Res Function(NotificationState) then,
  ) = _$NotificationStateCopyWithImpl<$Res, NotificationState>;
  @useResult
  $Res call({
    NotificationStatus status,
    List<NotificationEntity> notifications,
    String? nextCursor,
    int unreadCount,
    bool isLoadingMore,
    String? errorMessage,
  });
}

/// @nodoc
class _$NotificationStateCopyWithImpl<$Res, $Val extends NotificationState>
    implements $NotificationStateCopyWith<$Res> {
  _$NotificationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? notifications = null,
    Object? nextCursor = freezed,
    Object? unreadCount = null,
    Object? isLoadingMore = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as NotificationStatus,
            notifications: null == notifications
                ? _value.notifications
                : notifications // ignore: cast_nullable_to_non_nullable
                      as List<NotificationEntity>,
            nextCursor: freezed == nextCursor
                ? _value.nextCursor
                : nextCursor // ignore: cast_nullable_to_non_nullable
                      as String?,
            unreadCount: null == unreadCount
                ? _value.unreadCount
                : unreadCount // ignore: cast_nullable_to_non_nullable
                      as int,
            isLoadingMore: null == isLoadingMore
                ? _value.isLoadingMore
                : isLoadingMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NotificationStateImplCopyWith<$Res>
    implements $NotificationStateCopyWith<$Res> {
  factory _$$NotificationStateImplCopyWith(
    _$NotificationStateImpl value,
    $Res Function(_$NotificationStateImpl) then,
  ) = __$$NotificationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    NotificationStatus status,
    List<NotificationEntity> notifications,
    String? nextCursor,
    int unreadCount,
    bool isLoadingMore,
    String? errorMessage,
  });
}

/// @nodoc
class __$$NotificationStateImplCopyWithImpl<$Res>
    extends _$NotificationStateCopyWithImpl<$Res, _$NotificationStateImpl>
    implements _$$NotificationStateImplCopyWith<$Res> {
  __$$NotificationStateImplCopyWithImpl(
    _$NotificationStateImpl _value,
    $Res Function(_$NotificationStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? notifications = null,
    Object? nextCursor = freezed,
    Object? unreadCount = null,
    Object? isLoadingMore = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$NotificationStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as NotificationStatus,
        notifications: null == notifications
            ? _value._notifications
            : notifications // ignore: cast_nullable_to_non_nullable
                  as List<NotificationEntity>,
        nextCursor: freezed == nextCursor
            ? _value.nextCursor
            : nextCursor // ignore: cast_nullable_to_non_nullable
                  as String?,
        unreadCount: null == unreadCount
            ? _value.unreadCount
            : unreadCount // ignore: cast_nullable_to_non_nullable
                  as int,
        isLoadingMore: null == isLoadingMore
            ? _value.isLoadingMore
            : isLoadingMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$NotificationStateImpl extends _NotificationState {
  const _$NotificationStateImpl({
    this.status = NotificationStatus.initial,
    final List<NotificationEntity> notifications = const <NotificationEntity>[],
    this.nextCursor,
    this.unreadCount = 0,
    this.isLoadingMore = false,
    this.errorMessage,
  }) : _notifications = notifications,
       super._();

  @override
  @JsonKey()
  final NotificationStatus status;
  final List<NotificationEntity> _notifications;
  @override
  @JsonKey()
  List<NotificationEntity> get notifications {
    if (_notifications is EqualUnmodifiableListView) return _notifications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notifications);
  }

  /// Pass as `before` for the next page. `null` means there are no more —
  /// this is a cursor, never a page number: new notifications arrive at the
  /// top constantly, so an offset-based page 2 would repeat or skip rows.
  @override
  final String? nextCursor;
  @override
  @JsonKey()
  final int unreadCount;
  @override
  @JsonKey()
  final bool isLoadingMore;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'NotificationState(status: $status, notifications: $notifications, nextCursor: $nextCursor, unreadCount: $unreadCount, isLoadingMore: $isLoadingMore, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(
              other._notifications,
              _notifications,
            ) &&
            (identical(other.nextCursor, nextCursor) ||
                other.nextCursor == nextCursor) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    const DeepCollectionEquality().hash(_notifications),
    nextCursor,
    unreadCount,
    isLoadingMore,
    errorMessage,
  );

  /// Create a copy of NotificationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationStateImplCopyWith<_$NotificationStateImpl> get copyWith =>
      __$$NotificationStateImplCopyWithImpl<_$NotificationStateImpl>(
        this,
        _$identity,
      );
}

abstract class _NotificationState extends NotificationState {
  const factory _NotificationState({
    final NotificationStatus status,
    final List<NotificationEntity> notifications,
    final String? nextCursor,
    final int unreadCount,
    final bool isLoadingMore,
    final String? errorMessage,
  }) = _$NotificationStateImpl;
  const _NotificationState._() : super._();

  @override
  NotificationStatus get status;
  @override
  List<NotificationEntity> get notifications;

  /// Pass as `before` for the next page. `null` means there are no more —
  /// this is a cursor, never a page number: new notifications arrive at the
  /// top constantly, so an offset-based page 2 would repeat or skip rows.
  @override
  String? get nextCursor;
  @override
  int get unreadCount;
  @override
  bool get isLoadingMore;
  @override
  String? get errorMessage;

  /// Create a copy of NotificationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationStateImplCopyWith<_$NotificationStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
