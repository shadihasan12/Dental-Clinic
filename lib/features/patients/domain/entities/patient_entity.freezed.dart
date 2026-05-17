// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patient_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PatientEntity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get age => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  DateTime get dateOfBirth => throw _privateConstructorUsedError;
  String? get medicalHistory => throw _privateConstructorUsedError;
  String? get allergies => throw _privateConstructorUsedError;
  String? get insuranceProvider => throw _privateConstructorUsedError;
  String? get insuranceNumber => throw _privateConstructorUsedError;
  String? get emergencyContact => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  String? get nextVisit => throw _privateConstructorUsedError;
  double get balance => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  List<AuditEntry> get audits => throw _privateConstructorUsedError;

  /// Create a copy of PatientEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PatientEntityCopyWith<PatientEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatientEntityCopyWith<$Res> {
  factory $PatientEntityCopyWith(
    PatientEntity value,
    $Res Function(PatientEntity) then,
  ) = _$PatientEntityCopyWithImpl<$Res, PatientEntity>;
  @useResult
  $Res call({
    String id,
    String name,
    int age,
    String gender,
    String phone,
    String email,
    String address,
    DateTime dateOfBirth,
    String? medicalHistory,
    String? allergies,
    String? insuranceProvider,
    String? insuranceNumber,
    String? emergencyContact,
    String status,
    String? avatarUrl,
    String? nextVisit,
    double balance,
    DateTime? createdAt,
    List<AuditEntry> audits,
  });
}

/// @nodoc
class _$PatientEntityCopyWithImpl<$Res, $Val extends PatientEntity>
    implements $PatientEntityCopyWith<$Res> {
  _$PatientEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PatientEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? age = null,
    Object? gender = null,
    Object? phone = null,
    Object? email = null,
    Object? address = null,
    Object? dateOfBirth = null,
    Object? medicalHistory = freezed,
    Object? allergies = freezed,
    Object? insuranceProvider = freezed,
    Object? insuranceNumber = freezed,
    Object? emergencyContact = freezed,
    Object? status = null,
    Object? avatarUrl = freezed,
    Object? nextVisit = freezed,
    Object? balance = null,
    Object? createdAt = freezed,
    Object? audits = null,
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
            age: null == age
                ? _value.age
                : age // ignore: cast_nullable_to_non_nullable
                      as int,
            gender: null == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            dateOfBirth: null == dateOfBirth
                ? _value.dateOfBirth
                : dateOfBirth // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            medicalHistory: freezed == medicalHistory
                ? _value.medicalHistory
                : medicalHistory // ignore: cast_nullable_to_non_nullable
                      as String?,
            allergies: freezed == allergies
                ? _value.allergies
                : allergies // ignore: cast_nullable_to_non_nullable
                      as String?,
            insuranceProvider: freezed == insuranceProvider
                ? _value.insuranceProvider
                : insuranceProvider // ignore: cast_nullable_to_non_nullable
                      as String?,
            insuranceNumber: freezed == insuranceNumber
                ? _value.insuranceNumber
                : insuranceNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            emergencyContact: freezed == emergencyContact
                ? _value.emergencyContact
                : emergencyContact // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            nextVisit: freezed == nextVisit
                ? _value.nextVisit
                : nextVisit // ignore: cast_nullable_to_non_nullable
                      as String?,
            balance: null == balance
                ? _value.balance
                : balance // ignore: cast_nullable_to_non_nullable
                      as double,
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
abstract class _$$PatientEntityImplCopyWith<$Res>
    implements $PatientEntityCopyWith<$Res> {
  factory _$$PatientEntityImplCopyWith(
    _$PatientEntityImpl value,
    $Res Function(_$PatientEntityImpl) then,
  ) = __$$PatientEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    int age,
    String gender,
    String phone,
    String email,
    String address,
    DateTime dateOfBirth,
    String? medicalHistory,
    String? allergies,
    String? insuranceProvider,
    String? insuranceNumber,
    String? emergencyContact,
    String status,
    String? avatarUrl,
    String? nextVisit,
    double balance,
    DateTime? createdAt,
    List<AuditEntry> audits,
  });
}

/// @nodoc
class __$$PatientEntityImplCopyWithImpl<$Res>
    extends _$PatientEntityCopyWithImpl<$Res, _$PatientEntityImpl>
    implements _$$PatientEntityImplCopyWith<$Res> {
  __$$PatientEntityImplCopyWithImpl(
    _$PatientEntityImpl _value,
    $Res Function(_$PatientEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PatientEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? age = null,
    Object? gender = null,
    Object? phone = null,
    Object? email = null,
    Object? address = null,
    Object? dateOfBirth = null,
    Object? medicalHistory = freezed,
    Object? allergies = freezed,
    Object? insuranceProvider = freezed,
    Object? insuranceNumber = freezed,
    Object? emergencyContact = freezed,
    Object? status = null,
    Object? avatarUrl = freezed,
    Object? nextVisit = freezed,
    Object? balance = null,
    Object? createdAt = freezed,
    Object? audits = null,
  }) {
    return _then(
      _$PatientEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        age: null == age
            ? _value.age
            : age // ignore: cast_nullable_to_non_nullable
                  as int,
        gender: null == gender
            ? _value.gender
            : gender // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        dateOfBirth: null == dateOfBirth
            ? _value.dateOfBirth
            : dateOfBirth // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        medicalHistory: freezed == medicalHistory
            ? _value.medicalHistory
            : medicalHistory // ignore: cast_nullable_to_non_nullable
                  as String?,
        allergies: freezed == allergies
            ? _value.allergies
            : allergies // ignore: cast_nullable_to_non_nullable
                  as String?,
        insuranceProvider: freezed == insuranceProvider
            ? _value.insuranceProvider
            : insuranceProvider // ignore: cast_nullable_to_non_nullable
                  as String?,
        insuranceNumber: freezed == insuranceNumber
            ? _value.insuranceNumber
            : insuranceNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        emergencyContact: freezed == emergencyContact
            ? _value.emergencyContact
            : emergencyContact // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        nextVisit: freezed == nextVisit
            ? _value.nextVisit
            : nextVisit // ignore: cast_nullable_to_non_nullable
                  as String?,
        balance: null == balance
            ? _value.balance
            : balance // ignore: cast_nullable_to_non_nullable
                  as double,
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

class _$PatientEntityImpl implements _PatientEntity {
  const _$PatientEntityImpl({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.phone,
    required this.email,
    required this.address,
    required this.dateOfBirth,
    this.medicalHistory,
    this.allergies,
    this.insuranceProvider,
    this.insuranceNumber,
    this.emergencyContact,
    this.status = 'active',
    this.avatarUrl,
    this.nextVisit,
    this.balance = 0,
    this.createdAt,
    final List<AuditEntry> audits = const [],
  }) : _audits = audits;

  @override
  final String id;
  @override
  final String name;
  @override
  final int age;
  @override
  final String gender;
  @override
  final String phone;
  @override
  final String email;
  @override
  final String address;
  @override
  final DateTime dateOfBirth;
  @override
  final String? medicalHistory;
  @override
  final String? allergies;
  @override
  final String? insuranceProvider;
  @override
  final String? insuranceNumber;
  @override
  final String? emergencyContact;
  @override
  @JsonKey()
  final String status;
  @override
  final String? avatarUrl;
  @override
  final String? nextVisit;
  @override
  @JsonKey()
  final double balance;
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
    return 'PatientEntity(id: $id, name: $name, age: $age, gender: $gender, phone: $phone, email: $email, address: $address, dateOfBirth: $dateOfBirth, medicalHistory: $medicalHistory, allergies: $allergies, insuranceProvider: $insuranceProvider, insuranceNumber: $insuranceNumber, emergencyContact: $emergencyContact, status: $status, avatarUrl: $avatarUrl, nextVisit: $nextVisit, balance: $balance, createdAt: $createdAt, audits: $audits)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PatientEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.medicalHistory, medicalHistory) ||
                other.medicalHistory == medicalHistory) &&
            (identical(other.allergies, allergies) ||
                other.allergies == allergies) &&
            (identical(other.insuranceProvider, insuranceProvider) ||
                other.insuranceProvider == insuranceProvider) &&
            (identical(other.insuranceNumber, insuranceNumber) ||
                other.insuranceNumber == insuranceNumber) &&
            (identical(other.emergencyContact, emergencyContact) ||
                other.emergencyContact == emergencyContact) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.nextVisit, nextVisit) ||
                other.nextVisit == nextVisit) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._audits, _audits));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    name,
    age,
    gender,
    phone,
    email,
    address,
    dateOfBirth,
    medicalHistory,
    allergies,
    insuranceProvider,
    insuranceNumber,
    emergencyContact,
    status,
    avatarUrl,
    nextVisit,
    balance,
    createdAt,
    const DeepCollectionEquality().hash(_audits),
  ]);

  /// Create a copy of PatientEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PatientEntityImplCopyWith<_$PatientEntityImpl> get copyWith =>
      __$$PatientEntityImplCopyWithImpl<_$PatientEntityImpl>(this, _$identity);
}

abstract class _PatientEntity implements PatientEntity {
  const factory _PatientEntity({
    required final String id,
    required final String name,
    required final int age,
    required final String gender,
    required final String phone,
    required final String email,
    required final String address,
    required final DateTime dateOfBirth,
    final String? medicalHistory,
    final String? allergies,
    final String? insuranceProvider,
    final String? insuranceNumber,
    final String? emergencyContact,
    final String status,
    final String? avatarUrl,
    final String? nextVisit,
    final double balance,
    final DateTime? createdAt,
    final List<AuditEntry> audits,
  }) = _$PatientEntityImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  int get age;
  @override
  String get gender;
  @override
  String get phone;
  @override
  String get email;
  @override
  String get address;
  @override
  DateTime get dateOfBirth;
  @override
  String? get medicalHistory;
  @override
  String? get allergies;
  @override
  String? get insuranceProvider;
  @override
  String? get insuranceNumber;
  @override
  String? get emergencyContact;
  @override
  String get status;
  @override
  String? get avatarUrl;
  @override
  String? get nextVisit;
  @override
  double get balance;
  @override
  DateTime? get createdAt;
  @override
  List<AuditEntry> get audits;

  /// Create a copy of PatientEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PatientEntityImplCopyWith<_$PatientEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CaseEntity {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  double get totalCost => throw _privateConstructorUsedError;
  double get paidAmount => throw _privateConstructorUsedError;
  double get pendingAmount => throw _privateConstructorUsedError;
  List<VisitEntity> get visits => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  List<AuditEntry> get audits => throw _privateConstructorUsedError;

  /// Create a copy of CaseEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CaseEntityCopyWith<CaseEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CaseEntityCopyWith<$Res> {
  factory $CaseEntityCopyWith(
    CaseEntity value,
    $Res Function(CaseEntity) then,
  ) = _$CaseEntityCopyWithImpl<$Res, CaseEntity>;
  @useResult
  $Res call({
    String id,
    String title,
    DateTime startDate,
    DateTime? endDate,
    String status,
    double totalCost,
    double paidAmount,
    double pendingAmount,
    List<VisitEntity> visits,
    DateTime? createdAt,
    List<AuditEntry> audits,
  });
}

/// @nodoc
class _$CaseEntityCopyWithImpl<$Res, $Val extends CaseEntity>
    implements $CaseEntityCopyWith<$Res> {
  _$CaseEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CaseEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? status = null,
    Object? totalCost = null,
    Object? paidAmount = null,
    Object? pendingAmount = null,
    Object? visits = null,
    Object? createdAt = freezed,
    Object? audits = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            totalCost: null == totalCost
                ? _value.totalCost
                : totalCost // ignore: cast_nullable_to_non_nullable
                      as double,
            paidAmount: null == paidAmount
                ? _value.paidAmount
                : paidAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            pendingAmount: null == pendingAmount
                ? _value.pendingAmount
                : pendingAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            visits: null == visits
                ? _value.visits
                : visits // ignore: cast_nullable_to_non_nullable
                      as List<VisitEntity>,
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
abstract class _$$CaseEntityImplCopyWith<$Res>
    implements $CaseEntityCopyWith<$Res> {
  factory _$$CaseEntityImplCopyWith(
    _$CaseEntityImpl value,
    $Res Function(_$CaseEntityImpl) then,
  ) = __$$CaseEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    DateTime startDate,
    DateTime? endDate,
    String status,
    double totalCost,
    double paidAmount,
    double pendingAmount,
    List<VisitEntity> visits,
    DateTime? createdAt,
    List<AuditEntry> audits,
  });
}

/// @nodoc
class __$$CaseEntityImplCopyWithImpl<$Res>
    extends _$CaseEntityCopyWithImpl<$Res, _$CaseEntityImpl>
    implements _$$CaseEntityImplCopyWith<$Res> {
  __$$CaseEntityImplCopyWithImpl(
    _$CaseEntityImpl _value,
    $Res Function(_$CaseEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CaseEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? status = null,
    Object? totalCost = null,
    Object? paidAmount = null,
    Object? pendingAmount = null,
    Object? visits = null,
    Object? createdAt = freezed,
    Object? audits = null,
  }) {
    return _then(
      _$CaseEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        totalCost: null == totalCost
            ? _value.totalCost
            : totalCost // ignore: cast_nullable_to_non_nullable
                  as double,
        paidAmount: null == paidAmount
            ? _value.paidAmount
            : paidAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        pendingAmount: null == pendingAmount
            ? _value.pendingAmount
            : pendingAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        visits: null == visits
            ? _value._visits
            : visits // ignore: cast_nullable_to_non_nullable
                  as List<VisitEntity>,
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

class _$CaseEntityImpl implements _CaseEntity {
  const _$CaseEntityImpl({
    required this.id,
    required this.title,
    required this.startDate,
    this.endDate,
    required this.status,
    required this.totalCost,
    required this.paidAmount,
    required this.pendingAmount,
    final List<VisitEntity> visits = const [],
    this.createdAt,
    final List<AuditEntry> audits = const [],
  }) : _visits = visits,
       _audits = audits;

  @override
  final String id;
  @override
  final String title;
  @override
  final DateTime startDate;
  @override
  final DateTime? endDate;
  @override
  final String status;
  @override
  final double totalCost;
  @override
  final double paidAmount;
  @override
  final double pendingAmount;
  final List<VisitEntity> _visits;
  @override
  @JsonKey()
  List<VisitEntity> get visits {
    if (_visits is EqualUnmodifiableListView) return _visits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_visits);
  }

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
    return 'CaseEntity(id: $id, title: $title, startDate: $startDate, endDate: $endDate, status: $status, totalCost: $totalCost, paidAmount: $paidAmount, pendingAmount: $pendingAmount, visits: $visits, createdAt: $createdAt, audits: $audits)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CaseEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.totalCost, totalCost) ||
                other.totalCost == totalCost) &&
            (identical(other.paidAmount, paidAmount) ||
                other.paidAmount == paidAmount) &&
            (identical(other.pendingAmount, pendingAmount) ||
                other.pendingAmount == pendingAmount) &&
            const DeepCollectionEquality().equals(other._visits, _visits) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._audits, _audits));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    startDate,
    endDate,
    status,
    totalCost,
    paidAmount,
    pendingAmount,
    const DeepCollectionEquality().hash(_visits),
    createdAt,
    const DeepCollectionEquality().hash(_audits),
  );

  /// Create a copy of CaseEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CaseEntityImplCopyWith<_$CaseEntityImpl> get copyWith =>
      __$$CaseEntityImplCopyWithImpl<_$CaseEntityImpl>(this, _$identity);
}

abstract class _CaseEntity implements CaseEntity {
  const factory _CaseEntity({
    required final String id,
    required final String title,
    required final DateTime startDate,
    final DateTime? endDate,
    required final String status,
    required final double totalCost,
    required final double paidAmount,
    required final double pendingAmount,
    final List<VisitEntity> visits,
    final DateTime? createdAt,
    final List<AuditEntry> audits,
  }) = _$CaseEntityImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  DateTime get startDate;
  @override
  DateTime? get endDate;
  @override
  String get status;
  @override
  double get totalCost;
  @override
  double get paidAmount;
  @override
  double get pendingAmount;
  @override
  List<VisitEntity> get visits;
  @override
  DateTime? get createdAt;
  @override
  List<AuditEntry> get audits;

  /// Create a copy of CaseEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CaseEntityImplCopyWith<_$CaseEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$VisitEntity {
  String get id => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  List<String> get treatmentTypes => throw _privateConstructorUsedError;
  List<int> get teethTreated => throw _privateConstructorUsedError;
  String get summary => throw _privateConstructorUsedError;
  List<String> get attachments => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  List<AuditEntry> get audits => throw _privateConstructorUsedError;

  /// Create a copy of VisitEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VisitEntityCopyWith<VisitEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VisitEntityCopyWith<$Res> {
  factory $VisitEntityCopyWith(
    VisitEntity value,
    $Res Function(VisitEntity) then,
  ) = _$VisitEntityCopyWithImpl<$Res, VisitEntity>;
  @useResult
  $Res call({
    String id,
    DateTime date,
    List<String> treatmentTypes,
    List<int> teethTreated,
    String summary,
    List<String> attachments,
    DateTime? createdAt,
    List<AuditEntry> audits,
  });
}

/// @nodoc
class _$VisitEntityCopyWithImpl<$Res, $Val extends VisitEntity>
    implements $VisitEntityCopyWith<$Res> {
  _$VisitEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VisitEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? treatmentTypes = null,
    Object? teethTreated = null,
    Object? summary = null,
    Object? attachments = null,
    Object? createdAt = freezed,
    Object? audits = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            treatmentTypes: null == treatmentTypes
                ? _value.treatmentTypes
                : treatmentTypes // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            teethTreated: null == teethTreated
                ? _value.teethTreated
                : teethTreated // ignore: cast_nullable_to_non_nullable
                      as List<int>,
            summary: null == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as String,
            attachments: null == attachments
                ? _value.attachments
                : attachments // ignore: cast_nullable_to_non_nullable
                      as List<String>,
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
abstract class _$$VisitEntityImplCopyWith<$Res>
    implements $VisitEntityCopyWith<$Res> {
  factory _$$VisitEntityImplCopyWith(
    _$VisitEntityImpl value,
    $Res Function(_$VisitEntityImpl) then,
  ) = __$$VisitEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    DateTime date,
    List<String> treatmentTypes,
    List<int> teethTreated,
    String summary,
    List<String> attachments,
    DateTime? createdAt,
    List<AuditEntry> audits,
  });
}

/// @nodoc
class __$$VisitEntityImplCopyWithImpl<$Res>
    extends _$VisitEntityCopyWithImpl<$Res, _$VisitEntityImpl>
    implements _$$VisitEntityImplCopyWith<$Res> {
  __$$VisitEntityImplCopyWithImpl(
    _$VisitEntityImpl _value,
    $Res Function(_$VisitEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VisitEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? treatmentTypes = null,
    Object? teethTreated = null,
    Object? summary = null,
    Object? attachments = null,
    Object? createdAt = freezed,
    Object? audits = null,
  }) {
    return _then(
      _$VisitEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        treatmentTypes: null == treatmentTypes
            ? _value._treatmentTypes
            : treatmentTypes // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        teethTreated: null == teethTreated
            ? _value._teethTreated
            : teethTreated // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        summary: null == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as String,
        attachments: null == attachments
            ? _value._attachments
            : attachments // ignore: cast_nullable_to_non_nullable
                  as List<String>,
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

class _$VisitEntityImpl implements _VisitEntity {
  const _$VisitEntityImpl({
    required this.id,
    required this.date,
    required final List<String> treatmentTypes,
    final List<int> teethTreated = const [],
    required this.summary,
    final List<String> attachments = const [],
    this.createdAt,
    final List<AuditEntry> audits = const [],
  }) : _treatmentTypes = treatmentTypes,
       _teethTreated = teethTreated,
       _attachments = attachments,
       _audits = audits;

  @override
  final String id;
  @override
  final DateTime date;
  final List<String> _treatmentTypes;
  @override
  List<String> get treatmentTypes {
    if (_treatmentTypes is EqualUnmodifiableListView) return _treatmentTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_treatmentTypes);
  }

  final List<int> _teethTreated;
  @override
  @JsonKey()
  List<int> get teethTreated {
    if (_teethTreated is EqualUnmodifiableListView) return _teethTreated;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teethTreated);
  }

  @override
  final String summary;
  final List<String> _attachments;
  @override
  @JsonKey()
  List<String> get attachments {
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachments);
  }

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
    return 'VisitEntity(id: $id, date: $date, treatmentTypes: $treatmentTypes, teethTreated: $teethTreated, summary: $summary, attachments: $attachments, createdAt: $createdAt, audits: $audits)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VisitEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(
              other._treatmentTypes,
              _treatmentTypes,
            ) &&
            const DeepCollectionEquality().equals(
              other._teethTreated,
              _teethTreated,
            ) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality().equals(
              other._attachments,
              _attachments,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._audits, _audits));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    date,
    const DeepCollectionEquality().hash(_treatmentTypes),
    const DeepCollectionEquality().hash(_teethTreated),
    summary,
    const DeepCollectionEquality().hash(_attachments),
    createdAt,
    const DeepCollectionEquality().hash(_audits),
  );

  /// Create a copy of VisitEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VisitEntityImplCopyWith<_$VisitEntityImpl> get copyWith =>
      __$$VisitEntityImplCopyWithImpl<_$VisitEntityImpl>(this, _$identity);
}

abstract class _VisitEntity implements VisitEntity {
  const factory _VisitEntity({
    required final String id,
    required final DateTime date,
    required final List<String> treatmentTypes,
    final List<int> teethTreated,
    required final String summary,
    final List<String> attachments,
    final DateTime? createdAt,
    final List<AuditEntry> audits,
  }) = _$VisitEntityImpl;

  @override
  String get id;
  @override
  DateTime get date;
  @override
  List<String> get treatmentTypes;
  @override
  List<int> get teethTreated;
  @override
  String get summary;
  @override
  List<String> get attachments;
  @override
  DateTime? get createdAt;
  @override
  List<AuditEntry> get audits;

  /// Create a copy of VisitEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VisitEntityImplCopyWith<_$VisitEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PaymentEntity {
  String get id => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get caseId => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  /// Create a copy of PaymentEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentEntityCopyWith<PaymentEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentEntityCopyWith<$Res> {
  factory $PaymentEntityCopyWith(
    PaymentEntity value,
    $Res Function(PaymentEntity) then,
  ) = _$PaymentEntityCopyWithImpl<$Res, PaymentEntity>;
  @useResult
  $Res call({
    String id,
    DateTime date,
    double amount,
    String method,
    String status,
    String? caseId,
    String description,
  });
}

/// @nodoc
class _$PaymentEntityCopyWithImpl<$Res, $Val extends PaymentEntity>
    implements $PaymentEntityCopyWith<$Res> {
  _$PaymentEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? amount = null,
    Object? method = null,
    Object? status = null,
    Object? caseId = freezed,
    Object? description = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            method: null == method
                ? _value.method
                : method // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            caseId: freezed == caseId
                ? _value.caseId
                : caseId // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaymentEntityImplCopyWith<$Res>
    implements $PaymentEntityCopyWith<$Res> {
  factory _$$PaymentEntityImplCopyWith(
    _$PaymentEntityImpl value,
    $Res Function(_$PaymentEntityImpl) then,
  ) = __$$PaymentEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    DateTime date,
    double amount,
    String method,
    String status,
    String? caseId,
    String description,
  });
}

/// @nodoc
class __$$PaymentEntityImplCopyWithImpl<$Res>
    extends _$PaymentEntityCopyWithImpl<$Res, _$PaymentEntityImpl>
    implements _$$PaymentEntityImplCopyWith<$Res> {
  __$$PaymentEntityImplCopyWithImpl(
    _$PaymentEntityImpl _value,
    $Res Function(_$PaymentEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaymentEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? amount = null,
    Object? method = null,
    Object? status = null,
    Object? caseId = freezed,
    Object? description = null,
  }) {
    return _then(
      _$PaymentEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        method: null == method
            ? _value.method
            : method // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        caseId: freezed == caseId
            ? _value.caseId
            : caseId // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$PaymentEntityImpl implements _PaymentEntity {
  const _$PaymentEntityImpl({
    required this.id,
    required this.date,
    required this.amount,
    required this.method,
    required this.status,
    this.caseId,
    required this.description,
  });

  @override
  final String id;
  @override
  final DateTime date;
  @override
  final double amount;
  @override
  final String method;
  @override
  final String status;
  @override
  final String? caseId;
  @override
  final String description;

  @override
  String toString() {
    return 'PaymentEntity(id: $id, date: $date, amount: $amount, method: $method, status: $status, caseId: $caseId, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.caseId, caseId) || other.caseId == caseId) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    date,
    amount,
    method,
    status,
    caseId,
    description,
  );

  /// Create a copy of PaymentEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentEntityImplCopyWith<_$PaymentEntityImpl> get copyWith =>
      __$$PaymentEntityImplCopyWithImpl<_$PaymentEntityImpl>(this, _$identity);
}

abstract class _PaymentEntity implements PaymentEntity {
  const factory _PaymentEntity({
    required final String id,
    required final DateTime date,
    required final double amount,
    required final String method,
    required final String status,
    final String? caseId,
    required final String description,
  }) = _$PaymentEntityImpl;

  @override
  String get id;
  @override
  DateTime get date;
  @override
  double get amount;
  @override
  String get method;
  @override
  String get status;
  @override
  String? get caseId;
  @override
  String get description;

  /// Create a copy of PaymentEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentEntityImplCopyWith<_$PaymentEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
