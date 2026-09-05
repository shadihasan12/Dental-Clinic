// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clinic_info_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ClinicInfoEntity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get locationId => throw _privateConstructorUsedError;
  String get locationName => throw _privateConstructorUsedError;
  String get locationFullName => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  List<WorkingDayEntity> get workingDays => throw _privateConstructorUsedError;
  List<HolidayEntity> get holidays => throw _privateConstructorUsedError;

  /// Create a copy of ClinicInfoEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClinicInfoEntityCopyWith<ClinicInfoEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClinicInfoEntityCopyWith<$Res> {
  factory $ClinicInfoEntityCopyWith(
    ClinicInfoEntity value,
    $Res Function(ClinicInfoEntity) then,
  ) = _$ClinicInfoEntityCopyWithImpl<$Res, ClinicInfoEntity>;
  @useResult
  $Res call({
    String id,
    String name,
    String locationId,
    String locationName,
    String locationFullName,
    String address,
    List<WorkingDayEntity> workingDays,
    List<HolidayEntity> holidays,
  });
}

/// @nodoc
class _$ClinicInfoEntityCopyWithImpl<$Res, $Val extends ClinicInfoEntity>
    implements $ClinicInfoEntityCopyWith<$Res> {
  _$ClinicInfoEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClinicInfoEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? locationId = null,
    Object? locationName = null,
    Object? locationFullName = null,
    Object? address = null,
    Object? workingDays = null,
    Object? holidays = null,
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
        locationId: null == locationId
            ? _value.locationId
            : locationId // ignore: cast_nullable_to_non_nullable
                as String,
        locationName: null == locationName
            ? _value.locationName
            : locationName // ignore: cast_nullable_to_non_nullable
                as String,
        locationFullName: null == locationFullName
            ? _value.locationFullName
            : locationFullName // ignore: cast_nullable_to_non_nullable
                as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                as String,
        workingDays: null == workingDays
            ? _value.workingDays
            : workingDays // ignore: cast_nullable_to_non_nullable
                as List<WorkingDayEntity>,
        holidays: null == holidays
            ? _value.holidays
            : holidays // ignore: cast_nullable_to_non_nullable
                as List<HolidayEntity>,
      ) as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClinicInfoEntityImplCopyWith<$Res>
    implements $ClinicInfoEntityCopyWith<$Res> {
  factory _$$ClinicInfoEntityImplCopyWith(
    _$ClinicInfoEntityImpl value,
    $Res Function(_$ClinicInfoEntityImpl) then,
  ) = __$$ClinicInfoEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String locationId,
    String locationName,
    String locationFullName,
    String address,
    List<WorkingDayEntity> workingDays,
    List<HolidayEntity> holidays,
  });
}

/// @nodoc
class __$$ClinicInfoEntityImplCopyWithImpl<$Res>
    extends _$ClinicInfoEntityCopyWithImpl<$Res, _$ClinicInfoEntityImpl>
    implements _$$ClinicInfoEntityImplCopyWith<$Res> {
  __$$ClinicInfoEntityImplCopyWithImpl(
    _$ClinicInfoEntityImpl _value,
    $Res Function(_$ClinicInfoEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClinicInfoEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? locationId = null,
    Object? locationName = null,
    Object? locationFullName = null,
    Object? address = null,
    Object? workingDays = null,
    Object? holidays = null,
  }) {
    return _then(
      _$ClinicInfoEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                as String,
        locationId: null == locationId
            ? _value.locationId
            : locationId // ignore: cast_nullable_to_non_nullable
                as String,
        locationName: null == locationName
            ? _value.locationName
            : locationName // ignore: cast_nullable_to_non_nullable
                as String,
        locationFullName: null == locationFullName
            ? _value.locationFullName
            : locationFullName // ignore: cast_nullable_to_non_nullable
                as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                as String,
        workingDays: null == workingDays
            ? _value._workingDays
            : workingDays // ignore: cast_nullable_to_non_nullable
                as List<WorkingDayEntity>,
        holidays: null == holidays
            ? _value._holidays
            : holidays // ignore: cast_nullable_to_non_nullable
                as List<HolidayEntity>,
      ),
    );
  }
}

/// @nodoc

class _$ClinicInfoEntityImpl implements _ClinicInfoEntity {
  const _$ClinicInfoEntityImpl({
    required this.id,
    required this.name,
    this.locationId = '',
    this.locationName = '',
    this.locationFullName = '',
    this.address = '',
    required final List<WorkingDayEntity> workingDays,
    final List<HolidayEntity> holidays = const [],
  })  : _workingDays = workingDays,
        _holidays = holidays;

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final String locationId;
  @override
  @JsonKey()
  final String locationName;
  @override
  @JsonKey()
  final String locationFullName;
  @override
  @JsonKey()
  final String address;
  final List<WorkingDayEntity> _workingDays;
  @override
  List<WorkingDayEntity> get workingDays {
    if (_workingDays is EqualUnmodifiableListView) return _workingDays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_workingDays);
  }

  final List<HolidayEntity> _holidays;
  @override
  @JsonKey()
  List<HolidayEntity> get holidays {
    if (_holidays is EqualUnmodifiableListView) return _holidays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_holidays);
  }

  @override
  String toString() {
    return 'ClinicInfoEntity(id: $id, name: $name, locationId: $locationId, locationName: $locationName, locationFullName: $locationFullName, address: $address, workingDays: $workingDays, holidays: $holidays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClinicInfoEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.locationId, locationId) ||
                other.locationId == locationId) &&
            (identical(other.locationName, locationName) ||
                other.locationName == locationName) &&
            (identical(other.locationFullName, locationFullName) ||
                other.locationFullName == locationFullName) &&
            (identical(other.address, address) || other.address == address) &&
            const DeepCollectionEquality().equals(
              other._workingDays,
              _workingDays,
            ) &&
            const DeepCollectionEquality().equals(other._holidays, _holidays));
  }

  @override
  int get hashCode => Object.hash(
        runtimeType,
        id,
        name,
        locationId,
        locationName,
        locationFullName,
        address,
        const DeepCollectionEquality().hash(_workingDays),
        const DeepCollectionEquality().hash(_holidays),
      );

  /// Create a copy of ClinicInfoEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClinicInfoEntityImplCopyWith<_$ClinicInfoEntityImpl> get copyWith =>
      __$$ClinicInfoEntityImplCopyWithImpl<_$ClinicInfoEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _ClinicInfoEntity implements ClinicInfoEntity {
  const factory _ClinicInfoEntity({
    required final String id,
    required final String name,
    final String locationId,
    final String locationName,
    final String locationFullName,
    final String address,
    required final List<WorkingDayEntity> workingDays,
    final List<HolidayEntity> holidays,
  }) = _$ClinicInfoEntityImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  String get locationId;
  @override
  String get locationName;
  @override
  String get locationFullName;
  @override
  String get address;
  @override
  List<WorkingDayEntity> get workingDays;
  @override
  List<HolidayEntity> get holidays;

  /// Create a copy of ClinicInfoEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClinicInfoEntityImplCopyWith<_$ClinicInfoEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
