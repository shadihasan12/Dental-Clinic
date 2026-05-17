// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_response_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RegisterSpecialtyEntity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Create a copy of RegisterSpecialtyEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegisterSpecialtyEntityCopyWith<RegisterSpecialtyEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterSpecialtyEntityCopyWith<$Res> {
  factory $RegisterSpecialtyEntityCopyWith(
    RegisterSpecialtyEntity value,
    $Res Function(RegisterSpecialtyEntity) then,
  ) = _$RegisterSpecialtyEntityCopyWithImpl<$Res, RegisterSpecialtyEntity>;
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class _$RegisterSpecialtyEntityCopyWithImpl<
  $Res,
  $Val extends RegisterSpecialtyEntity
>
    implements $RegisterSpecialtyEntityCopyWith<$Res> {
  _$RegisterSpecialtyEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegisterSpecialtyEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RegisterSpecialtyEntityImplCopyWith<$Res>
    implements $RegisterSpecialtyEntityCopyWith<$Res> {
  factory _$$RegisterSpecialtyEntityImplCopyWith(
    _$RegisterSpecialtyEntityImpl value,
    $Res Function(_$RegisterSpecialtyEntityImpl) then,
  ) = __$$RegisterSpecialtyEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class __$$RegisterSpecialtyEntityImplCopyWithImpl<$Res>
    extends
        _$RegisterSpecialtyEntityCopyWithImpl<
          $Res,
          _$RegisterSpecialtyEntityImpl
        >
    implements _$$RegisterSpecialtyEntityImplCopyWith<$Res> {
  __$$RegisterSpecialtyEntityImplCopyWithImpl(
    _$RegisterSpecialtyEntityImpl _value,
    $Res Function(_$RegisterSpecialtyEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RegisterSpecialtyEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _$RegisterSpecialtyEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$RegisterSpecialtyEntityImpl implements _RegisterSpecialtyEntity {
  const _$RegisterSpecialtyEntityImpl({required this.id, required this.name});

  @override
  final String id;
  @override
  final String name;

  @override
  String toString() {
    return 'RegisterSpecialtyEntity(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterSpecialtyEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of RegisterSpecialtyEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterSpecialtyEntityImplCopyWith<_$RegisterSpecialtyEntityImpl>
  get copyWith =>
      __$$RegisterSpecialtyEntityImplCopyWithImpl<
        _$RegisterSpecialtyEntityImpl
      >(this, _$identity);
}

abstract class _RegisterSpecialtyEntity implements RegisterSpecialtyEntity {
  const factory _RegisterSpecialtyEntity({
    required final String id,
    required final String name,
  }) = _$RegisterSpecialtyEntityImpl;

  @override
  String get id;
  @override
  String get name;

  /// Create a copy of RegisterSpecialtyEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterSpecialtyEntityImplCopyWith<_$RegisterSpecialtyEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RegisterLocationEntity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String get countryCode => throw _privateConstructorUsedError;

  /// Create a copy of RegisterLocationEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegisterLocationEntityCopyWith<RegisterLocationEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterLocationEntityCopyWith<$Res> {
  factory $RegisterLocationEntityCopyWith(
    RegisterLocationEntity value,
    $Res Function(RegisterLocationEntity) then,
  ) = _$RegisterLocationEntityCopyWithImpl<$Res, RegisterLocationEntity>;
  @useResult
  $Res call({String id, String name, String fullName, String countryCode});
}

/// @nodoc
class _$RegisterLocationEntityCopyWithImpl<
  $Res,
  $Val extends RegisterLocationEntity
>
    implements $RegisterLocationEntityCopyWith<$Res> {
  _$RegisterLocationEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegisterLocationEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? fullName = null,
    Object? countryCode = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            fullName: null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String,
            countryCode: null == countryCode
                ? _value.countryCode
                : countryCode // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RegisterLocationEntityImplCopyWith<$Res>
    implements $RegisterLocationEntityCopyWith<$Res> {
  factory _$$RegisterLocationEntityImplCopyWith(
    _$RegisterLocationEntityImpl value,
    $Res Function(_$RegisterLocationEntityImpl) then,
  ) = __$$RegisterLocationEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String fullName, String countryCode});
}

/// @nodoc
class __$$RegisterLocationEntityImplCopyWithImpl<$Res>
    extends
        _$RegisterLocationEntityCopyWithImpl<$Res, _$RegisterLocationEntityImpl>
    implements _$$RegisterLocationEntityImplCopyWith<$Res> {
  __$$RegisterLocationEntityImplCopyWithImpl(
    _$RegisterLocationEntityImpl _value,
    $Res Function(_$RegisterLocationEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RegisterLocationEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? fullName = null,
    Object? countryCode = null,
  }) {
    return _then(
      _$RegisterLocationEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        fullName: null == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String,
        countryCode: null == countryCode
            ? _value.countryCode
            : countryCode // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$RegisterLocationEntityImpl implements _RegisterLocationEntity {
  const _$RegisterLocationEntityImpl({
    required this.id,
    required this.name,
    required this.fullName,
    required this.countryCode,
  });

  @override
  final String id;
  @override
  final String name;
  @override
  final String fullName;
  @override
  final String countryCode;

  @override
  String toString() {
    return 'RegisterLocationEntity(id: $id, name: $name, fullName: $fullName, countryCode: $countryCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterLocationEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.countryCode, countryCode) ||
                other.countryCode == countryCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, fullName, countryCode);

  /// Create a copy of RegisterLocationEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterLocationEntityImplCopyWith<_$RegisterLocationEntityImpl>
  get copyWith =>
      __$$RegisterLocationEntityImplCopyWithImpl<_$RegisterLocationEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _RegisterLocationEntity implements RegisterLocationEntity {
  const factory _RegisterLocationEntity({
    required final String id,
    required final String name,
    required final String fullName,
    required final String countryCode,
  }) = _$RegisterLocationEntityImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  String get fullName;
  @override
  String get countryCode;

  /// Create a copy of RegisterLocationEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterLocationEntityImplCopyWith<_$RegisterLocationEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RegisterClinicEntity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  RegisterLocationEntity get location => throw _privateConstructorUsedError;
  String get detailedAddress => throw _privateConstructorUsedError;

  /// Create a copy of RegisterClinicEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegisterClinicEntityCopyWith<RegisterClinicEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterClinicEntityCopyWith<$Res> {
  factory $RegisterClinicEntityCopyWith(
    RegisterClinicEntity value,
    $Res Function(RegisterClinicEntity) then,
  ) = _$RegisterClinicEntityCopyWithImpl<$Res, RegisterClinicEntity>;
  @useResult
  $Res call({
    String id,
    String name,
    String type,
    RegisterLocationEntity location,
    String detailedAddress,
  });

  $RegisterLocationEntityCopyWith<$Res> get location;
}

/// @nodoc
class _$RegisterClinicEntityCopyWithImpl<
  $Res,
  $Val extends RegisterClinicEntity
>
    implements $RegisterClinicEntityCopyWith<$Res> {
  _$RegisterClinicEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegisterClinicEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? location = null,
    Object? detailedAddress = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            location: null == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as RegisterLocationEntity,
            detailedAddress: null == detailedAddress
                ? _value.detailedAddress
                : detailedAddress // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }

  /// Create a copy of RegisterClinicEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RegisterLocationEntityCopyWith<$Res> get location {
    return $RegisterLocationEntityCopyWith<$Res>(_value.location, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RegisterClinicEntityImplCopyWith<$Res>
    implements $RegisterClinicEntityCopyWith<$Res> {
  factory _$$RegisterClinicEntityImplCopyWith(
    _$RegisterClinicEntityImpl value,
    $Res Function(_$RegisterClinicEntityImpl) then,
  ) = __$$RegisterClinicEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String type,
    RegisterLocationEntity location,
    String detailedAddress,
  });

  @override
  $RegisterLocationEntityCopyWith<$Res> get location;
}

/// @nodoc
class __$$RegisterClinicEntityImplCopyWithImpl<$Res>
    extends _$RegisterClinicEntityCopyWithImpl<$Res, _$RegisterClinicEntityImpl>
    implements _$$RegisterClinicEntityImplCopyWith<$Res> {
  __$$RegisterClinicEntityImplCopyWithImpl(
    _$RegisterClinicEntityImpl _value,
    $Res Function(_$RegisterClinicEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RegisterClinicEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? location = null,
    Object? detailedAddress = null,
  }) {
    return _then(
      _$RegisterClinicEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        location: null == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as RegisterLocationEntity,
        detailedAddress: null == detailedAddress
            ? _value.detailedAddress
            : detailedAddress // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$RegisterClinicEntityImpl implements _RegisterClinicEntity {
  const _$RegisterClinicEntityImpl({
    required this.id,
    required this.name,
    required this.type,
    required this.location,
    required this.detailedAddress,
  });

  @override
  final String id;
  @override
  final String name;
  @override
  final String type;
  @override
  final RegisterLocationEntity location;
  @override
  final String detailedAddress;

  @override
  String toString() {
    return 'RegisterClinicEntity(id: $id, name: $name, type: $type, location: $location, detailedAddress: $detailedAddress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterClinicEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.detailedAddress, detailedAddress) ||
                other.detailedAddress == detailedAddress));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, type, location, detailedAddress);

  /// Create a copy of RegisterClinicEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterClinicEntityImplCopyWith<_$RegisterClinicEntityImpl>
  get copyWith =>
      __$$RegisterClinicEntityImplCopyWithImpl<_$RegisterClinicEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _RegisterClinicEntity implements RegisterClinicEntity {
  const factory _RegisterClinicEntity({
    required final String id,
    required final String name,
    required final String type,
    required final RegisterLocationEntity location,
    required final String detailedAddress,
  }) = _$RegisterClinicEntityImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  String get type;
  @override
  RegisterLocationEntity get location;
  @override
  String get detailedAddress;

  /// Create a copy of RegisterClinicEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterClinicEntityImplCopyWith<_$RegisterClinicEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RegisterClinicMembershipEntity {
  RegisterClinicEntity get clinic => throw _privateConstructorUsedError;
  List<String> get roles =>
      throw _privateConstructorUsedError; // True when the user is the original owner of the clinic — drives
  // the "cannot be removed by other admins" rule downstream.
  bool get isOwner => throw _privateConstructorUsedError;

  /// Create a copy of RegisterClinicMembershipEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegisterClinicMembershipEntityCopyWith<RegisterClinicMembershipEntity>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterClinicMembershipEntityCopyWith<$Res> {
  factory $RegisterClinicMembershipEntityCopyWith(
    RegisterClinicMembershipEntity value,
    $Res Function(RegisterClinicMembershipEntity) then,
  ) =
      _$RegisterClinicMembershipEntityCopyWithImpl<
        $Res,
        RegisterClinicMembershipEntity
      >;
  @useResult
  $Res call({RegisterClinicEntity clinic, List<String> roles, bool isOwner});

  $RegisterClinicEntityCopyWith<$Res> get clinic;
}

/// @nodoc
class _$RegisterClinicMembershipEntityCopyWithImpl<
  $Res,
  $Val extends RegisterClinicMembershipEntity
>
    implements $RegisterClinicMembershipEntityCopyWith<$Res> {
  _$RegisterClinicMembershipEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegisterClinicMembershipEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clinic = null,
    Object? roles = null,
    Object? isOwner = null,
  }) {
    return _then(
      _value.copyWith(
            clinic: null == clinic
                ? _value.clinic
                : clinic // ignore: cast_nullable_to_non_nullable
                      as RegisterClinicEntity,
            roles: null == roles
                ? _value.roles
                : roles // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isOwner: null == isOwner
                ? _value.isOwner
                : isOwner // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of RegisterClinicMembershipEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RegisterClinicEntityCopyWith<$Res> get clinic {
    return $RegisterClinicEntityCopyWith<$Res>(_value.clinic, (value) {
      return _then(_value.copyWith(clinic: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RegisterClinicMembershipEntityImplCopyWith<$Res>
    implements $RegisterClinicMembershipEntityCopyWith<$Res> {
  factory _$$RegisterClinicMembershipEntityImplCopyWith(
    _$RegisterClinicMembershipEntityImpl value,
    $Res Function(_$RegisterClinicMembershipEntityImpl) then,
  ) = __$$RegisterClinicMembershipEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({RegisterClinicEntity clinic, List<String> roles, bool isOwner});

  @override
  $RegisterClinicEntityCopyWith<$Res> get clinic;
}

/// @nodoc
class __$$RegisterClinicMembershipEntityImplCopyWithImpl<$Res>
    extends
        _$RegisterClinicMembershipEntityCopyWithImpl<
          $Res,
          _$RegisterClinicMembershipEntityImpl
        >
    implements _$$RegisterClinicMembershipEntityImplCopyWith<$Res> {
  __$$RegisterClinicMembershipEntityImplCopyWithImpl(
    _$RegisterClinicMembershipEntityImpl _value,
    $Res Function(_$RegisterClinicMembershipEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RegisterClinicMembershipEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clinic = null,
    Object? roles = null,
    Object? isOwner = null,
  }) {
    return _then(
      _$RegisterClinicMembershipEntityImpl(
        clinic: null == clinic
            ? _value.clinic
            : clinic // ignore: cast_nullable_to_non_nullable
                  as RegisterClinicEntity,
        roles: null == roles
            ? _value._roles
            : roles // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isOwner: null == isOwner
            ? _value.isOwner
            : isOwner // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$RegisterClinicMembershipEntityImpl
    implements _RegisterClinicMembershipEntity {
  const _$RegisterClinicMembershipEntityImpl({
    required this.clinic,
    required final List<String> roles,
    this.isOwner = false,
  }) : _roles = roles;

  @override
  final RegisterClinicEntity clinic;
  final List<String> _roles;
  @override
  List<String> get roles {
    if (_roles is EqualUnmodifiableListView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roles);
  }

  // True when the user is the original owner of the clinic — drives
  // the "cannot be removed by other admins" rule downstream.
  @override
  @JsonKey()
  final bool isOwner;

  @override
  String toString() {
    return 'RegisterClinicMembershipEntity(clinic: $clinic, roles: $roles, isOwner: $isOwner)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterClinicMembershipEntityImpl &&
            (identical(other.clinic, clinic) || other.clinic == clinic) &&
            const DeepCollectionEquality().equals(other._roles, _roles) &&
            (identical(other.isOwner, isOwner) || other.isOwner == isOwner));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    clinic,
    const DeepCollectionEquality().hash(_roles),
    isOwner,
  );

  /// Create a copy of RegisterClinicMembershipEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterClinicMembershipEntityImplCopyWith<
    _$RegisterClinicMembershipEntityImpl
  >
  get copyWith =>
      __$$RegisterClinicMembershipEntityImplCopyWithImpl<
        _$RegisterClinicMembershipEntityImpl
      >(this, _$identity);
}

abstract class _RegisterClinicMembershipEntity
    implements RegisterClinicMembershipEntity {
  const factory _RegisterClinicMembershipEntity({
    required final RegisterClinicEntity clinic,
    required final List<String> roles,
    final bool isOwner,
  }) = _$RegisterClinicMembershipEntityImpl;

  @override
  RegisterClinicEntity get clinic;
  @override
  List<String> get roles; // True when the user is the original owner of the clinic — drives
  // the "cannot be removed by other admins" rule downstream.
  @override
  bool get isOwner;

  /// Create a copy of RegisterClinicMembershipEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterClinicMembershipEntityImplCopyWith<
    _$RegisterClinicMembershipEntityImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RegisterResponseEntity {
  String get id => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  bool get emailVerified => throw _privateConstructorUsedError;
  String get mobileNumber => throw _privateConstructorUsedError;
  bool get isSuperAdmin => throw _privateConstructorUsedError;
  RegisterSpecialtyEntity get specialty => throw _privateConstructorUsedError;
  List<RegisterClinicMembershipEntity> get clinics =>
      throw _privateConstructorUsedError;

  /// Create a copy of RegisterResponseEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegisterResponseEntityCopyWith<RegisterResponseEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterResponseEntityCopyWith<$Res> {
  factory $RegisterResponseEntityCopyWith(
    RegisterResponseEntity value,
    $Res Function(RegisterResponseEntity) then,
  ) = _$RegisterResponseEntityCopyWithImpl<$Res, RegisterResponseEntity>;
  @useResult
  $Res call({
    String id,
    String? image,
    String name,
    String email,
    bool emailVerified,
    String mobileNumber,
    bool isSuperAdmin,
    RegisterSpecialtyEntity specialty,
    List<RegisterClinicMembershipEntity> clinics,
  });

  $RegisterSpecialtyEntityCopyWith<$Res> get specialty;
}

/// @nodoc
class _$RegisterResponseEntityCopyWithImpl<
  $Res,
  $Val extends RegisterResponseEntity
>
    implements $RegisterResponseEntityCopyWith<$Res> {
  _$RegisterResponseEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegisterResponseEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? image = freezed,
    Object? name = null,
    Object? email = null,
    Object? emailVerified = null,
    Object? mobileNumber = null,
    Object? isSuperAdmin = null,
    Object? specialty = null,
    Object? clinics = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            image: freezed == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            emailVerified: null == emailVerified
                ? _value.emailVerified
                : emailVerified // ignore: cast_nullable_to_non_nullable
                      as bool,
            mobileNumber: null == mobileNumber
                ? _value.mobileNumber
                : mobileNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            isSuperAdmin: null == isSuperAdmin
                ? _value.isSuperAdmin
                : isSuperAdmin // ignore: cast_nullable_to_non_nullable
                      as bool,
            specialty: null == specialty
                ? _value.specialty
                : specialty // ignore: cast_nullable_to_non_nullable
                      as RegisterSpecialtyEntity,
            clinics: null == clinics
                ? _value.clinics
                : clinics // ignore: cast_nullable_to_non_nullable
                      as List<RegisterClinicMembershipEntity>,
          )
          as $Val,
    );
  }

  /// Create a copy of RegisterResponseEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RegisterSpecialtyEntityCopyWith<$Res> get specialty {
    return $RegisterSpecialtyEntityCopyWith<$Res>(_value.specialty, (value) {
      return _then(_value.copyWith(specialty: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RegisterResponseEntityImplCopyWith<$Res>
    implements $RegisterResponseEntityCopyWith<$Res> {
  factory _$$RegisterResponseEntityImplCopyWith(
    _$RegisterResponseEntityImpl value,
    $Res Function(_$RegisterResponseEntityImpl) then,
  ) = __$$RegisterResponseEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? image,
    String name,
    String email,
    bool emailVerified,
    String mobileNumber,
    bool isSuperAdmin,
    RegisterSpecialtyEntity specialty,
    List<RegisterClinicMembershipEntity> clinics,
  });

  @override
  $RegisterSpecialtyEntityCopyWith<$Res> get specialty;
}

/// @nodoc
class __$$RegisterResponseEntityImplCopyWithImpl<$Res>
    extends
        _$RegisterResponseEntityCopyWithImpl<$Res, _$RegisterResponseEntityImpl>
    implements _$$RegisterResponseEntityImplCopyWith<$Res> {
  __$$RegisterResponseEntityImplCopyWithImpl(
    _$RegisterResponseEntityImpl _value,
    $Res Function(_$RegisterResponseEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RegisterResponseEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? image = freezed,
    Object? name = null,
    Object? email = null,
    Object? emailVerified = null,
    Object? mobileNumber = null,
    Object? isSuperAdmin = null,
    Object? specialty = null,
    Object? clinics = null,
  }) {
    return _then(
      _$RegisterResponseEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        image: freezed == image
            ? _value.image
            : image // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        emailVerified: null == emailVerified
            ? _value.emailVerified
            : emailVerified // ignore: cast_nullable_to_non_nullable
                  as bool,
        mobileNumber: null == mobileNumber
            ? _value.mobileNumber
            : mobileNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        isSuperAdmin: null == isSuperAdmin
            ? _value.isSuperAdmin
            : isSuperAdmin // ignore: cast_nullable_to_non_nullable
                  as bool,
        specialty: null == specialty
            ? _value.specialty
            : specialty // ignore: cast_nullable_to_non_nullable
                  as RegisterSpecialtyEntity,
        clinics: null == clinics
            ? _value._clinics
            : clinics // ignore: cast_nullable_to_non_nullable
                  as List<RegisterClinicMembershipEntity>,
      ),
    );
  }
}

/// @nodoc

class _$RegisterResponseEntityImpl extends _RegisterResponseEntity {
  const _$RegisterResponseEntityImpl({
    required this.id,
    this.image,
    required this.name,
    required this.email,
    required this.emailVerified,
    required this.mobileNumber,
    required this.isSuperAdmin,
    required this.specialty,
    required final List<RegisterClinicMembershipEntity> clinics,
  }) : _clinics = clinics,
       super._();

  @override
  final String id;
  @override
  final String? image;
  @override
  final String name;
  @override
  final String email;
  @override
  final bool emailVerified;
  @override
  final String mobileNumber;
  @override
  final bool isSuperAdmin;
  @override
  final RegisterSpecialtyEntity specialty;
  final List<RegisterClinicMembershipEntity> _clinics;
  @override
  List<RegisterClinicMembershipEntity> get clinics {
    if (_clinics is EqualUnmodifiableListView) return _clinics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_clinics);
  }

  @override
  String toString() {
    return 'RegisterResponseEntity(id: $id, image: $image, name: $name, email: $email, emailVerified: $emailVerified, mobileNumber: $mobileNumber, isSuperAdmin: $isSuperAdmin, specialty: $specialty, clinics: $clinics)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterResponseEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.emailVerified, emailVerified) ||
                other.emailVerified == emailVerified) &&
            (identical(other.mobileNumber, mobileNumber) ||
                other.mobileNumber == mobileNumber) &&
            (identical(other.isSuperAdmin, isSuperAdmin) ||
                other.isSuperAdmin == isSuperAdmin) &&
            (identical(other.specialty, specialty) ||
                other.specialty == specialty) &&
            const DeepCollectionEquality().equals(other._clinics, _clinics));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    image,
    name,
    email,
    emailVerified,
    mobileNumber,
    isSuperAdmin,
    specialty,
    const DeepCollectionEquality().hash(_clinics),
  );

  /// Create a copy of RegisterResponseEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterResponseEntityImplCopyWith<_$RegisterResponseEntityImpl>
  get copyWith =>
      __$$RegisterResponseEntityImplCopyWithImpl<_$RegisterResponseEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _RegisterResponseEntity extends RegisterResponseEntity {
  const factory _RegisterResponseEntity({
    required final String id,
    final String? image,
    required final String name,
    required final String email,
    required final bool emailVerified,
    required final String mobileNumber,
    required final bool isSuperAdmin,
    required final RegisterSpecialtyEntity specialty,
    required final List<RegisterClinicMembershipEntity> clinics,
  }) = _$RegisterResponseEntityImpl;
  const _RegisterResponseEntity._() : super._();

  @override
  String get id;
  @override
  String? get image;
  @override
  String get name;
  @override
  String get email;
  @override
  bool get emailVerified;
  @override
  String get mobileNumber;
  @override
  bool get isSuperAdmin;
  @override
  RegisterSpecialtyEntity get specialty;
  @override
  List<RegisterClinicMembershipEntity> get clinics;

  /// Create a copy of RegisterResponseEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterResponseEntityImplCopyWith<_$RegisterResponseEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}
