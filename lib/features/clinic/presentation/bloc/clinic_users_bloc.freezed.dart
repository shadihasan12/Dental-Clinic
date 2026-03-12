// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clinic_users_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ClinicUsersEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(
      String firstName,
      String lastName,
      String email,
      String mobileNumber,
      String password,
      String passwordConfirmation,
      List<String> roles,
      String? specialtyId,
    )
    addUser,
    required TResult Function(String userId, List<String> roles) updateRoles,
    required TResult Function(String userId) removeUser,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(
      String firstName,
      String lastName,
      String email,
      String mobileNumber,
      String password,
      String passwordConfirmation,
      List<String> roles,
      String? specialtyId,
    )?
    addUser,
    TResult? Function(String userId, List<String> roles)? updateRoles,
    TResult? Function(String userId)? removeUser,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(
      String firstName,
      String lastName,
      String email,
      String mobileNumber,
      String password,
      String passwordConfirmation,
      List<String> roles,
      String? specialtyId,
    )?
    addUser,
    TResult Function(String userId, List<String> roles)? updateRoles,
    TResult Function(String userId)? removeUser,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_AddUser value) addUser,
    required TResult Function(_UpdateRoles value) updateRoles,
    required TResult Function(_RemoveUser value) removeUser,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_AddUser value)? addUser,
    TResult? Function(_UpdateRoles value)? updateRoles,
    TResult? Function(_RemoveUser value)? removeUser,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_AddUser value)? addUser,
    TResult Function(_UpdateRoles value)? updateRoles,
    TResult Function(_RemoveUser value)? removeUser,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClinicUsersEventCopyWith<$Res> {
  factory $ClinicUsersEventCopyWith(
    ClinicUsersEvent value,
    $Res Function(ClinicUsersEvent) then,
  ) = _$ClinicUsersEventCopyWithImpl<$Res, ClinicUsersEvent>;
}

/// @nodoc
class _$ClinicUsersEventCopyWithImpl<$Res, $Val extends ClinicUsersEvent>
    implements $ClinicUsersEventCopyWith<$Res> {
  _$ClinicUsersEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClinicUsersEvent
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
    extends _$ClinicUsersEventCopyWithImpl<$Res, _$LoadImpl>
    implements _$$LoadImplCopyWith<$Res> {
  __$$LoadImplCopyWithImpl(_$LoadImpl _value, $Res Function(_$LoadImpl) _then)
    : super(_value, _then);

  /// Create a copy of ClinicUsersEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadImpl implements _Load {
  const _$LoadImpl();

  @override
  String toString() {
    return 'ClinicUsersEvent.load()';
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
    required TResult Function(
      String firstName,
      String lastName,
      String email,
      String mobileNumber,
      String password,
      String passwordConfirmation,
      List<String> roles,
      String? specialtyId,
    )
    addUser,
    required TResult Function(String userId, List<String> roles) updateRoles,
    required TResult Function(String userId) removeUser,
  }) {
    return load();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(
      String firstName,
      String lastName,
      String email,
      String mobileNumber,
      String password,
      String passwordConfirmation,
      List<String> roles,
      String? specialtyId,
    )?
    addUser,
    TResult? Function(String userId, List<String> roles)? updateRoles,
    TResult? Function(String userId)? removeUser,
  }) {
    return load?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(
      String firstName,
      String lastName,
      String email,
      String mobileNumber,
      String password,
      String passwordConfirmation,
      List<String> roles,
      String? specialtyId,
    )?
    addUser,
    TResult Function(String userId, List<String> roles)? updateRoles,
    TResult Function(String userId)? removeUser,
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
    required TResult Function(_AddUser value) addUser,
    required TResult Function(_UpdateRoles value) updateRoles,
    required TResult Function(_RemoveUser value) removeUser,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_AddUser value)? addUser,
    TResult? Function(_UpdateRoles value)? updateRoles,
    TResult? Function(_RemoveUser value)? removeUser,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_AddUser value)? addUser,
    TResult Function(_UpdateRoles value)? updateRoles,
    TResult Function(_RemoveUser value)? removeUser,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class _Load implements ClinicUsersEvent {
  const factory _Load() = _$LoadImpl;
}

/// @nodoc
abstract class _$$AddUserImplCopyWith<$Res> {
  factory _$$AddUserImplCopyWith(
    _$AddUserImpl value,
    $Res Function(_$AddUserImpl) then,
  ) = __$$AddUserImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String firstName,
    String lastName,
    String email,
    String mobileNumber,
    String password,
    String passwordConfirmation,
    List<String> roles,
    String? specialtyId,
  });
}

/// @nodoc
class __$$AddUserImplCopyWithImpl<$Res>
    extends _$ClinicUsersEventCopyWithImpl<$Res, _$AddUserImpl>
    implements _$$AddUserImplCopyWith<$Res> {
  __$$AddUserImplCopyWithImpl(
    _$AddUserImpl _value,
    $Res Function(_$AddUserImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClinicUsersEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? mobileNumber = null,
    Object? password = null,
    Object? passwordConfirmation = null,
    Object? roles = null,
    Object? specialtyId = freezed,
  }) {
    return _then(
      _$AddUserImpl(
        firstName: null == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String,
        lastName: null == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        mobileNumber: null == mobileNumber
            ? _value.mobileNumber
            : mobileNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        password: null == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String,
        passwordConfirmation: null == passwordConfirmation
            ? _value.passwordConfirmation
            : passwordConfirmation // ignore: cast_nullable_to_non_nullable
                  as String,
        roles: null == roles
            ? _value._roles
            : roles // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        specialtyId: freezed == specialtyId
            ? _value.specialtyId
            : specialtyId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$AddUserImpl implements _AddUser {
  const _$AddUserImpl({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNumber,
    required this.password,
    required this.passwordConfirmation,
    required final List<String> roles,
    this.specialtyId,
  }) : _roles = roles;

  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String email;
  @override
  final String mobileNumber;
  @override
  final String password;
  @override
  final String passwordConfirmation;
  final List<String> _roles;
  @override
  List<String> get roles {
    if (_roles is EqualUnmodifiableListView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roles);
  }

  @override
  final String? specialtyId;

  @override
  String toString() {
    return 'ClinicUsersEvent.addUser(firstName: $firstName, lastName: $lastName, email: $email, mobileNumber: $mobileNumber, password: $password, passwordConfirmation: $passwordConfirmation, roles: $roles, specialtyId: $specialtyId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddUserImpl &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.mobileNumber, mobileNumber) ||
                other.mobileNumber == mobileNumber) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.passwordConfirmation, passwordConfirmation) ||
                other.passwordConfirmation == passwordConfirmation) &&
            const DeepCollectionEquality().equals(other._roles, _roles) &&
            (identical(other.specialtyId, specialtyId) ||
                other.specialtyId == specialtyId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    firstName,
    lastName,
    email,
    mobileNumber,
    password,
    passwordConfirmation,
    const DeepCollectionEquality().hash(_roles),
    specialtyId,
  );

  /// Create a copy of ClinicUsersEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddUserImplCopyWith<_$AddUserImpl> get copyWith =>
      __$$AddUserImplCopyWithImpl<_$AddUserImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(
      String firstName,
      String lastName,
      String email,
      String mobileNumber,
      String password,
      String passwordConfirmation,
      List<String> roles,
      String? specialtyId,
    )
    addUser,
    required TResult Function(String userId, List<String> roles) updateRoles,
    required TResult Function(String userId) removeUser,
  }) {
    return addUser(
      firstName,
      lastName,
      email,
      mobileNumber,
      password,
      passwordConfirmation,
      roles,
      specialtyId,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(
      String firstName,
      String lastName,
      String email,
      String mobileNumber,
      String password,
      String passwordConfirmation,
      List<String> roles,
      String? specialtyId,
    )?
    addUser,
    TResult? Function(String userId, List<String> roles)? updateRoles,
    TResult? Function(String userId)? removeUser,
  }) {
    return addUser?.call(
      firstName,
      lastName,
      email,
      mobileNumber,
      password,
      passwordConfirmation,
      roles,
      specialtyId,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(
      String firstName,
      String lastName,
      String email,
      String mobileNumber,
      String password,
      String passwordConfirmation,
      List<String> roles,
      String? specialtyId,
    )?
    addUser,
    TResult Function(String userId, List<String> roles)? updateRoles,
    TResult Function(String userId)? removeUser,
    required TResult orElse(),
  }) {
    if (addUser != null) {
      return addUser(
        firstName,
        lastName,
        email,
        mobileNumber,
        password,
        passwordConfirmation,
        roles,
        specialtyId,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_AddUser value) addUser,
    required TResult Function(_UpdateRoles value) updateRoles,
    required TResult Function(_RemoveUser value) removeUser,
  }) {
    return addUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_AddUser value)? addUser,
    TResult? Function(_UpdateRoles value)? updateRoles,
    TResult? Function(_RemoveUser value)? removeUser,
  }) {
    return addUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_AddUser value)? addUser,
    TResult Function(_UpdateRoles value)? updateRoles,
    TResult Function(_RemoveUser value)? removeUser,
    required TResult orElse(),
  }) {
    if (addUser != null) {
      return addUser(this);
    }
    return orElse();
  }
}

abstract class _AddUser implements ClinicUsersEvent {
  const factory _AddUser({
    required final String firstName,
    required final String lastName,
    required final String email,
    required final String mobileNumber,
    required final String password,
    required final String passwordConfirmation,
    required final List<String> roles,
    final String? specialtyId,
  }) = _$AddUserImpl;

  String get firstName;
  String get lastName;
  String get email;
  String get mobileNumber;
  String get password;
  String get passwordConfirmation;
  List<String> get roles;
  String? get specialtyId;

  /// Create a copy of ClinicUsersEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddUserImplCopyWith<_$AddUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateRolesImplCopyWith<$Res> {
  factory _$$UpdateRolesImplCopyWith(
    _$UpdateRolesImpl value,
    $Res Function(_$UpdateRolesImpl) then,
  ) = __$$UpdateRolesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userId, List<String> roles});
}

/// @nodoc
class __$$UpdateRolesImplCopyWithImpl<$Res>
    extends _$ClinicUsersEventCopyWithImpl<$Res, _$UpdateRolesImpl>
    implements _$$UpdateRolesImplCopyWith<$Res> {
  __$$UpdateRolesImplCopyWithImpl(
    _$UpdateRolesImpl _value,
    $Res Function(_$UpdateRolesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClinicUsersEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? userId = null, Object? roles = null}) {
    return _then(
      _$UpdateRolesImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
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

class _$UpdateRolesImpl implements _UpdateRoles {
  const _$UpdateRolesImpl({
    required this.userId,
    required final List<String> roles,
  }) : _roles = roles;

  @override
  final String userId;
  final List<String> _roles;
  @override
  List<String> get roles {
    if (_roles is EqualUnmodifiableListView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roles);
  }

  @override
  String toString() {
    return 'ClinicUsersEvent.updateRoles(userId: $userId, roles: $roles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateRolesImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality().equals(other._roles, _roles));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    const DeepCollectionEquality().hash(_roles),
  );

  /// Create a copy of ClinicUsersEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateRolesImplCopyWith<_$UpdateRolesImpl> get copyWith =>
      __$$UpdateRolesImplCopyWithImpl<_$UpdateRolesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(
      String firstName,
      String lastName,
      String email,
      String mobileNumber,
      String password,
      String passwordConfirmation,
      List<String> roles,
      String? specialtyId,
    )
    addUser,
    required TResult Function(String userId, List<String> roles) updateRoles,
    required TResult Function(String userId) removeUser,
  }) {
    return updateRoles(userId, roles);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(
      String firstName,
      String lastName,
      String email,
      String mobileNumber,
      String password,
      String passwordConfirmation,
      List<String> roles,
      String? specialtyId,
    )?
    addUser,
    TResult? Function(String userId, List<String> roles)? updateRoles,
    TResult? Function(String userId)? removeUser,
  }) {
    return updateRoles?.call(userId, roles);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(
      String firstName,
      String lastName,
      String email,
      String mobileNumber,
      String password,
      String passwordConfirmation,
      List<String> roles,
      String? specialtyId,
    )?
    addUser,
    TResult Function(String userId, List<String> roles)? updateRoles,
    TResult Function(String userId)? removeUser,
    required TResult orElse(),
  }) {
    if (updateRoles != null) {
      return updateRoles(userId, roles);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_AddUser value) addUser,
    required TResult Function(_UpdateRoles value) updateRoles,
    required TResult Function(_RemoveUser value) removeUser,
  }) {
    return updateRoles(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_AddUser value)? addUser,
    TResult? Function(_UpdateRoles value)? updateRoles,
    TResult? Function(_RemoveUser value)? removeUser,
  }) {
    return updateRoles?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_AddUser value)? addUser,
    TResult Function(_UpdateRoles value)? updateRoles,
    TResult Function(_RemoveUser value)? removeUser,
    required TResult orElse(),
  }) {
    if (updateRoles != null) {
      return updateRoles(this);
    }
    return orElse();
  }
}

abstract class _UpdateRoles implements ClinicUsersEvent {
  const factory _UpdateRoles({
    required final String userId,
    required final List<String> roles,
  }) = _$UpdateRolesImpl;

  String get userId;
  List<String> get roles;

  /// Create a copy of ClinicUsersEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateRolesImplCopyWith<_$UpdateRolesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveUserImplCopyWith<$Res> {
  factory _$$RemoveUserImplCopyWith(
    _$RemoveUserImpl value,
    $Res Function(_$RemoveUserImpl) then,
  ) = __$$RemoveUserImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userId});
}

/// @nodoc
class __$$RemoveUserImplCopyWithImpl<$Res>
    extends _$ClinicUsersEventCopyWithImpl<$Res, _$RemoveUserImpl>
    implements _$$RemoveUserImplCopyWith<$Res> {
  __$$RemoveUserImplCopyWithImpl(
    _$RemoveUserImpl _value,
    $Res Function(_$RemoveUserImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClinicUsersEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? userId = null}) {
    return _then(
      _$RemoveUserImpl(
        null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$RemoveUserImpl implements _RemoveUser {
  const _$RemoveUserImpl(this.userId);

  @override
  final String userId;

  @override
  String toString() {
    return 'ClinicUsersEvent.removeUser(userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveUserImpl &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId);

  /// Create a copy of ClinicUsersEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveUserImplCopyWith<_$RemoveUserImpl> get copyWith =>
      __$$RemoveUserImplCopyWithImpl<_$RemoveUserImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(
      String firstName,
      String lastName,
      String email,
      String mobileNumber,
      String password,
      String passwordConfirmation,
      List<String> roles,
      String? specialtyId,
    )
    addUser,
    required TResult Function(String userId, List<String> roles) updateRoles,
    required TResult Function(String userId) removeUser,
  }) {
    return removeUser(userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(
      String firstName,
      String lastName,
      String email,
      String mobileNumber,
      String password,
      String passwordConfirmation,
      List<String> roles,
      String? specialtyId,
    )?
    addUser,
    TResult? Function(String userId, List<String> roles)? updateRoles,
    TResult? Function(String userId)? removeUser,
  }) {
    return removeUser?.call(userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(
      String firstName,
      String lastName,
      String email,
      String mobileNumber,
      String password,
      String passwordConfirmation,
      List<String> roles,
      String? specialtyId,
    )?
    addUser,
    TResult Function(String userId, List<String> roles)? updateRoles,
    TResult Function(String userId)? removeUser,
    required TResult orElse(),
  }) {
    if (removeUser != null) {
      return removeUser(userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_AddUser value) addUser,
    required TResult Function(_UpdateRoles value) updateRoles,
    required TResult Function(_RemoveUser value) removeUser,
  }) {
    return removeUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_AddUser value)? addUser,
    TResult? Function(_UpdateRoles value)? updateRoles,
    TResult? Function(_RemoveUser value)? removeUser,
  }) {
    return removeUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_AddUser value)? addUser,
    TResult Function(_UpdateRoles value)? updateRoles,
    TResult Function(_RemoveUser value)? removeUser,
    required TResult orElse(),
  }) {
    if (removeUser != null) {
      return removeUser(this);
    }
    return orElse();
  }
}

abstract class _RemoveUser implements ClinicUsersEvent {
  const factory _RemoveUser(final String userId) = _$RemoveUserImpl;

  String get userId;

  /// Create a copy of ClinicUsersEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemoveUserImplCopyWith<_$RemoveUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ClinicUsersState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ClinicUserEntity> users) loaded,
    required TResult Function(String message) error,
    required TResult Function(List<ClinicUserEntity> users) submitting,
    required TResult Function(List<ClinicUserEntity> users, String message)
    submitSuccess,
    required TResult Function(List<ClinicUserEntity> users, String message)
    submitError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ClinicUserEntity> users)? loaded,
    TResult? Function(String message)? error,
    TResult? Function(List<ClinicUserEntity> users)? submitting,
    TResult? Function(List<ClinicUserEntity> users, String message)?
    submitSuccess,
    TResult? Function(List<ClinicUserEntity> users, String message)?
    submitError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ClinicUserEntity> users)? loaded,
    TResult Function(String message)? error,
    TResult Function(List<ClinicUserEntity> users)? submitting,
    TResult Function(List<ClinicUserEntity> users, String message)?
    submitSuccess,
    TResult Function(List<ClinicUserEntity> users, String message)? submitError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_SubmitSuccess value) submitSuccess,
    required TResult Function(_SubmitError value) submitError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_SubmitSuccess value)? submitSuccess,
    TResult? Function(_SubmitError value)? submitError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_SubmitSuccess value)? submitSuccess,
    TResult Function(_SubmitError value)? submitError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClinicUsersStateCopyWith<$Res> {
  factory $ClinicUsersStateCopyWith(
    ClinicUsersState value,
    $Res Function(ClinicUsersState) then,
  ) = _$ClinicUsersStateCopyWithImpl<$Res, ClinicUsersState>;
}

/// @nodoc
class _$ClinicUsersStateCopyWithImpl<$Res, $Val extends ClinicUsersState>
    implements $ClinicUsersStateCopyWith<$Res> {
  _$ClinicUsersStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClinicUsersState
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
    extends _$ClinicUsersStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClinicUsersState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'ClinicUsersState.initial()';
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
    required TResult Function(List<ClinicUserEntity> users) loaded,
    required TResult Function(String message) error,
    required TResult Function(List<ClinicUserEntity> users) submitting,
    required TResult Function(List<ClinicUserEntity> users, String message)
    submitSuccess,
    required TResult Function(List<ClinicUserEntity> users, String message)
    submitError,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ClinicUserEntity> users)? loaded,
    TResult? Function(String message)? error,
    TResult? Function(List<ClinicUserEntity> users)? submitting,
    TResult? Function(List<ClinicUserEntity> users, String message)?
    submitSuccess,
    TResult? Function(List<ClinicUserEntity> users, String message)?
    submitError,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ClinicUserEntity> users)? loaded,
    TResult Function(String message)? error,
    TResult Function(List<ClinicUserEntity> users)? submitting,
    TResult Function(List<ClinicUserEntity> users, String message)?
    submitSuccess,
    TResult Function(List<ClinicUserEntity> users, String message)? submitError,
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
    required TResult Function(_Error value) error,
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_SubmitSuccess value) submitSuccess,
    required TResult Function(_SubmitError value) submitError,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_SubmitSuccess value)? submitSuccess,
    TResult? Function(_SubmitError value)? submitError,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_SubmitSuccess value)? submitSuccess,
    TResult Function(_SubmitError value)? submitError,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements ClinicUsersState {
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
    extends _$ClinicUsersStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClinicUsersState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'ClinicUsersState.loading()';
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
    required TResult Function(List<ClinicUserEntity> users) loaded,
    required TResult Function(String message) error,
    required TResult Function(List<ClinicUserEntity> users) submitting,
    required TResult Function(List<ClinicUserEntity> users, String message)
    submitSuccess,
    required TResult Function(List<ClinicUserEntity> users, String message)
    submitError,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ClinicUserEntity> users)? loaded,
    TResult? Function(String message)? error,
    TResult? Function(List<ClinicUserEntity> users)? submitting,
    TResult? Function(List<ClinicUserEntity> users, String message)?
    submitSuccess,
    TResult? Function(List<ClinicUserEntity> users, String message)?
    submitError,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ClinicUserEntity> users)? loaded,
    TResult Function(String message)? error,
    TResult Function(List<ClinicUserEntity> users)? submitting,
    TResult Function(List<ClinicUserEntity> users, String message)?
    submitSuccess,
    TResult Function(List<ClinicUserEntity> users, String message)? submitError,
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
    required TResult Function(_Error value) error,
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_SubmitSuccess value) submitSuccess,
    required TResult Function(_SubmitError value) submitError,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_SubmitSuccess value)? submitSuccess,
    TResult? Function(_SubmitError value)? submitError,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_SubmitSuccess value)? submitSuccess,
    TResult Function(_SubmitError value)? submitError,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements ClinicUsersState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
    _$LoadedImpl value,
    $Res Function(_$LoadedImpl) then,
  ) = __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<ClinicUserEntity> users});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$ClinicUsersStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
    _$LoadedImpl _value,
    $Res Function(_$LoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClinicUsersState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? users = null}) {
    return _then(
      _$LoadedImpl(
        null == users
            ? _value._users
            : users // ignore: cast_nullable_to_non_nullable
                  as List<ClinicUserEntity>,
      ),
    );
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(final List<ClinicUserEntity> users) : _users = users;

  final List<ClinicUserEntity> _users;
  @override
  List<ClinicUserEntity> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  @override
  String toString() {
    return 'ClinicUsersState.loaded(users: $users)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(other._users, _users));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_users));

  /// Create a copy of ClinicUsersState
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
    required TResult Function(List<ClinicUserEntity> users) loaded,
    required TResult Function(String message) error,
    required TResult Function(List<ClinicUserEntity> users) submitting,
    required TResult Function(List<ClinicUserEntity> users, String message)
    submitSuccess,
    required TResult Function(List<ClinicUserEntity> users, String message)
    submitError,
  }) {
    return loaded(users);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ClinicUserEntity> users)? loaded,
    TResult? Function(String message)? error,
    TResult? Function(List<ClinicUserEntity> users)? submitting,
    TResult? Function(List<ClinicUserEntity> users, String message)?
    submitSuccess,
    TResult? Function(List<ClinicUserEntity> users, String message)?
    submitError,
  }) {
    return loaded?.call(users);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ClinicUserEntity> users)? loaded,
    TResult Function(String message)? error,
    TResult Function(List<ClinicUserEntity> users)? submitting,
    TResult Function(List<ClinicUserEntity> users, String message)?
    submitSuccess,
    TResult Function(List<ClinicUserEntity> users, String message)? submitError,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(users);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_SubmitSuccess value) submitSuccess,
    required TResult Function(_SubmitError value) submitError,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_SubmitSuccess value)? submitSuccess,
    TResult? Function(_SubmitError value)? submitError,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_SubmitSuccess value)? submitSuccess,
    TResult Function(_SubmitError value)? submitError,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements ClinicUsersState {
  const factory _Loaded(final List<ClinicUserEntity> users) = _$LoadedImpl;

  List<ClinicUserEntity> get users;

  /// Create a copy of ClinicUsersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
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
    extends _$ClinicUsersStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClinicUsersState
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
    return 'ClinicUsersState.error(message: $message)';
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

  /// Create a copy of ClinicUsersState
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
    required TResult Function(List<ClinicUserEntity> users) loaded,
    required TResult Function(String message) error,
    required TResult Function(List<ClinicUserEntity> users) submitting,
    required TResult Function(List<ClinicUserEntity> users, String message)
    submitSuccess,
    required TResult Function(List<ClinicUserEntity> users, String message)
    submitError,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ClinicUserEntity> users)? loaded,
    TResult? Function(String message)? error,
    TResult? Function(List<ClinicUserEntity> users)? submitting,
    TResult? Function(List<ClinicUserEntity> users, String message)?
    submitSuccess,
    TResult? Function(List<ClinicUserEntity> users, String message)?
    submitError,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ClinicUserEntity> users)? loaded,
    TResult Function(String message)? error,
    TResult Function(List<ClinicUserEntity> users)? submitting,
    TResult Function(List<ClinicUserEntity> users, String message)?
    submitSuccess,
    TResult Function(List<ClinicUserEntity> users, String message)? submitError,
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
    required TResult Function(_Error value) error,
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_SubmitSuccess value) submitSuccess,
    required TResult Function(_SubmitError value) submitError,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_SubmitSuccess value)? submitSuccess,
    TResult? Function(_SubmitError value)? submitError,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_SubmitSuccess value)? submitSuccess,
    TResult Function(_SubmitError value)? submitError,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements ClinicUsersState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of ClinicUsersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SubmittingImplCopyWith<$Res> {
  factory _$$SubmittingImplCopyWith(
    _$SubmittingImpl value,
    $Res Function(_$SubmittingImpl) then,
  ) = __$$SubmittingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<ClinicUserEntity> users});
}

/// @nodoc
class __$$SubmittingImplCopyWithImpl<$Res>
    extends _$ClinicUsersStateCopyWithImpl<$Res, _$SubmittingImpl>
    implements _$$SubmittingImplCopyWith<$Res> {
  __$$SubmittingImplCopyWithImpl(
    _$SubmittingImpl _value,
    $Res Function(_$SubmittingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClinicUsersState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? users = null}) {
    return _then(
      _$SubmittingImpl(
        null == users
            ? _value._users
            : users // ignore: cast_nullable_to_non_nullable
                  as List<ClinicUserEntity>,
      ),
    );
  }
}

/// @nodoc

class _$SubmittingImpl implements _Submitting {
  const _$SubmittingImpl(final List<ClinicUserEntity> users) : _users = users;

  final List<ClinicUserEntity> _users;
  @override
  List<ClinicUserEntity> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  @override
  String toString() {
    return 'ClinicUsersState.submitting(users: $users)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmittingImpl &&
            const DeepCollectionEquality().equals(other._users, _users));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_users));

  /// Create a copy of ClinicUsersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmittingImplCopyWith<_$SubmittingImpl> get copyWith =>
      __$$SubmittingImplCopyWithImpl<_$SubmittingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ClinicUserEntity> users) loaded,
    required TResult Function(String message) error,
    required TResult Function(List<ClinicUserEntity> users) submitting,
    required TResult Function(List<ClinicUserEntity> users, String message)
    submitSuccess,
    required TResult Function(List<ClinicUserEntity> users, String message)
    submitError,
  }) {
    return submitting(users);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ClinicUserEntity> users)? loaded,
    TResult? Function(String message)? error,
    TResult? Function(List<ClinicUserEntity> users)? submitting,
    TResult? Function(List<ClinicUserEntity> users, String message)?
    submitSuccess,
    TResult? Function(List<ClinicUserEntity> users, String message)?
    submitError,
  }) {
    return submitting?.call(users);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ClinicUserEntity> users)? loaded,
    TResult Function(String message)? error,
    TResult Function(List<ClinicUserEntity> users)? submitting,
    TResult Function(List<ClinicUserEntity> users, String message)?
    submitSuccess,
    TResult Function(List<ClinicUserEntity> users, String message)? submitError,
    required TResult orElse(),
  }) {
    if (submitting != null) {
      return submitting(users);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_SubmitSuccess value) submitSuccess,
    required TResult Function(_SubmitError value) submitError,
  }) {
    return submitting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_SubmitSuccess value)? submitSuccess,
    TResult? Function(_SubmitError value)? submitError,
  }) {
    return submitting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_SubmitSuccess value)? submitSuccess,
    TResult Function(_SubmitError value)? submitError,
    required TResult orElse(),
  }) {
    if (submitting != null) {
      return submitting(this);
    }
    return orElse();
  }
}

abstract class _Submitting implements ClinicUsersState {
  const factory _Submitting(final List<ClinicUserEntity> users) =
      _$SubmittingImpl;

  List<ClinicUserEntity> get users;

  /// Create a copy of ClinicUsersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubmittingImplCopyWith<_$SubmittingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SubmitSuccessImplCopyWith<$Res> {
  factory _$$SubmitSuccessImplCopyWith(
    _$SubmitSuccessImpl value,
    $Res Function(_$SubmitSuccessImpl) then,
  ) = __$$SubmitSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<ClinicUserEntity> users, String message});
}

/// @nodoc
class __$$SubmitSuccessImplCopyWithImpl<$Res>
    extends _$ClinicUsersStateCopyWithImpl<$Res, _$SubmitSuccessImpl>
    implements _$$SubmitSuccessImplCopyWith<$Res> {
  __$$SubmitSuccessImplCopyWithImpl(
    _$SubmitSuccessImpl _value,
    $Res Function(_$SubmitSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClinicUsersState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? users = null, Object? message = null}) {
    return _then(
      _$SubmitSuccessImpl(
        null == users
            ? _value._users
            : users // ignore: cast_nullable_to_non_nullable
                  as List<ClinicUserEntity>,
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SubmitSuccessImpl implements _SubmitSuccess {
  const _$SubmitSuccessImpl(final List<ClinicUserEntity> users, this.message)
    : _users = users;

  final List<ClinicUserEntity> _users;
  @override
  List<ClinicUserEntity> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  @override
  final String message;

  @override
  String toString() {
    return 'ClinicUsersState.submitSuccess(users: $users, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmitSuccessImpl &&
            const DeepCollectionEquality().equals(other._users, _users) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_users),
    message,
  );

  /// Create a copy of ClinicUsersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmitSuccessImplCopyWith<_$SubmitSuccessImpl> get copyWith =>
      __$$SubmitSuccessImplCopyWithImpl<_$SubmitSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ClinicUserEntity> users) loaded,
    required TResult Function(String message) error,
    required TResult Function(List<ClinicUserEntity> users) submitting,
    required TResult Function(List<ClinicUserEntity> users, String message)
    submitSuccess,
    required TResult Function(List<ClinicUserEntity> users, String message)
    submitError,
  }) {
    return submitSuccess(users, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ClinicUserEntity> users)? loaded,
    TResult? Function(String message)? error,
    TResult? Function(List<ClinicUserEntity> users)? submitting,
    TResult? Function(List<ClinicUserEntity> users, String message)?
    submitSuccess,
    TResult? Function(List<ClinicUserEntity> users, String message)?
    submitError,
  }) {
    return submitSuccess?.call(users, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ClinicUserEntity> users)? loaded,
    TResult Function(String message)? error,
    TResult Function(List<ClinicUserEntity> users)? submitting,
    TResult Function(List<ClinicUserEntity> users, String message)?
    submitSuccess,
    TResult Function(List<ClinicUserEntity> users, String message)? submitError,
    required TResult orElse(),
  }) {
    if (submitSuccess != null) {
      return submitSuccess(users, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_SubmitSuccess value) submitSuccess,
    required TResult Function(_SubmitError value) submitError,
  }) {
    return submitSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_SubmitSuccess value)? submitSuccess,
    TResult? Function(_SubmitError value)? submitError,
  }) {
    return submitSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_SubmitSuccess value)? submitSuccess,
    TResult Function(_SubmitError value)? submitError,
    required TResult orElse(),
  }) {
    if (submitSuccess != null) {
      return submitSuccess(this);
    }
    return orElse();
  }
}

abstract class _SubmitSuccess implements ClinicUsersState {
  const factory _SubmitSuccess(
    final List<ClinicUserEntity> users,
    final String message,
  ) = _$SubmitSuccessImpl;

  List<ClinicUserEntity> get users;
  String get message;

  /// Create a copy of ClinicUsersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubmitSuccessImplCopyWith<_$SubmitSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SubmitErrorImplCopyWith<$Res> {
  factory _$$SubmitErrorImplCopyWith(
    _$SubmitErrorImpl value,
    $Res Function(_$SubmitErrorImpl) then,
  ) = __$$SubmitErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<ClinicUserEntity> users, String message});
}

/// @nodoc
class __$$SubmitErrorImplCopyWithImpl<$Res>
    extends _$ClinicUsersStateCopyWithImpl<$Res, _$SubmitErrorImpl>
    implements _$$SubmitErrorImplCopyWith<$Res> {
  __$$SubmitErrorImplCopyWithImpl(
    _$SubmitErrorImpl _value,
    $Res Function(_$SubmitErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClinicUsersState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? users = null, Object? message = null}) {
    return _then(
      _$SubmitErrorImpl(
        null == users
            ? _value._users
            : users // ignore: cast_nullable_to_non_nullable
                  as List<ClinicUserEntity>,
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SubmitErrorImpl implements _SubmitError {
  const _$SubmitErrorImpl(final List<ClinicUserEntity> users, this.message)
    : _users = users;

  final List<ClinicUserEntity> _users;
  @override
  List<ClinicUserEntity> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  @override
  final String message;

  @override
  String toString() {
    return 'ClinicUsersState.submitError(users: $users, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmitErrorImpl &&
            const DeepCollectionEquality().equals(other._users, _users) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_users),
    message,
  );

  /// Create a copy of ClinicUsersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmitErrorImplCopyWith<_$SubmitErrorImpl> get copyWith =>
      __$$SubmitErrorImplCopyWithImpl<_$SubmitErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ClinicUserEntity> users) loaded,
    required TResult Function(String message) error,
    required TResult Function(List<ClinicUserEntity> users) submitting,
    required TResult Function(List<ClinicUserEntity> users, String message)
    submitSuccess,
    required TResult Function(List<ClinicUserEntity> users, String message)
    submitError,
  }) {
    return submitError(users, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ClinicUserEntity> users)? loaded,
    TResult? Function(String message)? error,
    TResult? Function(List<ClinicUserEntity> users)? submitting,
    TResult? Function(List<ClinicUserEntity> users, String message)?
    submitSuccess,
    TResult? Function(List<ClinicUserEntity> users, String message)?
    submitError,
  }) {
    return submitError?.call(users, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ClinicUserEntity> users)? loaded,
    TResult Function(String message)? error,
    TResult Function(List<ClinicUserEntity> users)? submitting,
    TResult Function(List<ClinicUserEntity> users, String message)?
    submitSuccess,
    TResult Function(List<ClinicUserEntity> users, String message)? submitError,
    required TResult orElse(),
  }) {
    if (submitError != null) {
      return submitError(users, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_SubmitSuccess value) submitSuccess,
    required TResult Function(_SubmitError value) submitError,
  }) {
    return submitError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_SubmitSuccess value)? submitSuccess,
    TResult? Function(_SubmitError value)? submitError,
  }) {
    return submitError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_SubmitSuccess value)? submitSuccess,
    TResult Function(_SubmitError value)? submitError,
    required TResult orElse(),
  }) {
    if (submitError != null) {
      return submitError(this);
    }
    return orElse();
  }
}

abstract class _SubmitError implements ClinicUsersState {
  const factory _SubmitError(
    final List<ClinicUserEntity> users,
    final String message,
  ) = _$SubmitErrorImpl;

  List<ClinicUserEntity> get users;
  String get message;

  /// Create a copy of ClinicUsersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubmitErrorImplCopyWith<_$SubmitErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
