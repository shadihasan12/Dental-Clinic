// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$NotificationEntity {
  String get id => throw _privateConstructorUsedError;

  /// Server-defined kind — drives the icon and colour. May be a value this
  /// build has never seen; render a neutral fallback rather than throwing.
  String get category => throw _privateConstructorUsedError;

  /// Already rendered in the caller's language. Show as-is.
  String get title => throw _privateConstructorUsedError;

  /// Already rendered in the caller's language. May legitimately be null —
  /// announcements are often title-only.
  String? get body => throw _privateConstructorUsedError;

  /// Deep-link payload. `data['type']` is always present and names the
  /// destination screen. See [NotificationRouting].
  Map<String, dynamic> get data => throw _privateConstructorUsedError;

  /// Whether a banner was ever raised for it. Windows-relevant only.
  bool get isSeen => throw _privateConstructorUsedError;

  /// Whether the user opened it. Drives the unread dot and the badge.
  bool get isRead => throw _privateConstructorUsedError;
  DateTime? get readAt => throw _privateConstructorUsedError;
  DateTime get sentAt => throw _privateConstructorUsedError;

  /// Create a copy of NotificationEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationEntityCopyWith<NotificationEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationEntityCopyWith<$Res> {
  factory $NotificationEntityCopyWith(
    NotificationEntity value,
    $Res Function(NotificationEntity) then,
  ) = _$NotificationEntityCopyWithImpl<$Res, NotificationEntity>;
  @useResult
  $Res call({
    String id,
    String category,
    String title,
    String? body,
    Map<String, dynamic> data,
    bool isSeen,
    bool isRead,
    DateTime? readAt,
    DateTime sentAt,
  });
}

/// @nodoc
class _$NotificationEntityCopyWithImpl<$Res, $Val extends NotificationEntity>
    implements $NotificationEntityCopyWith<$Res> {
  _$NotificationEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? category = null,
    Object? title = null,
    Object? body = freezed,
    Object? data = null,
    Object? isSeen = null,
    Object? isRead = null,
    Object? readAt = freezed,
    Object? sentAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            body: freezed == body
                ? _value.body
                : body // ignore: cast_nullable_to_non_nullable
                      as String?,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            isSeen: null == isSeen
                ? _value.isSeen
                : isSeen // ignore: cast_nullable_to_non_nullable
                      as bool,
            isRead: null == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                      as bool,
            readAt: freezed == readAt
                ? _value.readAt
                : readAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            sentAt: null == sentAt
                ? _value.sentAt
                : sentAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NotificationEntityImplCopyWith<$Res>
    implements $NotificationEntityCopyWith<$Res> {
  factory _$$NotificationEntityImplCopyWith(
    _$NotificationEntityImpl value,
    $Res Function(_$NotificationEntityImpl) then,
  ) = __$$NotificationEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String category,
    String title,
    String? body,
    Map<String, dynamic> data,
    bool isSeen,
    bool isRead,
    DateTime? readAt,
    DateTime sentAt,
  });
}

/// @nodoc
class __$$NotificationEntityImplCopyWithImpl<$Res>
    extends _$NotificationEntityCopyWithImpl<$Res, _$NotificationEntityImpl>
    implements _$$NotificationEntityImplCopyWith<$Res> {
  __$$NotificationEntityImplCopyWithImpl(
    _$NotificationEntityImpl _value,
    $Res Function(_$NotificationEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? category = null,
    Object? title = null,
    Object? body = freezed,
    Object? data = null,
    Object? isSeen = null,
    Object? isRead = null,
    Object? readAt = freezed,
    Object? sentAt = null,
  }) {
    return _then(
      _$NotificationEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        body: freezed == body
            ? _value.body
            : body // ignore: cast_nullable_to_non_nullable
                  as String?,
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        isSeen: null == isSeen
            ? _value.isSeen
            : isSeen // ignore: cast_nullable_to_non_nullable
                  as bool,
        isRead: null == isRead
            ? _value.isRead
            : isRead // ignore: cast_nullable_to_non_nullable
                  as bool,
        readAt: freezed == readAt
            ? _value.readAt
            : readAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        sentAt: null == sentAt
            ? _value.sentAt
            : sentAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$NotificationEntityImpl implements _NotificationEntity {
  const _$NotificationEntityImpl({
    required this.id,
    required this.category,
    required this.title,
    this.body,
    final Map<String, dynamic> data = const <String, dynamic>{},
    this.isSeen = false,
    this.isRead = false,
    this.readAt,
    required this.sentAt,
  }) : _data = data;

  @override
  final String id;

  /// Server-defined kind — drives the icon and colour. May be a value this
  /// build has never seen; render a neutral fallback rather than throwing.
  @override
  final String category;

  /// Already rendered in the caller's language. Show as-is.
  @override
  final String title;

  /// Already rendered in the caller's language. May legitimately be null —
  /// announcements are often title-only.
  @override
  final String? body;

  /// Deep-link payload. `data['type']` is always present and names the
  /// destination screen. See [NotificationRouting].
  final Map<String, dynamic> _data;

  /// Deep-link payload. `data['type']` is always present and names the
  /// destination screen. See [NotificationRouting].
  @override
  @JsonKey()
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  /// Whether a banner was ever raised for it. Windows-relevant only.
  @override
  @JsonKey()
  final bool isSeen;

  /// Whether the user opened it. Drives the unread dot and the badge.
  @override
  @JsonKey()
  final bool isRead;
  @override
  final DateTime? readAt;
  @override
  final DateTime sentAt;

  @override
  String toString() {
    return 'NotificationEntity(id: $id, category: $category, title: $title, body: $body, data: $data, isSeen: $isSeen, isRead: $isRead, readAt: $readAt, sentAt: $sentAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.isSeen, isSeen) || other.isSeen == isSeen) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.readAt, readAt) || other.readAt == readAt) &&
            (identical(other.sentAt, sentAt) || other.sentAt == sentAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    category,
    title,
    body,
    const DeepCollectionEquality().hash(_data),
    isSeen,
    isRead,
    readAt,
    sentAt,
  );

  /// Create a copy of NotificationEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationEntityImplCopyWith<_$NotificationEntityImpl> get copyWith =>
      __$$NotificationEntityImplCopyWithImpl<_$NotificationEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _NotificationEntity implements NotificationEntity {
  const factory _NotificationEntity({
    required final String id,
    required final String category,
    required final String title,
    final String? body,
    final Map<String, dynamic> data,
    final bool isSeen,
    final bool isRead,
    final DateTime? readAt,
    required final DateTime sentAt,
  }) = _$NotificationEntityImpl;

  @override
  String get id;

  /// Server-defined kind — drives the icon and colour. May be a value this
  /// build has never seen; render a neutral fallback rather than throwing.
  @override
  String get category;

  /// Already rendered in the caller's language. Show as-is.
  @override
  String get title;

  /// Already rendered in the caller's language. May legitimately be null —
  /// announcements are often title-only.
  @override
  String? get body;

  /// Deep-link payload. `data['type']` is always present and names the
  /// destination screen. See [NotificationRouting].
  @override
  Map<String, dynamic> get data;

  /// Whether a banner was ever raised for it. Windows-relevant only.
  @override
  bool get isSeen;

  /// Whether the user opened it. Drives the unread dot and the badge.
  @override
  bool get isRead;
  @override
  DateTime? get readAt;
  @override
  DateTime get sentAt;

  /// Create a copy of NotificationEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationEntityImplCopyWith<_$NotificationEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$NotificationPageEntity {
  List<NotificationEntity> get notifications =>
      throw _privateConstructorUsedError;

  /// Pass as `before` for the next page. `null` means no more pages.
  String? get nextCursor => throw _privateConstructorUsedError;
  int get unreadCount => throw _privateConstructorUsedError;

  /// Create a copy of NotificationPageEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationPageEntityCopyWith<NotificationPageEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationPageEntityCopyWith<$Res> {
  factory $NotificationPageEntityCopyWith(
    NotificationPageEntity value,
    $Res Function(NotificationPageEntity) then,
  ) = _$NotificationPageEntityCopyWithImpl<$Res, NotificationPageEntity>;
  @useResult
  $Res call({
    List<NotificationEntity> notifications,
    String? nextCursor,
    int unreadCount,
  });
}

/// @nodoc
class _$NotificationPageEntityCopyWithImpl<
  $Res,
  $Val extends NotificationPageEntity
>
    implements $NotificationPageEntityCopyWith<$Res> {
  _$NotificationPageEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationPageEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notifications = null,
    Object? nextCursor = freezed,
    Object? unreadCount = null,
  }) {
    return _then(
      _value.copyWith(
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NotificationPageEntityImplCopyWith<$Res>
    implements $NotificationPageEntityCopyWith<$Res> {
  factory _$$NotificationPageEntityImplCopyWith(
    _$NotificationPageEntityImpl value,
    $Res Function(_$NotificationPageEntityImpl) then,
  ) = __$$NotificationPageEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<NotificationEntity> notifications,
    String? nextCursor,
    int unreadCount,
  });
}

/// @nodoc
class __$$NotificationPageEntityImplCopyWithImpl<$Res>
    extends
        _$NotificationPageEntityCopyWithImpl<$Res, _$NotificationPageEntityImpl>
    implements _$$NotificationPageEntityImplCopyWith<$Res> {
  __$$NotificationPageEntityImplCopyWithImpl(
    _$NotificationPageEntityImpl _value,
    $Res Function(_$NotificationPageEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationPageEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notifications = null,
    Object? nextCursor = freezed,
    Object? unreadCount = null,
  }) {
    return _then(
      _$NotificationPageEntityImpl(
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
      ),
    );
  }
}

/// @nodoc

class _$NotificationPageEntityImpl implements _NotificationPageEntity {
  const _$NotificationPageEntityImpl({
    required final List<NotificationEntity> notifications,
    this.nextCursor,
    this.unreadCount = 0,
  }) : _notifications = notifications;

  final List<NotificationEntity> _notifications;
  @override
  List<NotificationEntity> get notifications {
    if (_notifications is EqualUnmodifiableListView) return _notifications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notifications);
  }

  /// Pass as `before` for the next page. `null` means no more pages.
  @override
  final String? nextCursor;
  @override
  @JsonKey()
  final int unreadCount;

  @override
  String toString() {
    return 'NotificationPageEntity(notifications: $notifications, nextCursor: $nextCursor, unreadCount: $unreadCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationPageEntityImpl &&
            const DeepCollectionEquality().equals(
              other._notifications,
              _notifications,
            ) &&
            (identical(other.nextCursor, nextCursor) ||
                other.nextCursor == nextCursor) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_notifications),
    nextCursor,
    unreadCount,
  );

  /// Create a copy of NotificationPageEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationPageEntityImplCopyWith<_$NotificationPageEntityImpl>
  get copyWith =>
      __$$NotificationPageEntityImplCopyWithImpl<_$NotificationPageEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _NotificationPageEntity implements NotificationPageEntity {
  const factory _NotificationPageEntity({
    required final List<NotificationEntity> notifications,
    final String? nextCursor,
    final int unreadCount,
  }) = _$NotificationPageEntityImpl;

  @override
  List<NotificationEntity> get notifications;

  /// Pass as `before` for the next page. `null` means no more pages.
  @override
  String? get nextCursor;
  @override
  int get unreadCount;

  /// Create a copy of NotificationPageEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationPageEntityImplCopyWith<_$NotificationPageEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UnseenNotificationsEntity {
  List<NotificationEntity> get notifications =>
      throw _privateConstructorUsedError;

  /// How many unseen notifications were withheld past the server's cap.
  /// Surface as a single summary banner, never as that many banners.
  int get remaining => throw _privateConstructorUsedError;
  int get unreadCount => throw _privateConstructorUsedError;

  /// Seconds until the next poll. Server-controlled — never hardcode it.
  int get pollAfter => throw _privateConstructorUsedError;

  /// Create a copy of UnseenNotificationsEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UnseenNotificationsEntityCopyWith<UnseenNotificationsEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnseenNotificationsEntityCopyWith<$Res> {
  factory $UnseenNotificationsEntityCopyWith(
    UnseenNotificationsEntity value,
    $Res Function(UnseenNotificationsEntity) then,
  ) = _$UnseenNotificationsEntityCopyWithImpl<$Res, UnseenNotificationsEntity>;
  @useResult
  $Res call({
    List<NotificationEntity> notifications,
    int remaining,
    int unreadCount,
    int pollAfter,
  });
}

/// @nodoc
class _$UnseenNotificationsEntityCopyWithImpl<
  $Res,
  $Val extends UnseenNotificationsEntity
>
    implements $UnseenNotificationsEntityCopyWith<$Res> {
  _$UnseenNotificationsEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UnseenNotificationsEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notifications = null,
    Object? remaining = null,
    Object? unreadCount = null,
    Object? pollAfter = null,
  }) {
    return _then(
      _value.copyWith(
            notifications: null == notifications
                ? _value.notifications
                : notifications // ignore: cast_nullable_to_non_nullable
                      as List<NotificationEntity>,
            remaining: null == remaining
                ? _value.remaining
                : remaining // ignore: cast_nullable_to_non_nullable
                      as int,
            unreadCount: null == unreadCount
                ? _value.unreadCount
                : unreadCount // ignore: cast_nullable_to_non_nullable
                      as int,
            pollAfter: null == pollAfter
                ? _value.pollAfter
                : pollAfter // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UnseenNotificationsEntityImplCopyWith<$Res>
    implements $UnseenNotificationsEntityCopyWith<$Res> {
  factory _$$UnseenNotificationsEntityImplCopyWith(
    _$UnseenNotificationsEntityImpl value,
    $Res Function(_$UnseenNotificationsEntityImpl) then,
  ) = __$$UnseenNotificationsEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<NotificationEntity> notifications,
    int remaining,
    int unreadCount,
    int pollAfter,
  });
}

/// @nodoc
class __$$UnseenNotificationsEntityImplCopyWithImpl<$Res>
    extends
        _$UnseenNotificationsEntityCopyWithImpl<
          $Res,
          _$UnseenNotificationsEntityImpl
        >
    implements _$$UnseenNotificationsEntityImplCopyWith<$Res> {
  __$$UnseenNotificationsEntityImplCopyWithImpl(
    _$UnseenNotificationsEntityImpl _value,
    $Res Function(_$UnseenNotificationsEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UnseenNotificationsEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notifications = null,
    Object? remaining = null,
    Object? unreadCount = null,
    Object? pollAfter = null,
  }) {
    return _then(
      _$UnseenNotificationsEntityImpl(
        notifications: null == notifications
            ? _value._notifications
            : notifications // ignore: cast_nullable_to_non_nullable
                  as List<NotificationEntity>,
        remaining: null == remaining
            ? _value.remaining
            : remaining // ignore: cast_nullable_to_non_nullable
                  as int,
        unreadCount: null == unreadCount
            ? _value.unreadCount
            : unreadCount // ignore: cast_nullable_to_non_nullable
                  as int,
        pollAfter: null == pollAfter
            ? _value.pollAfter
            : pollAfter // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$UnseenNotificationsEntityImpl implements _UnseenNotificationsEntity {
  const _$UnseenNotificationsEntityImpl({
    required final List<NotificationEntity> notifications,
    this.remaining = 0,
    this.unreadCount = 0,
    this.pollAfter = 30,
  }) : _notifications = notifications;

  final List<NotificationEntity> _notifications;
  @override
  List<NotificationEntity> get notifications {
    if (_notifications is EqualUnmodifiableListView) return _notifications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notifications);
  }

  /// How many unseen notifications were withheld past the server's cap.
  /// Surface as a single summary banner, never as that many banners.
  @override
  @JsonKey()
  final int remaining;
  @override
  @JsonKey()
  final int unreadCount;

  /// Seconds until the next poll. Server-controlled — never hardcode it.
  @override
  @JsonKey()
  final int pollAfter;

  @override
  String toString() {
    return 'UnseenNotificationsEntity(notifications: $notifications, remaining: $remaining, unreadCount: $unreadCount, pollAfter: $pollAfter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnseenNotificationsEntityImpl &&
            const DeepCollectionEquality().equals(
              other._notifications,
              _notifications,
            ) &&
            (identical(other.remaining, remaining) ||
                other.remaining == remaining) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.pollAfter, pollAfter) ||
                other.pollAfter == pollAfter));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_notifications),
    remaining,
    unreadCount,
    pollAfter,
  );

  /// Create a copy of UnseenNotificationsEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnseenNotificationsEntityImplCopyWith<_$UnseenNotificationsEntityImpl>
  get copyWith =>
      __$$UnseenNotificationsEntityImplCopyWithImpl<
        _$UnseenNotificationsEntityImpl
      >(this, _$identity);
}

abstract class _UnseenNotificationsEntity implements UnseenNotificationsEntity {
  const factory _UnseenNotificationsEntity({
    required final List<NotificationEntity> notifications,
    final int remaining,
    final int unreadCount,
    final int pollAfter,
  }) = _$UnseenNotificationsEntityImpl;

  @override
  List<NotificationEntity> get notifications;

  /// How many unseen notifications were withheld past the server's cap.
  /// Surface as a single summary banner, never as that many banners.
  @override
  int get remaining;
  @override
  int get unreadCount;

  /// Seconds until the next poll. Server-controlled — never hardcode it.
  @override
  int get pollAfter;

  /// Create a copy of UnseenNotificationsEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnseenNotificationsEntityImplCopyWith<_$UnseenNotificationsEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}
