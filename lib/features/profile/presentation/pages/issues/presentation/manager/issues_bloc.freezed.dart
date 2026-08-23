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
    required TResult Function(String title, String description) submit,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(String title, String description)? submit,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(String title, String description)? submit,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_Submit value) submit,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_Submit value)? submit,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
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
    required TResult Function(String title, String description) submit,
  }) {
    return load();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(String title, String description)? submit,
  }) {
    return load?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(String title, String description)? submit,
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
    required TResult Function(_Submit value) submit,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_Submit value)? submit,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
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
abstract class _$$SubmitImplCopyWith<$Res> {
  factory _$$SubmitImplCopyWith(
    _$SubmitImpl value,
    $Res Function(_$SubmitImpl) then,
  ) = __$$SubmitImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String title, String description});
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
  $Res call({Object? title = null, Object? description = null}) {
    return _then(
      _$SubmitImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SubmitImpl implements _Submit {
  const _$SubmitImpl({required this.title, required this.description});

  @override
  final String title;
  @override
  final String description;

  @override
  String toString() {
    return 'IssuesEvent.submit(title: $title, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmitImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, description);

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
    required TResult Function(String title, String description) submit,
  }) {
    return submit(title, description);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(String title, String description)? submit,
  }) {
    return submit?.call(title, description);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(String title, String description)? submit,
    required TResult orElse(),
  }) {
    if (submit != null) {
      return submit(title, description);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_Submit value) submit,
  }) {
    return submit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_Submit value)? submit,
  }) {
    return submit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
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
    required final String title,
    required final String description,
  }) = _$SubmitImpl;

  String get title;
  String get description;

  /// Create a copy of IssuesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubmitImplCopyWith<_$SubmitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$IssuesState {
  IssuesStatus get status => throw _privateConstructorUsedError;

  /// Rendered in the order held here — newest first, which is the order
  /// the list endpoint is expected to return.
  List<IssueEntity> get issues => throw _privateConstructorUsedError;

  /// Set when the list could not be loaded. The form still works; only
  /// the list below is replaced by the error card.
  String? get errorMessage => throw _privateConstructorUsedError;

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
    String? errorMessage,
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
    Object? errorMessage = freezed,
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
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
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
    String? errorMessage,
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
    Object? errorMessage = freezed,
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
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
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
    this.errorMessage,
    this.isSubmitting = false,
    this.submitError,
    this.justCreated = false,
  }) : _issues = issues,
       super._();

  @override
  @JsonKey()
  final IssuesStatus status;

  /// Rendered in the order held here — newest first, which is the order
  /// the list endpoint is expected to return.
  final List<IssueEntity> _issues;

  /// Rendered in the order held here — newest first, which is the order
  /// the list endpoint is expected to return.
  @override
  @JsonKey()
  List<IssueEntity> get issues {
    if (_issues is EqualUnmodifiableListView) return _issues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_issues);
  }

  /// Set when the list could not be loaded. The form still works; only
  /// the list below is replaced by the error card.
  @override
  final String? errorMessage;

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
    return 'IssuesState(status: $status, issues: $issues, errorMessage: $errorMessage, isSubmitting: $isSubmitting, submitError: $submitError, justCreated: $justCreated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IssuesStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._issues, _issues) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
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
    errorMessage,
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
    final String? errorMessage,
    final bool isSubmitting,
    final String? submitError,
    final bool justCreated,
  }) = _$IssuesStateImpl;
  const _IssuesState._() : super._();

  @override
  IssuesStatus get status;

  /// Rendered in the order held here — newest first, which is the order
  /// the list endpoint is expected to return.
  @override
  List<IssueEntity> get issues;

  /// Set when the list could not be loaded. The form still works; only
  /// the list below is replaced by the error card.
  @override
  String? get errorMessage;

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
