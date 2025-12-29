// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clinic_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ClinicEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String clinicId) loadClinic,
    required TResult Function(String clinicId) loadMembers,
    required TResult Function(ClinicEntity clinic) updateClinicInfo,
    required TResult Function(String membershipId, ClinicRole newRole)
    updateMemberRole,
    required TResult Function(String membershipId) removeMember,
    required TResult Function(String clinicId) leaveClinic,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String clinicId)? loadClinic,
    TResult? Function(String clinicId)? loadMembers,
    TResult? Function(ClinicEntity clinic)? updateClinicInfo,
    TResult? Function(String membershipId, ClinicRole newRole)?
    updateMemberRole,
    TResult? Function(String membershipId)? removeMember,
    TResult? Function(String clinicId)? leaveClinic,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String clinicId)? loadClinic,
    TResult Function(String clinicId)? loadMembers,
    TResult Function(ClinicEntity clinic)? updateClinicInfo,
    TResult Function(String membershipId, ClinicRole newRole)? updateMemberRole,
    TResult Function(String membershipId)? removeMember,
    TResult Function(String clinicId)? leaveClinic,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadClinic value) loadClinic,
    required TResult Function(_LoadMembers value) loadMembers,
    required TResult Function(_UpdateClinicInfo value) updateClinicInfo,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_LeaveClinic value) leaveClinic,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadClinic value)? loadClinic,
    TResult? Function(_LoadMembers value)? loadMembers,
    TResult? Function(_UpdateClinicInfo value)? updateClinicInfo,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_LeaveClinic value)? leaveClinic,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadClinic value)? loadClinic,
    TResult Function(_LoadMembers value)? loadMembers,
    TResult Function(_UpdateClinicInfo value)? updateClinicInfo,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_LeaveClinic value)? leaveClinic,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClinicEventCopyWith<$Res> {
  factory $ClinicEventCopyWith(
    ClinicEvent value,
    $Res Function(ClinicEvent) then,
  ) = _$ClinicEventCopyWithImpl<$Res, ClinicEvent>;
}

/// @nodoc
class _$ClinicEventCopyWithImpl<$Res, $Val extends ClinicEvent>
    implements $ClinicEventCopyWith<$Res> {
  _$ClinicEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClinicEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadClinicImplCopyWith<$Res> {
  factory _$$LoadClinicImplCopyWith(
    _$LoadClinicImpl value,
    $Res Function(_$LoadClinicImpl) then,
  ) = __$$LoadClinicImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String clinicId});
}

/// @nodoc
class __$$LoadClinicImplCopyWithImpl<$Res>
    extends _$ClinicEventCopyWithImpl<$Res, _$LoadClinicImpl>
    implements _$$LoadClinicImplCopyWith<$Res> {
  __$$LoadClinicImplCopyWithImpl(
    _$LoadClinicImpl _value,
    $Res Function(_$LoadClinicImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClinicEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? clinicId = null}) {
    return _then(
      _$LoadClinicImpl(
        null == clinicId
            ? _value.clinicId
            : clinicId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LoadClinicImpl implements _LoadClinic {
  const _$LoadClinicImpl(this.clinicId);

  @override
  final String clinicId;

  @override
  String toString() {
    return 'ClinicEvent.loadClinic(clinicId: $clinicId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadClinicImpl &&
            (identical(other.clinicId, clinicId) ||
                other.clinicId == clinicId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, clinicId);

  /// Create a copy of ClinicEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadClinicImplCopyWith<_$LoadClinicImpl> get copyWith =>
      __$$LoadClinicImplCopyWithImpl<_$LoadClinicImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String clinicId) loadClinic,
    required TResult Function(String clinicId) loadMembers,
    required TResult Function(ClinicEntity clinic) updateClinicInfo,
    required TResult Function(String membershipId, ClinicRole newRole)
    updateMemberRole,
    required TResult Function(String membershipId) removeMember,
    required TResult Function(String clinicId) leaveClinic,
  }) {
    return loadClinic(clinicId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String clinicId)? loadClinic,
    TResult? Function(String clinicId)? loadMembers,
    TResult? Function(ClinicEntity clinic)? updateClinicInfo,
    TResult? Function(String membershipId, ClinicRole newRole)?
    updateMemberRole,
    TResult? Function(String membershipId)? removeMember,
    TResult? Function(String clinicId)? leaveClinic,
  }) {
    return loadClinic?.call(clinicId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String clinicId)? loadClinic,
    TResult Function(String clinicId)? loadMembers,
    TResult Function(ClinicEntity clinic)? updateClinicInfo,
    TResult Function(String membershipId, ClinicRole newRole)? updateMemberRole,
    TResult Function(String membershipId)? removeMember,
    TResult Function(String clinicId)? leaveClinic,
    required TResult orElse(),
  }) {
    if (loadClinic != null) {
      return loadClinic(clinicId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadClinic value) loadClinic,
    required TResult Function(_LoadMembers value) loadMembers,
    required TResult Function(_UpdateClinicInfo value) updateClinicInfo,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_LeaveClinic value) leaveClinic,
  }) {
    return loadClinic(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadClinic value)? loadClinic,
    TResult? Function(_LoadMembers value)? loadMembers,
    TResult? Function(_UpdateClinicInfo value)? updateClinicInfo,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_LeaveClinic value)? leaveClinic,
  }) {
    return loadClinic?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadClinic value)? loadClinic,
    TResult Function(_LoadMembers value)? loadMembers,
    TResult Function(_UpdateClinicInfo value)? updateClinicInfo,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_LeaveClinic value)? leaveClinic,
    required TResult orElse(),
  }) {
    if (loadClinic != null) {
      return loadClinic(this);
    }
    return orElse();
  }
}

abstract class _LoadClinic implements ClinicEvent {
  const factory _LoadClinic(final String clinicId) = _$LoadClinicImpl;

  String get clinicId;

  /// Create a copy of ClinicEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadClinicImplCopyWith<_$LoadClinicImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadMembersImplCopyWith<$Res> {
  factory _$$LoadMembersImplCopyWith(
    _$LoadMembersImpl value,
    $Res Function(_$LoadMembersImpl) then,
  ) = __$$LoadMembersImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String clinicId});
}

/// @nodoc
class __$$LoadMembersImplCopyWithImpl<$Res>
    extends _$ClinicEventCopyWithImpl<$Res, _$LoadMembersImpl>
    implements _$$LoadMembersImplCopyWith<$Res> {
  __$$LoadMembersImplCopyWithImpl(
    _$LoadMembersImpl _value,
    $Res Function(_$LoadMembersImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClinicEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? clinicId = null}) {
    return _then(
      _$LoadMembersImpl(
        null == clinicId
            ? _value.clinicId
            : clinicId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LoadMembersImpl implements _LoadMembers {
  const _$LoadMembersImpl(this.clinicId);

  @override
  final String clinicId;

  @override
  String toString() {
    return 'ClinicEvent.loadMembers(clinicId: $clinicId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadMembersImpl &&
            (identical(other.clinicId, clinicId) ||
                other.clinicId == clinicId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, clinicId);

  /// Create a copy of ClinicEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadMembersImplCopyWith<_$LoadMembersImpl> get copyWith =>
      __$$LoadMembersImplCopyWithImpl<_$LoadMembersImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String clinicId) loadClinic,
    required TResult Function(String clinicId) loadMembers,
    required TResult Function(ClinicEntity clinic) updateClinicInfo,
    required TResult Function(String membershipId, ClinicRole newRole)
    updateMemberRole,
    required TResult Function(String membershipId) removeMember,
    required TResult Function(String clinicId) leaveClinic,
  }) {
    return loadMembers(clinicId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String clinicId)? loadClinic,
    TResult? Function(String clinicId)? loadMembers,
    TResult? Function(ClinicEntity clinic)? updateClinicInfo,
    TResult? Function(String membershipId, ClinicRole newRole)?
    updateMemberRole,
    TResult? Function(String membershipId)? removeMember,
    TResult? Function(String clinicId)? leaveClinic,
  }) {
    return loadMembers?.call(clinicId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String clinicId)? loadClinic,
    TResult Function(String clinicId)? loadMembers,
    TResult Function(ClinicEntity clinic)? updateClinicInfo,
    TResult Function(String membershipId, ClinicRole newRole)? updateMemberRole,
    TResult Function(String membershipId)? removeMember,
    TResult Function(String clinicId)? leaveClinic,
    required TResult orElse(),
  }) {
    if (loadMembers != null) {
      return loadMembers(clinicId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadClinic value) loadClinic,
    required TResult Function(_LoadMembers value) loadMembers,
    required TResult Function(_UpdateClinicInfo value) updateClinicInfo,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_LeaveClinic value) leaveClinic,
  }) {
    return loadMembers(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadClinic value)? loadClinic,
    TResult? Function(_LoadMembers value)? loadMembers,
    TResult? Function(_UpdateClinicInfo value)? updateClinicInfo,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_LeaveClinic value)? leaveClinic,
  }) {
    return loadMembers?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadClinic value)? loadClinic,
    TResult Function(_LoadMembers value)? loadMembers,
    TResult Function(_UpdateClinicInfo value)? updateClinicInfo,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_LeaveClinic value)? leaveClinic,
    required TResult orElse(),
  }) {
    if (loadMembers != null) {
      return loadMembers(this);
    }
    return orElse();
  }
}

abstract class _LoadMembers implements ClinicEvent {
  const factory _LoadMembers(final String clinicId) = _$LoadMembersImpl;

  String get clinicId;

  /// Create a copy of ClinicEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadMembersImplCopyWith<_$LoadMembersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateClinicInfoImplCopyWith<$Res> {
  factory _$$UpdateClinicInfoImplCopyWith(
    _$UpdateClinicInfoImpl value,
    $Res Function(_$UpdateClinicInfoImpl) then,
  ) = __$$UpdateClinicInfoImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ClinicEntity clinic});

  $ClinicEntityCopyWith<$Res> get clinic;
}

/// @nodoc
class __$$UpdateClinicInfoImplCopyWithImpl<$Res>
    extends _$ClinicEventCopyWithImpl<$Res, _$UpdateClinicInfoImpl>
    implements _$$UpdateClinicInfoImplCopyWith<$Res> {
  __$$UpdateClinicInfoImplCopyWithImpl(
    _$UpdateClinicInfoImpl _value,
    $Res Function(_$UpdateClinicInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClinicEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? clinic = null}) {
    return _then(
      _$UpdateClinicInfoImpl(
        null == clinic
            ? _value.clinic
            : clinic // ignore: cast_nullable_to_non_nullable
                  as ClinicEntity,
      ),
    );
  }

  /// Create a copy of ClinicEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ClinicEntityCopyWith<$Res> get clinic {
    return $ClinicEntityCopyWith<$Res>(_value.clinic, (value) {
      return _then(_value.copyWith(clinic: value));
    });
  }
}

/// @nodoc

class _$UpdateClinicInfoImpl implements _UpdateClinicInfo {
  const _$UpdateClinicInfoImpl(this.clinic);

  @override
  final ClinicEntity clinic;

  @override
  String toString() {
    return 'ClinicEvent.updateClinicInfo(clinic: $clinic)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateClinicInfoImpl &&
            (identical(other.clinic, clinic) || other.clinic == clinic));
  }

  @override
  int get hashCode => Object.hash(runtimeType, clinic);

  /// Create a copy of ClinicEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateClinicInfoImplCopyWith<_$UpdateClinicInfoImpl> get copyWith =>
      __$$UpdateClinicInfoImplCopyWithImpl<_$UpdateClinicInfoImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String clinicId) loadClinic,
    required TResult Function(String clinicId) loadMembers,
    required TResult Function(ClinicEntity clinic) updateClinicInfo,
    required TResult Function(String membershipId, ClinicRole newRole)
    updateMemberRole,
    required TResult Function(String membershipId) removeMember,
    required TResult Function(String clinicId) leaveClinic,
  }) {
    return updateClinicInfo(clinic);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String clinicId)? loadClinic,
    TResult? Function(String clinicId)? loadMembers,
    TResult? Function(ClinicEntity clinic)? updateClinicInfo,
    TResult? Function(String membershipId, ClinicRole newRole)?
    updateMemberRole,
    TResult? Function(String membershipId)? removeMember,
    TResult? Function(String clinicId)? leaveClinic,
  }) {
    return updateClinicInfo?.call(clinic);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String clinicId)? loadClinic,
    TResult Function(String clinicId)? loadMembers,
    TResult Function(ClinicEntity clinic)? updateClinicInfo,
    TResult Function(String membershipId, ClinicRole newRole)? updateMemberRole,
    TResult Function(String membershipId)? removeMember,
    TResult Function(String clinicId)? leaveClinic,
    required TResult orElse(),
  }) {
    if (updateClinicInfo != null) {
      return updateClinicInfo(clinic);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadClinic value) loadClinic,
    required TResult Function(_LoadMembers value) loadMembers,
    required TResult Function(_UpdateClinicInfo value) updateClinicInfo,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_LeaveClinic value) leaveClinic,
  }) {
    return updateClinicInfo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadClinic value)? loadClinic,
    TResult? Function(_LoadMembers value)? loadMembers,
    TResult? Function(_UpdateClinicInfo value)? updateClinicInfo,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_LeaveClinic value)? leaveClinic,
  }) {
    return updateClinicInfo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadClinic value)? loadClinic,
    TResult Function(_LoadMembers value)? loadMembers,
    TResult Function(_UpdateClinicInfo value)? updateClinicInfo,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_LeaveClinic value)? leaveClinic,
    required TResult orElse(),
  }) {
    if (updateClinicInfo != null) {
      return updateClinicInfo(this);
    }
    return orElse();
  }
}

abstract class _UpdateClinicInfo implements ClinicEvent {
  const factory _UpdateClinicInfo(final ClinicEntity clinic) =
      _$UpdateClinicInfoImpl;

  ClinicEntity get clinic;

  /// Create a copy of ClinicEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateClinicInfoImplCopyWith<_$UpdateClinicInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateMemberRoleImplCopyWith<$Res> {
  factory _$$UpdateMemberRoleImplCopyWith(
    _$UpdateMemberRoleImpl value,
    $Res Function(_$UpdateMemberRoleImpl) then,
  ) = __$$UpdateMemberRoleImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String membershipId, ClinicRole newRole});
}

/// @nodoc
class __$$UpdateMemberRoleImplCopyWithImpl<$Res>
    extends _$ClinicEventCopyWithImpl<$Res, _$UpdateMemberRoleImpl>
    implements _$$UpdateMemberRoleImplCopyWith<$Res> {
  __$$UpdateMemberRoleImplCopyWithImpl(
    _$UpdateMemberRoleImpl _value,
    $Res Function(_$UpdateMemberRoleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClinicEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? membershipId = null, Object? newRole = null}) {
    return _then(
      _$UpdateMemberRoleImpl(
        membershipId: null == membershipId
            ? _value.membershipId
            : membershipId // ignore: cast_nullable_to_non_nullable
                  as String,
        newRole: null == newRole
            ? _value.newRole
            : newRole // ignore: cast_nullable_to_non_nullable
                  as ClinicRole,
      ),
    );
  }
}

/// @nodoc

class _$UpdateMemberRoleImpl implements _UpdateMemberRole {
  const _$UpdateMemberRoleImpl({
    required this.membershipId,
    required this.newRole,
  });

  @override
  final String membershipId;
  @override
  final ClinicRole newRole;

  @override
  String toString() {
    return 'ClinicEvent.updateMemberRole(membershipId: $membershipId, newRole: $newRole)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateMemberRoleImpl &&
            (identical(other.membershipId, membershipId) ||
                other.membershipId == membershipId) &&
            (identical(other.newRole, newRole) || other.newRole == newRole));
  }

  @override
  int get hashCode => Object.hash(runtimeType, membershipId, newRole);

  /// Create a copy of ClinicEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateMemberRoleImplCopyWith<_$UpdateMemberRoleImpl> get copyWith =>
      __$$UpdateMemberRoleImplCopyWithImpl<_$UpdateMemberRoleImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String clinicId) loadClinic,
    required TResult Function(String clinicId) loadMembers,
    required TResult Function(ClinicEntity clinic) updateClinicInfo,
    required TResult Function(String membershipId, ClinicRole newRole)
    updateMemberRole,
    required TResult Function(String membershipId) removeMember,
    required TResult Function(String clinicId) leaveClinic,
  }) {
    return updateMemberRole(membershipId, newRole);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String clinicId)? loadClinic,
    TResult? Function(String clinicId)? loadMembers,
    TResult? Function(ClinicEntity clinic)? updateClinicInfo,
    TResult? Function(String membershipId, ClinicRole newRole)?
    updateMemberRole,
    TResult? Function(String membershipId)? removeMember,
    TResult? Function(String clinicId)? leaveClinic,
  }) {
    return updateMemberRole?.call(membershipId, newRole);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String clinicId)? loadClinic,
    TResult Function(String clinicId)? loadMembers,
    TResult Function(ClinicEntity clinic)? updateClinicInfo,
    TResult Function(String membershipId, ClinicRole newRole)? updateMemberRole,
    TResult Function(String membershipId)? removeMember,
    TResult Function(String clinicId)? leaveClinic,
    required TResult orElse(),
  }) {
    if (updateMemberRole != null) {
      return updateMemberRole(membershipId, newRole);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadClinic value) loadClinic,
    required TResult Function(_LoadMembers value) loadMembers,
    required TResult Function(_UpdateClinicInfo value) updateClinicInfo,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_LeaveClinic value) leaveClinic,
  }) {
    return updateMemberRole(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadClinic value)? loadClinic,
    TResult? Function(_LoadMembers value)? loadMembers,
    TResult? Function(_UpdateClinicInfo value)? updateClinicInfo,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_LeaveClinic value)? leaveClinic,
  }) {
    return updateMemberRole?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadClinic value)? loadClinic,
    TResult Function(_LoadMembers value)? loadMembers,
    TResult Function(_UpdateClinicInfo value)? updateClinicInfo,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_LeaveClinic value)? leaveClinic,
    required TResult orElse(),
  }) {
    if (updateMemberRole != null) {
      return updateMemberRole(this);
    }
    return orElse();
  }
}

abstract class _UpdateMemberRole implements ClinicEvent {
  const factory _UpdateMemberRole({
    required final String membershipId,
    required final ClinicRole newRole,
  }) = _$UpdateMemberRoleImpl;

  String get membershipId;
  ClinicRole get newRole;

  /// Create a copy of ClinicEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateMemberRoleImplCopyWith<_$UpdateMemberRoleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveMemberImplCopyWith<$Res> {
  factory _$$RemoveMemberImplCopyWith(
    _$RemoveMemberImpl value,
    $Res Function(_$RemoveMemberImpl) then,
  ) = __$$RemoveMemberImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String membershipId});
}

/// @nodoc
class __$$RemoveMemberImplCopyWithImpl<$Res>
    extends _$ClinicEventCopyWithImpl<$Res, _$RemoveMemberImpl>
    implements _$$RemoveMemberImplCopyWith<$Res> {
  __$$RemoveMemberImplCopyWithImpl(
    _$RemoveMemberImpl _value,
    $Res Function(_$RemoveMemberImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClinicEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? membershipId = null}) {
    return _then(
      _$RemoveMemberImpl(
        null == membershipId
            ? _value.membershipId
            : membershipId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$RemoveMemberImpl implements _RemoveMember {
  const _$RemoveMemberImpl(this.membershipId);

  @override
  final String membershipId;

  @override
  String toString() {
    return 'ClinicEvent.removeMember(membershipId: $membershipId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveMemberImpl &&
            (identical(other.membershipId, membershipId) ||
                other.membershipId == membershipId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, membershipId);

  /// Create a copy of ClinicEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveMemberImplCopyWith<_$RemoveMemberImpl> get copyWith =>
      __$$RemoveMemberImplCopyWithImpl<_$RemoveMemberImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String clinicId) loadClinic,
    required TResult Function(String clinicId) loadMembers,
    required TResult Function(ClinicEntity clinic) updateClinicInfo,
    required TResult Function(String membershipId, ClinicRole newRole)
    updateMemberRole,
    required TResult Function(String membershipId) removeMember,
    required TResult Function(String clinicId) leaveClinic,
  }) {
    return removeMember(membershipId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String clinicId)? loadClinic,
    TResult? Function(String clinicId)? loadMembers,
    TResult? Function(ClinicEntity clinic)? updateClinicInfo,
    TResult? Function(String membershipId, ClinicRole newRole)?
    updateMemberRole,
    TResult? Function(String membershipId)? removeMember,
    TResult? Function(String clinicId)? leaveClinic,
  }) {
    return removeMember?.call(membershipId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String clinicId)? loadClinic,
    TResult Function(String clinicId)? loadMembers,
    TResult Function(ClinicEntity clinic)? updateClinicInfo,
    TResult Function(String membershipId, ClinicRole newRole)? updateMemberRole,
    TResult Function(String membershipId)? removeMember,
    TResult Function(String clinicId)? leaveClinic,
    required TResult orElse(),
  }) {
    if (removeMember != null) {
      return removeMember(membershipId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadClinic value) loadClinic,
    required TResult Function(_LoadMembers value) loadMembers,
    required TResult Function(_UpdateClinicInfo value) updateClinicInfo,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_LeaveClinic value) leaveClinic,
  }) {
    return removeMember(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadClinic value)? loadClinic,
    TResult? Function(_LoadMembers value)? loadMembers,
    TResult? Function(_UpdateClinicInfo value)? updateClinicInfo,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_LeaveClinic value)? leaveClinic,
  }) {
    return removeMember?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadClinic value)? loadClinic,
    TResult Function(_LoadMembers value)? loadMembers,
    TResult Function(_UpdateClinicInfo value)? updateClinicInfo,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_LeaveClinic value)? leaveClinic,
    required TResult orElse(),
  }) {
    if (removeMember != null) {
      return removeMember(this);
    }
    return orElse();
  }
}

abstract class _RemoveMember implements ClinicEvent {
  const factory _RemoveMember(final String membershipId) = _$RemoveMemberImpl;

  String get membershipId;

  /// Create a copy of ClinicEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemoveMemberImplCopyWith<_$RemoveMemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LeaveClinicImplCopyWith<$Res> {
  factory _$$LeaveClinicImplCopyWith(
    _$LeaveClinicImpl value,
    $Res Function(_$LeaveClinicImpl) then,
  ) = __$$LeaveClinicImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String clinicId});
}

/// @nodoc
class __$$LeaveClinicImplCopyWithImpl<$Res>
    extends _$ClinicEventCopyWithImpl<$Res, _$LeaveClinicImpl>
    implements _$$LeaveClinicImplCopyWith<$Res> {
  __$$LeaveClinicImplCopyWithImpl(
    _$LeaveClinicImpl _value,
    $Res Function(_$LeaveClinicImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClinicEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? clinicId = null}) {
    return _then(
      _$LeaveClinicImpl(
        null == clinicId
            ? _value.clinicId
            : clinicId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LeaveClinicImpl implements _LeaveClinic {
  const _$LeaveClinicImpl(this.clinicId);

  @override
  final String clinicId;

  @override
  String toString() {
    return 'ClinicEvent.leaveClinic(clinicId: $clinicId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveClinicImpl &&
            (identical(other.clinicId, clinicId) ||
                other.clinicId == clinicId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, clinicId);

  /// Create a copy of ClinicEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveClinicImplCopyWith<_$LeaveClinicImpl> get copyWith =>
      __$$LeaveClinicImplCopyWithImpl<_$LeaveClinicImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String clinicId) loadClinic,
    required TResult Function(String clinicId) loadMembers,
    required TResult Function(ClinicEntity clinic) updateClinicInfo,
    required TResult Function(String membershipId, ClinicRole newRole)
    updateMemberRole,
    required TResult Function(String membershipId) removeMember,
    required TResult Function(String clinicId) leaveClinic,
  }) {
    return leaveClinic(clinicId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String clinicId)? loadClinic,
    TResult? Function(String clinicId)? loadMembers,
    TResult? Function(ClinicEntity clinic)? updateClinicInfo,
    TResult? Function(String membershipId, ClinicRole newRole)?
    updateMemberRole,
    TResult? Function(String membershipId)? removeMember,
    TResult? Function(String clinicId)? leaveClinic,
  }) {
    return leaveClinic?.call(clinicId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String clinicId)? loadClinic,
    TResult Function(String clinicId)? loadMembers,
    TResult Function(ClinicEntity clinic)? updateClinicInfo,
    TResult Function(String membershipId, ClinicRole newRole)? updateMemberRole,
    TResult Function(String membershipId)? removeMember,
    TResult Function(String clinicId)? leaveClinic,
    required TResult orElse(),
  }) {
    if (leaveClinic != null) {
      return leaveClinic(clinicId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadClinic value) loadClinic,
    required TResult Function(_LoadMembers value) loadMembers,
    required TResult Function(_UpdateClinicInfo value) updateClinicInfo,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_LeaveClinic value) leaveClinic,
  }) {
    return leaveClinic(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadClinic value)? loadClinic,
    TResult? Function(_LoadMembers value)? loadMembers,
    TResult? Function(_UpdateClinicInfo value)? updateClinicInfo,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_LeaveClinic value)? leaveClinic,
  }) {
    return leaveClinic?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadClinic value)? loadClinic,
    TResult Function(_LoadMembers value)? loadMembers,
    TResult Function(_UpdateClinicInfo value)? updateClinicInfo,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_LeaveClinic value)? leaveClinic,
    required TResult orElse(),
  }) {
    if (leaveClinic != null) {
      return leaveClinic(this);
    }
    return orElse();
  }
}

abstract class _LeaveClinic implements ClinicEvent {
  const factory _LeaveClinic(final String clinicId) = _$LeaveClinicImpl;

  String get clinicId;

  /// Create a copy of ClinicEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaveClinicImplCopyWith<_$LeaveClinicImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ClinicState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isMembersLoading => throw _privateConstructorUsedError;
  bool get isUpdating => throw _privateConstructorUsedError;
  ClinicEntity? get clinic => throw _privateConstructorUsedError;
  List<ClinicMembershipEntity> get members =>
      throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  bool get updateSuccess => throw _privateConstructorUsedError;
  bool get removeSuccess => throw _privateConstructorUsedError;
  bool get leaveSuccess => throw _privateConstructorUsedError;

  /// Create a copy of ClinicState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClinicStateCopyWith<ClinicState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClinicStateCopyWith<$Res> {
  factory $ClinicStateCopyWith(
    ClinicState value,
    $Res Function(ClinicState) then,
  ) = _$ClinicStateCopyWithImpl<$Res, ClinicState>;
  @useResult
  $Res call({
    bool isLoading,
    bool isMembersLoading,
    bool isUpdating,
    ClinicEntity? clinic,
    List<ClinicMembershipEntity> members,
    String? error,
    bool updateSuccess,
    bool removeSuccess,
    bool leaveSuccess,
  });

  $ClinicEntityCopyWith<$Res>? get clinic;
}

/// @nodoc
class _$ClinicStateCopyWithImpl<$Res, $Val extends ClinicState>
    implements $ClinicStateCopyWith<$Res> {
  _$ClinicStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClinicState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isMembersLoading = null,
    Object? isUpdating = null,
    Object? clinic = freezed,
    Object? members = null,
    Object? error = freezed,
    Object? updateSuccess = null,
    Object? removeSuccess = null,
    Object? leaveSuccess = null,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isMembersLoading: null == isMembersLoading
                ? _value.isMembersLoading
                : isMembersLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isUpdating: null == isUpdating
                ? _value.isUpdating
                : isUpdating // ignore: cast_nullable_to_non_nullable
                      as bool,
            clinic: freezed == clinic
                ? _value.clinic
                : clinic // ignore: cast_nullable_to_non_nullable
                      as ClinicEntity?,
            members: null == members
                ? _value.members
                : members // ignore: cast_nullable_to_non_nullable
                      as List<ClinicMembershipEntity>,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
            updateSuccess: null == updateSuccess
                ? _value.updateSuccess
                : updateSuccess // ignore: cast_nullable_to_non_nullable
                      as bool,
            removeSuccess: null == removeSuccess
                ? _value.removeSuccess
                : removeSuccess // ignore: cast_nullable_to_non_nullable
                      as bool,
            leaveSuccess: null == leaveSuccess
                ? _value.leaveSuccess
                : leaveSuccess // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of ClinicState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ClinicEntityCopyWith<$Res>? get clinic {
    if (_value.clinic == null) {
      return null;
    }

    return $ClinicEntityCopyWith<$Res>(_value.clinic!, (value) {
      return _then(_value.copyWith(clinic: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ClinicStateImplCopyWith<$Res>
    implements $ClinicStateCopyWith<$Res> {
  factory _$$ClinicStateImplCopyWith(
    _$ClinicStateImpl value,
    $Res Function(_$ClinicStateImpl) then,
  ) = __$$ClinicStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    bool isMembersLoading,
    bool isUpdating,
    ClinicEntity? clinic,
    List<ClinicMembershipEntity> members,
    String? error,
    bool updateSuccess,
    bool removeSuccess,
    bool leaveSuccess,
  });

  @override
  $ClinicEntityCopyWith<$Res>? get clinic;
}

/// @nodoc
class __$$ClinicStateImplCopyWithImpl<$Res>
    extends _$ClinicStateCopyWithImpl<$Res, _$ClinicStateImpl>
    implements _$$ClinicStateImplCopyWith<$Res> {
  __$$ClinicStateImplCopyWithImpl(
    _$ClinicStateImpl _value,
    $Res Function(_$ClinicStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClinicState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isMembersLoading = null,
    Object? isUpdating = null,
    Object? clinic = freezed,
    Object? members = null,
    Object? error = freezed,
    Object? updateSuccess = null,
    Object? removeSuccess = null,
    Object? leaveSuccess = null,
  }) {
    return _then(
      _$ClinicStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isMembersLoading: null == isMembersLoading
            ? _value.isMembersLoading
            : isMembersLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isUpdating: null == isUpdating
            ? _value.isUpdating
            : isUpdating // ignore: cast_nullable_to_non_nullable
                  as bool,
        clinic: freezed == clinic
            ? _value.clinic
            : clinic // ignore: cast_nullable_to_non_nullable
                  as ClinicEntity?,
        members: null == members
            ? _value._members
            : members // ignore: cast_nullable_to_non_nullable
                  as List<ClinicMembershipEntity>,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        updateSuccess: null == updateSuccess
            ? _value.updateSuccess
            : updateSuccess // ignore: cast_nullable_to_non_nullable
                  as bool,
        removeSuccess: null == removeSuccess
            ? _value.removeSuccess
            : removeSuccess // ignore: cast_nullable_to_non_nullable
                  as bool,
        leaveSuccess: null == leaveSuccess
            ? _value.leaveSuccess
            : leaveSuccess // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$ClinicStateImpl implements _ClinicState {
  const _$ClinicStateImpl({
    this.isLoading = false,
    this.isMembersLoading = false,
    this.isUpdating = false,
    this.clinic,
    final List<ClinicMembershipEntity> members = const [],
    this.error,
    this.updateSuccess = false,
    this.removeSuccess = false,
    this.leaveSuccess = false,
  }) : _members = members;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isMembersLoading;
  @override
  @JsonKey()
  final bool isUpdating;
  @override
  final ClinicEntity? clinic;
  final List<ClinicMembershipEntity> _members;
  @override
  @JsonKey()
  List<ClinicMembershipEntity> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  @override
  final String? error;
  @override
  @JsonKey()
  final bool updateSuccess;
  @override
  @JsonKey()
  final bool removeSuccess;
  @override
  @JsonKey()
  final bool leaveSuccess;

  @override
  String toString() {
    return 'ClinicState(isLoading: $isLoading, isMembersLoading: $isMembersLoading, isUpdating: $isUpdating, clinic: $clinic, members: $members, error: $error, updateSuccess: $updateSuccess, removeSuccess: $removeSuccess, leaveSuccess: $leaveSuccess)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClinicStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isMembersLoading, isMembersLoading) ||
                other.isMembersLoading == isMembersLoading) &&
            (identical(other.isUpdating, isUpdating) ||
                other.isUpdating == isUpdating) &&
            (identical(other.clinic, clinic) || other.clinic == clinic) &&
            const DeepCollectionEquality().equals(other._members, _members) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.updateSuccess, updateSuccess) ||
                other.updateSuccess == updateSuccess) &&
            (identical(other.removeSuccess, removeSuccess) ||
                other.removeSuccess == removeSuccess) &&
            (identical(other.leaveSuccess, leaveSuccess) ||
                other.leaveSuccess == leaveSuccess));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    isMembersLoading,
    isUpdating,
    clinic,
    const DeepCollectionEquality().hash(_members),
    error,
    updateSuccess,
    removeSuccess,
    leaveSuccess,
  );

  /// Create a copy of ClinicState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClinicStateImplCopyWith<_$ClinicStateImpl> get copyWith =>
      __$$ClinicStateImplCopyWithImpl<_$ClinicStateImpl>(this, _$identity);
}

abstract class _ClinicState implements ClinicState {
  const factory _ClinicState({
    final bool isLoading,
    final bool isMembersLoading,
    final bool isUpdating,
    final ClinicEntity? clinic,
    final List<ClinicMembershipEntity> members,
    final String? error,
    final bool updateSuccess,
    final bool removeSuccess,
    final bool leaveSuccess,
  }) = _$ClinicStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isMembersLoading;
  @override
  bool get isUpdating;
  @override
  ClinicEntity? get clinic;
  @override
  List<ClinicMembershipEntity> get members;
  @override
  String? get error;
  @override
  bool get updateSuccess;
  @override
  bool get removeSuccess;
  @override
  bool get leaveSuccess;

  /// Create a copy of ClinicState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClinicStateImplCopyWith<_$ClinicStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
