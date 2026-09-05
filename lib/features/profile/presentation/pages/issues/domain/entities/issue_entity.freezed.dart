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
mixin _$IssueAttachmentEntity {
  String get mediaItemId => throw _privateConstructorUsedError;
  String get viewUrl => throw _privateConstructorUsedError;
  String get downloadUrl => throw _privateConstructorUsedError;

  /// Create a copy of IssueAttachmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IssueAttachmentEntityCopyWith<IssueAttachmentEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IssueAttachmentEntityCopyWith<$Res> {
  factory $IssueAttachmentEntityCopyWith(
    IssueAttachmentEntity value,
    $Res Function(IssueAttachmentEntity) then,
  ) = _$IssueAttachmentEntityCopyWithImpl<$Res, IssueAttachmentEntity>;
  @useResult
  $Res call({String mediaItemId, String viewUrl, String downloadUrl});
}

/// @nodoc
class _$IssueAttachmentEntityCopyWithImpl<
  $Res,
  $Val extends IssueAttachmentEntity
>
    implements $IssueAttachmentEntityCopyWith<$Res> {
  _$IssueAttachmentEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IssueAttachmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mediaItemId = null,
    Object? viewUrl = null,
    Object? downloadUrl = null,
  }) {
    return _then(
      _value.copyWith(
            mediaItemId: null == mediaItemId
                ? _value.mediaItemId
                : mediaItemId // ignore: cast_nullable_to_non_nullable
                      as String,
            viewUrl: null == viewUrl
                ? _value.viewUrl
                : viewUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            downloadUrl: null == downloadUrl
                ? _value.downloadUrl
                : downloadUrl // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$IssueAttachmentEntityImplCopyWith<$Res>
    implements $IssueAttachmentEntityCopyWith<$Res> {
  factory _$$IssueAttachmentEntityImplCopyWith(
    _$IssueAttachmentEntityImpl value,
    $Res Function(_$IssueAttachmentEntityImpl) then,
  ) = __$$IssueAttachmentEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String mediaItemId, String viewUrl, String downloadUrl});
}

/// @nodoc
class __$$IssueAttachmentEntityImplCopyWithImpl<$Res>
    extends
        _$IssueAttachmentEntityCopyWithImpl<$Res, _$IssueAttachmentEntityImpl>
    implements _$$IssueAttachmentEntityImplCopyWith<$Res> {
  __$$IssueAttachmentEntityImplCopyWithImpl(
    _$IssueAttachmentEntityImpl _value,
    $Res Function(_$IssueAttachmentEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IssueAttachmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mediaItemId = null,
    Object? viewUrl = null,
    Object? downloadUrl = null,
  }) {
    return _then(
      _$IssueAttachmentEntityImpl(
        mediaItemId: null == mediaItemId
            ? _value.mediaItemId
            : mediaItemId // ignore: cast_nullable_to_non_nullable
                  as String,
        viewUrl: null == viewUrl
            ? _value.viewUrl
            : viewUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        downloadUrl: null == downloadUrl
            ? _value.downloadUrl
            : downloadUrl // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$IssueAttachmentEntityImpl implements _IssueAttachmentEntity {
  const _$IssueAttachmentEntityImpl({
    required this.mediaItemId,
    required this.viewUrl,
    required this.downloadUrl,
  });

  @override
  final String mediaItemId;
  @override
  final String viewUrl;
  @override
  final String downloadUrl;

  @override
  String toString() {
    return 'IssueAttachmentEntity(mediaItemId: $mediaItemId, viewUrl: $viewUrl, downloadUrl: $downloadUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IssueAttachmentEntityImpl &&
            (identical(other.mediaItemId, mediaItemId) ||
                other.mediaItemId == mediaItemId) &&
            (identical(other.viewUrl, viewUrl) || other.viewUrl == viewUrl) &&
            (identical(other.downloadUrl, downloadUrl) ||
                other.downloadUrl == downloadUrl));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, mediaItemId, viewUrl, downloadUrl);

  /// Create a copy of IssueAttachmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IssueAttachmentEntityImplCopyWith<_$IssueAttachmentEntityImpl>
  get copyWith =>
      __$$IssueAttachmentEntityImplCopyWithImpl<_$IssueAttachmentEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _IssueAttachmentEntity implements IssueAttachmentEntity {
  const factory _IssueAttachmentEntity({
    required final String mediaItemId,
    required final String viewUrl,
    required final String downloadUrl,
  }) = _$IssueAttachmentEntityImpl;

  @override
  String get mediaItemId;
  @override
  String get viewUrl;
  @override
  String get downloadUrl;

  /// Create a copy of IssueAttachmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IssueAttachmentEntityImplCopyWith<_$IssueAttachmentEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$IssueOptionEntity {
  String get value => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;

  /// Create a copy of IssueOptionEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IssueOptionEntityCopyWith<IssueOptionEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IssueOptionEntityCopyWith<$Res> {
  factory $IssueOptionEntityCopyWith(
    IssueOptionEntity value,
    $Res Function(IssueOptionEntity) then,
  ) = _$IssueOptionEntityCopyWithImpl<$Res, IssueOptionEntity>;
  @useResult
  $Res call({String value, String label});
}

/// @nodoc
class _$IssueOptionEntityCopyWithImpl<$Res, $Val extends IssueOptionEntity>
    implements $IssueOptionEntityCopyWith<$Res> {
  _$IssueOptionEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IssueOptionEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = null, Object? label = null}) {
    return _then(
      _value.copyWith(
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as String,
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$IssueOptionEntityImplCopyWith<$Res>
    implements $IssueOptionEntityCopyWith<$Res> {
  factory _$$IssueOptionEntityImplCopyWith(
    _$IssueOptionEntityImpl value,
    $Res Function(_$IssueOptionEntityImpl) then,
  ) = __$$IssueOptionEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String value, String label});
}

/// @nodoc
class __$$IssueOptionEntityImplCopyWithImpl<$Res>
    extends _$IssueOptionEntityCopyWithImpl<$Res, _$IssueOptionEntityImpl>
    implements _$$IssueOptionEntityImplCopyWith<$Res> {
  __$$IssueOptionEntityImplCopyWithImpl(
    _$IssueOptionEntityImpl _value,
    $Res Function(_$IssueOptionEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IssueOptionEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = null, Object? label = null}) {
    return _then(
      _$IssueOptionEntityImpl(
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String,
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$IssueOptionEntityImpl implements _IssueOptionEntity {
  const _$IssueOptionEntityImpl({required this.value, required this.label});

  @override
  final String value;
  @override
  final String label;

  @override
  String toString() {
    return 'IssueOptionEntity(value: $value, label: $label)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IssueOptionEntityImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.label, label) || other.label == label));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value, label);

  /// Create a copy of IssueOptionEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IssueOptionEntityImplCopyWith<_$IssueOptionEntityImpl> get copyWith =>
      __$$IssueOptionEntityImplCopyWithImpl<_$IssueOptionEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _IssueOptionEntity implements IssueOptionEntity {
  const factory _IssueOptionEntity({
    required final String value,
    required final String label,
  }) = _$IssueOptionEntityImpl;

  @override
  String get value;
  @override
  String get label;

  /// Create a copy of IssueOptionEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IssueOptionEntityImplCopyWith<_$IssueOptionEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$IssueEntity {
  String get id => throw _privateConstructorUsedError;

  /// Wire value, e.g. `BUG`. Labelled from the categories endpoint.
  String get category => throw _privateConstructorUsedError;

  /// Wire value, e.g. `OPEN`. Labelled from the statuses endpoint.
  String get status => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<IssueAttachmentEntity> get attachments =>
      throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Moves when support acts on the report, and the list is sorted by it —
  /// this is the "last activity", not the filing date.
  DateTime? get updatedAt => throw _privateConstructorUsedError;

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
    String category,
    String status,
    String title,
    String description,
    List<IssueAttachmentEntity> attachments,
    DateTime? createdAt,
    DateTime? updatedAt,
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
    Object? category = null,
    Object? status = null,
    Object? title = null,
    Object? description = null,
    Object? attachments = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            attachments: null == attachments
                ? _value.attachments
                : attachments // ignore: cast_nullable_to_non_nullable
                      as List<IssueAttachmentEntity>,
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
    String category,
    String status,
    String title,
    String description,
    List<IssueAttachmentEntity> attachments,
    DateTime? createdAt,
    DateTime? updatedAt,
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
    Object? category = null,
    Object? status = null,
    Object? title = null,
    Object? description = null,
    Object? attachments = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$IssueEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        attachments: null == attachments
            ? _value._attachments
            : attachments // ignore: cast_nullable_to_non_nullable
                  as List<IssueAttachmentEntity>,
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

class _$IssueEntityImpl extends _IssueEntity {
  const _$IssueEntityImpl({
    required this.id,
    this.category = '',
    this.status = '',
    required this.title,
    required this.description,
    final List<IssueAttachmentEntity> attachments =
        const <IssueAttachmentEntity>[],
    this.createdAt,
    this.updatedAt,
  }) : _attachments = attachments,
       super._();

  @override
  final String id;

  /// Wire value, e.g. `BUG`. Labelled from the categories endpoint.
  @override
  @JsonKey()
  final String category;

  /// Wire value, e.g. `OPEN`. Labelled from the statuses endpoint.
  @override
  @JsonKey()
  final String status;
  @override
  final String title;
  @override
  final String description;
  final List<IssueAttachmentEntity> _attachments;
  @override
  @JsonKey()
  List<IssueAttachmentEntity> get attachments {
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachments);
  }

  @override
  final DateTime? createdAt;

  /// Moves when support acts on the report, and the list is sorted by it —
  /// this is the "last activity", not the filing date.
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'IssueEntity(id: $id, category: $category, status: $status, title: $title, description: $description, attachments: $attachments, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IssueEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(
              other._attachments,
              _attachments,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    category,
    status,
    title,
    description,
    const DeepCollectionEquality().hash(_attachments),
    createdAt,
    updatedAt,
  );

  /// Create a copy of IssueEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IssueEntityImplCopyWith<_$IssueEntityImpl> get copyWith =>
      __$$IssueEntityImplCopyWithImpl<_$IssueEntityImpl>(this, _$identity);
}

abstract class _IssueEntity extends IssueEntity {
  const factory _IssueEntity({
    required final String id,
    final String category,
    final String status,
    required final String title,
    required final String description,
    final List<IssueAttachmentEntity> attachments,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$IssueEntityImpl;
  const _IssueEntity._() : super._();

  @override
  String get id;

  /// Wire value, e.g. `BUG`. Labelled from the categories endpoint.
  @override
  String get category;

  /// Wire value, e.g. `OPEN`. Labelled from the statuses endpoint.
  @override
  String get status;
  @override
  String get title;
  @override
  String get description;
  @override
  List<IssueAttachmentEntity> get attachments;
  @override
  DateTime? get createdAt;

  /// Moves when support acts on the report, and the list is sorted by it —
  /// this is the "last activity", not the filing date.
  @override
  DateTime? get updatedAt;

  /// Create a copy of IssueEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IssueEntityImplCopyWith<_$IssueEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$IssuePageEntity {
  List<IssueEntity> get items => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get lastPage => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;

  /// Create a copy of IssuePageEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IssuePageEntityCopyWith<IssuePageEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IssuePageEntityCopyWith<$Res> {
  factory $IssuePageEntityCopyWith(
    IssuePageEntity value,
    $Res Function(IssuePageEntity) then,
  ) = _$IssuePageEntityCopyWithImpl<$Res, IssuePageEntity>;
  @useResult
  $Res call({List<IssueEntity> items, int page, int lastPage, int total});
}

/// @nodoc
class _$IssuePageEntityCopyWithImpl<$Res, $Val extends IssuePageEntity>
    implements $IssuePageEntityCopyWith<$Res> {
  _$IssuePageEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IssuePageEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? page = null,
    Object? lastPage = null,
    Object? total = null,
  }) {
    return _then(
      _value.copyWith(
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<IssueEntity>,
            page: null == page
                ? _value.page
                : page // ignore: cast_nullable_to_non_nullable
                      as int,
            lastPage: null == lastPage
                ? _value.lastPage
                : lastPage // ignore: cast_nullable_to_non_nullable
                      as int,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$IssuePageEntityImplCopyWith<$Res>
    implements $IssuePageEntityCopyWith<$Res> {
  factory _$$IssuePageEntityImplCopyWith(
    _$IssuePageEntityImpl value,
    $Res Function(_$IssuePageEntityImpl) then,
  ) = __$$IssuePageEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<IssueEntity> items, int page, int lastPage, int total});
}

/// @nodoc
class __$$IssuePageEntityImplCopyWithImpl<$Res>
    extends _$IssuePageEntityCopyWithImpl<$Res, _$IssuePageEntityImpl>
    implements _$$IssuePageEntityImplCopyWith<$Res> {
  __$$IssuePageEntityImplCopyWithImpl(
    _$IssuePageEntityImpl _value,
    $Res Function(_$IssuePageEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IssuePageEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? page = null,
    Object? lastPage = null,
    Object? total = null,
  }) {
    return _then(
      _$IssuePageEntityImpl(
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<IssueEntity>,
        page: null == page
            ? _value.page
            : page // ignore: cast_nullable_to_non_nullable
                  as int,
        lastPage: null == lastPage
            ? _value.lastPage
            : lastPage // ignore: cast_nullable_to_non_nullable
                  as int,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$IssuePageEntityImpl extends _IssuePageEntity {
  const _$IssuePageEntityImpl({
    final List<IssueEntity> items = const <IssueEntity>[],
    this.page = 1,
    this.lastPage = 1,
    this.total = 0,
  }) : _items = items,
       super._();

  final List<IssueEntity> _items;
  @override
  @JsonKey()
  List<IssueEntity> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final int lastPage;
  @override
  @JsonKey()
  final int total;

  @override
  String toString() {
    return 'IssuePageEntity(items: $items, page: $page, lastPage: $lastPage, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IssuePageEntityImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.lastPage, lastPage) ||
                other.lastPage == lastPage) &&
            (identical(other.total, total) || other.total == total));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_items),
    page,
    lastPage,
    total,
  );

  /// Create a copy of IssuePageEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IssuePageEntityImplCopyWith<_$IssuePageEntityImpl> get copyWith =>
      __$$IssuePageEntityImplCopyWithImpl<_$IssuePageEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _IssuePageEntity extends IssuePageEntity {
  const factory _IssuePageEntity({
    final List<IssueEntity> items,
    final int page,
    final int lastPage,
    final int total,
  }) = _$IssuePageEntityImpl;
  const _IssuePageEntity._() : super._();

  @override
  List<IssueEntity> get items;
  @override
  int get page;
  @override
  int get lastPage;
  @override
  int get total;

  /// Create a copy of IssuePageEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IssuePageEntityImplCopyWith<_$IssuePageEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
