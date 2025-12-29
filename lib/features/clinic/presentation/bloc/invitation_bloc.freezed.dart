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
    required TResult Function(String clinicId) loadSentInvitations,
    required TResult Function(String userEmail) loadReceivedInvitations,
    required TResult Function(String clinicId, String clinicName)
    sendInvitation,
    required TResult Function(String invitationId) cancelInvitation,
    required TResult Function(String invitationId) acceptInvitation,
    required TResult Function(String invitationId) rejectInvitation,
    required TResult Function(String email) updateInviteeEmail,
    required TResult Function(ClinicRole role) updateInviteeRole,
    required TResult Function(String message) updateInviteMessage,
    required TResult Function() resetInviteForm,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String clinicId)? loadSentInvitations,
    TResult? Function(String userEmail)? loadReceivedInvitations,
    TResult? Function(String clinicId, String clinicName)? sendInvitation,
    TResult? Function(String invitationId)? cancelInvitation,
    TResult? Function(String invitationId)? acceptInvitation,
    TResult? Function(String invitationId)? rejectInvitation,
    TResult? Function(String email)? updateInviteeEmail,
    TResult? Function(ClinicRole role)? updateInviteeRole,
    TResult? Function(String message)? updateInviteMessage,
    TResult? Function()? resetInviteForm,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String clinicId)? loadSentInvitations,
    TResult Function(String userEmail)? loadReceivedInvitations,
    TResult Function(String clinicId, String clinicName)? sendInvitation,
    TResult Function(String invitationId)? cancelInvitation,
    TResult Function(String invitationId)? acceptInvitation,
    TResult Function(String invitationId)? rejectInvitation,
    TResult Function(String email)? updateInviteeEmail,
    TResult Function(ClinicRole role)? updateInviteeRole,
    TResult Function(String message)? updateInviteMessage,
    TResult Function()? resetInviteForm,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSentInvitations value) loadSentInvitations,
    required TResult Function(_LoadReceivedInvitations value)
    loadReceivedInvitations,
    required TResult Function(_SendInvitation value) sendInvitation,
    required TResult Function(_CancelInvitation value) cancelInvitation,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_RejectInvitation value) rejectInvitation,
    required TResult Function(_UpdateInviteeEmail value) updateInviteeEmail,
    required TResult Function(_UpdateInviteeRole value) updateInviteeRole,
    required TResult Function(_UpdateInviteMessage value) updateInviteMessage,
    required TResult Function(_ResetInviteForm value) resetInviteForm,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult? Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult? Function(_SendInvitation value)? sendInvitation,
    TResult? Function(_CancelInvitation value)? cancelInvitation,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_RejectInvitation value)? rejectInvitation,
    TResult? Function(_UpdateInviteeEmail value)? updateInviteeEmail,
    TResult? Function(_UpdateInviteeRole value)? updateInviteeRole,
    TResult? Function(_UpdateInviteMessage value)? updateInviteMessage,
    TResult? Function(_ResetInviteForm value)? resetInviteForm,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult Function(_SendInvitation value)? sendInvitation,
    TResult Function(_CancelInvitation value)? cancelInvitation,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_RejectInvitation value)? rejectInvitation,
    TResult Function(_UpdateInviteeEmail value)? updateInviteeEmail,
    TResult Function(_UpdateInviteeRole value)? updateInviteeRole,
    TResult Function(_UpdateInviteMessage value)? updateInviteMessage,
    TResult Function(_ResetInviteForm value)? resetInviteForm,
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
  @useResult
  $Res call({String clinicId});
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
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? clinicId = null}) {
    return _then(
      _$LoadSentInvitationsImpl(
        null == clinicId
            ? _value.clinicId
            : clinicId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LoadSentInvitationsImpl implements _LoadSentInvitations {
  const _$LoadSentInvitationsImpl(this.clinicId);

  @override
  final String clinicId;

  @override
  String toString() {
    return 'InvitationEvent.loadSentInvitations(clinicId: $clinicId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadSentInvitationsImpl &&
            (identical(other.clinicId, clinicId) ||
                other.clinicId == clinicId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, clinicId);

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadSentInvitationsImplCopyWith<_$LoadSentInvitationsImpl> get copyWith =>
      __$$LoadSentInvitationsImplCopyWithImpl<_$LoadSentInvitationsImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String clinicId) loadSentInvitations,
    required TResult Function(String userEmail) loadReceivedInvitations,
    required TResult Function(String clinicId, String clinicName)
    sendInvitation,
    required TResult Function(String invitationId) cancelInvitation,
    required TResult Function(String invitationId) acceptInvitation,
    required TResult Function(String invitationId) rejectInvitation,
    required TResult Function(String email) updateInviteeEmail,
    required TResult Function(ClinicRole role) updateInviteeRole,
    required TResult Function(String message) updateInviteMessage,
    required TResult Function() resetInviteForm,
  }) {
    return loadSentInvitations(clinicId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String clinicId)? loadSentInvitations,
    TResult? Function(String userEmail)? loadReceivedInvitations,
    TResult? Function(String clinicId, String clinicName)? sendInvitation,
    TResult? Function(String invitationId)? cancelInvitation,
    TResult? Function(String invitationId)? acceptInvitation,
    TResult? Function(String invitationId)? rejectInvitation,
    TResult? Function(String email)? updateInviteeEmail,
    TResult? Function(ClinicRole role)? updateInviteeRole,
    TResult? Function(String message)? updateInviteMessage,
    TResult? Function()? resetInviteForm,
  }) {
    return loadSentInvitations?.call(clinicId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String clinicId)? loadSentInvitations,
    TResult Function(String userEmail)? loadReceivedInvitations,
    TResult Function(String clinicId, String clinicName)? sendInvitation,
    TResult Function(String invitationId)? cancelInvitation,
    TResult Function(String invitationId)? acceptInvitation,
    TResult Function(String invitationId)? rejectInvitation,
    TResult Function(String email)? updateInviteeEmail,
    TResult Function(ClinicRole role)? updateInviteeRole,
    TResult Function(String message)? updateInviteMessage,
    TResult Function()? resetInviteForm,
    required TResult orElse(),
  }) {
    if (loadSentInvitations != null) {
      return loadSentInvitations(clinicId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSentInvitations value) loadSentInvitations,
    required TResult Function(_LoadReceivedInvitations value)
    loadReceivedInvitations,
    required TResult Function(_SendInvitation value) sendInvitation,
    required TResult Function(_CancelInvitation value) cancelInvitation,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_RejectInvitation value) rejectInvitation,
    required TResult Function(_UpdateInviteeEmail value) updateInviteeEmail,
    required TResult Function(_UpdateInviteeRole value) updateInviteeRole,
    required TResult Function(_UpdateInviteMessage value) updateInviteMessage,
    required TResult Function(_ResetInviteForm value) resetInviteForm,
  }) {
    return loadSentInvitations(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult? Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult? Function(_SendInvitation value)? sendInvitation,
    TResult? Function(_CancelInvitation value)? cancelInvitation,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_RejectInvitation value)? rejectInvitation,
    TResult? Function(_UpdateInviteeEmail value)? updateInviteeEmail,
    TResult? Function(_UpdateInviteeRole value)? updateInviteeRole,
    TResult? Function(_UpdateInviteMessage value)? updateInviteMessage,
    TResult? Function(_ResetInviteForm value)? resetInviteForm,
  }) {
    return loadSentInvitations?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult Function(_SendInvitation value)? sendInvitation,
    TResult Function(_CancelInvitation value)? cancelInvitation,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_RejectInvitation value)? rejectInvitation,
    TResult Function(_UpdateInviteeEmail value)? updateInviteeEmail,
    TResult Function(_UpdateInviteeRole value)? updateInviteeRole,
    TResult Function(_UpdateInviteMessage value)? updateInviteMessage,
    TResult Function(_ResetInviteForm value)? resetInviteForm,
    required TResult orElse(),
  }) {
    if (loadSentInvitations != null) {
      return loadSentInvitations(this);
    }
    return orElse();
  }
}

abstract class _LoadSentInvitations implements InvitationEvent {
  const factory _LoadSentInvitations(final String clinicId) =
      _$LoadSentInvitationsImpl;

  String get clinicId;

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadSentInvitationsImplCopyWith<_$LoadSentInvitationsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadReceivedInvitationsImplCopyWith<$Res> {
  factory _$$LoadReceivedInvitationsImplCopyWith(
    _$LoadReceivedInvitationsImpl value,
    $Res Function(_$LoadReceivedInvitationsImpl) then,
  ) = __$$LoadReceivedInvitationsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userEmail});
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
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? userEmail = null}) {
    return _then(
      _$LoadReceivedInvitationsImpl(
        null == userEmail
            ? _value.userEmail
            : userEmail // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LoadReceivedInvitationsImpl implements _LoadReceivedInvitations {
  const _$LoadReceivedInvitationsImpl(this.userEmail);

  @override
  final String userEmail;

  @override
  String toString() {
    return 'InvitationEvent.loadReceivedInvitations(userEmail: $userEmail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadReceivedInvitationsImpl &&
            (identical(other.userEmail, userEmail) ||
                other.userEmail == userEmail));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userEmail);

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadReceivedInvitationsImplCopyWith<_$LoadReceivedInvitationsImpl>
  get copyWith =>
      __$$LoadReceivedInvitationsImplCopyWithImpl<
        _$LoadReceivedInvitationsImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String clinicId) loadSentInvitations,
    required TResult Function(String userEmail) loadReceivedInvitations,
    required TResult Function(String clinicId, String clinicName)
    sendInvitation,
    required TResult Function(String invitationId) cancelInvitation,
    required TResult Function(String invitationId) acceptInvitation,
    required TResult Function(String invitationId) rejectInvitation,
    required TResult Function(String email) updateInviteeEmail,
    required TResult Function(ClinicRole role) updateInviteeRole,
    required TResult Function(String message) updateInviteMessage,
    required TResult Function() resetInviteForm,
  }) {
    return loadReceivedInvitations(userEmail);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String clinicId)? loadSentInvitations,
    TResult? Function(String userEmail)? loadReceivedInvitations,
    TResult? Function(String clinicId, String clinicName)? sendInvitation,
    TResult? Function(String invitationId)? cancelInvitation,
    TResult? Function(String invitationId)? acceptInvitation,
    TResult? Function(String invitationId)? rejectInvitation,
    TResult? Function(String email)? updateInviteeEmail,
    TResult? Function(ClinicRole role)? updateInviteeRole,
    TResult? Function(String message)? updateInviteMessage,
    TResult? Function()? resetInviteForm,
  }) {
    return loadReceivedInvitations?.call(userEmail);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String clinicId)? loadSentInvitations,
    TResult Function(String userEmail)? loadReceivedInvitations,
    TResult Function(String clinicId, String clinicName)? sendInvitation,
    TResult Function(String invitationId)? cancelInvitation,
    TResult Function(String invitationId)? acceptInvitation,
    TResult Function(String invitationId)? rejectInvitation,
    TResult Function(String email)? updateInviteeEmail,
    TResult Function(ClinicRole role)? updateInviteeRole,
    TResult Function(String message)? updateInviteMessage,
    TResult Function()? resetInviteForm,
    required TResult orElse(),
  }) {
    if (loadReceivedInvitations != null) {
      return loadReceivedInvitations(userEmail);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSentInvitations value) loadSentInvitations,
    required TResult Function(_LoadReceivedInvitations value)
    loadReceivedInvitations,
    required TResult Function(_SendInvitation value) sendInvitation,
    required TResult Function(_CancelInvitation value) cancelInvitation,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_RejectInvitation value) rejectInvitation,
    required TResult Function(_UpdateInviteeEmail value) updateInviteeEmail,
    required TResult Function(_UpdateInviteeRole value) updateInviteeRole,
    required TResult Function(_UpdateInviteMessage value) updateInviteMessage,
    required TResult Function(_ResetInviteForm value) resetInviteForm,
  }) {
    return loadReceivedInvitations(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult? Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult? Function(_SendInvitation value)? sendInvitation,
    TResult? Function(_CancelInvitation value)? cancelInvitation,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_RejectInvitation value)? rejectInvitation,
    TResult? Function(_UpdateInviteeEmail value)? updateInviteeEmail,
    TResult? Function(_UpdateInviteeRole value)? updateInviteeRole,
    TResult? Function(_UpdateInviteMessage value)? updateInviteMessage,
    TResult? Function(_ResetInviteForm value)? resetInviteForm,
  }) {
    return loadReceivedInvitations?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult Function(_SendInvitation value)? sendInvitation,
    TResult Function(_CancelInvitation value)? cancelInvitation,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_RejectInvitation value)? rejectInvitation,
    TResult Function(_UpdateInviteeEmail value)? updateInviteeEmail,
    TResult Function(_UpdateInviteeRole value)? updateInviteeRole,
    TResult Function(_UpdateInviteMessage value)? updateInviteMessage,
    TResult Function(_ResetInviteForm value)? resetInviteForm,
    required TResult orElse(),
  }) {
    if (loadReceivedInvitations != null) {
      return loadReceivedInvitations(this);
    }
    return orElse();
  }
}

abstract class _LoadReceivedInvitations implements InvitationEvent {
  const factory _LoadReceivedInvitations(final String userEmail) =
      _$LoadReceivedInvitationsImpl;

  String get userEmail;

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadReceivedInvitationsImplCopyWith<_$LoadReceivedInvitationsImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendInvitationImplCopyWith<$Res> {
  factory _$$SendInvitationImplCopyWith(
    _$SendInvitationImpl value,
    $Res Function(_$SendInvitationImpl) then,
  ) = __$$SendInvitationImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String clinicId, String clinicName});
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
  $Res call({Object? clinicId = null, Object? clinicName = null}) {
    return _then(
      _$SendInvitationImpl(
        clinicId: null == clinicId
            ? _value.clinicId
            : clinicId // ignore: cast_nullable_to_non_nullable
                  as String,
        clinicName: null == clinicName
            ? _value.clinicName
            : clinicName // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SendInvitationImpl implements _SendInvitation {
  const _$SendInvitationImpl({
    required this.clinicId,
    required this.clinicName,
  });

  @override
  final String clinicId;
  @override
  final String clinicName;

  @override
  String toString() {
    return 'InvitationEvent.sendInvitation(clinicId: $clinicId, clinicName: $clinicName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendInvitationImpl &&
            (identical(other.clinicId, clinicId) ||
                other.clinicId == clinicId) &&
            (identical(other.clinicName, clinicName) ||
                other.clinicName == clinicName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, clinicId, clinicName);

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
    required TResult Function(String clinicId) loadSentInvitations,
    required TResult Function(String userEmail) loadReceivedInvitations,
    required TResult Function(String clinicId, String clinicName)
    sendInvitation,
    required TResult Function(String invitationId) cancelInvitation,
    required TResult Function(String invitationId) acceptInvitation,
    required TResult Function(String invitationId) rejectInvitation,
    required TResult Function(String email) updateInviteeEmail,
    required TResult Function(ClinicRole role) updateInviteeRole,
    required TResult Function(String message) updateInviteMessage,
    required TResult Function() resetInviteForm,
  }) {
    return sendInvitation(clinicId, clinicName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String clinicId)? loadSentInvitations,
    TResult? Function(String userEmail)? loadReceivedInvitations,
    TResult? Function(String clinicId, String clinicName)? sendInvitation,
    TResult? Function(String invitationId)? cancelInvitation,
    TResult? Function(String invitationId)? acceptInvitation,
    TResult? Function(String invitationId)? rejectInvitation,
    TResult? Function(String email)? updateInviteeEmail,
    TResult? Function(ClinicRole role)? updateInviteeRole,
    TResult? Function(String message)? updateInviteMessage,
    TResult? Function()? resetInviteForm,
  }) {
    return sendInvitation?.call(clinicId, clinicName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String clinicId)? loadSentInvitations,
    TResult Function(String userEmail)? loadReceivedInvitations,
    TResult Function(String clinicId, String clinicName)? sendInvitation,
    TResult Function(String invitationId)? cancelInvitation,
    TResult Function(String invitationId)? acceptInvitation,
    TResult Function(String invitationId)? rejectInvitation,
    TResult Function(String email)? updateInviteeEmail,
    TResult Function(ClinicRole role)? updateInviteeRole,
    TResult Function(String message)? updateInviteMessage,
    TResult Function()? resetInviteForm,
    required TResult orElse(),
  }) {
    if (sendInvitation != null) {
      return sendInvitation(clinicId, clinicName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSentInvitations value) loadSentInvitations,
    required TResult Function(_LoadReceivedInvitations value)
    loadReceivedInvitations,
    required TResult Function(_SendInvitation value) sendInvitation,
    required TResult Function(_CancelInvitation value) cancelInvitation,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_RejectInvitation value) rejectInvitation,
    required TResult Function(_UpdateInviteeEmail value) updateInviteeEmail,
    required TResult Function(_UpdateInviteeRole value) updateInviteeRole,
    required TResult Function(_UpdateInviteMessage value) updateInviteMessage,
    required TResult Function(_ResetInviteForm value) resetInviteForm,
  }) {
    return sendInvitation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult? Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult? Function(_SendInvitation value)? sendInvitation,
    TResult? Function(_CancelInvitation value)? cancelInvitation,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_RejectInvitation value)? rejectInvitation,
    TResult? Function(_UpdateInviteeEmail value)? updateInviteeEmail,
    TResult? Function(_UpdateInviteeRole value)? updateInviteeRole,
    TResult? Function(_UpdateInviteMessage value)? updateInviteMessage,
    TResult? Function(_ResetInviteForm value)? resetInviteForm,
  }) {
    return sendInvitation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult Function(_SendInvitation value)? sendInvitation,
    TResult Function(_CancelInvitation value)? cancelInvitation,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_RejectInvitation value)? rejectInvitation,
    TResult Function(_UpdateInviteeEmail value)? updateInviteeEmail,
    TResult Function(_UpdateInviteeRole value)? updateInviteeRole,
    TResult Function(_UpdateInviteMessage value)? updateInviteMessage,
    TResult Function(_ResetInviteForm value)? resetInviteForm,
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
    required final String clinicId,
    required final String clinicName,
  }) = _$SendInvitationImpl;

  String get clinicId;
  String get clinicName;

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
    required TResult Function(String clinicId) loadSentInvitations,
    required TResult Function(String userEmail) loadReceivedInvitations,
    required TResult Function(String clinicId, String clinicName)
    sendInvitation,
    required TResult Function(String invitationId) cancelInvitation,
    required TResult Function(String invitationId) acceptInvitation,
    required TResult Function(String invitationId) rejectInvitation,
    required TResult Function(String email) updateInviteeEmail,
    required TResult Function(ClinicRole role) updateInviteeRole,
    required TResult Function(String message) updateInviteMessage,
    required TResult Function() resetInviteForm,
  }) {
    return cancelInvitation(invitationId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String clinicId)? loadSentInvitations,
    TResult? Function(String userEmail)? loadReceivedInvitations,
    TResult? Function(String clinicId, String clinicName)? sendInvitation,
    TResult? Function(String invitationId)? cancelInvitation,
    TResult? Function(String invitationId)? acceptInvitation,
    TResult? Function(String invitationId)? rejectInvitation,
    TResult? Function(String email)? updateInviteeEmail,
    TResult? Function(ClinicRole role)? updateInviteeRole,
    TResult? Function(String message)? updateInviteMessage,
    TResult? Function()? resetInviteForm,
  }) {
    return cancelInvitation?.call(invitationId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String clinicId)? loadSentInvitations,
    TResult Function(String userEmail)? loadReceivedInvitations,
    TResult Function(String clinicId, String clinicName)? sendInvitation,
    TResult Function(String invitationId)? cancelInvitation,
    TResult Function(String invitationId)? acceptInvitation,
    TResult Function(String invitationId)? rejectInvitation,
    TResult Function(String email)? updateInviteeEmail,
    TResult Function(ClinicRole role)? updateInviteeRole,
    TResult Function(String message)? updateInviteMessage,
    TResult Function()? resetInviteForm,
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
    required TResult Function(_SendInvitation value) sendInvitation,
    required TResult Function(_CancelInvitation value) cancelInvitation,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_RejectInvitation value) rejectInvitation,
    required TResult Function(_UpdateInviteeEmail value) updateInviteeEmail,
    required TResult Function(_UpdateInviteeRole value) updateInviteeRole,
    required TResult Function(_UpdateInviteMessage value) updateInviteMessage,
    required TResult Function(_ResetInviteForm value) resetInviteForm,
  }) {
    return cancelInvitation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult? Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult? Function(_SendInvitation value)? sendInvitation,
    TResult? Function(_CancelInvitation value)? cancelInvitation,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_RejectInvitation value)? rejectInvitation,
    TResult? Function(_UpdateInviteeEmail value)? updateInviteeEmail,
    TResult? Function(_UpdateInviteeRole value)? updateInviteeRole,
    TResult? Function(_UpdateInviteMessage value)? updateInviteMessage,
    TResult? Function(_ResetInviteForm value)? resetInviteForm,
  }) {
    return cancelInvitation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult Function(_SendInvitation value)? sendInvitation,
    TResult Function(_CancelInvitation value)? cancelInvitation,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_RejectInvitation value)? rejectInvitation,
    TResult Function(_UpdateInviteeEmail value)? updateInviteeEmail,
    TResult Function(_UpdateInviteeRole value)? updateInviteeRole,
    TResult Function(_UpdateInviteMessage value)? updateInviteMessage,
    TResult Function(_ResetInviteForm value)? resetInviteForm,
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
    required TResult Function(String clinicId) loadSentInvitations,
    required TResult Function(String userEmail) loadReceivedInvitations,
    required TResult Function(String clinicId, String clinicName)
    sendInvitation,
    required TResult Function(String invitationId) cancelInvitation,
    required TResult Function(String invitationId) acceptInvitation,
    required TResult Function(String invitationId) rejectInvitation,
    required TResult Function(String email) updateInviteeEmail,
    required TResult Function(ClinicRole role) updateInviteeRole,
    required TResult Function(String message) updateInviteMessage,
    required TResult Function() resetInviteForm,
  }) {
    return acceptInvitation(invitationId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String clinicId)? loadSentInvitations,
    TResult? Function(String userEmail)? loadReceivedInvitations,
    TResult? Function(String clinicId, String clinicName)? sendInvitation,
    TResult? Function(String invitationId)? cancelInvitation,
    TResult? Function(String invitationId)? acceptInvitation,
    TResult? Function(String invitationId)? rejectInvitation,
    TResult? Function(String email)? updateInviteeEmail,
    TResult? Function(ClinicRole role)? updateInviteeRole,
    TResult? Function(String message)? updateInviteMessage,
    TResult? Function()? resetInviteForm,
  }) {
    return acceptInvitation?.call(invitationId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String clinicId)? loadSentInvitations,
    TResult Function(String userEmail)? loadReceivedInvitations,
    TResult Function(String clinicId, String clinicName)? sendInvitation,
    TResult Function(String invitationId)? cancelInvitation,
    TResult Function(String invitationId)? acceptInvitation,
    TResult Function(String invitationId)? rejectInvitation,
    TResult Function(String email)? updateInviteeEmail,
    TResult Function(ClinicRole role)? updateInviteeRole,
    TResult Function(String message)? updateInviteMessage,
    TResult Function()? resetInviteForm,
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
    required TResult Function(_SendInvitation value) sendInvitation,
    required TResult Function(_CancelInvitation value) cancelInvitation,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_RejectInvitation value) rejectInvitation,
    required TResult Function(_UpdateInviteeEmail value) updateInviteeEmail,
    required TResult Function(_UpdateInviteeRole value) updateInviteeRole,
    required TResult Function(_UpdateInviteMessage value) updateInviteMessage,
    required TResult Function(_ResetInviteForm value) resetInviteForm,
  }) {
    return acceptInvitation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult? Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult? Function(_SendInvitation value)? sendInvitation,
    TResult? Function(_CancelInvitation value)? cancelInvitation,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_RejectInvitation value)? rejectInvitation,
    TResult? Function(_UpdateInviteeEmail value)? updateInviteeEmail,
    TResult? Function(_UpdateInviteeRole value)? updateInviteeRole,
    TResult? Function(_UpdateInviteMessage value)? updateInviteMessage,
    TResult? Function(_ResetInviteForm value)? resetInviteForm,
  }) {
    return acceptInvitation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult Function(_SendInvitation value)? sendInvitation,
    TResult Function(_CancelInvitation value)? cancelInvitation,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_RejectInvitation value)? rejectInvitation,
    TResult Function(_UpdateInviteeEmail value)? updateInviteeEmail,
    TResult Function(_UpdateInviteeRole value)? updateInviteeRole,
    TResult Function(_UpdateInviteMessage value)? updateInviteMessage,
    TResult Function(_ResetInviteForm value)? resetInviteForm,
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
    required TResult Function(String clinicId) loadSentInvitations,
    required TResult Function(String userEmail) loadReceivedInvitations,
    required TResult Function(String clinicId, String clinicName)
    sendInvitation,
    required TResult Function(String invitationId) cancelInvitation,
    required TResult Function(String invitationId) acceptInvitation,
    required TResult Function(String invitationId) rejectInvitation,
    required TResult Function(String email) updateInviteeEmail,
    required TResult Function(ClinicRole role) updateInviteeRole,
    required TResult Function(String message) updateInviteMessage,
    required TResult Function() resetInviteForm,
  }) {
    return rejectInvitation(invitationId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String clinicId)? loadSentInvitations,
    TResult? Function(String userEmail)? loadReceivedInvitations,
    TResult? Function(String clinicId, String clinicName)? sendInvitation,
    TResult? Function(String invitationId)? cancelInvitation,
    TResult? Function(String invitationId)? acceptInvitation,
    TResult? Function(String invitationId)? rejectInvitation,
    TResult? Function(String email)? updateInviteeEmail,
    TResult? Function(ClinicRole role)? updateInviteeRole,
    TResult? Function(String message)? updateInviteMessage,
    TResult? Function()? resetInviteForm,
  }) {
    return rejectInvitation?.call(invitationId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String clinicId)? loadSentInvitations,
    TResult Function(String userEmail)? loadReceivedInvitations,
    TResult Function(String clinicId, String clinicName)? sendInvitation,
    TResult Function(String invitationId)? cancelInvitation,
    TResult Function(String invitationId)? acceptInvitation,
    TResult Function(String invitationId)? rejectInvitation,
    TResult Function(String email)? updateInviteeEmail,
    TResult Function(ClinicRole role)? updateInviteeRole,
    TResult Function(String message)? updateInviteMessage,
    TResult Function()? resetInviteForm,
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
    required TResult Function(_SendInvitation value) sendInvitation,
    required TResult Function(_CancelInvitation value) cancelInvitation,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_RejectInvitation value) rejectInvitation,
    required TResult Function(_UpdateInviteeEmail value) updateInviteeEmail,
    required TResult Function(_UpdateInviteeRole value) updateInviteeRole,
    required TResult Function(_UpdateInviteMessage value) updateInviteMessage,
    required TResult Function(_ResetInviteForm value) resetInviteForm,
  }) {
    return rejectInvitation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult? Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult? Function(_SendInvitation value)? sendInvitation,
    TResult? Function(_CancelInvitation value)? cancelInvitation,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_RejectInvitation value)? rejectInvitation,
    TResult? Function(_UpdateInviteeEmail value)? updateInviteeEmail,
    TResult? Function(_UpdateInviteeRole value)? updateInviteeRole,
    TResult? Function(_UpdateInviteMessage value)? updateInviteMessage,
    TResult? Function(_ResetInviteForm value)? resetInviteForm,
  }) {
    return rejectInvitation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult Function(_SendInvitation value)? sendInvitation,
    TResult Function(_CancelInvitation value)? cancelInvitation,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_RejectInvitation value)? rejectInvitation,
    TResult Function(_UpdateInviteeEmail value)? updateInviteeEmail,
    TResult Function(_UpdateInviteeRole value)? updateInviteeRole,
    TResult Function(_UpdateInviteMessage value)? updateInviteMessage,
    TResult Function(_ResetInviteForm value)? resetInviteForm,
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
abstract class _$$UpdateInviteeEmailImplCopyWith<$Res> {
  factory _$$UpdateInviteeEmailImplCopyWith(
    _$UpdateInviteeEmailImpl value,
    $Res Function(_$UpdateInviteeEmailImpl) then,
  ) = __$$UpdateInviteeEmailImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$UpdateInviteeEmailImplCopyWithImpl<$Res>
    extends _$InvitationEventCopyWithImpl<$Res, _$UpdateInviteeEmailImpl>
    implements _$$UpdateInviteeEmailImplCopyWith<$Res> {
  __$$UpdateInviteeEmailImplCopyWithImpl(
    _$UpdateInviteeEmailImpl _value,
    $Res Function(_$UpdateInviteeEmailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null}) {
    return _then(
      _$UpdateInviteeEmailImpl(
        null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$UpdateInviteeEmailImpl implements _UpdateInviteeEmail {
  const _$UpdateInviteeEmailImpl(this.email);

  @override
  final String email;

  @override
  String toString() {
    return 'InvitationEvent.updateInviteeEmail(email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateInviteeEmailImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateInviteeEmailImplCopyWith<_$UpdateInviteeEmailImpl> get copyWith =>
      __$$UpdateInviteeEmailImplCopyWithImpl<_$UpdateInviteeEmailImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String clinicId) loadSentInvitations,
    required TResult Function(String userEmail) loadReceivedInvitations,
    required TResult Function(String clinicId, String clinicName)
    sendInvitation,
    required TResult Function(String invitationId) cancelInvitation,
    required TResult Function(String invitationId) acceptInvitation,
    required TResult Function(String invitationId) rejectInvitation,
    required TResult Function(String email) updateInviteeEmail,
    required TResult Function(ClinicRole role) updateInviteeRole,
    required TResult Function(String message) updateInviteMessage,
    required TResult Function() resetInviteForm,
  }) {
    return updateInviteeEmail(email);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String clinicId)? loadSentInvitations,
    TResult? Function(String userEmail)? loadReceivedInvitations,
    TResult? Function(String clinicId, String clinicName)? sendInvitation,
    TResult? Function(String invitationId)? cancelInvitation,
    TResult? Function(String invitationId)? acceptInvitation,
    TResult? Function(String invitationId)? rejectInvitation,
    TResult? Function(String email)? updateInviteeEmail,
    TResult? Function(ClinicRole role)? updateInviteeRole,
    TResult? Function(String message)? updateInviteMessage,
    TResult? Function()? resetInviteForm,
  }) {
    return updateInviteeEmail?.call(email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String clinicId)? loadSentInvitations,
    TResult Function(String userEmail)? loadReceivedInvitations,
    TResult Function(String clinicId, String clinicName)? sendInvitation,
    TResult Function(String invitationId)? cancelInvitation,
    TResult Function(String invitationId)? acceptInvitation,
    TResult Function(String invitationId)? rejectInvitation,
    TResult Function(String email)? updateInviteeEmail,
    TResult Function(ClinicRole role)? updateInviteeRole,
    TResult Function(String message)? updateInviteMessage,
    TResult Function()? resetInviteForm,
    required TResult orElse(),
  }) {
    if (updateInviteeEmail != null) {
      return updateInviteeEmail(email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSentInvitations value) loadSentInvitations,
    required TResult Function(_LoadReceivedInvitations value)
    loadReceivedInvitations,
    required TResult Function(_SendInvitation value) sendInvitation,
    required TResult Function(_CancelInvitation value) cancelInvitation,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_RejectInvitation value) rejectInvitation,
    required TResult Function(_UpdateInviteeEmail value) updateInviteeEmail,
    required TResult Function(_UpdateInviteeRole value) updateInviteeRole,
    required TResult Function(_UpdateInviteMessage value) updateInviteMessage,
    required TResult Function(_ResetInviteForm value) resetInviteForm,
  }) {
    return updateInviteeEmail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult? Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult? Function(_SendInvitation value)? sendInvitation,
    TResult? Function(_CancelInvitation value)? cancelInvitation,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_RejectInvitation value)? rejectInvitation,
    TResult? Function(_UpdateInviteeEmail value)? updateInviteeEmail,
    TResult? Function(_UpdateInviteeRole value)? updateInviteeRole,
    TResult? Function(_UpdateInviteMessage value)? updateInviteMessage,
    TResult? Function(_ResetInviteForm value)? resetInviteForm,
  }) {
    return updateInviteeEmail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult Function(_SendInvitation value)? sendInvitation,
    TResult Function(_CancelInvitation value)? cancelInvitation,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_RejectInvitation value)? rejectInvitation,
    TResult Function(_UpdateInviteeEmail value)? updateInviteeEmail,
    TResult Function(_UpdateInviteeRole value)? updateInviteeRole,
    TResult Function(_UpdateInviteMessage value)? updateInviteMessage,
    TResult Function(_ResetInviteForm value)? resetInviteForm,
    required TResult orElse(),
  }) {
    if (updateInviteeEmail != null) {
      return updateInviteeEmail(this);
    }
    return orElse();
  }
}

abstract class _UpdateInviteeEmail implements InvitationEvent {
  const factory _UpdateInviteeEmail(final String email) =
      _$UpdateInviteeEmailImpl;

  String get email;

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateInviteeEmailImplCopyWith<_$UpdateInviteeEmailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateInviteeRoleImplCopyWith<$Res> {
  factory _$$UpdateInviteeRoleImplCopyWith(
    _$UpdateInviteeRoleImpl value,
    $Res Function(_$UpdateInviteeRoleImpl) then,
  ) = __$$UpdateInviteeRoleImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ClinicRole role});
}

/// @nodoc
class __$$UpdateInviteeRoleImplCopyWithImpl<$Res>
    extends _$InvitationEventCopyWithImpl<$Res, _$UpdateInviteeRoleImpl>
    implements _$$UpdateInviteeRoleImplCopyWith<$Res> {
  __$$UpdateInviteeRoleImplCopyWithImpl(
    _$UpdateInviteeRoleImpl _value,
    $Res Function(_$UpdateInviteeRoleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? role = null}) {
    return _then(
      _$UpdateInviteeRoleImpl(
        null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as ClinicRole,
      ),
    );
  }
}

/// @nodoc

class _$UpdateInviteeRoleImpl implements _UpdateInviteeRole {
  const _$UpdateInviteeRoleImpl(this.role);

  @override
  final ClinicRole role;

  @override
  String toString() {
    return 'InvitationEvent.updateInviteeRole(role: $role)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateInviteeRoleImpl &&
            (identical(other.role, role) || other.role == role));
  }

  @override
  int get hashCode => Object.hash(runtimeType, role);

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateInviteeRoleImplCopyWith<_$UpdateInviteeRoleImpl> get copyWith =>
      __$$UpdateInviteeRoleImplCopyWithImpl<_$UpdateInviteeRoleImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String clinicId) loadSentInvitations,
    required TResult Function(String userEmail) loadReceivedInvitations,
    required TResult Function(String clinicId, String clinicName)
    sendInvitation,
    required TResult Function(String invitationId) cancelInvitation,
    required TResult Function(String invitationId) acceptInvitation,
    required TResult Function(String invitationId) rejectInvitation,
    required TResult Function(String email) updateInviteeEmail,
    required TResult Function(ClinicRole role) updateInviteeRole,
    required TResult Function(String message) updateInviteMessage,
    required TResult Function() resetInviteForm,
  }) {
    return updateInviteeRole(role);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String clinicId)? loadSentInvitations,
    TResult? Function(String userEmail)? loadReceivedInvitations,
    TResult? Function(String clinicId, String clinicName)? sendInvitation,
    TResult? Function(String invitationId)? cancelInvitation,
    TResult? Function(String invitationId)? acceptInvitation,
    TResult? Function(String invitationId)? rejectInvitation,
    TResult? Function(String email)? updateInviteeEmail,
    TResult? Function(ClinicRole role)? updateInviteeRole,
    TResult? Function(String message)? updateInviteMessage,
    TResult? Function()? resetInviteForm,
  }) {
    return updateInviteeRole?.call(role);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String clinicId)? loadSentInvitations,
    TResult Function(String userEmail)? loadReceivedInvitations,
    TResult Function(String clinicId, String clinicName)? sendInvitation,
    TResult Function(String invitationId)? cancelInvitation,
    TResult Function(String invitationId)? acceptInvitation,
    TResult Function(String invitationId)? rejectInvitation,
    TResult Function(String email)? updateInviteeEmail,
    TResult Function(ClinicRole role)? updateInviteeRole,
    TResult Function(String message)? updateInviteMessage,
    TResult Function()? resetInviteForm,
    required TResult orElse(),
  }) {
    if (updateInviteeRole != null) {
      return updateInviteeRole(role);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSentInvitations value) loadSentInvitations,
    required TResult Function(_LoadReceivedInvitations value)
    loadReceivedInvitations,
    required TResult Function(_SendInvitation value) sendInvitation,
    required TResult Function(_CancelInvitation value) cancelInvitation,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_RejectInvitation value) rejectInvitation,
    required TResult Function(_UpdateInviteeEmail value) updateInviteeEmail,
    required TResult Function(_UpdateInviteeRole value) updateInviteeRole,
    required TResult Function(_UpdateInviteMessage value) updateInviteMessage,
    required TResult Function(_ResetInviteForm value) resetInviteForm,
  }) {
    return updateInviteeRole(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult? Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult? Function(_SendInvitation value)? sendInvitation,
    TResult? Function(_CancelInvitation value)? cancelInvitation,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_RejectInvitation value)? rejectInvitation,
    TResult? Function(_UpdateInviteeEmail value)? updateInviteeEmail,
    TResult? Function(_UpdateInviteeRole value)? updateInviteeRole,
    TResult? Function(_UpdateInviteMessage value)? updateInviteMessage,
    TResult? Function(_ResetInviteForm value)? resetInviteForm,
  }) {
    return updateInviteeRole?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult Function(_SendInvitation value)? sendInvitation,
    TResult Function(_CancelInvitation value)? cancelInvitation,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_RejectInvitation value)? rejectInvitation,
    TResult Function(_UpdateInviteeEmail value)? updateInviteeEmail,
    TResult Function(_UpdateInviteeRole value)? updateInviteeRole,
    TResult Function(_UpdateInviteMessage value)? updateInviteMessage,
    TResult Function(_ResetInviteForm value)? resetInviteForm,
    required TResult orElse(),
  }) {
    if (updateInviteeRole != null) {
      return updateInviteeRole(this);
    }
    return orElse();
  }
}

abstract class _UpdateInviteeRole implements InvitationEvent {
  const factory _UpdateInviteeRole(final ClinicRole role) =
      _$UpdateInviteeRoleImpl;

  ClinicRole get role;

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateInviteeRoleImplCopyWith<_$UpdateInviteeRoleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateInviteMessageImplCopyWith<$Res> {
  factory _$$UpdateInviteMessageImplCopyWith(
    _$UpdateInviteMessageImpl value,
    $Res Function(_$UpdateInviteMessageImpl) then,
  ) = __$$UpdateInviteMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$UpdateInviteMessageImplCopyWithImpl<$Res>
    extends _$InvitationEventCopyWithImpl<$Res, _$UpdateInviteMessageImpl>
    implements _$$UpdateInviteMessageImplCopyWith<$Res> {
  __$$UpdateInviteMessageImplCopyWithImpl(
    _$UpdateInviteMessageImpl _value,
    $Res Function(_$UpdateInviteMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$UpdateInviteMessageImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$UpdateInviteMessageImpl implements _UpdateInviteMessage {
  const _$UpdateInviteMessageImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'InvitationEvent.updateInviteMessage(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateInviteMessageImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateInviteMessageImplCopyWith<_$UpdateInviteMessageImpl> get copyWith =>
      __$$UpdateInviteMessageImplCopyWithImpl<_$UpdateInviteMessageImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String clinicId) loadSentInvitations,
    required TResult Function(String userEmail) loadReceivedInvitations,
    required TResult Function(String clinicId, String clinicName)
    sendInvitation,
    required TResult Function(String invitationId) cancelInvitation,
    required TResult Function(String invitationId) acceptInvitation,
    required TResult Function(String invitationId) rejectInvitation,
    required TResult Function(String email) updateInviteeEmail,
    required TResult Function(ClinicRole role) updateInviteeRole,
    required TResult Function(String message) updateInviteMessage,
    required TResult Function() resetInviteForm,
  }) {
    return updateInviteMessage(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String clinicId)? loadSentInvitations,
    TResult? Function(String userEmail)? loadReceivedInvitations,
    TResult? Function(String clinicId, String clinicName)? sendInvitation,
    TResult? Function(String invitationId)? cancelInvitation,
    TResult? Function(String invitationId)? acceptInvitation,
    TResult? Function(String invitationId)? rejectInvitation,
    TResult? Function(String email)? updateInviteeEmail,
    TResult? Function(ClinicRole role)? updateInviteeRole,
    TResult? Function(String message)? updateInviteMessage,
    TResult? Function()? resetInviteForm,
  }) {
    return updateInviteMessage?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String clinicId)? loadSentInvitations,
    TResult Function(String userEmail)? loadReceivedInvitations,
    TResult Function(String clinicId, String clinicName)? sendInvitation,
    TResult Function(String invitationId)? cancelInvitation,
    TResult Function(String invitationId)? acceptInvitation,
    TResult Function(String invitationId)? rejectInvitation,
    TResult Function(String email)? updateInviteeEmail,
    TResult Function(ClinicRole role)? updateInviteeRole,
    TResult Function(String message)? updateInviteMessage,
    TResult Function()? resetInviteForm,
    required TResult orElse(),
  }) {
    if (updateInviteMessage != null) {
      return updateInviteMessage(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSentInvitations value) loadSentInvitations,
    required TResult Function(_LoadReceivedInvitations value)
    loadReceivedInvitations,
    required TResult Function(_SendInvitation value) sendInvitation,
    required TResult Function(_CancelInvitation value) cancelInvitation,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_RejectInvitation value) rejectInvitation,
    required TResult Function(_UpdateInviteeEmail value) updateInviteeEmail,
    required TResult Function(_UpdateInviteeRole value) updateInviteeRole,
    required TResult Function(_UpdateInviteMessage value) updateInviteMessage,
    required TResult Function(_ResetInviteForm value) resetInviteForm,
  }) {
    return updateInviteMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult? Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult? Function(_SendInvitation value)? sendInvitation,
    TResult? Function(_CancelInvitation value)? cancelInvitation,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_RejectInvitation value)? rejectInvitation,
    TResult? Function(_UpdateInviteeEmail value)? updateInviteeEmail,
    TResult? Function(_UpdateInviteeRole value)? updateInviteeRole,
    TResult? Function(_UpdateInviteMessage value)? updateInviteMessage,
    TResult? Function(_ResetInviteForm value)? resetInviteForm,
  }) {
    return updateInviteMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult Function(_SendInvitation value)? sendInvitation,
    TResult Function(_CancelInvitation value)? cancelInvitation,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_RejectInvitation value)? rejectInvitation,
    TResult Function(_UpdateInviteeEmail value)? updateInviteeEmail,
    TResult Function(_UpdateInviteeRole value)? updateInviteeRole,
    TResult Function(_UpdateInviteMessage value)? updateInviteMessage,
    TResult Function(_ResetInviteForm value)? resetInviteForm,
    required TResult orElse(),
  }) {
    if (updateInviteMessage != null) {
      return updateInviteMessage(this);
    }
    return orElse();
  }
}

abstract class _UpdateInviteMessage implements InvitationEvent {
  const factory _UpdateInviteMessage(final String message) =
      _$UpdateInviteMessageImpl;

  String get message;

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateInviteMessageImplCopyWith<_$UpdateInviteMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResetInviteFormImplCopyWith<$Res> {
  factory _$$ResetInviteFormImplCopyWith(
    _$ResetInviteFormImpl value,
    $Res Function(_$ResetInviteFormImpl) then,
  ) = __$$ResetInviteFormImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResetInviteFormImplCopyWithImpl<$Res>
    extends _$InvitationEventCopyWithImpl<$Res, _$ResetInviteFormImpl>
    implements _$$ResetInviteFormImplCopyWith<$Res> {
  __$$ResetInviteFormImplCopyWithImpl(
    _$ResetInviteFormImpl _value,
    $Res Function(_$ResetInviteFormImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InvitationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResetInviteFormImpl implements _ResetInviteForm {
  const _$ResetInviteFormImpl();

  @override
  String toString() {
    return 'InvitationEvent.resetInviteForm()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ResetInviteFormImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String clinicId) loadSentInvitations,
    required TResult Function(String userEmail) loadReceivedInvitations,
    required TResult Function(String clinicId, String clinicName)
    sendInvitation,
    required TResult Function(String invitationId) cancelInvitation,
    required TResult Function(String invitationId) acceptInvitation,
    required TResult Function(String invitationId) rejectInvitation,
    required TResult Function(String email) updateInviteeEmail,
    required TResult Function(ClinicRole role) updateInviteeRole,
    required TResult Function(String message) updateInviteMessage,
    required TResult Function() resetInviteForm,
  }) {
    return resetInviteForm();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String clinicId)? loadSentInvitations,
    TResult? Function(String userEmail)? loadReceivedInvitations,
    TResult? Function(String clinicId, String clinicName)? sendInvitation,
    TResult? Function(String invitationId)? cancelInvitation,
    TResult? Function(String invitationId)? acceptInvitation,
    TResult? Function(String invitationId)? rejectInvitation,
    TResult? Function(String email)? updateInviteeEmail,
    TResult? Function(ClinicRole role)? updateInviteeRole,
    TResult? Function(String message)? updateInviteMessage,
    TResult? Function()? resetInviteForm,
  }) {
    return resetInviteForm?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String clinicId)? loadSentInvitations,
    TResult Function(String userEmail)? loadReceivedInvitations,
    TResult Function(String clinicId, String clinicName)? sendInvitation,
    TResult Function(String invitationId)? cancelInvitation,
    TResult Function(String invitationId)? acceptInvitation,
    TResult Function(String invitationId)? rejectInvitation,
    TResult Function(String email)? updateInviteeEmail,
    TResult Function(ClinicRole role)? updateInviteeRole,
    TResult Function(String message)? updateInviteMessage,
    TResult Function()? resetInviteForm,
    required TResult orElse(),
  }) {
    if (resetInviteForm != null) {
      return resetInviteForm();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSentInvitations value) loadSentInvitations,
    required TResult Function(_LoadReceivedInvitations value)
    loadReceivedInvitations,
    required TResult Function(_SendInvitation value) sendInvitation,
    required TResult Function(_CancelInvitation value) cancelInvitation,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_RejectInvitation value) rejectInvitation,
    required TResult Function(_UpdateInviteeEmail value) updateInviteeEmail,
    required TResult Function(_UpdateInviteeRole value) updateInviteeRole,
    required TResult Function(_UpdateInviteMessage value) updateInviteMessage,
    required TResult Function(_ResetInviteForm value) resetInviteForm,
  }) {
    return resetInviteForm(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult? Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult? Function(_SendInvitation value)? sendInvitation,
    TResult? Function(_CancelInvitation value)? cancelInvitation,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_RejectInvitation value)? rejectInvitation,
    TResult? Function(_UpdateInviteeEmail value)? updateInviteeEmail,
    TResult? Function(_UpdateInviteeRole value)? updateInviteeRole,
    TResult? Function(_UpdateInviteMessage value)? updateInviteMessage,
    TResult? Function(_ResetInviteForm value)? resetInviteForm,
  }) {
    return resetInviteForm?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSentInvitations value)? loadSentInvitations,
    TResult Function(_LoadReceivedInvitations value)? loadReceivedInvitations,
    TResult Function(_SendInvitation value)? sendInvitation,
    TResult Function(_CancelInvitation value)? cancelInvitation,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_RejectInvitation value)? rejectInvitation,
    TResult Function(_UpdateInviteeEmail value)? updateInviteeEmail,
    TResult Function(_UpdateInviteeRole value)? updateInviteeRole,
    TResult Function(_UpdateInviteMessage value)? updateInviteMessage,
    TResult Function(_ResetInviteForm value)? resetInviteForm,
    required TResult orElse(),
  }) {
    if (resetInviteForm != null) {
      return resetInviteForm(this);
    }
    return orElse();
  }
}

abstract class _ResetInviteForm implements InvitationEvent {
  const factory _ResetInviteForm() = _$ResetInviteFormImpl;
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
    return 'InvitationState(isLoading: $isLoading, isSending: $isSending, isUpdating: $isUpdating, sentInvitations: $sentInvitations, receivedInvitations: $receivedInvitations, error: $error, inviteeEmail: $inviteeEmail, inviteeRole: $inviteeRole, inviteMessage: $inviteMessage, sendSuccess: $sendSuccess, cancelSuccess: $cancelSuccess, acceptSuccess: $acceptSuccess, rejectSuccess: $rejectSuccess)';
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
