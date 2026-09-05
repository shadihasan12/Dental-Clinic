// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'issues_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$IssuesEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() loadMore,
    required TResult Function() reloadCategories,
    required TResult Function(
      String category,
      String title,
      String description,
      List<String> mediaItemIds,
    )
    submit,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function()? loadMore,
    TResult? Function()? reloadCategories,
    TResult? Function(
      String category,
      String title,
      String description,
      List<String> mediaItemIds,
    )?
    submit,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? loadMore,
    TResult Function()? reloadCategories,
    TResult Function(
      String category,
      String title,
      String description,
      List<String> mediaItemIds,
    )?
    submit,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_ReloadCategories value) reloadCategories,
    required TResult Function(_Submit value) submit,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_ReloadCategories value)? reloadCategories,
    TResult? Function(_Submit value)? submit,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_ReloadCategories value)? reloadCategories,
    TResult Function(_Submit value)? submit,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IssuesEventCopyWith<$Res> {
  factory $IssuesEventCopyWith(
    IssuesEvent value,
    $Res Function(IssuesEvent) then,
  ) = _$IssuesEventCopyWithImpl<$Res, IssuesEvent>;
}

/// @nodoc
class _$IssuesEventCopyWithImpl<$Res, $Val extends IssuesEvent>
    implements $IssuesEventCopyWith<$Res> {
  _$IssuesEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IssuesEvent
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
    extends _$IssuesEventCopyWithImpl<$Res, _$LoadImpl>
    implements _$$LoadImplCopyWith<$Res> {
  __$$LoadImplCopyWithImpl(_$LoadImpl _value, $Res Function(_$LoadImpl) _then)
    : super(_value, _then);

  /// Create a copy of IssuesEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadImpl implements _Load {
  const _$LoadImpl();

  @override
  String toString() {
    return 'IssuesEvent.load()';
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
    required TResult Function() loadMore,
    required TResult Function() reloadCategories,
    required TResult Function(
      String category,
      String title,
      String description,
      List<String> mediaItemIds,
    )
    submit,
  }) {
    return load();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function()? loadMore,
    TResult? Function()? reloadCategories,
    TResult? Function(
      String category,
      String title,
      String description,
      List<String> mediaItemIds,
    )?
    submit,
  }) {
    return load?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? loadMore,
    TResult Function()? reloadCategories,
    TResult Function(
      String category,
      String title,
      String description,
      List<String> mediaItemIds,
    )?
    submit,
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
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_ReloadCategories value) reloadCategories,
    required TResult Function(_Submit value) submit,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_ReloadCategories value)? reloadCategories,
    TResult? Function(_Submit value)? submit,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_ReloadCategories value)? reloadCategories,
    TResult Function(_Submit value)? submit,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class _Load implements IssuesEvent {
  const factory _Load() = _$LoadImpl;
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
    extends _$IssuesEventCopyWithImpl<$Res, _$LoadMoreImpl>
    implements _$$LoadMoreImplCopyWith<$Res> {
  __$$LoadMoreImplCopyWithImpl(
    _$LoadMoreImpl _value,
    $Res Function(_$LoadMoreImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IssuesEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadMoreImpl implements _LoadMore {
  const _$LoadMoreImpl();

  @override
  String toString() {
    return 'IssuesEvent.loadMore()';
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
    required TResult Function() loadMore,
    required TResult Function() reloadCategories,
    required TResult Function(
      String category,
      String title,
      String description,
      List<String> mediaItemIds,
    )
    submit,
  }) {
    return loadMore();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function()? loadMore,
    TResult? Function()? reloadCategories,
    TResult? Function(
      String category,
      String title,
      String description,
      List<String> mediaItemIds,
    )?
    submit,
  }) {
    return loadMore?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? loadMore,
    TResult Function()? reloadCategories,
    TResult Function(
      String category,
      String title,
      String description,
      List<String> mediaItemIds,
    )?
    submit,
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
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_ReloadCategories value) reloadCategories,
    required TResult Function(_Submit value) submit,
  }) {
    return loadMore(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_ReloadCategories value)? reloadCategories,
    TResult? Function(_Submit value)? submit,
  }) {
    return loadMore?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_ReloadCategories value)? reloadCategories,
    TResult Function(_Submit value)? submit,
    required TResult orElse(),
  }) {
    if (loadMore != null) {
      return loadMore(this);
    }
    return orElse();
  }
}

abstract class _LoadMore implements IssuesEvent {
  const factory _LoadMore() = _$LoadMoreImpl;
}

/// @nodoc
abstract class _$$ReloadCategoriesImplCopyWith<$Res> {
  factory _$$ReloadCategoriesImplCopyWith(
    _$ReloadCategoriesImpl value,
    $Res Function(_$ReloadCategoriesImpl) then,
  ) = __$$ReloadCategoriesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ReloadCategoriesImplCopyWithImpl<$Res>
    extends _$IssuesEventCopyWithImpl<$Res, _$ReloadCategoriesImpl>
    implements _$$ReloadCategoriesImplCopyWith<$Res> {
  __$$ReloadCategoriesImplCopyWithImpl(
    _$ReloadCategoriesImpl _value,
    $Res Function(_$ReloadCategoriesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IssuesEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ReloadCategoriesImpl implements _ReloadCategories {
  const _$ReloadCategoriesImpl();

  @override
  String toString() {
    return 'IssuesEvent.reloadCategories()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ReloadCategoriesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() loadMore,
    required TResult Function() reloadCategories,
    required TResult Function(
      String category,
      String title,
      String description,
      List<String> mediaItemIds,
    )
    submit,
  }) {
    return reloadCategories();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function()? loadMore,
    TResult? Function()? reloadCategories,
    TResult? Function(
      String category,
      String title,
      String description,
      List<String> mediaItemIds,
    )?
    submit,
  }) {
    return reloadCategories?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? loadMore,
    TResult Function()? reloadCategories,
    TResult Function(
      String category,
      String title,
      String description,
      List<String> mediaItemIds,
    )?
    submit,
    required TResult orElse(),
  }) {
    if (reloadCategories != null) {
      return reloadCategories();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_ReloadCategories value) reloadCategories,
    required TResult Function(_Submit value) submit,
  }) {
    return reloadCategories(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_ReloadCategories value)? reloadCategories,
    TResult? Function(_Submit value)? submit,
  }) {
    return reloadCategories?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_ReloadCategories value)? reloadCategories,
    TResult Function(_Submit value)? submit,
    required TResult orElse(),
  }) {
    if (reloadCategories != null) {
      return reloadCategories(this);
    }
    return orElse();
  }
}

abstract class _ReloadCategories implements IssuesEvent {
  const factory _ReloadCategories() = _$ReloadCategoriesImpl;
}

/// @nodoc
abstract class _$$SubmitImplCopyWith<$Res> {
  factory _$$SubmitImplCopyWith(
    _$SubmitImpl value,
    $Res Function(_$SubmitImpl) then,
  ) = __$$SubmitImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String category,
    String title,
    String description,
    List<String> mediaItemIds,
  });
}

/// @nodoc
class __$$SubmitImplCopyWithImpl<$Res>
    extends _$IssuesEventCopyWithImpl<$Res, _$SubmitImpl>
    implements _$$SubmitImplCopyWith<$Res> {
  __$$SubmitImplCopyWithImpl(
    _$SubmitImpl _value,
    $Res Function(_$SubmitImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IssuesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = null,
    Object? title = null,
    Object? description = null,
    Object? mediaItemIds = null,
  }) {
    return _then(
      _$SubmitImpl(
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        mediaItemIds: null == mediaItemIds
            ? _value._mediaItemIds
            : mediaItemIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc

class _$SubmitImpl implements _Submit {
  const _$SubmitImpl({
    required this.category,
    required this.title,
    required this.description,
    final List<String> mediaItemIds = const <String>[],
  }) : _mediaItemIds = mediaItemIds;

  @override
  final String category;
  @override
  final String title;
  @override
  final String description;
  final List<String> _mediaItemIds;
  @override
  @JsonKey()
  List<String> get mediaItemIds {
    if (_mediaItemIds is EqualUnmodifiableListView) return _mediaItemIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mediaItemIds);
  }

  @override
  String toString() {
    return 'IssuesEvent.submit(category: $category, title: $title, description: $description, mediaItemIds: $mediaItemIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmitImpl &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(
              other._mediaItemIds,
              _mediaItemIds,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    category,
    title,
    description,
    const DeepCollectionEquality().hash(_mediaItemIds),
  );

  /// Create a copy of IssuesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmitImplCopyWith<_$SubmitImpl> get copyWith =>
      __$$SubmitImplCopyWithImpl<_$SubmitImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() loadMore,
    required TResult Function() reloadCategories,
    required TResult Function(
      String category,
      String title,
      String description,
      List<String> mediaItemIds,
    )
    submit,
  }) {
    return submit(category, title, description, mediaItemIds);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function()? loadMore,
    TResult? Function()? reloadCategories,
    TResult? Function(
      String category,
      String title,
      String description,
      List<String> mediaItemIds,
    )?
    submit,
  }) {
    return submit?.call(category, title, description, mediaItemIds);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? loadMore,
    TResult Function()? reloadCategories,
    TResult Function(
      String category,
      String title,
      String description,
      List<String> mediaItemIds,
    )?
    submit,
    required TResult orElse(),
  }) {
    if (submit != null) {
      return submit(category, title, description, mediaItemIds);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_ReloadCategories value) reloadCategories,
    required TResult Function(_Submit value) submit,
  }) {
    return submit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_ReloadCategories value)? reloadCategories,
    TResult? Function(_Submit value)? submit,
  }) {
    return submit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_ReloadCategories value)? reloadCategories,
    TResult Function(_Submit value)? submit,
    required TResult orElse(),
  }) {
    if (submit != null) {
      return submit(this);
    }
    return orElse();
  }
}

abstract class _Submit implements IssuesEvent {
  const factory _Submit({
    required final String category,
    required final String title,
    required final String description,
    final List<String> mediaItemIds,
  }) = _$SubmitImpl;

  String get category;
  String get title;
  String get description;
  List<String> get mediaItemIds;

  /// Create a copy of IssuesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubmitImplCopyWith<_$SubmitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$IssuesState {
  IssuesStatus get status => throw _privateConstructorUsedError;

  /// Rendered in the order held here, which is the server's:
  /// `updated_at` descending, so whatever support just touched is on top.
  List<IssueEntity> get issues => throw _privateConstructorUsedError;

  /// Page most recently loaded, and the highest page there is.
  int get page => throw _privateConstructorUsedError;
  int get lastPage => throw _privateConstructorUsedError;

  /// True while a *further* page is loading — the list stays on screen and
  /// only the footer shows a spinner.
  bool get isLoadingMore => throw _privateConstructorUsedError;

  /// Set when the list could not be loaded. The form still works; only
  /// the list below is replaced by the error card.
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Categories for the compose form, straight from the API.
  List<IssueOptionEntity> get categories => throw _privateConstructorUsedError;

  /// Set when the category list failed. Without it there is nothing valid
  /// to send, so the form offers a retry instead of a dropdown.
  String? get categoriesError => throw _privateConstructorUsedError;
  bool get isLoadingCategories => throw _privateConstructorUsedError;

  /// Status labels, keyed by wire value when rendering a report.
  List<IssueOptionEntity> get statuses => throw _privateConstructorUsedError;

  /// True while a create is in flight — the button shows a spinner and
  /// stops accepting taps.
  bool get isSubmitting => throw _privateConstructorUsedError;

  /// Set when a create was rejected. Shown against the form, not the
  /// list, because that is what the user has to act on.
  String? get submitError => throw _privateConstructorUsedError;

  /// Raised for exactly one emission after a successful create so the
  /// page can clear the fields and confirm. Consumers must not treat it
  /// as durable state.
  bool get justCreated => throw _privateConstructorUsedError;

  /// Create a copy of IssuesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IssuesStateCopyWith<IssuesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IssuesStateCopyWith<$Res> {
  factory $IssuesStateCopyWith(
    IssuesState value,
    $Res Function(IssuesState) then,
  ) = _$IssuesStateCopyWithImpl<$Res, IssuesState>;
  @useResult
  $Res call({
    IssuesStatus status,
    List<IssueEntity> issues,
    int page,
    int lastPage,
    bool isLoadingMore,
    String? errorMessage,
    List<IssueOptionEntity> categories,
    String? categoriesError,
    bool isLoadingCategories,
    List<IssueOptionEntity> statuses,
    bool isSubmitting,
    String? submitError,
    bool justCreated,
  });
}

/// @nodoc
class _$IssuesStateCopyWithImpl<$Res, $Val extends IssuesState>
    implements $IssuesStateCopyWith<$Res> {
  _$IssuesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IssuesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? issues = null,
    Object? page = null,
    Object? lastPage = null,
    Object? isLoadingMore = null,
    Object? errorMessage = freezed,
    Object? categories = null,
    Object? categoriesError = freezed,
    Object? isLoadingCategories = null,
    Object? statuses = null,
    Object? isSubmitting = null,
    Object? submitError = freezed,
    Object? justCreated = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as IssuesStatus,
            issues: null == issues
                ? _value.issues
                : issues // ignore: cast_nullable_to_non_nullable
                      as List<IssueEntity>,
            page: null == page
                ? _value.page
                : page // ignore: cast_nullable_to_non_nullable
                      as int,
            lastPage: null == lastPage
                ? _value.lastPage
                : lastPage // ignore: cast_nullable_to_non_nullable
                      as int,
            isLoadingMore: null == isLoadingMore
                ? _value.isLoadingMore
                : isLoadingMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            categories: null == categories
                ? _value.categories
                : categories // ignore: cast_nullable_to_non_nullable
                      as List<IssueOptionEntity>,
            categoriesError: freezed == categoriesError
                ? _value.categoriesError
                : categoriesError // ignore: cast_nullable_to_non_nullable
                      as String?,
            isLoadingCategories: null == isLoadingCategories
                ? _value.isLoadingCategories
                : isLoadingCategories // ignore: cast_nullable_to_non_nullable
                      as bool,
            statuses: null == statuses
                ? _value.statuses
                : statuses // ignore: cast_nullable_to_non_nullable
                      as List<IssueOptionEntity>,
            isSubmitting: null == isSubmitting
                ? _value.isSubmitting
                : isSubmitting // ignore: cast_nullable_to_non_nullable
                      as bool,
            submitError: freezed == submitError
                ? _value.submitError
                : submitError // ignore: cast_nullable_to_non_nullable
                      as String?,
            justCreated: null == justCreated
                ? _value.justCreated
                : justCreated // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$IssuesStateImplCopyWith<$Res>
    implements $IssuesStateCopyWith<$Res> {
  factory _$$IssuesStateImplCopyWith(
    _$IssuesStateImpl value,
    $Res Function(_$IssuesStateImpl) then,
  ) = __$$IssuesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    IssuesStatus status,
    List<IssueEntity> issues,
    int page,
    int lastPage,
    bool isLoadingMore,
    String? errorMessage,
    List<IssueOptionEntity> categories,
    String? categoriesError,
    bool isLoadingCategories,
    List<IssueOptionEntity> statuses,
    bool isSubmitting,
    String? submitError,
    bool justCreated,
  });
}

/// @nodoc
class __$$IssuesStateImplCopyWithImpl<$Res>
    extends _$IssuesStateCopyWithImpl<$Res, _$IssuesStateImpl>
    implements _$$IssuesStateImplCopyWith<$Res> {
  __$$IssuesStateImplCopyWithImpl(
    _$IssuesStateImpl _value,
    $Res Function(_$IssuesStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IssuesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? issues = null,
    Object? page = null,
    Object? lastPage = null,
    Object? isLoadingMore = null,
    Object? errorMessage = freezed,
    Object? categories = null,
    Object? categoriesError = freezed,
    Object? isLoadingCategories = null,
    Object? statuses = null,
    Object? isSubmitting = null,
    Object? submitError = freezed,
    Object? justCreated = null,
  }) {
    return _then(
      _$IssuesStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as IssuesStatus,
        issues: null == issues
            ? _value._issues
            : issues // ignore: cast_nullable_to_non_nullable
                  as List<IssueEntity>,
        page: null == page
            ? _value.page
            : page // ignore: cast_nullable_to_non_nullable
                  as int,
        lastPage: null == lastPage
            ? _value.lastPage
            : lastPage // ignore: cast_nullable_to_non_nullable
                  as int,
        isLoadingMore: null == isLoadingMore
            ? _value.isLoadingMore
            : isLoadingMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        categories: null == categories
            ? _value._categories
            : categories // ignore: cast_nullable_to_non_nullable
                  as List<IssueOptionEntity>,
        categoriesError: freezed == categoriesError
            ? _value.categoriesError
            : categoriesError // ignore: cast_nullable_to_non_nullable
                  as String?,
        isLoadingCategories: null == isLoadingCategories
            ? _value.isLoadingCategories
            : isLoadingCategories // ignore: cast_nullable_to_non_nullable
                  as bool,
        statuses: null == statuses
            ? _value._statuses
            : statuses // ignore: cast_nullable_to_non_nullable
                  as List<IssueOptionEntity>,
        isSubmitting: null == isSubmitting
            ? _value.isSubmitting
            : isSubmitting // ignore: cast_nullable_to_non_nullable
                  as bool,
        submitError: freezed == submitError
            ? _value.submitError
            : submitError // ignore: cast_nullable_to_non_nullable
                  as String?,
        justCreated: null == justCreated
            ? _value.justCreated
            : justCreated // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$IssuesStateImpl extends _IssuesState {
  const _$IssuesStateImpl({
    this.status = IssuesStatus.initial,
    final List<IssueEntity> issues = const <IssueEntity>[],
    this.page = 1,
    this.lastPage = 1,
    this.isLoadingMore = false,
    this.errorMessage,
    final List<IssueOptionEntity> categories = const <IssueOptionEntity>[],
    this.categoriesError,
    this.isLoadingCategories = false,
    final List<IssueOptionEntity> statuses = const <IssueOptionEntity>[],
    this.isSubmitting = false,
    this.submitError,
    this.justCreated = false,
  }) : _issues = issues,
       _categories = categories,
       _statuses = statuses,
       super._();

  @override
  @JsonKey()
  final IssuesStatus status;

  /// Rendered in the order held here, which is the server's:
  /// `updated_at` descending, so whatever support just touched is on top.
  final List<IssueEntity> _issues;

  /// Rendered in the order held here, which is the server's:
  /// `updated_at` descending, so whatever support just touched is on top.
  @override
  @JsonKey()
  List<IssueEntity> get issues {
    if (_issues is EqualUnmodifiableListView) return _issues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_issues);
  }

  /// Page most recently loaded, and the highest page there is.
  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final int lastPage;

  /// True while a *further* page is loading — the list stays on screen and
  /// only the footer shows a spinner.
  @override
  @JsonKey()
  final bool isLoadingMore;

  /// Set when the list could not be loaded. The form still works; only
  /// the list below is replaced by the error card.
  @override
  final String? errorMessage;

  /// Categories for the compose form, straight from the API.
  final List<IssueOptionEntity> _categories;

  /// Categories for the compose form, straight from the API.
  @override
  @JsonKey()
  List<IssueOptionEntity> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  /// Set when the category list failed. Without it there is nothing valid
  /// to send, so the form offers a retry instead of a dropdown.
  @override
  final String? categoriesError;
  @override
  @JsonKey()
  final bool isLoadingCategories;

  /// Status labels, keyed by wire value when rendering a report.
  final List<IssueOptionEntity> _statuses;

  /// Status labels, keyed by wire value when rendering a report.
  @override
  @JsonKey()
  List<IssueOptionEntity> get statuses {
    if (_statuses is EqualUnmodifiableListView) return _statuses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_statuses);
  }

  /// True while a create is in flight — the button shows a spinner and
  /// stops accepting taps.
  @override
  @JsonKey()
  final bool isSubmitting;

  /// Set when a create was rejected. Shown against the form, not the
  /// list, because that is what the user has to act on.
  @override
  final String? submitError;

  /// Raised for exactly one emission after a successful create so the
  /// page can clear the fields and confirm. Consumers must not treat it
  /// as durable state.
  @override
  @JsonKey()
  final bool justCreated;

  @override
  String toString() {
    return 'IssuesState(status: $status, issues: $issues, page: $page, lastPage: $lastPage, isLoadingMore: $isLoadingMore, errorMessage: $errorMessage, categories: $categories, categoriesError: $categoriesError, isLoadingCategories: $isLoadingCategories, statuses: $statuses, isSubmitting: $isSubmitting, submitError: $submitError, justCreated: $justCreated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IssuesStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._issues, _issues) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.lastPage, lastPage) ||
                other.lastPage == lastPage) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality().equals(
              other._categories,
              _categories,
            ) &&
            (identical(other.categoriesError, categoriesError) ||
                other.categoriesError == categoriesError) &&
            (identical(other.isLoadingCategories, isLoadingCategories) ||
                other.isLoadingCategories == isLoadingCategories) &&
            const DeepCollectionEquality().equals(other._statuses, _statuses) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.submitError, submitError) ||
                other.submitError == submitError) &&
            (identical(other.justCreated, justCreated) ||
                other.justCreated == justCreated));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    const DeepCollectionEquality().hash(_issues),
    page,
    lastPage,
    isLoadingMore,
    errorMessage,
    const DeepCollectionEquality().hash(_categories),
    categoriesError,
    isLoadingCategories,
    const DeepCollectionEquality().hash(_statuses),
    isSubmitting,
    submitError,
    justCreated,
  );

  /// Create a copy of IssuesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IssuesStateImplCopyWith<_$IssuesStateImpl> get copyWith =>
      __$$IssuesStateImplCopyWithImpl<_$IssuesStateImpl>(this, _$identity);
}

abstract class _IssuesState extends IssuesState {
  const factory _IssuesState({
    final IssuesStatus status,
    final List<IssueEntity> issues,
    final int page,
    final int lastPage,
    final bool isLoadingMore,
    final String? errorMessage,
    final List<IssueOptionEntity> categories,
    final String? categoriesError,
    final bool isLoadingCategories,
    final List<IssueOptionEntity> statuses,
    final bool isSubmitting,
    final String? submitError,
    final bool justCreated,
  }) = _$IssuesStateImpl;
  const _IssuesState._() : super._();

  @override
  IssuesStatus get status;

  /// Rendered in the order held here, which is the server's:
  /// `updated_at` descending, so whatever support just touched is on top.
  @override
  List<IssueEntity> get issues;

  /// Page most recently loaded, and the highest page there is.
  @override
  int get page;
  @override
  int get lastPage;

  /// True while a *further* page is loading — the list stays on screen and
  /// only the footer shows a spinner.
  @override
  bool get isLoadingMore;

  /// Set when the list could not be loaded. The form still works; only
  /// the list below is replaced by the error card.
  @override
  String? get errorMessage;

  /// Categories for the compose form, straight from the API.
  @override
  List<IssueOptionEntity> get categories;

  /// Set when the category list failed. Without it there is nothing valid
  /// to send, so the form offers a retry instead of a dropdown.
  @override
  String? get categoriesError;
  @override
  bool get isLoadingCategories;

  /// Status labels, keyed by wire value when rendering a report.
  @override
  List<IssueOptionEntity> get statuses;

  /// True while a create is in flight — the button shows a spinner and
  /// stops accepting taps.
  @override
  bool get isSubmitting;

  /// Set when a create was rejected. Shown against the form, not the
  /// list, because that is what the user has to act on.
  @override
  String? get submitError;

  /// Raised for exactly one emission after a successful create so the
  /// page can clear the fields and confirm. Consumers must not treat it
  /// as durable state.
  @override
  bool get justCreated;

  /// Create a copy of IssuesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IssuesStateImplCopyWith<_$IssuesStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
