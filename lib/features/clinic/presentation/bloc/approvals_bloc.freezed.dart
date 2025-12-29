// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'approvals_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ApprovalsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String clinicId) loadPendingApprovals,
    required TResult Function(String requestId) approveRequest,
    required TResult Function(String requestId, String? rejectionReason)
    rejectRequest,
    required TResult Function(
      String clinicId,
      String patientId,
      String patientName,
      String? reason,
    )
    requestPatientDeletion,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String clinicId)? loadPendingApprovals,
    TResult? Function(String requestId)? approveRequest,
    TResult? Function(String requestId, String? rejectionReason)? rejectRequest,
    TResult? Function(
      String clinicId,
      String patientId,
      String patientName,
      String? reason,
    )?
    requestPatientDeletion,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String clinicId)? loadPendingApprovals,
    TResult Function(String requestId)? approveRequest,
    TResult Function(String requestId, String? rejectionReason)? rejectRequest,
    TResult Function(
      String clinicId,
      String patientId,
      String patientName,
      String? reason,
    )?
    requestPatientDeletion,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadPendingApprovals value) loadPendingApprovals,
    required TResult Function(_ApproveRequest value) approveRequest,
    required TResult Function(_RejectRequest value) rejectRequest,
    required TResult Function(_RequestPatientDeletion value)
    requestPatientDeletion,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadPendingApprovals value)? loadPendingApprovals,
    TResult? Function(_ApproveRequest value)? approveRequest,
    TResult? Function(_RejectRequest value)? rejectRequest,
    TResult? Function(_RequestPatientDeletion value)? requestPatientDeletion,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadPendingApprovals value)? loadPendingApprovals,
    TResult Function(_ApproveRequest value)? approveRequest,
    TResult Function(_RejectRequest value)? rejectRequest,
    TResult Function(_RequestPatientDeletion value)? requestPatientDeletion,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApprovalsEventCopyWith<$Res> {
  factory $ApprovalsEventCopyWith(
    ApprovalsEvent value,
    $Res Function(ApprovalsEvent) then,
  ) = _$ApprovalsEventCopyWithImpl<$Res, ApprovalsEvent>;
}

/// @nodoc
class _$ApprovalsEventCopyWithImpl<$Res, $Val extends ApprovalsEvent>
    implements $ApprovalsEventCopyWith<$Res> {
  _$ApprovalsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadPendingApprovalsImplCopyWith<$Res> {
  factory _$$LoadPendingApprovalsImplCopyWith(
    _$LoadPendingApprovalsImpl value,
    $Res Function(_$LoadPendingApprovalsImpl) then,
  ) = __$$LoadPendingApprovalsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String clinicId});
}

/// @nodoc
class __$$LoadPendingApprovalsImplCopyWithImpl<$Res>
    extends _$ApprovalsEventCopyWithImpl<$Res, _$LoadPendingApprovalsImpl>
    implements _$$LoadPendingApprovalsImplCopyWith<$Res> {
  __$$LoadPendingApprovalsImplCopyWithImpl(
    _$LoadPendingApprovalsImpl _value,
    $Res Function(_$LoadPendingApprovalsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? clinicId = null}) {
    return _then(
      _$LoadPendingApprovalsImpl(
        null == clinicId
            ? _value.clinicId
            : clinicId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LoadPendingApprovalsImpl implements _LoadPendingApprovals {
  const _$LoadPendingApprovalsImpl(this.clinicId);

  @override
  final String clinicId;

  @override
  String toString() {
    return 'ApprovalsEvent.loadPendingApprovals(clinicId: $clinicId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadPendingApprovalsImpl &&
            (identical(other.clinicId, clinicId) ||
                other.clinicId == clinicId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, clinicId);

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadPendingApprovalsImplCopyWith<_$LoadPendingApprovalsImpl>
  get copyWith =>
      __$$LoadPendingApprovalsImplCopyWithImpl<_$LoadPendingApprovalsImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String clinicId) loadPendingApprovals,
    required TResult Function(String requestId) approveRequest,
    required TResult Function(String requestId, String? rejectionReason)
    rejectRequest,
    required TResult Function(
      String clinicId,
      String patientId,
      String patientName,
      String? reason,
    )
    requestPatientDeletion,
  }) {
    return loadPendingApprovals(clinicId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String clinicId)? loadPendingApprovals,
    TResult? Function(String requestId)? approveRequest,
    TResult? Function(String requestId, String? rejectionReason)? rejectRequest,
    TResult? Function(
      String clinicId,
      String patientId,
      String patientName,
      String? reason,
    )?
    requestPatientDeletion,
  }) {
    return loadPendingApprovals?.call(clinicId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String clinicId)? loadPendingApprovals,
    TResult Function(String requestId)? approveRequest,
    TResult Function(String requestId, String? rejectionReason)? rejectRequest,
    TResult Function(
      String clinicId,
      String patientId,
      String patientName,
      String? reason,
    )?
    requestPatientDeletion,
    required TResult orElse(),
  }) {
    if (loadPendingApprovals != null) {
      return loadPendingApprovals(clinicId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadPendingApprovals value) loadPendingApprovals,
    required TResult Function(_ApproveRequest value) approveRequest,
    required TResult Function(_RejectRequest value) rejectRequest,
    required TResult Function(_RequestPatientDeletion value)
    requestPatientDeletion,
  }) {
    return loadPendingApprovals(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadPendingApprovals value)? loadPendingApprovals,
    TResult? Function(_ApproveRequest value)? approveRequest,
    TResult? Function(_RejectRequest value)? rejectRequest,
    TResult? Function(_RequestPatientDeletion value)? requestPatientDeletion,
  }) {
    return loadPendingApprovals?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadPendingApprovals value)? loadPendingApprovals,
    TResult Function(_ApproveRequest value)? approveRequest,
    TResult Function(_RejectRequest value)? rejectRequest,
    TResult Function(_RequestPatientDeletion value)? requestPatientDeletion,
    required TResult orElse(),
  }) {
    if (loadPendingApprovals != null) {
      return loadPendingApprovals(this);
    }
    return orElse();
  }
}

abstract class _LoadPendingApprovals implements ApprovalsEvent {
  const factory _LoadPendingApprovals(final String clinicId) =
      _$LoadPendingApprovalsImpl;

  String get clinicId;

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadPendingApprovalsImplCopyWith<_$LoadPendingApprovalsImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ApproveRequestImplCopyWith<$Res> {
  factory _$$ApproveRequestImplCopyWith(
    _$ApproveRequestImpl value,
    $Res Function(_$ApproveRequestImpl) then,
  ) = __$$ApproveRequestImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String requestId});
}

/// @nodoc
class __$$ApproveRequestImplCopyWithImpl<$Res>
    extends _$ApprovalsEventCopyWithImpl<$Res, _$ApproveRequestImpl>
    implements _$$ApproveRequestImplCopyWith<$Res> {
  __$$ApproveRequestImplCopyWithImpl(
    _$ApproveRequestImpl _value,
    $Res Function(_$ApproveRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? requestId = null}) {
    return _then(
      _$ApproveRequestImpl(
        null == requestId
            ? _value.requestId
            : requestId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ApproveRequestImpl implements _ApproveRequest {
  const _$ApproveRequestImpl(this.requestId);

  @override
  final String requestId;

  @override
  String toString() {
    return 'ApprovalsEvent.approveRequest(requestId: $requestId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApproveRequestImpl &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, requestId);

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApproveRequestImplCopyWith<_$ApproveRequestImpl> get copyWith =>
      __$$ApproveRequestImplCopyWithImpl<_$ApproveRequestImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String clinicId) loadPendingApprovals,
    required TResult Function(String requestId) approveRequest,
    required TResult Function(String requestId, String? rejectionReason)
    rejectRequest,
    required TResult Function(
      String clinicId,
      String patientId,
      String patientName,
      String? reason,
    )
    requestPatientDeletion,
  }) {
    return approveRequest(requestId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String clinicId)? loadPendingApprovals,
    TResult? Function(String requestId)? approveRequest,
    TResult? Function(String requestId, String? rejectionReason)? rejectRequest,
    TResult? Function(
      String clinicId,
      String patientId,
      String patientName,
      String? reason,
    )?
    requestPatientDeletion,
  }) {
    return approveRequest?.call(requestId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String clinicId)? loadPendingApprovals,
    TResult Function(String requestId)? approveRequest,
    TResult Function(String requestId, String? rejectionReason)? rejectRequest,
    TResult Function(
      String clinicId,
      String patientId,
      String patientName,
      String? reason,
    )?
    requestPatientDeletion,
    required TResult orElse(),
  }) {
    if (approveRequest != null) {
      return approveRequest(requestId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadPendingApprovals value) loadPendingApprovals,
    required TResult Function(_ApproveRequest value) approveRequest,
    required TResult Function(_RejectRequest value) rejectRequest,
    required TResult Function(_RequestPatientDeletion value)
    requestPatientDeletion,
  }) {
    return approveRequest(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadPendingApprovals value)? loadPendingApprovals,
    TResult? Function(_ApproveRequest value)? approveRequest,
    TResult? Function(_RejectRequest value)? rejectRequest,
    TResult? Function(_RequestPatientDeletion value)? requestPatientDeletion,
  }) {
    return approveRequest?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadPendingApprovals value)? loadPendingApprovals,
    TResult Function(_ApproveRequest value)? approveRequest,
    TResult Function(_RejectRequest value)? rejectRequest,
    TResult Function(_RequestPatientDeletion value)? requestPatientDeletion,
    required TResult orElse(),
  }) {
    if (approveRequest != null) {
      return approveRequest(this);
    }
    return orElse();
  }
}

abstract class _ApproveRequest implements ApprovalsEvent {
  const factory _ApproveRequest(final String requestId) = _$ApproveRequestImpl;

  String get requestId;

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApproveRequestImplCopyWith<_$ApproveRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RejectRequestImplCopyWith<$Res> {
  factory _$$RejectRequestImplCopyWith(
    _$RejectRequestImpl value,
    $Res Function(_$RejectRequestImpl) then,
  ) = __$$RejectRequestImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String requestId, String? rejectionReason});
}

/// @nodoc
class __$$RejectRequestImplCopyWithImpl<$Res>
    extends _$ApprovalsEventCopyWithImpl<$Res, _$RejectRequestImpl>
    implements _$$RejectRequestImplCopyWith<$Res> {
  __$$RejectRequestImplCopyWithImpl(
    _$RejectRequestImpl _value,
    $Res Function(_$RejectRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? requestId = null, Object? rejectionReason = freezed}) {
    return _then(
      _$RejectRequestImpl(
        requestId: null == requestId
            ? _value.requestId
            : requestId // ignore: cast_nullable_to_non_nullable
                  as String,
        rejectionReason: freezed == rejectionReason
            ? _value.rejectionReason
            : rejectionReason // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$RejectRequestImpl implements _RejectRequest {
  const _$RejectRequestImpl({required this.requestId, this.rejectionReason});

  @override
  final String requestId;
  @override
  final String? rejectionReason;

  @override
  String toString() {
    return 'ApprovalsEvent.rejectRequest(requestId: $requestId, rejectionReason: $rejectionReason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RejectRequestImpl &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId) &&
            (identical(other.rejectionReason, rejectionReason) ||
                other.rejectionReason == rejectionReason));
  }

  @override
  int get hashCode => Object.hash(runtimeType, requestId, rejectionReason);

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RejectRequestImplCopyWith<_$RejectRequestImpl> get copyWith =>
      __$$RejectRequestImplCopyWithImpl<_$RejectRequestImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String clinicId) loadPendingApprovals,
    required TResult Function(String requestId) approveRequest,
    required TResult Function(String requestId, String? rejectionReason)
    rejectRequest,
    required TResult Function(
      String clinicId,
      String patientId,
      String patientName,
      String? reason,
    )
    requestPatientDeletion,
  }) {
    return rejectRequest(requestId, rejectionReason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String clinicId)? loadPendingApprovals,
    TResult? Function(String requestId)? approveRequest,
    TResult? Function(String requestId, String? rejectionReason)? rejectRequest,
    TResult? Function(
      String clinicId,
      String patientId,
      String patientName,
      String? reason,
    )?
    requestPatientDeletion,
  }) {
    return rejectRequest?.call(requestId, rejectionReason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String clinicId)? loadPendingApprovals,
    TResult Function(String requestId)? approveRequest,
    TResult Function(String requestId, String? rejectionReason)? rejectRequest,
    TResult Function(
      String clinicId,
      String patientId,
      String patientName,
      String? reason,
    )?
    requestPatientDeletion,
    required TResult orElse(),
  }) {
    if (rejectRequest != null) {
      return rejectRequest(requestId, rejectionReason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadPendingApprovals value) loadPendingApprovals,
    required TResult Function(_ApproveRequest value) approveRequest,
    required TResult Function(_RejectRequest value) rejectRequest,
    required TResult Function(_RequestPatientDeletion value)
    requestPatientDeletion,
  }) {
    return rejectRequest(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadPendingApprovals value)? loadPendingApprovals,
    TResult? Function(_ApproveRequest value)? approveRequest,
    TResult? Function(_RejectRequest value)? rejectRequest,
    TResult? Function(_RequestPatientDeletion value)? requestPatientDeletion,
  }) {
    return rejectRequest?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadPendingApprovals value)? loadPendingApprovals,
    TResult Function(_ApproveRequest value)? approveRequest,
    TResult Function(_RejectRequest value)? rejectRequest,
    TResult Function(_RequestPatientDeletion value)? requestPatientDeletion,
    required TResult orElse(),
  }) {
    if (rejectRequest != null) {
      return rejectRequest(this);
    }
    return orElse();
  }
}

abstract class _RejectRequest implements ApprovalsEvent {
  const factory _RejectRequest({
    required final String requestId,
    final String? rejectionReason,
  }) = _$RejectRequestImpl;

  String get requestId;
  String? get rejectionReason;

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RejectRequestImplCopyWith<_$RejectRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RequestPatientDeletionImplCopyWith<$Res> {
  factory _$$RequestPatientDeletionImplCopyWith(
    _$RequestPatientDeletionImpl value,
    $Res Function(_$RequestPatientDeletionImpl) then,
  ) = __$$RequestPatientDeletionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String clinicId,
    String patientId,
    String patientName,
    String? reason,
  });
}

/// @nodoc
class __$$RequestPatientDeletionImplCopyWithImpl<$Res>
    extends _$ApprovalsEventCopyWithImpl<$Res, _$RequestPatientDeletionImpl>
    implements _$$RequestPatientDeletionImplCopyWith<$Res> {
  __$$RequestPatientDeletionImplCopyWithImpl(
    _$RequestPatientDeletionImpl _value,
    $Res Function(_$RequestPatientDeletionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clinicId = null,
    Object? patientId = null,
    Object? patientName = null,
    Object? reason = freezed,
  }) {
    return _then(
      _$RequestPatientDeletionImpl(
        clinicId: null == clinicId
            ? _value.clinicId
            : clinicId // ignore: cast_nullable_to_non_nullable
                  as String,
        patientId: null == patientId
            ? _value.patientId
            : patientId // ignore: cast_nullable_to_non_nullable
                  as String,
        patientName: null == patientName
            ? _value.patientName
            : patientName // ignore: cast_nullable_to_non_nullable
                  as String,
        reason: freezed == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$RequestPatientDeletionImpl implements _RequestPatientDeletion {
  const _$RequestPatientDeletionImpl({
    required this.clinicId,
    required this.patientId,
    required this.patientName,
    this.reason,
  });

  @override
  final String clinicId;
  @override
  final String patientId;
  @override
  final String patientName;
  @override
  final String? reason;

  @override
  String toString() {
    return 'ApprovalsEvent.requestPatientDeletion(clinicId: $clinicId, patientId: $patientId, patientName: $patientName, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestPatientDeletionImpl &&
            (identical(other.clinicId, clinicId) ||
                other.clinicId == clinicId) &&
            (identical(other.patientId, patientId) ||
                other.patientId == patientId) &&
            (identical(other.patientName, patientName) ||
                other.patientName == patientName) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, clinicId, patientId, patientName, reason);

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestPatientDeletionImplCopyWith<_$RequestPatientDeletionImpl>
  get copyWith =>
      __$$RequestPatientDeletionImplCopyWithImpl<_$RequestPatientDeletionImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String clinicId) loadPendingApprovals,
    required TResult Function(String requestId) approveRequest,
    required TResult Function(String requestId, String? rejectionReason)
    rejectRequest,
    required TResult Function(
      String clinicId,
      String patientId,
      String patientName,
      String? reason,
    )
    requestPatientDeletion,
  }) {
    return requestPatientDeletion(clinicId, patientId, patientName, reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String clinicId)? loadPendingApprovals,
    TResult? Function(String requestId)? approveRequest,
    TResult? Function(String requestId, String? rejectionReason)? rejectRequest,
    TResult? Function(
      String clinicId,
      String patientId,
      String patientName,
      String? reason,
    )?
    requestPatientDeletion,
  }) {
    return requestPatientDeletion?.call(
      clinicId,
      patientId,
      patientName,
      reason,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String clinicId)? loadPendingApprovals,
    TResult Function(String requestId)? approveRequest,
    TResult Function(String requestId, String? rejectionReason)? rejectRequest,
    TResult Function(
      String clinicId,
      String patientId,
      String patientName,
      String? reason,
    )?
    requestPatientDeletion,
    required TResult orElse(),
  }) {
    if (requestPatientDeletion != null) {
      return requestPatientDeletion(clinicId, patientId, patientName, reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadPendingApprovals value) loadPendingApprovals,
    required TResult Function(_ApproveRequest value) approveRequest,
    required TResult Function(_RejectRequest value) rejectRequest,
    required TResult Function(_RequestPatientDeletion value)
    requestPatientDeletion,
  }) {
    return requestPatientDeletion(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadPendingApprovals value)? loadPendingApprovals,
    TResult? Function(_ApproveRequest value)? approveRequest,
    TResult? Function(_RejectRequest value)? rejectRequest,
    TResult? Function(_RequestPatientDeletion value)? requestPatientDeletion,
  }) {
    return requestPatientDeletion?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadPendingApprovals value)? loadPendingApprovals,
    TResult Function(_ApproveRequest value)? approveRequest,
    TResult Function(_RejectRequest value)? rejectRequest,
    TResult Function(_RequestPatientDeletion value)? requestPatientDeletion,
    required TResult orElse(),
  }) {
    if (requestPatientDeletion != null) {
      return requestPatientDeletion(this);
    }
    return orElse();
  }
}

abstract class _RequestPatientDeletion implements ApprovalsEvent {
  const factory _RequestPatientDeletion({
    required final String clinicId,
    required final String patientId,
    required final String patientName,
    final String? reason,
  }) = _$RequestPatientDeletionImpl;

  String get clinicId;
  String get patientId;
  String get patientName;
  String? get reason;

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RequestPatientDeletionImplCopyWith<_$RequestPatientDeletionImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ApprovalsState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isProcessing => throw _privateConstructorUsedError;
  bool get isSubmitting => throw _privateConstructorUsedError;
  List<ApprovalRequestEntity> get pendingApprovals =>
      throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError; // Success flags
  bool get approveSuccess => throw _privateConstructorUsedError;
  bool get rejectSuccess => throw _privateConstructorUsedError;
  bool get submitSuccess => throw _privateConstructorUsedError;

  /// Create a copy of ApprovalsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApprovalsStateCopyWith<ApprovalsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApprovalsStateCopyWith<$Res> {
  factory $ApprovalsStateCopyWith(
    ApprovalsState value,
    $Res Function(ApprovalsState) then,
  ) = _$ApprovalsStateCopyWithImpl<$Res, ApprovalsState>;
  @useResult
  $Res call({
    bool isLoading,
    bool isProcessing,
    bool isSubmitting,
    List<ApprovalRequestEntity> pendingApprovals,
    String? error,
    bool approveSuccess,
    bool rejectSuccess,
    bool submitSuccess,
  });
}

/// @nodoc
class _$ApprovalsStateCopyWithImpl<$Res, $Val extends ApprovalsState>
    implements $ApprovalsStateCopyWith<$Res> {
  _$ApprovalsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApprovalsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isProcessing = null,
    Object? isSubmitting = null,
    Object? pendingApprovals = null,
    Object? error = freezed,
    Object? approveSuccess = null,
    Object? rejectSuccess = null,
    Object? submitSuccess = null,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isProcessing: null == isProcessing
                ? _value.isProcessing
                : isProcessing // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSubmitting: null == isSubmitting
                ? _value.isSubmitting
                : isSubmitting // ignore: cast_nullable_to_non_nullable
                      as bool,
            pendingApprovals: null == pendingApprovals
                ? _value.pendingApprovals
                : pendingApprovals // ignore: cast_nullable_to_non_nullable
                      as List<ApprovalRequestEntity>,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
            approveSuccess: null == approveSuccess
                ? _value.approveSuccess
                : approveSuccess // ignore: cast_nullable_to_non_nullable
                      as bool,
            rejectSuccess: null == rejectSuccess
                ? _value.rejectSuccess
                : rejectSuccess // ignore: cast_nullable_to_non_nullable
                      as bool,
            submitSuccess: null == submitSuccess
                ? _value.submitSuccess
                : submitSuccess // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ApprovalsStateImplCopyWith<$Res>
    implements $ApprovalsStateCopyWith<$Res> {
  factory _$$ApprovalsStateImplCopyWith(
    _$ApprovalsStateImpl value,
    $Res Function(_$ApprovalsStateImpl) then,
  ) = __$$ApprovalsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    bool isProcessing,
    bool isSubmitting,
    List<ApprovalRequestEntity> pendingApprovals,
    String? error,
    bool approveSuccess,
    bool rejectSuccess,
    bool submitSuccess,
  });
}

/// @nodoc
class __$$ApprovalsStateImplCopyWithImpl<$Res>
    extends _$ApprovalsStateCopyWithImpl<$Res, _$ApprovalsStateImpl>
    implements _$$ApprovalsStateImplCopyWith<$Res> {
  __$$ApprovalsStateImplCopyWithImpl(
    _$ApprovalsStateImpl _value,
    $Res Function(_$ApprovalsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApprovalsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isProcessing = null,
    Object? isSubmitting = null,
    Object? pendingApprovals = null,
    Object? error = freezed,
    Object? approveSuccess = null,
    Object? rejectSuccess = null,
    Object? submitSuccess = null,
  }) {
    return _then(
      _$ApprovalsStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isProcessing: null == isProcessing
            ? _value.isProcessing
            : isProcessing // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSubmitting: null == isSubmitting
            ? _value.isSubmitting
            : isSubmitting // ignore: cast_nullable_to_non_nullable
                  as bool,
        pendingApprovals: null == pendingApprovals
            ? _value._pendingApprovals
            : pendingApprovals // ignore: cast_nullable_to_non_nullable
                  as List<ApprovalRequestEntity>,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        approveSuccess: null == approveSuccess
            ? _value.approveSuccess
            : approveSuccess // ignore: cast_nullable_to_non_nullable
                  as bool,
        rejectSuccess: null == rejectSuccess
            ? _value.rejectSuccess
            : rejectSuccess // ignore: cast_nullable_to_non_nullable
                  as bool,
        submitSuccess: null == submitSuccess
            ? _value.submitSuccess
            : submitSuccess // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$ApprovalsStateImpl implements _ApprovalsState {
  const _$ApprovalsStateImpl({
    this.isLoading = false,
    this.isProcessing = false,
    this.isSubmitting = false,
    final List<ApprovalRequestEntity> pendingApprovals = const [],
    this.error,
    this.approveSuccess = false,
    this.rejectSuccess = false,
    this.submitSuccess = false,
  }) : _pendingApprovals = pendingApprovals;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isProcessing;
  @override
  @JsonKey()
  final bool isSubmitting;
  final List<ApprovalRequestEntity> _pendingApprovals;
  @override
  @JsonKey()
  List<ApprovalRequestEntity> get pendingApprovals {
    if (_pendingApprovals is EqualUnmodifiableListView)
      return _pendingApprovals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pendingApprovals);
  }

  @override
  final String? error;
  // Success flags
  @override
  @JsonKey()
  final bool approveSuccess;
  @override
  @JsonKey()
  final bool rejectSuccess;
  @override
  @JsonKey()
  final bool submitSuccess;

  @override
  String toString() {
    return 'ApprovalsState(isLoading: $isLoading, isProcessing: $isProcessing, isSubmitting: $isSubmitting, pendingApprovals: $pendingApprovals, error: $error, approveSuccess: $approveSuccess, rejectSuccess: $rejectSuccess, submitSuccess: $submitSuccess)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApprovalsStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            const DeepCollectionEquality().equals(
              other._pendingApprovals,
              _pendingApprovals,
            ) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.approveSuccess, approveSuccess) ||
                other.approveSuccess == approveSuccess) &&
            (identical(other.rejectSuccess, rejectSuccess) ||
                other.rejectSuccess == rejectSuccess) &&
            (identical(other.submitSuccess, submitSuccess) ||
                other.submitSuccess == submitSuccess));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    isProcessing,
    isSubmitting,
    const DeepCollectionEquality().hash(_pendingApprovals),
    error,
    approveSuccess,
    rejectSuccess,
    submitSuccess,
  );

  /// Create a copy of ApprovalsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApprovalsStateImplCopyWith<_$ApprovalsStateImpl> get copyWith =>
      __$$ApprovalsStateImplCopyWithImpl<_$ApprovalsStateImpl>(
        this,
        _$identity,
      );
}

abstract class _ApprovalsState implements ApprovalsState {
  const factory _ApprovalsState({
    final bool isLoading,
    final bool isProcessing,
    final bool isSubmitting,
    final List<ApprovalRequestEntity> pendingApprovals,
    final String? error,
    final bool approveSuccess,
    final bool rejectSuccess,
    final bool submitSuccess,
  }) = _$ApprovalsStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isProcessing;
  @override
  bool get isSubmitting;
  @override
  List<ApprovalRequestEntity> get pendingApprovals;
  @override
  String? get error; // Success flags
  @override
  bool get approveSuccess;
  @override
  bool get rejectSuccess;
  @override
  bool get submitSuccess;

  /// Create a copy of ApprovalsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApprovalsStateImplCopyWith<_$ApprovalsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
