// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invitation_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$InvitationEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadSentInvitations,
    required TResult Function() loadReceivedInvitations,
    required TResult Function(InvitationStatus status) filterReceivedByStatus,
    required TResult Function(InvitationStatus status) filterSentByStatus,
    required TResult Function(String email, List<String> roles) sendInvitation,
    required TResult Function(String invitationId) cancelInvitation,
    required TResult Function(String invitationId) acceptInvitation,
    required TResult Function(String invitationId) rejectInvitation,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadSentInvitations,
    TResult? Function()? loadReceivedInvitations,
    TResult? Function(InvitationStatus status)? filterReceivedByStatus,
    TResult? Function(InvitationStatus status)? filterSentByStatus,
    TResult? Function(String email, List<String> roles)? sendInvitation,
    TResult? Function(String invitationId)? cancelInvitation,
    TResult? Function(String invitationId)? acceptInvitation,
    TResult? Function(String invitationId)? rejectInvitation,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadSentInvitations,
    TResult Function()? loadReceivedInvitations,
    TResult Function(InvitationStatus status)? filterReceivedByStatus,
    TResult Function(InvitationStatus status)? filterSentByStatus,
    TResult Function(String email, List<String> roles)? sendInvitation,
    TResult Function(String invitationId)? cancelInvitation,
    TResult Function(String invitationId)? acceptInvitation,
    TResult Function(String invitationId)? rejectInvitation,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSentInvitations value) loadSentInvitations,
    required TResult Function(_LoadReceivedInvitations value)
    loadReceivedInvitations,
    required TResult Function(_FilterReceivedByStatus value)
    filterReceivedByStatus,
    required TResult Function(_FilterSentByStatus value) filterSentByStatus,
    required TResult Function(_SendInvitation value) sendInvitation,
    required TResult Function(_CancelInvitation value) cancelInvitation,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_RejectInvitation value) rejectInvitation,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult? Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult? Function(_FilterReceivedByStatus value)? filterReceivedByStatus,
    TResult? Function(_FilterSentByStatus value)? filterSentByStatus,
    TResult? Function(_SendInvitation value)? sendInvitation,
    TResult? Function(_CancelInvitation value)? cancelInvitation,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_RejectInvitation value)? rejectInvitation,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult Function(_FilterReceivedByStatus value)? filterReceivedByStatus,
    TResult Function(_FilterSentByStatus value)? filterSentByStatus,
    TResult Function(_SendInvitation value)? sendInvitation,
    TResult Function(_CancelInvitation value)? cancelInvitation,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_RejectInvitation value)? rejectInvitation,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvitationEventCopyWith<$Res> {
  factory $InvitationEventCopyWith(
    InvitationEvent value,
    $Res Function(InvitationEvent) then,
  ) = _$InvitationEventCopyWithImpl<$Res, InvitationEvent>;
}

/// @nodoc
class _$InvitationEventCopyWithImpl<$Res, $Val extends InvitationEvent>
    implements $InvitationEventCopyWith<$Res> {
  _$InvitationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadSentInvitationsImplCopyWith<$Res> {
  factory _$$LoadSentInvitationsImplCopyWith(
    _$LoadSentInvitationsImpl value,
    $Res Function(_$LoadSentInvitationsImpl) then,
  ) = __$$LoadSentInvitationsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadSentInvitationsImplCopyWithImpl<$Res>
    extends _$InvitationEventCopyWithImpl<$Res, _$LoadSentInvitationsImpl>
    implements _$$LoadSentInvitationsImplCopyWith<$Res> {
  __$$LoadSentInvitationsImplCopyWithImpl(
    _$LoadSentInvitationsImpl _value,
    $Res Function(_$LoadSentInvitationsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadSentInvitationsImpl implements _LoadSentInvitations {
  const _$LoadSentInvitationsImpl();

  @override
  String toString() {
    return 'InvitationEvent.loadSentInvitations()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadSentInvitationsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadSentInvitations,
    required TResult Function() loadReceivedInvitations,
    required TResult Function(InvitationStatus status) filterReceivedByStatus,
    required TResult Function(InvitationStatus status) filterSentByStatus,
    required TResult Function(String email, List<String> roles) sendInvitation,
    required TResult Function(String invitationId) cancelInvitation,
    required TResult Function(String invitationId) acceptInvitation,
    required TResult Function(String invitationId) rejectInvitation,
  }) {
    return loadSentInvitations();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadSentInvitations,
    TResult? Function()? loadReceivedInvitations,
    TResult? Function(InvitationStatus status)? filterReceivedByStatus,
    TResult? Function(InvitationStatus status)? filterSentByStatus,
    TResult? Function(String email, List<String> roles)? sendInvitation,
    TResult? Function(String invitationId)? cancelInvitation,
    TResult? Function(String invitationId)? acceptInvitation,
    TResult? Function(String invitationId)? rejectInvitation,
  }) {
    return loadSentInvitations?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadSentInvitations,
    TResult Function()? loadReceivedInvitations,
    TResult Function(InvitationStatus status)? filterReceivedByStatus,
    TResult Function(InvitationStatus status)? filterSentByStatus,
    TResult Function(String email, List<String> roles)? sendInvitation,
    TResult Function(String invitationId)? cancelInvitation,
    TResult Function(String invitationId)? acceptInvitation,
    TResult Function(String invitationId)? rejectInvitation,
    required TResult orElse(),
  }) {
    if (loadSentInvitations != null) {
      return loadSentInvitations();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSentInvitations value) loadSentInvitations,
    required TResult Function(_LoadReceivedInvitations value)
    loadReceivedInvitations,
    required TResult Function(_FilterReceivedByStatus value)
    filterReceivedByStatus,
    required TResult Function(_FilterSentByStatus value) filterSentByStatus,
    required TResult Function(_SendInvitation value) sendInvitation,
    required TResult Function(_CancelInvitation value) cancelInvitation,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_RejectInvitation value) rejectInvitation,
  }) {
    return loadSentInvitations(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult? Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult? Function(_FilterReceivedByStatus value)? filterReceivedByStatus,
    TResult? Function(_FilterSentByStatus value)? filterSentByStatus,
    TResult? Function(_SendInvitation value)? sendInvitation,
    TResult? Function(_CancelInvitation value)? cancelInvitation,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_RejectInvitation value)? rejectInvitation,
  }) {
    return loadSentInvitations?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult Function(_FilterReceivedByStatus value)? filterReceivedByStatus,
    TResult Function(_FilterSentByStatus value)? filterSentByStatus,
    TResult Function(_SendInvitation value)? sendInvitation,
    TResult Function(_CancelInvitation value)? cancelInvitation,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_RejectInvitation value)? rejectInvitation,
    required TResult orElse(),
  }) {
    if (loadSentInvitations != null) {
      return loadSentInvitations(this);
    }
    return orElse();
  }
}

abstract class _LoadSentInvitations implements InvitationEvent {
  const factory _LoadSentInvitations() = _$LoadSentInvitationsImpl;
}

/// @nodoc
abstract class _$$LoadReceivedInvitationsImplCopyWith<$Res> {
  factory _$$LoadReceivedInvitationsImplCopyWith(
    _$LoadReceivedInvitationsImpl value,
    $Res Function(_$LoadReceivedInvitationsImpl) then,
  ) = __$$LoadReceivedInvitationsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadReceivedInvitationsImplCopyWithImpl<$Res>
    extends _$InvitationEventCopyWithImpl<$Res, _$LoadReceivedInvitationsImpl>
    implements _$$LoadReceivedInvitationsImplCopyWith<$Res> {
  __$$LoadReceivedInvitationsImplCopyWithImpl(
    _$LoadReceivedInvitationsImpl _value,
    $Res Function(_$LoadReceivedInvitationsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadReceivedInvitationsImpl implements _LoadReceivedInvitations {
  const _$LoadReceivedInvitationsImpl();

  @override
  String toString() {
    return 'InvitationEvent.loadReceivedInvitations()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadReceivedInvitationsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadSentInvitations,
    required TResult Function() loadReceivedInvitations,
    required TResult Function(InvitationStatus status) filterReceivedByStatus,
    required TResult Function(InvitationStatus status) filterSentByStatus,
    required TResult Function(String email, List<String> roles) sendInvitation,
    required TResult Function(String invitationId) cancelInvitation,
    required TResult Function(String invitationId) acceptInvitation,
    required TResult Function(String invitationId) rejectInvitation,
  }) {
    return loadReceivedInvitations();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadSentInvitations,
    TResult? Function()? loadReceivedInvitations,
    TResult? Function(InvitationStatus status)? filterReceivedByStatus,
    TResult? Function(InvitationStatus status)? filterSentByStatus,
    TResult? Function(String email, List<String> roles)? sendInvitation,
    TResult? Function(String invitationId)? cancelInvitation,
    TResult? Function(String invitationId)? acceptInvitation,
    TResult? Function(String invitationId)? rejectInvitation,
  }) {
    return loadReceivedInvitations?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadSentInvitations,
    TResult Function()? loadReceivedInvitations,
    TResult Function(InvitationStatus status)? filterReceivedByStatus,
    TResult Function(InvitationStatus status)? filterSentByStatus,
    TResult Function(String email, List<String> roles)? sendInvitation,
    TResult Function(String invitationId)? cancelInvitation,
    TResult Function(String invitationId)? acceptInvitation,
    TResult Function(String invitationId)? rejectInvitation,
    required TResult orElse(),
  }) {
    if (loadReceivedInvitations != null) {
      return loadReceivedInvitations();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSentInvitations value) loadSentInvitations,
    required TResult Function(_LoadReceivedInvitations value)
    loadReceivedInvitations,
    required TResult Function(_FilterReceivedByStatus value)
    filterReceivedByStatus,
    required TResult Function(_FilterSentByStatus value) filterSentByStatus,
    required TResult Function(_SendInvitation value) sendInvitation,
    required TResult Function(_CancelInvitation value) cancelInvitation,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_RejectInvitation value) rejectInvitation,
  }) {
    return loadReceivedInvitations(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult? Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult? Function(_FilterReceivedByStatus value)? filterReceivedByStatus,
    TResult? Function(_FilterSentByStatus value)? filterSentByStatus,
    TResult? Function(_SendInvitation value)? sendInvitation,
    TResult? Function(_CancelInvitation value)? cancelInvitation,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_RejectInvitation value)? rejectInvitation,
  }) {
    return loadReceivedInvitations?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult Function(_FilterReceivedByStatus value)? filterReceivedByStatus,
    TResult Function(_FilterSentByStatus value)? filterSentByStatus,
    TResult Function(_SendInvitation value)? sendInvitation,
    TResult Function(_CancelInvitation value)? cancelInvitation,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_RejectInvitation value)? rejectInvitation,
    required TResult orElse(),
  }) {
    if (loadReceivedInvitations != null) {
      return loadReceivedInvitations(this);
    }
    return orElse();
  }
}

abstract class _LoadReceivedInvitations implements InvitationEvent {
  const factory _LoadReceivedInvitations() = _$LoadReceivedInvitationsImpl;
}

/// @nodoc
abstract class _$$FilterReceivedByStatusImplCopyWith<$Res> {
  factory _$$FilterReceivedByStatusImplCopyWith(
    _$FilterReceivedByStatusImpl value,
    $Res Function(_$FilterReceivedByStatusImpl) then,
  ) = __$$FilterReceivedByStatusImplCopyWithImpl<$Res>;
  @useResult
  $Res call({InvitationStatus status});
}

/// @nodoc
class __$$FilterReceivedByStatusImplCopyWithImpl<$Res>
    extends _$InvitationEventCopyWithImpl<$Res, _$FilterReceivedByStatusImpl>
    implements _$$FilterReceivedByStatusImplCopyWith<$Res> {
  __$$FilterReceivedByStatusImplCopyWithImpl(
    _$FilterReceivedByStatusImpl _value,
    $Res Function(_$FilterReceivedByStatusImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null}) {
    return _then(
      _$FilterReceivedByStatusImpl(
        null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as InvitationStatus,
      ),
    );
  }
}

/// @nodoc

class _$FilterReceivedByStatusImpl implements _FilterReceivedByStatus {
  const _$FilterReceivedByStatusImpl(this.status);

  @override
  final InvitationStatus status;

  @override
  String toString() {
    return 'InvitationEvent.filterReceivedByStatus(status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterReceivedByStatusImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterReceivedByStatusImplCopyWith<_$FilterReceivedByStatusImpl>
  get copyWith =>
      __$$FilterReceivedByStatusImplCopyWithImpl<_$FilterReceivedByStatusImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadSentInvitations,
    required TResult Function() loadReceivedInvitations,
    required TResult Function(InvitationStatus status) filterReceivedByStatus,
    required TResult Function(InvitationStatus status) filterSentByStatus,
    required TResult Function(String email, List<String> roles) sendInvitation,
    required TResult Function(String invitationId) cancelInvitation,
    required TResult Function(String invitationId) acceptInvitation,
    required TResult Function(String invitationId) rejectInvitation,
  }) {
    return filterReceivedByStatus(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadSentInvitations,
    TResult? Function()? loadReceivedInvitations,
    TResult? Function(InvitationStatus status)? filterReceivedByStatus,
    TResult? Function(InvitationStatus status)? filterSentByStatus,
    TResult? Function(String email, List<String> roles)? sendInvitation,
    TResult? Function(String invitationId)? cancelInvitation,
    TResult? Function(String invitationId)? acceptInvitation,
    TResult? Function(String invitationId)? rejectInvitation,
  }) {
    return filterReceivedByStatus?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadSentInvitations,
    TResult Function()? loadReceivedInvitations,
    TResult Function(InvitationStatus status)? filterReceivedByStatus,
    TResult Function(InvitationStatus status)? filterSentByStatus,
    TResult Function(String email, List<String> roles)? sendInvitation,
    TResult Function(String invitationId)? cancelInvitation,
    TResult Function(String invitationId)? acceptInvitation,
    TResult Function(String invitationId)? rejectInvitation,
    required TResult orElse(),
  }) {
    if (filterReceivedByStatus != null) {
      return filterReceivedByStatus(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSentInvitations value) loadSentInvitations,
    required TResult Function(_LoadReceivedInvitations value)
    loadReceivedInvitations,
    required TResult Function(_FilterReceivedByStatus value)
    filterReceivedByStatus,
    required TResult Function(_FilterSentByStatus value) filterSentByStatus,
    required TResult Function(_SendInvitation value) sendInvitation,
    required TResult Function(_CancelInvitation value) cancelInvitation,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_RejectInvitation value) rejectInvitation,
  }) {
    return filterReceivedByStatus(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult? Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult? Function(_FilterReceivedByStatus value)? filterReceivedByStatus,
    TResult? Function(_FilterSentByStatus value)? filterSentByStatus,
    TResult? Function(_SendInvitation value)? sendInvitation,
    TResult? Function(_CancelInvitation value)? cancelInvitation,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_RejectInvitation value)? rejectInvitation,
  }) {
    return filterReceivedByStatus?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult Function(_FilterReceivedByStatus value)? filterReceivedByStatus,
    TResult Function(_FilterSentByStatus value)? filterSentByStatus,
    TResult Function(_SendInvitation value)? sendInvitation,
    TResult Function(_CancelInvitation value)? cancelInvitation,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_RejectInvitation value)? rejectInvitation,
    required TResult orElse(),
  }) {
    if (filterReceivedByStatus != null) {
      return filterReceivedByStatus(this);
    }
    return orElse();
  }
}

abstract class _FilterReceivedByStatus implements InvitationEvent {
  const factory _FilterReceivedByStatus(final InvitationStatus status) =
      _$FilterReceivedByStatusImpl;

  InvitationStatus get status;

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilterReceivedByStatusImplCopyWith<_$FilterReceivedByStatusImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FilterSentByStatusImplCopyWith<$Res> {
  factory _$$FilterSentByStatusImplCopyWith(
    _$FilterSentByStatusImpl value,
    $Res Function(_$FilterSentByStatusImpl) then,
  ) = __$$FilterSentByStatusImplCopyWithImpl<$Res>;
  @useResult
  $Res call({InvitationStatus status});
}

/// @nodoc
class __$$FilterSentByStatusImplCopyWithImpl<$Res>
    extends _$InvitationEventCopyWithImpl<$Res, _$FilterSentByStatusImpl>
    implements _$$FilterSentByStatusImplCopyWith<$Res> {
  __$$FilterSentByStatusImplCopyWithImpl(
    _$FilterSentByStatusImpl _value,
    $Res Function(_$FilterSentByStatusImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null}) {
    return _then(
      _$FilterSentByStatusImpl(
        null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as InvitationStatus,
      ),
    );
  }
}

/// @nodoc

class _$FilterSentByStatusImpl implements _FilterSentByStatus {
  const _$FilterSentByStatusImpl(this.status);

  @override
  final InvitationStatus status;

  @override
  String toString() {
    return 'InvitationEvent.filterSentByStatus(status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterSentByStatusImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterSentByStatusImplCopyWith<_$FilterSentByStatusImpl> get copyWith =>
      __$$FilterSentByStatusImplCopyWithImpl<_$FilterSentByStatusImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadSentInvitations,
    required TResult Function() loadReceivedInvitations,
    required TResult Function(InvitationStatus status) filterReceivedByStatus,
    required TResult Function(InvitationStatus status) filterSentByStatus,
    required TResult Function(String email, List<String> roles) sendInvitation,
    required TResult Function(String invitationId) cancelInvitation,
    required TResult Function(String invitationId) acceptInvitation,
    required TResult Function(String invitationId) rejectInvitation,
  }) {
    return filterSentByStatus(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadSentInvitations,
    TResult? Function()? loadReceivedInvitations,
    TResult? Function(InvitationStatus status)? filterReceivedByStatus,
    TResult? Function(InvitationStatus status)? filterSentByStatus,
    TResult? Function(String email, List<String> roles)? sendInvitation,
    TResult? Function(String invitationId)? cancelInvitation,
    TResult? Function(String invitationId)? acceptInvitation,
    TResult? Function(String invitationId)? rejectInvitation,
  }) {
    return filterSentByStatus?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadSentInvitations,
    TResult Function()? loadReceivedInvitations,
    TResult Function(InvitationStatus status)? filterReceivedByStatus,
    TResult Function(InvitationStatus status)? filterSentByStatus,
    TResult Function(String email, List<String> roles)? sendInvitation,
    TResult Function(String invitationId)? cancelInvitation,
    TResult Function(String invitationId)? acceptInvitation,
    TResult Function(String invitationId)? rejectInvitation,
    required TResult orElse(),
  }) {
    if (filterSentByStatus != null) {
      return filterSentByStatus(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSentInvitations value) loadSentInvitations,
    required TResult Function(_LoadReceivedInvitations value)
    loadReceivedInvitations,
    required TResult Function(_FilterReceivedByStatus value)
    filterReceivedByStatus,
    required TResult Function(_FilterSentByStatus value) filterSentByStatus,
    required TResult Function(_SendInvitation value) sendInvitation,
    required TResult Function(_CancelInvitation value) cancelInvitation,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_RejectInvitation value) rejectInvitation,
  }) {
    return filterSentByStatus(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult? Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult? Function(_FilterReceivedByStatus value)? filterReceivedByStatus,
    TResult? Function(_FilterSentByStatus value)? filterSentByStatus,
    TResult? Function(_SendInvitation value)? sendInvitation,
    TResult? Function(_CancelInvitation value)? cancelInvitation,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_RejectInvitation value)? rejectInvitation,
  }) {
    return filterSentByStatus?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult Function(_FilterReceivedByStatus value)? filterReceivedByStatus,
    TResult Function(_FilterSentByStatus value)? filterSentByStatus,
    TResult Function(_SendInvitation value)? sendInvitation,
    TResult Function(_CancelInvitation value)? cancelInvitation,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_RejectInvitation value)? rejectInvitation,
    required TResult orElse(),
  }) {
    if (filterSentByStatus != null) {
      return filterSentByStatus(this);
    }
    return orElse();
  }
}

abstract class _FilterSentByStatus implements InvitationEvent {
  const factory _FilterSentByStatus(final InvitationStatus status) =
      _$FilterSentByStatusImpl;

  InvitationStatus get status;

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilterSentByStatusImplCopyWith<_$FilterSentByStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendInvitationImplCopyWith<$Res> {
  factory _$$SendInvitationImplCopyWith(
    _$SendInvitationImpl value,
    $Res Function(_$SendInvitationImpl) then,
  ) = __$$SendInvitationImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email, List<String> roles});
}

/// @nodoc
class __$$SendInvitationImplCopyWithImpl<$Res>
    extends _$InvitationEventCopyWithImpl<$Res, _$SendInvitationImpl>
    implements _$$SendInvitationImplCopyWith<$Res> {
  __$$SendInvitationImplCopyWithImpl(
    _$SendInvitationImpl _value,
    $Res Function(_$SendInvitationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null, Object? roles = null}) {
    return _then(
      _$SendInvitationImpl(
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        roles: null == roles
            ? _value._roles
            : roles // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc

class _$SendInvitationImpl implements _SendInvitation {
  const _$SendInvitationImpl({
    required this.email,
    required final List<String> roles,
  }) : _roles = roles;

  @override
  final String email;
  final List<String> _roles;
  @override
  List<String> get roles {
    if (_roles is EqualUnmodifiableListView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roles);
  }

  @override
  String toString() {
    return 'InvitationEvent.sendInvitation(email: $email, roles: $roles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendInvitationImpl &&
            (identical(other.email, email) || other.email == email) &&
            const DeepCollectionEquality().equals(other._roles, _roles));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    email,
    const DeepCollectionEquality().hash(_roles),
  );

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendInvitationImplCopyWith<_$SendInvitationImpl> get copyWith =>
      __$$SendInvitationImplCopyWithImpl<_$SendInvitationImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadSentInvitations,
    required TResult Function() loadReceivedInvitations,
    required TResult Function(InvitationStatus status) filterReceivedByStatus,
    required TResult Function(InvitationStatus status) filterSentByStatus,
    required TResult Function(String email, List<String> roles) sendInvitation,
    required TResult Function(String invitationId) cancelInvitation,
    required TResult Function(String invitationId) acceptInvitation,
    required TResult Function(String invitationId) rejectInvitation,
  }) {
    return sendInvitation(email, roles);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadSentInvitations,
    TResult? Function()? loadReceivedInvitations,
    TResult? Function(InvitationStatus status)? filterReceivedByStatus,
    TResult? Function(InvitationStatus status)? filterSentByStatus,
    TResult? Function(String email, List<String> roles)? sendInvitation,
    TResult? Function(String invitationId)? cancelInvitation,
    TResult? Function(String invitationId)? acceptInvitation,
    TResult? Function(String invitationId)? rejectInvitation,
  }) {
    return sendInvitation?.call(email, roles);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadSentInvitations,
    TResult Function()? loadReceivedInvitations,
    TResult Function(InvitationStatus status)? filterReceivedByStatus,
    TResult Function(InvitationStatus status)? filterSentByStatus,
    TResult Function(String email, List<String> roles)? sendInvitation,
    TResult Function(String invitationId)? cancelInvitation,
    TResult Function(String invitationId)? acceptInvitation,
    TResult Function(String invitationId)? rejectInvitation,
    required TResult orElse(),
  }) {
    if (sendInvitation != null) {
      return sendInvitation(email, roles);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSentInvitations value) loadSentInvitations,
    required TResult Function(_LoadReceivedInvitations value)
    loadReceivedInvitations,
    required TResult Function(_FilterReceivedByStatus value)
    filterReceivedByStatus,
    required TResult Function(_FilterSentByStatus value) filterSentByStatus,
    required TResult Function(_SendInvitation value) sendInvitation,
    required TResult Function(_CancelInvitation value) cancelInvitation,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_RejectInvitation value) rejectInvitation,
  }) {
    return sendInvitation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult? Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult? Function(_FilterReceivedByStatus value)? filterReceivedByStatus,
    TResult? Function(_FilterSentByStatus value)? filterSentByStatus,
    TResult? Function(_SendInvitation value)? sendInvitation,
    TResult? Function(_CancelInvitation value)? cancelInvitation,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_RejectInvitation value)? rejectInvitation,
  }) {
    return sendInvitation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult Function(_FilterReceivedByStatus value)? filterReceivedByStatus,
    TResult Function(_FilterSentByStatus value)? filterSentByStatus,
    TResult Function(_SendInvitation value)? sendInvitation,
    TResult Function(_CancelInvitation value)? cancelInvitation,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_RejectInvitation value)? rejectInvitation,
    required TResult orElse(),
  }) {
    if (sendInvitation != null) {
      return sendInvitation(this);
    }
    return orElse();
  }
}

abstract class _SendInvitation implements InvitationEvent {
  const factory _SendInvitation({
    required final String email,
    required final List<String> roles,
  }) = _$SendInvitationImpl;

  String get email;
  List<String> get roles;

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendInvitationImplCopyWith<_$SendInvitationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CancelInvitationImplCopyWith<$Res> {
  factory _$$CancelInvitationImplCopyWith(
    _$CancelInvitationImpl value,
    $Res Function(_$CancelInvitationImpl) then,
  ) = __$$CancelInvitationImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String invitationId});
}

/// @nodoc
class __$$CancelInvitationImplCopyWithImpl<$Res>
    extends _$InvitationEventCopyWithImpl<$Res, _$CancelInvitationImpl>
    implements _$$CancelInvitationImplCopyWith<$Res> {
  __$$CancelInvitationImplCopyWithImpl(
    _$CancelInvitationImpl _value,
    $Res Function(_$CancelInvitationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? invitationId = null}) {
    return _then(
      _$CancelInvitationImpl(
        null == invitationId
            ? _value.invitationId
            : invitationId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$CancelInvitationImpl implements _CancelInvitation {
  const _$CancelInvitationImpl(this.invitationId);

  @override
  final String invitationId;

  @override
  String toString() {
    return 'InvitationEvent.cancelInvitation(invitationId: $invitationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CancelInvitationImpl &&
            (identical(other.invitationId, invitationId) ||
                other.invitationId == invitationId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, invitationId);

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CancelInvitationImplCopyWith<_$CancelInvitationImpl> get copyWith =>
      __$$CancelInvitationImplCopyWithImpl<_$CancelInvitationImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadSentInvitations,
    required TResult Function() loadReceivedInvitations,
    required TResult Function(InvitationStatus status) filterReceivedByStatus,
    required TResult Function(InvitationStatus status) filterSentByStatus,
    required TResult Function(String email, List<String> roles) sendInvitation,
    required TResult Function(String invitationId) cancelInvitation,
    required TResult Function(String invitationId) acceptInvitation,
    required TResult Function(String invitationId) rejectInvitation,
  }) {
    return cancelInvitation(invitationId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadSentInvitations,
    TResult? Function()? loadReceivedInvitations,
    TResult? Function(InvitationStatus status)? filterReceivedByStatus,
    TResult? Function(InvitationStatus status)? filterSentByStatus,
    TResult? Function(String email, List<String> roles)? sendInvitation,
    TResult? Function(String invitationId)? cancelInvitation,
    TResult? Function(String invitationId)? acceptInvitation,
    TResult? Function(String invitationId)? rejectInvitation,
  }) {
    return cancelInvitation?.call(invitationId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadSentInvitations,
    TResult Function()? loadReceivedInvitations,
    TResult Function(InvitationStatus status)? filterReceivedByStatus,
    TResult Function(InvitationStatus status)? filterSentByStatus,
    TResult Function(String email, List<String> roles)? sendInvitation,
    TResult Function(String invitationId)? cancelInvitation,
    TResult Function(String invitationId)? acceptInvitation,
    TResult Function(String invitationId)? rejectInvitation,
    required TResult orElse(),
  }) {
    if (cancelInvitation != null) {
      return cancelInvitation(invitationId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSentInvitations value) loadSentInvitations,
    required TResult Function(_LoadReceivedInvitations value)
    loadReceivedInvitations,
    required TResult Function(_FilterReceivedByStatus value)
    filterReceivedByStatus,
    required TResult Function(_FilterSentByStatus value) filterSentByStatus,
    required TResult Function(_SendInvitation value) sendInvitation,
    required TResult Function(_CancelInvitation value) cancelInvitation,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_RejectInvitation value) rejectInvitation,
  }) {
    return cancelInvitation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult? Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult? Function(_FilterReceivedByStatus value)? filterReceivedByStatus,
    TResult? Function(_FilterSentByStatus value)? filterSentByStatus,
    TResult? Function(_SendInvitation value)? sendInvitation,
    TResult? Function(_CancelInvitation value)? cancelInvitation,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_RejectInvitation value)? rejectInvitation,
  }) {
    return cancelInvitation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult Function(_FilterReceivedByStatus value)? filterReceivedByStatus,
    TResult Function(_FilterSentByStatus value)? filterSentByStatus,
    TResult Function(_SendInvitation value)? sendInvitation,
    TResult Function(_CancelInvitation value)? cancelInvitation,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_RejectInvitation value)? rejectInvitation,
    required TResult orElse(),
  }) {
    if (cancelInvitation != null) {
      return cancelInvitation(this);
    }
    return orElse();
  }
}

abstract class _CancelInvitation implements InvitationEvent {
  const factory _CancelInvitation(final String invitationId) =
      _$CancelInvitationImpl;

  String get invitationId;

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CancelInvitationImplCopyWith<_$CancelInvitationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AcceptInvitationImplCopyWith<$Res> {
  factory _$$AcceptInvitationImplCopyWith(
    _$AcceptInvitationImpl value,
    $Res Function(_$AcceptInvitationImpl) then,
  ) = __$$AcceptInvitationImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String invitationId});
}

/// @nodoc
class __$$AcceptInvitationImplCopyWithImpl<$Res>
    extends _$InvitationEventCopyWithImpl<$Res, _$AcceptInvitationImpl>
    implements _$$AcceptInvitationImplCopyWith<$Res> {
  __$$AcceptInvitationImplCopyWithImpl(
    _$AcceptInvitationImpl _value,
    $Res Function(_$AcceptInvitationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? invitationId = null}) {
    return _then(
      _$AcceptInvitationImpl(
        null == invitationId
            ? _value.invitationId
            : invitationId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AcceptInvitationImpl implements _AcceptInvitation {
  const _$AcceptInvitationImpl(this.invitationId);

  @override
  final String invitationId;

  @override
  String toString() {
    return 'InvitationEvent.acceptInvitation(invitationId: $invitationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AcceptInvitationImpl &&
            (identical(other.invitationId, invitationId) ||
                other.invitationId == invitationId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, invitationId);

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AcceptInvitationImplCopyWith<_$AcceptInvitationImpl> get copyWith =>
      __$$AcceptInvitationImplCopyWithImpl<_$AcceptInvitationImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadSentInvitations,
    required TResult Function() loadReceivedInvitations,
    required TResult Function(InvitationStatus status) filterReceivedByStatus,
    required TResult Function(InvitationStatus status) filterSentByStatus,
    required TResult Function(String email, List<String> roles) sendInvitation,
    required TResult Function(String invitationId) cancelInvitation,
    required TResult Function(String invitationId) acceptInvitation,
    required TResult Function(String invitationId) rejectInvitation,
  }) {
    return acceptInvitation(invitationId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadSentInvitations,
    TResult? Function()? loadReceivedInvitations,
    TResult? Function(InvitationStatus status)? filterReceivedByStatus,
    TResult? Function(InvitationStatus status)? filterSentByStatus,
    TResult? Function(String email, List<String> roles)? sendInvitation,
    TResult? Function(String invitationId)? cancelInvitation,
    TResult? Function(String invitationId)? acceptInvitation,
    TResult? Function(String invitationId)? rejectInvitation,
  }) {
    return acceptInvitation?.call(invitationId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadSentInvitations,
    TResult Function()? loadReceivedInvitations,
    TResult Function(InvitationStatus status)? filterReceivedByStatus,
    TResult Function(InvitationStatus status)? filterSentByStatus,
    TResult Function(String email, List<String> roles)? sendInvitation,
    TResult Function(String invitationId)? cancelInvitation,
    TResult Function(String invitationId)? acceptInvitation,
    TResult Function(String invitationId)? rejectInvitation,
    required TResult orElse(),
  }) {
    if (acceptInvitation != null) {
      return acceptInvitation(invitationId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSentInvitations value) loadSentInvitations,
    required TResult Function(_LoadReceivedInvitations value)
    loadReceivedInvitations,
    required TResult Function(_FilterReceivedByStatus value)
    filterReceivedByStatus,
    required TResult Function(_FilterSentByStatus value) filterSentByStatus,
    required TResult Function(_SendInvitation value) sendInvitation,
    required TResult Function(_CancelInvitation value) cancelInvitation,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_RejectInvitation value) rejectInvitation,
  }) {
    return acceptInvitation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult? Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult? Function(_FilterReceivedByStatus value)? filterReceivedByStatus,
    TResult? Function(_FilterSentByStatus value)? filterSentByStatus,
    TResult? Function(_SendInvitation value)? sendInvitation,
    TResult? Function(_CancelInvitation value)? cancelInvitation,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_RejectInvitation value)? rejectInvitation,
  }) {
    return acceptInvitation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult Function(_FilterReceivedByStatus value)? filterReceivedByStatus,
    TResult Function(_FilterSentByStatus value)? filterSentByStatus,
    TResult Function(_SendInvitation value)? sendInvitation,
    TResult Function(_CancelInvitation value)? cancelInvitation,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_RejectInvitation value)? rejectInvitation,
    required TResult orElse(),
  }) {
    if (acceptInvitation != null) {
      return acceptInvitation(this);
    }
    return orElse();
  }
}

abstract class _AcceptInvitation implements InvitationEvent {
  const factory _AcceptInvitation(final String invitationId) =
      _$AcceptInvitationImpl;

  String get invitationId;

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AcceptInvitationImplCopyWith<_$AcceptInvitationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RejectInvitationImplCopyWith<$Res> {
  factory _$$RejectInvitationImplCopyWith(
    _$RejectInvitationImpl value,
    $Res Function(_$RejectInvitationImpl) then,
  ) = __$$RejectInvitationImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String invitationId});
}

/// @nodoc
class __$$RejectInvitationImplCopyWithImpl<$Res>
    extends _$InvitationEventCopyWithImpl<$Res, _$RejectInvitationImpl>
    implements _$$RejectInvitationImplCopyWith<$Res> {
  __$$RejectInvitationImplCopyWithImpl(
    _$RejectInvitationImpl _value,
    $Res Function(_$RejectInvitationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? invitationId = null}) {
    return _then(
      _$RejectInvitationImpl(
        null == invitationId
            ? _value.invitationId
            : invitationId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$RejectInvitationImpl implements _RejectInvitation {
  const _$RejectInvitationImpl(this.invitationId);

  @override
  final String invitationId;

  @override
  String toString() {
    return 'InvitationEvent.rejectInvitation(invitationId: $invitationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RejectInvitationImpl &&
            (identical(other.invitationId, invitationId) ||
                other.invitationId == invitationId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, invitationId);

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RejectInvitationImplCopyWith<_$RejectInvitationImpl> get copyWith =>
      __$$RejectInvitationImplCopyWithImpl<_$RejectInvitationImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadSentInvitations,
    required TResult Function() loadReceivedInvitations,
    required TResult Function(InvitationStatus status) filterReceivedByStatus,
    required TResult Function(InvitationStatus status) filterSentByStatus,
    required TResult Function(String email, List<String> roles) sendInvitation,
    required TResult Function(String invitationId) cancelInvitation,
    required TResult Function(String invitationId) acceptInvitation,
    required TResult Function(String invitationId) rejectInvitation,
  }) {
    return rejectInvitation(invitationId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadSentInvitations,
    TResult? Function()? loadReceivedInvitations,
    TResult? Function(InvitationStatus status)? filterReceivedByStatus,
    TResult? Function(InvitationStatus status)? filterSentByStatus,
    TResult? Function(String email, List<String> roles)? sendInvitation,
    TResult? Function(String invitationId)? cancelInvitation,
    TResult? Function(String invitationId)? acceptInvitation,
    TResult? Function(String invitationId)? rejectInvitation,
  }) {
    return rejectInvitation?.call(invitationId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadSentInvitations,
    TResult Function()? loadReceivedInvitations,
    TResult Function(InvitationStatus status)? filterReceivedByStatus,
    TResult Function(InvitationStatus status)? filterSentByStatus,
    TResult Function(String email, List<String> roles)? sendInvitation,
    TResult Function(String invitationId)? cancelInvitation,
    TResult Function(String invitationId)? acceptInvitation,
    TResult Function(String invitationId)? rejectInvitation,
    required TResult orElse(),
  }) {
    if (rejectInvitation != null) {
      return rejectInvitation(invitationId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSentInvitations value) loadSentInvitations,
    required TResult Function(_LoadReceivedInvitations value)
    loadReceivedInvitations,
    required TResult Function(_FilterReceivedByStatus value)
    filterReceivedByStatus,
    required TResult Function(_FilterSentByStatus value) filterSentByStatus,
    required TResult Function(_SendInvitation value) sendInvitation,
    required TResult Function(_CancelInvitation value) cancelInvitation,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_RejectInvitation value) rejectInvitation,
  }) {
    return rejectInvitation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult? Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult? Function(_FilterReceivedByStatus value)? filterReceivedByStatus,
    TResult? Function(_FilterSentByStatus value)? filterSentByStatus,
    TResult? Function(_SendInvitation value)? sendInvitation,
    TResult? Function(_CancelInvitation value)? cancelInvitation,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_RejectInvitation value)? rejectInvitation,
  }) {
    return rejectInvitation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult Function(_FilterReceivedByStatus value)? filterReceivedByStatus,
    TResult Function(_FilterSentByStatus value)? filterSentByStatus,
    TResult Function(_SendInvitation value)? sendInvitation,
    TResult Function(_CancelInvitation value)? cancelInvitation,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_RejectInvitation value)? rejectInvitation,
    required TResult orElse(),
  }) {
    if (rejectInvitation != null) {
      return rejectInvitation(this);
    }
    return orElse();
  }
}

abstract class _RejectInvitation implements InvitationEvent {
  const factory _RejectInvitation(final String invitationId) =
      _$RejectInvitationImpl;

  String get invitationId;

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RejectInvitationImplCopyWith<_$RejectInvitationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$InvitationState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isSending => throw _privateConstructorUsedError;
  bool get isUpdating => throw _privateConstructorUsedError;
  List<InvitationEntity> get sentInvitations =>
      throw _privateConstructorUsedError;
  List<InvitationEntity> get receivedInvitations =>
      throw _privateConstructorUsedError;
  InvitationStatus get receivedFilter => throw _privateConstructorUsedError;
  InvitationStatus get sentFilter => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError; // Invite form fields
  String get inviteeEmail => throw _privateConstructorUsedError;
  ClinicRole get inviteeRole => throw _privateConstructorUsedError;
  String get inviteMessage =>
      throw _privateConstructorUsedError; // Success flags
  bool get sendSuccess => throw _privateConstructorUsedError;
  bool get cancelSuccess => throw _privateConstructorUsedError;
  bool get acceptSuccess => throw _privateConstructorUsedError;
  bool get rejectSuccess => throw _privateConstructorUsedError;

  /// Create a copy of InvitationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InvitationStateCopyWith<InvitationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvitationStateCopyWith<$Res> {
  factory $InvitationStateCopyWith(
    InvitationState value,
    $Res Function(InvitationState) then,
  ) = _$InvitationStateCopyWithImpl<$Res, InvitationState>;
  @useResult
  $Res call({
    bool isLoading,
    bool isSending,
    bool isUpdating,
    List<InvitationEntity> sentInvitations,
    List<InvitationEntity> receivedInvitations,
    InvitationStatus receivedFilter,
    InvitationStatus sentFilter,
    String? error,
    String inviteeEmail,
    ClinicRole inviteeRole,
    String inviteMessage,
    bool sendSuccess,
    bool cancelSuccess,
    bool acceptSuccess,
    bool rejectSuccess,
  });
}

/// @nodoc
class _$InvitationStateCopyWithImpl<$Res, $Val extends InvitationState>
    implements $InvitationStateCopyWith<$Res> {
  _$InvitationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InvitationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isSending = null,
    Object? isUpdating = null,
    Object? sentInvitations = null,
    Object? receivedInvitations = null,
    Object? receivedFilter = null,
    Object? sentFilter = null,
    Object? error = freezed,
    Object? inviteeEmail = null,
    Object? inviteeRole = null,
    Object? inviteMessage = null,
    Object? sendSuccess = null,
    Object? cancelSuccess = null,
    Object? acceptSuccess = null,
    Object? rejectSuccess = null,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSending: null == isSending
                ? _value.isSending
                : isSending // ignore: cast_nullable_to_non_nullable
                      as bool,
            isUpdating: null == isUpdating
                ? _value.isUpdating
                : isUpdating // ignore: cast_nullable_to_non_nullable
                      as bool,
            sentInvitations: null == sentInvitations
                ? _value.sentInvitations
                : sentInvitations // ignore: cast_nullable_to_non_nullable
                      as List<InvitationEntity>,
            receivedInvitations: null == receivedInvitations
                ? _value.receivedInvitations
                : receivedInvitations // ignore: cast_nullable_to_non_nullable
                      as List<InvitationEntity>,
            receivedFilter: null == receivedFilter
                ? _value.receivedFilter
                : receivedFilter // ignore: cast_nullable_to_non_nullable
                      as InvitationStatus,
            sentFilter: null == sentFilter
                ? _value.sentFilter
                : sentFilter // ignore: cast_nullable_to_non_nullable
                      as InvitationStatus,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
            inviteeEmail: null == inviteeEmail
                ? _value.inviteeEmail
                : inviteeEmail // ignore: cast_nullable_to_non_nullable
                      as String,
            inviteeRole: null == inviteeRole
                ? _value.inviteeRole
                : inviteeRole // ignore: cast_nullable_to_non_nullable
                      as ClinicRole,
            inviteMessage: null == inviteMessage
                ? _value.inviteMessage
                : inviteMessage // ignore: cast_nullable_to_non_nullable
                      as String,
            sendSuccess: null == sendSuccess
                ? _value.sendSuccess
                : sendSuccess // ignore: cast_nullable_to_non_nullable
                      as bool,
            cancelSuccess: null == cancelSuccess
                ? _value.cancelSuccess
                : cancelSuccess // ignore: cast_nullable_to_non_nullable
                      as bool,
            acceptSuccess: null == acceptSuccess
                ? _value.acceptSuccess
                : acceptSuccess // ignore: cast_nullable_to_non_nullable
                      as bool,
            rejectSuccess: null == rejectSuccess
                ? _value.rejectSuccess
                : rejectSuccess // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InvitationStateImplCopyWith<$Res>
    implements $InvitationStateCopyWith<$Res> {
  factory _$$InvitationStateImplCopyWith(
    _$InvitationStateImpl value,
    $Res Function(_$InvitationStateImpl) then,
  ) = __$$InvitationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    bool isSending,
    bool isUpdating,
    List<InvitationEntity> sentInvitations,
    List<InvitationEntity> receivedInvitations,
    InvitationStatus receivedFilter,
    InvitationStatus sentFilter,
    String? error,
    String inviteeEmail,
    ClinicRole inviteeRole,
    String inviteMessage,
    bool sendSuccess,
    bool cancelSuccess,
    bool acceptSuccess,
    bool rejectSuccess,
  });
}

/// @nodoc
class __$$InvitationStateImplCopyWithImpl<$Res>
    extends _$InvitationStateCopyWithImpl<$Res, _$InvitationStateImpl>
    implements _$$InvitationStateImplCopyWith<$Res> {
  __$$InvitationStateImplCopyWithImpl(
    _$InvitationStateImpl _value,
    $Res Function(_$InvitationStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InvitationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isSending = null,
    Object? isUpdating = null,
    Object? sentInvitations = null,
    Object? receivedInvitations = null,
    Object? receivedFilter = null,
    Object? sentFilter = null,
    Object? error = freezed,
    Object? inviteeEmail = null,
    Object? inviteeRole = null,
    Object? inviteMessage = null,
    Object? sendSuccess = null,
    Object? cancelSuccess = null,
    Object? acceptSuccess = null,
    Object? rejectSuccess = null,
  }) {
    return _then(
      _$InvitationStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSending: null == isSending
            ? _value.isSending
            : isSending // ignore: cast_nullable_to_non_nullable
                  as bool,
        isUpdating: null == isUpdating
            ? _value.isUpdating
            : isUpdating // ignore: cast_nullable_to_non_nullable
                  as bool,
        sentInvitations: null == sentInvitations
            ? _value._sentInvitations
            : sentInvitations // ignore: cast_nullable_to_non_nullable
                  as List<InvitationEntity>,
        receivedInvitations: null == receivedInvitations
            ? _value._receivedInvitations
            : receivedInvitations // ignore: cast_nullable_to_non_nullable
                  as List<InvitationEntity>,
        receivedFilter: null == receivedFilter
            ? _value.receivedFilter
            : receivedFilter // ignore: cast_nullable_to_non_nullable
                  as InvitationStatus,
        sentFilter: null == sentFilter
            ? _value.sentFilter
            : sentFilter // ignore: cast_nullable_to_non_nullable
                  as InvitationStatus,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        inviteeEmail: null == inviteeEmail
            ? _value.inviteeEmail
            : inviteeEmail // ignore: cast_nullable_to_non_nullable
                  as String,
        inviteeRole: null == inviteeRole
            ? _value.inviteeRole
            : inviteeRole // ignore: cast_nullable_to_non_nullable
                  as ClinicRole,
        inviteMessage: null == inviteMessage
            ? _value.inviteMessage
            : inviteMessage // ignore: cast_nullable_to_non_nullable
                  as String,
        sendSuccess: null == sendSuccess
            ? _value.sendSuccess
            : sendSuccess // ignore: cast_nullable_to_non_nullable
                  as bool,
        cancelSuccess: null == cancelSuccess
            ? _value.cancelSuccess
            : cancelSuccess // ignore: cast_nullable_to_non_nullable
                  as bool,
        acceptSuccess: null == acceptSuccess
            ? _value.acceptSuccess
            : acceptSuccess // ignore: cast_nullable_to_non_nullable
                  as bool,
        rejectSuccess: null == rejectSuccess
            ? _value.rejectSuccess
            : rejectSuccess // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$InvitationStateImpl implements _InvitationState {
  const _$InvitationStateImpl({
    this.isLoading = false,
    this.isSending = false,
    this.isUpdating = false,
    final List<InvitationEntity> sentInvitations = const [],
    final List<InvitationEntity> receivedInvitations = const [],
    this.receivedFilter = InvitationStatus.pending,
    this.sentFilter = InvitationStatus.pending,
    this.error,
    this.inviteeEmail = '',
    this.inviteeRole = ClinicRole.dentist,
    this.inviteMessage = '',
    this.sendSuccess = false,
    this.cancelSuccess = false,
    this.acceptSuccess = false,
    this.rejectSuccess = false,
  }) : _sentInvitations = sentInvitations,
       _receivedInvitations = receivedInvitations;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isSending;
  @override
  @JsonKey()
  final bool isUpdating;
  final List<InvitationEntity> _sentInvitations;
  @override
  @JsonKey()
  List<InvitationEntity> get sentInvitations {
    if (_sentInvitations is EqualUnmodifiableListView) return _sentInvitations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sentInvitations);
  }

  final List<InvitationEntity> _receivedInvitations;
  @override
  @JsonKey()
  List<InvitationEntity> get receivedInvitations {
    if (_receivedInvitations is EqualUnmodifiableListView)
      return _receivedInvitations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_receivedInvitations);
  }

  @override
  @JsonKey()
  final InvitationStatus receivedFilter;
  @override
  @JsonKey()
  final InvitationStatus sentFilter;
  @override
  final String? error;
  // Invite form fields
  @override
  @JsonKey()
  final String inviteeEmail;
  @override
  @JsonKey()
  final ClinicRole inviteeRole;
  @override
  @JsonKey()
  final String inviteMessage;
  // Success flags
  @override
  @JsonKey()
  final bool sendSuccess;
  @override
  @JsonKey()
  final bool cancelSuccess;
  @override
  @JsonKey()
  final bool acceptSuccess;
  @override
  @JsonKey()
  final bool rejectSuccess;

  @override
  String toString() {
    return 'InvitationState(isLoading: $isLoading, isSending: $isSending, isUpdating: $isUpdating, sentInvitations: $sentInvitations, receivedInvitations: $receivedInvitations, receivedFilter: $receivedFilter, sentFilter: $sentFilter, error: $error, inviteeEmail: $inviteeEmail, inviteeRole: $inviteeRole, inviteMessage: $inviteMessage, sendSuccess: $sendSuccess, cancelSuccess: $cancelSuccess, acceptSuccess: $acceptSuccess, rejectSuccess: $rejectSuccess)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvitationStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSending, isSending) ||
                other.isSending == isSending) &&
            (identical(other.isUpdating, isUpdating) ||
                other.isUpdating == isUpdating) &&
            const DeepCollectionEquality().equals(
              other._sentInvitations,
              _sentInvitations,
            ) &&
            const DeepCollectionEquality().equals(
              other._receivedInvitations,
              _receivedInvitations,
            ) &&
            (identical(other.receivedFilter, receivedFilter) ||
                other.receivedFilter == receivedFilter) &&
            (identical(other.sentFilter, sentFilter) ||
                other.sentFilter == sentFilter) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.inviteeEmail, inviteeEmail) ||
                other.inviteeEmail == inviteeEmail) &&
            (identical(other.inviteeRole, inviteeRole) ||
                other.inviteeRole == inviteeRole) &&
            (identical(other.inviteMessage, inviteMessage) ||
                other.inviteMessage == inviteMessage) &&
            (identical(other.sendSuccess, sendSuccess) ||
                other.sendSuccess == sendSuccess) &&
            (identical(other.cancelSuccess, cancelSuccess) ||
                other.cancelSuccess == cancelSuccess) &&
            (identical(other.acceptSuccess, acceptSuccess) ||
                other.acceptSuccess == acceptSuccess) &&
            (identical(other.rejectSuccess, rejectSuccess) ||
                other.rejectSuccess == rejectSuccess));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    isSending,
    isUpdating,
    const DeepCollectionEquality().hash(_sentInvitations),
    const DeepCollectionEquality().hash(_receivedInvitations),
    receivedFilter,
    sentFilter,
    error,
    inviteeEmail,
    inviteeRole,
    inviteMessage,
    sendSuccess,
    cancelSuccess,
    acceptSuccess,
    rejectSuccess,
  );

  /// Create a copy of InvitationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvitationStateImplCopyWith<_$InvitationStateImpl> get copyWith =>
      __$$InvitationStateImplCopyWithImpl<_$InvitationStateImpl>(
        this,
        _$identity,
      );
}

abstract class _InvitationState implements InvitationState {
  const factory _InvitationState({
    final bool isLoading,
    final bool isSending,
    final bool isUpdating,
    final List<InvitationEntity> sentInvitations,
    final List<InvitationEntity> receivedInvitations,
    final InvitationStatus receivedFilter,
    final InvitationStatus sentFilter,
    final String? error,
    final String inviteeEmail,
    final ClinicRole inviteeRole,
    final String inviteMessage,
    final bool sendSuccess,
    final bool cancelSuccess,
    final bool acceptSuccess,
    final bool rejectSuccess,
  }) = _$InvitationStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isSending;
  @override
  bool get isUpdating;
  @override
  List<InvitationEntity> get sentInvitations;
  @override
  List<InvitationEntity> get receivedInvitations;
  @override
  InvitationStatus get receivedFilter;
  @override
  InvitationStatus get sentFilter;
  @override
  String? get error; // Invite form fields
  @override
  String get inviteeEmail;
  @override
  ClinicRole get inviteeRole;
  @override
  String get inviteMessage; // Success flags
  @override
  bool get sendSuccess;
  @override
  bool get cancelSuccess;
  @override
  bool get acceptSuccess;
  @override
  bool get rejectSuccess;

  /// Create a copy of InvitationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvitationStateImplCopyWith<_$InvitationStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
