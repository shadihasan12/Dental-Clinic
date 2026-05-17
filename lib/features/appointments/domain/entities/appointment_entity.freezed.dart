// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AppointmentEntity {
  String get id => throw _privateConstructorUsedError;
  String get patientId => throw _privateConstructorUsedError;
  String get patientName => throw _privateConstructorUsedError;
  String get doctorId => throw _privateConstructorUsedError;
  String get doctorName => throw _privateConstructorUsedError;
  DateTime get dateTime => throw _privateConstructorUsedError;
  int get durationMinutes => throw _privateConstructorUsedError;
  String get treatmentType => throw _privateConstructorUsedError;
  AppointmentStatus get status => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String? get clinicId => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  List<AuditEntry> get audits => throw _privateConstructorUsedError;

  /// Create a copy of AppointmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppointmentEntityCopyWith<AppointmentEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentEntityCopyWith<$Res> {
  factory $AppointmentEntityCopyWith(
    AppointmentEntity value,
    $Res Function(AppointmentEntity) then,
  ) = _$AppointmentEntityCopyWithImpl<$Res, AppointmentEntity>;
  @useResult
  $Res call({
    String id,
    String patientId,
    String patientName,
    String doctorId,
    String doctorName,
    DateTime dateTime,
    int durationMinutes,
    String treatmentType,
    AppointmentStatus status,
    String? notes,
    String? clinicId,
    DateTime? createdAt,
    List<AuditEntry> audits,
  });
}

/// @nodoc
class _$AppointmentEntityCopyWithImpl<$Res, $Val extends AppointmentEntity>
    implements $AppointmentEntityCopyWith<$Res> {
  _$AppointmentEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppointmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? patientId = null,
    Object? patientName = null,
    Object? doctorId = null,
    Object? doctorName = null,
    Object? dateTime = null,
    Object? durationMinutes = null,
    Object? treatmentType = null,
    Object? status = null,
    Object? notes = freezed,
    Object? clinicId = freezed,
    Object? createdAt = freezed,
    Object? audits = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            patientId: null == patientId
                ? _value.patientId
                : patientId // ignore: cast_nullable_to_non_nullable
                      as String,
            patientName: null == patientName
                ? _value.patientName
                : patientName // ignore: cast_nullable_to_non_nullable
                      as String,
            doctorId: null == doctorId
                ? _value.doctorId
                : doctorId // ignore: cast_nullable_to_non_nullable
                      as String,
            doctorName: null == doctorName
                ? _value.doctorName
                : doctorName // ignore: cast_nullable_to_non_nullable
                      as String,
            dateTime: null == dateTime
                ? _value.dateTime
                : dateTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            durationMinutes: null == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            treatmentType: null == treatmentType
                ? _value.treatmentType
                : treatmentType // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as AppointmentStatus,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            clinicId: freezed == clinicId
                ? _value.clinicId
                : clinicId // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            audits: null == audits
                ? _value.audits
                : audits // ignore: cast_nullable_to_non_nullable
                      as List<AuditEntry>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AppointmentEntityImplCopyWith<$Res>
    implements $AppointmentEntityCopyWith<$Res> {
  factory _$$AppointmentEntityImplCopyWith(
    _$AppointmentEntityImpl value,
    $Res Function(_$AppointmentEntityImpl) then,
  ) = __$$AppointmentEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String patientId,
    String patientName,
    String doctorId,
    String doctorName,
    DateTime dateTime,
    int durationMinutes,
    String treatmentType,
    AppointmentStatus status,
    String? notes,
    String? clinicId,
    DateTime? createdAt,
    List<AuditEntry> audits,
  });
}

/// @nodoc
class __$$AppointmentEntityImplCopyWithImpl<$Res>
    extends _$AppointmentEntityCopyWithImpl<$Res, _$AppointmentEntityImpl>
    implements _$$AppointmentEntityImplCopyWith<$Res> {
  __$$AppointmentEntityImplCopyWithImpl(
    _$AppointmentEntityImpl _value,
    $Res Function(_$AppointmentEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppointmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? patientId = null,
    Object? patientName = null,
    Object? doctorId = null,
    Object? doctorName = null,
    Object? dateTime = null,
    Object? durationMinutes = null,
    Object? treatmentType = null,
    Object? status = null,
    Object? notes = freezed,
    Object? clinicId = freezed,
    Object? createdAt = freezed,
    Object? audits = null,
  }) {
    return _then(
      _$AppointmentEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        patientId: null == patientId
            ? _value.patientId
            : patientId // ignore: cast_nullable_to_non_nullable
                  as String,
        patientName: null == patientName
            ? _value.patientName
            : patientName // ignore: cast_nullable_to_non_nullable
                  as String,
        doctorId: null == doctorId
            ? _value.doctorId
            : doctorId // ignore: cast_nullable_to_non_nullable
                  as String,
        doctorName: null == doctorName
            ? _value.doctorName
            : doctorName // ignore: cast_nullable_to_non_nullable
                  as String,
        dateTime: null == dateTime
            ? _value.dateTime
            : dateTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        durationMinutes: null == durationMinutes
            ? _value.durationMinutes
            : durationMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        treatmentType: null == treatmentType
            ? _value.treatmentType
            : treatmentType // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as AppointmentStatus,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        clinicId: freezed == clinicId
            ? _value.clinicId
            : clinicId // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        audits: null == audits
            ? _value._audits
            : audits // ignore: cast_nullable_to_non_nullable
                  as List<AuditEntry>,
      ),
    );
  }
}

/// @nodoc

class _$AppointmentEntityImpl extends _AppointmentEntity {
  const _$AppointmentEntityImpl({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.doctorId,
    required this.doctorName,
    required this.dateTime,
    required this.durationMinutes,
    required this.treatmentType,
    required this.status,
    this.notes,
    this.clinicId,
    this.createdAt,
    final List<AuditEntry> audits = const [],
  }) : _audits = audits,
       super._();

  @override
  final String id;
  @override
  final String patientId;
  @override
  final String patientName;
  @override
  final String doctorId;
  @override
  final String doctorName;
  @override
  final DateTime dateTime;
  @override
  final int durationMinutes;
  @override
  final String treatmentType;
  @override
  final AppointmentStatus status;
  @override
  final String? notes;
  @override
  final String? clinicId;
  @override
  final DateTime? createdAt;
  final List<AuditEntry> _audits;
  @override
  @JsonKey()
  List<AuditEntry> get audits {
    if (_audits is EqualUnmodifiableListView) return _audits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_audits);
  }

  @override
  String toString() {
    return 'AppointmentEntity(id: $id, patientId: $patientId, patientName: $patientName, doctorId: $doctorId, doctorName: $doctorName, dateTime: $dateTime, durationMinutes: $durationMinutes, treatmentType: $treatmentType, status: $status, notes: $notes, clinicId: $clinicId, createdAt: $createdAt, audits: $audits)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppointmentEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.patientId, patientId) ||
                other.patientId == patientId) &&
            (identical(other.patientName, patientName) ||
                other.patientName == patientName) &&
            (identical(other.doctorId, doctorId) ||
                other.doctorId == doctorId) &&
            (identical(other.doctorName, doctorName) ||
                other.doctorName == doctorName) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.treatmentType, treatmentType) ||
                other.treatmentType == treatmentType) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.clinicId, clinicId) ||
                other.clinicId == clinicId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._audits, _audits));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    patientId,
    patientName,
    doctorId,
    doctorName,
    dateTime,
    durationMinutes,
    treatmentType,
    status,
    notes,
    clinicId,
    createdAt,
    const DeepCollectionEquality().hash(_audits),
  );

  /// Create a copy of AppointmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppointmentEntityImplCopyWith<_$AppointmentEntityImpl> get copyWith =>
      __$$AppointmentEntityImplCopyWithImpl<_$AppointmentEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _AppointmentEntity extends AppointmentEntity {
  const factory _AppointmentEntity({
    required final String id,
    required final String patientId,
    required final String patientName,
    required final String doctorId,
    required final String doctorName,
    required final DateTime dateTime,
    required final int durationMinutes,
    required final String treatmentType,
    required final AppointmentStatus status,
    final String? notes,
    final String? clinicId,
    final DateTime? createdAt,
    final List<AuditEntry> audits,
  }) = _$AppointmentEntityImpl;
  const _AppointmentEntity._() : super._();

  @override
  String get id;
  @override
  String get patientId;
  @override
  String get patientName;
  @override
  String get doctorId;
  @override
  String get doctorName;
  @override
  DateTime get dateTime;
  @override
  int get durationMinutes;
  @override
  String get treatmentType;
  @override
  AppointmentStatus get status;
  @override
  String? get notes;
  @override
  String? get clinicId;
  @override
  DateTime? get createdAt;
  @override
  List<AuditEntry> get audits;

  /// Create a copy of AppointmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppointmentEntityImplCopyWith<_$AppointmentEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
