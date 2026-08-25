// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invoice_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$InvoiceEntity {
  String get id => throw _privateConstructorUsedError;
  String get number => throw _privateConstructorUsedError;
  String get clinicId => throw _privateConstructorUsedError;
  InvoiceKind get kind => throw _privateConstructorUsedError;
  InvoiceStatus get status => throw _privateConstructorUsedError;
  PaymentProviderKind get provider => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  DateTime get issuedAt => throw _privateConstructorUsedError;
  DateTime get dueAt =>
      throw _privateConstructorUsedError; // Subscription-specific (nullable so the entity can be reused for other
  // kinds later).
  PlanTier? get planTier => throw _privateConstructorUsedError;
  BillingCycle? get billingCycle => throw _privateConstructorUsedError;
  PaymentProofEntity? get proof => throw _privateConstructorUsedError;
  RejectionInfo? get rejection => throw _privateConstructorUsedError;
  DateTime? get paidAt => throw _privateConstructorUsedError;

  /// When the linked subscription period would end if this invoice were
  /// approved right now. Used for the renewal countdown on details.
  DateTime? get activatesUntil => throw _privateConstructorUsedError;
  bool get isRenewal => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Create a copy of InvoiceEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InvoiceEntityCopyWith<InvoiceEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoiceEntityCopyWith<$Res> {
  factory $InvoiceEntityCopyWith(
    InvoiceEntity value,
    $Res Function(InvoiceEntity) then,
  ) = _$InvoiceEntityCopyWithImpl<$Res, InvoiceEntity>;
  @useResult
  $Res call({
    String id,
    String number,
    String clinicId,
    InvoiceKind kind,
    InvoiceStatus status,
    PaymentProviderKind provider,
    double amount,
    String currency,
    DateTime issuedAt,
    DateTime dueAt,
    PlanTier? planTier,
    BillingCycle? billingCycle,
    PaymentProofEntity? proof,
    RejectionInfo? rejection,
    DateTime? paidAt,
    DateTime? activatesUntil,
    bool isRenewal,
    String? notes,
  });

  $PaymentProofEntityCopyWith<$Res>? get proof;
  $RejectionInfoCopyWith<$Res>? get rejection;
}

/// @nodoc
class _$InvoiceEntityCopyWithImpl<$Res, $Val extends InvoiceEntity>
    implements $InvoiceEntityCopyWith<$Res> {
  _$InvoiceEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InvoiceEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? number = null,
    Object? clinicId = null,
    Object? kind = null,
    Object? status = null,
    Object? provider = null,
    Object? amount = null,
    Object? currency = null,
    Object? issuedAt = null,
    Object? dueAt = null,
    Object? planTier = freezed,
    Object? billingCycle = freezed,
    Object? proof = freezed,
    Object? rejection = freezed,
    Object? paidAt = freezed,
    Object? activatesUntil = freezed,
    Object? isRenewal = null,
    Object? notes = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            number: null == number
                ? _value.number
                : number // ignore: cast_nullable_to_non_nullable
                      as String,
            clinicId: null == clinicId
                ? _value.clinicId
                : clinicId // ignore: cast_nullable_to_non_nullable
                      as String,
            kind: null == kind
                ? _value.kind
                : kind // ignore: cast_nullable_to_non_nullable
                      as InvoiceKind,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as InvoiceStatus,
            provider: null == provider
                ? _value.provider
                : provider // ignore: cast_nullable_to_non_nullable
                      as PaymentProviderKind,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String,
            issuedAt: null == issuedAt
                ? _value.issuedAt
                : issuedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            dueAt: null == dueAt
                ? _value.dueAt
                : dueAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            planTier: freezed == planTier
                ? _value.planTier
                : planTier // ignore: cast_nullable_to_non_nullable
                      as PlanTier?,
            billingCycle: freezed == billingCycle
                ? _value.billingCycle
                : billingCycle // ignore: cast_nullable_to_non_nullable
                      as BillingCycle?,
            proof: freezed == proof
                ? _value.proof
                : proof // ignore: cast_nullable_to_non_nullable
                      as PaymentProofEntity?,
            rejection: freezed == rejection
                ? _value.rejection
                : rejection // ignore: cast_nullable_to_non_nullable
                      as RejectionInfo?,
            paidAt: freezed == paidAt
                ? _value.paidAt
                : paidAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            activatesUntil: freezed == activatesUntil
                ? _value.activatesUntil
                : activatesUntil // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isRenewal: null == isRenewal
                ? _value.isRenewal
                : isRenewal // ignore: cast_nullable_to_non_nullable
                      as bool,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of InvoiceEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaymentProofEntityCopyWith<$Res>? get proof {
    if (_value.proof == null) {
      return null;
    }

    return $PaymentProofEntityCopyWith<$Res>(_value.proof!, (value) {
      return _then(_value.copyWith(proof: value) as $Val);
    });
  }

  /// Create a copy of InvoiceEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RejectionInfoCopyWith<$Res>? get rejection {
    if (_value.rejection == null) {
      return null;
    }

    return $RejectionInfoCopyWith<$Res>(_value.rejection!, (value) {
      return _then(_value.copyWith(rejection: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$InvoiceEntityImplCopyWith<$Res>
    implements $InvoiceEntityCopyWith<$Res> {
  factory _$$InvoiceEntityImplCopyWith(
    _$InvoiceEntityImpl value,
    $Res Function(_$InvoiceEntityImpl) then,
  ) = __$$InvoiceEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String number,
    String clinicId,
    InvoiceKind kind,
    InvoiceStatus status,
    PaymentProviderKind provider,
    double amount,
    String currency,
    DateTime issuedAt,
    DateTime dueAt,
    PlanTier? planTier,
    BillingCycle? billingCycle,
    PaymentProofEntity? proof,
    RejectionInfo? rejection,
    DateTime? paidAt,
    DateTime? activatesUntil,
    bool isRenewal,
    String? notes,
  });

  @override
  $PaymentProofEntityCopyWith<$Res>? get proof;
  @override
  $RejectionInfoCopyWith<$Res>? get rejection;
}

/// @nodoc
class __$$InvoiceEntityImplCopyWithImpl<$Res>
    extends _$InvoiceEntityCopyWithImpl<$Res, _$InvoiceEntityImpl>
    implements _$$InvoiceEntityImplCopyWith<$Res> {
  __$$InvoiceEntityImplCopyWithImpl(
    _$InvoiceEntityImpl _value,
    $Res Function(_$InvoiceEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InvoiceEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? number = null,
    Object? clinicId = null,
    Object? kind = null,
    Object? status = null,
    Object? provider = null,
    Object? amount = null,
    Object? currency = null,
    Object? issuedAt = null,
    Object? dueAt = null,
    Object? planTier = freezed,
    Object? billingCycle = freezed,
    Object? proof = freezed,
    Object? rejection = freezed,
    Object? paidAt = freezed,
    Object? activatesUntil = freezed,
    Object? isRenewal = null,
    Object? notes = freezed,
  }) {
    return _then(
      _$InvoiceEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        number: null == number
            ? _value.number
            : number // ignore: cast_nullable_to_non_nullable
                  as String,
        clinicId: null == clinicId
            ? _value.clinicId
            : clinicId // ignore: cast_nullable_to_non_nullable
                  as String,
        kind: null == kind
            ? _value.kind
            : kind // ignore: cast_nullable_to_non_nullable
                  as InvoiceKind,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as InvoiceStatus,
        provider: null == provider
            ? _value.provider
            : provider // ignore: cast_nullable_to_non_nullable
                  as PaymentProviderKind,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String,
        issuedAt: null == issuedAt
            ? _value.issuedAt
            : issuedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        dueAt: null == dueAt
            ? _value.dueAt
            : dueAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        planTier: freezed == planTier
            ? _value.planTier
            : planTier // ignore: cast_nullable_to_non_nullable
                  as PlanTier?,
        billingCycle: freezed == billingCycle
            ? _value.billingCycle
            : billingCycle // ignore: cast_nullable_to_non_nullable
                  as BillingCycle?,
        proof: freezed == proof
            ? _value.proof
            : proof // ignore: cast_nullable_to_non_nullable
                  as PaymentProofEntity?,
        rejection: freezed == rejection
            ? _value.rejection
            : rejection // ignore: cast_nullable_to_non_nullable
                  as RejectionInfo?,
        paidAt: freezed == paidAt
            ? _value.paidAt
            : paidAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        activatesUntil: freezed == activatesUntil
            ? _value.activatesUntil
            : activatesUntil // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isRenewal: null == isRenewal
            ? _value.isRenewal
            : isRenewal // ignore: cast_nullable_to_non_nullable
                  as bool,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$InvoiceEntityImpl extends _InvoiceEntity {
  const _$InvoiceEntityImpl({
    required this.id,
    required this.number,
    required this.clinicId,
    required this.kind,
    required this.status,
    required this.provider,
    required this.amount,
    required this.currency,
    required this.issuedAt,
    required this.dueAt,
    this.planTier,
    this.billingCycle,
    this.proof,
    this.rejection,
    this.paidAt,
    this.activatesUntil,
    this.isRenewal = false,
    this.notes,
  }) : super._();

  @override
  final String id;
  @override
  final String number;
  @override
  final String clinicId;
  @override
  final InvoiceKind kind;
  @override
  final InvoiceStatus status;
  @override
  final PaymentProviderKind provider;
  @override
  final double amount;
  @override
  final String currency;
  @override
  final DateTime issuedAt;
  @override
  final DateTime dueAt;
  // Subscription-specific (nullable so the entity can be reused for other
  // kinds later).
  @override
  final PlanTier? planTier;
  @override
  final BillingCycle? billingCycle;
  @override
  final PaymentProofEntity? proof;
  @override
  final RejectionInfo? rejection;
  @override
  final DateTime? paidAt;

  /// When the linked subscription period would end if this invoice were
  /// approved right now. Used for the renewal countdown on details.
  @override
  final DateTime? activatesUntil;
  @override
  @JsonKey()
  final bool isRenewal;
  @override
  final String? notes;

  @override
  String toString() {
    return 'InvoiceEntity(id: $id, number: $number, clinicId: $clinicId, kind: $kind, status: $status, provider: $provider, amount: $amount, currency: $currency, issuedAt: $issuedAt, dueAt: $dueAt, planTier: $planTier, billingCycle: $billingCycle, proof: $proof, rejection: $rejection, paidAt: $paidAt, activatesUntil: $activatesUntil, isRenewal: $isRenewal, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvoiceEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.clinicId, clinicId) ||
                other.clinicId == clinicId) &&
            (identical(other.kind, kind) || other.kind == kind) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.issuedAt, issuedAt) ||
                other.issuedAt == issuedAt) &&
            (identical(other.dueAt, dueAt) || other.dueAt == dueAt) &&
            (identical(other.planTier, planTier) ||
                other.planTier == planTier) &&
            (identical(other.billingCycle, billingCycle) ||
                other.billingCycle == billingCycle) &&
            (identical(other.proof, proof) || other.proof == proof) &&
            (identical(other.rejection, rejection) ||
                other.rejection == rejection) &&
            (identical(other.paidAt, paidAt) || other.paidAt == paidAt) &&
            (identical(other.activatesUntil, activatesUntil) ||
                other.activatesUntil == activatesUntil) &&
            (identical(other.isRenewal, isRenewal) ||
                other.isRenewal == isRenewal) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    number,
    clinicId,
    kind,
    status,
    provider,
    amount,
    currency,
    issuedAt,
    dueAt,
    planTier,
    billingCycle,
    proof,
    rejection,
    paidAt,
    activatesUntil,
    isRenewal,
    notes,
  );

  /// Create a copy of InvoiceEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvoiceEntityImplCopyWith<_$InvoiceEntityImpl> get copyWith =>
      __$$InvoiceEntityImplCopyWithImpl<_$InvoiceEntityImpl>(this, _$identity);
}

abstract class _InvoiceEntity extends InvoiceEntity {
  const factory _InvoiceEntity({
    required final String id,
    required final String number,
    required final String clinicId,
    required final InvoiceKind kind,
    required final InvoiceStatus status,
    required final PaymentProviderKind provider,
    required final double amount,
    required final String currency,
    required final DateTime issuedAt,
    required final DateTime dueAt,
    final PlanTier? planTier,
    final BillingCycle? billingCycle,
    final PaymentProofEntity? proof,
    final RejectionInfo? rejection,
    final DateTime? paidAt,
    final DateTime? activatesUntil,
    final bool isRenewal,
    final String? notes,
  }) = _$InvoiceEntityImpl;
  const _InvoiceEntity._() : super._();

  @override
  String get id;
  @override
  String get number;
  @override
  String get clinicId;
  @override
  InvoiceKind get kind;
  @override
  InvoiceStatus get status;
  @override
  PaymentProviderKind get provider;
  @override
  double get amount;
  @override
  String get currency;
  @override
  DateTime get issuedAt;
  @override
  DateTime get dueAt; // Subscription-specific (nullable so the entity can be reused for other
  // kinds later).
  @override
  PlanTier? get planTier;
  @override
  BillingCycle? get billingCycle;
  @override
  PaymentProofEntity? get proof;
  @override
  RejectionInfo? get rejection;
  @override
  DateTime? get paidAt;

  /// When the linked subscription period would end if this invoice were
  /// approved right now. Used for the renewal countdown on details.
  @override
  DateTime? get activatesUntil;
  @override
  bool get isRenewal;
  @override
  String? get notes;

  /// Create a copy of InvoiceEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvoiceEntityImplCopyWith<_$InvoiceEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PaymentProofEntity {
  /// Local file path or remote URL of the receipt screenshot.
  String get receiptPath => throw _privateConstructorUsedError;
  String get referenceNumber => throw _privateConstructorUsedError;
  ManualPaymentMethod get methodUsed => throw _privateConstructorUsedError;
  DateTime get submittedAt => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Create a copy of PaymentProofEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentProofEntityCopyWith<PaymentProofEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentProofEntityCopyWith<$Res> {
  factory $PaymentProofEntityCopyWith(
    PaymentProofEntity value,
    $Res Function(PaymentProofEntity) then,
  ) = _$PaymentProofEntityCopyWithImpl<$Res, PaymentProofEntity>;
  @useResult
  $Res call({
    String receiptPath,
    String referenceNumber,
    ManualPaymentMethod methodUsed,
    DateTime submittedAt,
    String? notes,
  });
}

/// @nodoc
class _$PaymentProofEntityCopyWithImpl<$Res, $Val extends PaymentProofEntity>
    implements $PaymentProofEntityCopyWith<$Res> {
  _$PaymentProofEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentProofEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? receiptPath = null,
    Object? referenceNumber = null,
    Object? methodUsed = null,
    Object? submittedAt = null,
    Object? notes = freezed,
  }) {
    return _then(
      _value.copyWith(
            receiptPath: null == receiptPath
                ? _value.receiptPath
                : receiptPath // ignore: cast_nullable_to_non_nullable
                      as String,
            referenceNumber: null == referenceNumber
                ? _value.referenceNumber
                : referenceNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            methodUsed: null == methodUsed
                ? _value.methodUsed
                : methodUsed // ignore: cast_nullable_to_non_nullable
                      as ManualPaymentMethod,
            submittedAt: null == submittedAt
                ? _value.submittedAt
                : submittedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaymentProofEntityImplCopyWith<$Res>
    implements $PaymentProofEntityCopyWith<$Res> {
  factory _$$PaymentProofEntityImplCopyWith(
    _$PaymentProofEntityImpl value,
    $Res Function(_$PaymentProofEntityImpl) then,
  ) = __$$PaymentProofEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String receiptPath,
    String referenceNumber,
    ManualPaymentMethod methodUsed,
    DateTime submittedAt,
    String? notes,
  });
}

/// @nodoc
class __$$PaymentProofEntityImplCopyWithImpl<$Res>
    extends _$PaymentProofEntityCopyWithImpl<$Res, _$PaymentProofEntityImpl>
    implements _$$PaymentProofEntityImplCopyWith<$Res> {
  __$$PaymentProofEntityImplCopyWithImpl(
    _$PaymentProofEntityImpl _value,
    $Res Function(_$PaymentProofEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaymentProofEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? receiptPath = null,
    Object? referenceNumber = null,
    Object? methodUsed = null,
    Object? submittedAt = null,
    Object? notes = freezed,
  }) {
    return _then(
      _$PaymentProofEntityImpl(
        receiptPath: null == receiptPath
            ? _value.receiptPath
            : receiptPath // ignore: cast_nullable_to_non_nullable
                  as String,
        referenceNumber: null == referenceNumber
            ? _value.referenceNumber
            : referenceNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        methodUsed: null == methodUsed
            ? _value.methodUsed
            : methodUsed // ignore: cast_nullable_to_non_nullable
                  as ManualPaymentMethod,
        submittedAt: null == submittedAt
            ? _value.submittedAt
            : submittedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$PaymentProofEntityImpl extends _PaymentProofEntity {
  const _$PaymentProofEntityImpl({
    required this.receiptPath,
    required this.referenceNumber,
    required this.methodUsed,
    required this.submittedAt,
    this.notes,
  }) : super._();

  /// Local file path or remote URL of the receipt screenshot.
  @override
  final String receiptPath;
  @override
  final String referenceNumber;
  @override
  final ManualPaymentMethod methodUsed;
  @override
  final DateTime submittedAt;
  @override
  final String? notes;

  @override
  String toString() {
    return 'PaymentProofEntity(receiptPath: $receiptPath, referenceNumber: $referenceNumber, methodUsed: $methodUsed, submittedAt: $submittedAt, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentProofEntityImpl &&
            (identical(other.receiptPath, receiptPath) ||
                other.receiptPath == receiptPath) &&
            (identical(other.referenceNumber, referenceNumber) ||
                other.referenceNumber == referenceNumber) &&
            (identical(other.methodUsed, methodUsed) ||
                other.methodUsed == methodUsed) &&
            (identical(other.submittedAt, submittedAt) ||
                other.submittedAt == submittedAt) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    receiptPath,
    referenceNumber,
    methodUsed,
    submittedAt,
    notes,
  );

  /// Create a copy of PaymentProofEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentProofEntityImplCopyWith<_$PaymentProofEntityImpl> get copyWith =>
      __$$PaymentProofEntityImplCopyWithImpl<_$PaymentProofEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _PaymentProofEntity extends PaymentProofEntity {
  const factory _PaymentProofEntity({
    required final String receiptPath,
    required final String referenceNumber,
    required final ManualPaymentMethod methodUsed,
    required final DateTime submittedAt,
    final String? notes,
  }) = _$PaymentProofEntityImpl;
  const _PaymentProofEntity._() : super._();

  /// Local file path or remote URL of the receipt screenshot.
  @override
  String get receiptPath;
  @override
  String get referenceNumber;
  @override
  ManualPaymentMethod get methodUsed;
  @override
  DateTime get submittedAt;
  @override
  String? get notes;

  /// Create a copy of PaymentProofEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentProofEntityImplCopyWith<_$PaymentProofEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RejectionInfo {
  DateTime get rejectedAt => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;

  /// Create a copy of RejectionInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RejectionInfoCopyWith<RejectionInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RejectionInfoCopyWith<$Res> {
  factory $RejectionInfoCopyWith(
    RejectionInfo value,
    $Res Function(RejectionInfo) then,
  ) = _$RejectionInfoCopyWithImpl<$Res, RejectionInfo>;
  @useResult
  $Res call({DateTime rejectedAt, String? reason});
}

/// @nodoc
class _$RejectionInfoCopyWithImpl<$Res, $Val extends RejectionInfo>
    implements $RejectionInfoCopyWith<$Res> {
  _$RejectionInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RejectionInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? rejectedAt = null, Object? reason = freezed}) {
    return _then(
      _value.copyWith(
            rejectedAt: null == rejectedAt
                ? _value.rejectedAt
                : rejectedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            reason: freezed == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RejectionInfoImplCopyWith<$Res>
    implements $RejectionInfoCopyWith<$Res> {
  factory _$$RejectionInfoImplCopyWith(
    _$RejectionInfoImpl value,
    $Res Function(_$RejectionInfoImpl) then,
  ) = __$$RejectionInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime rejectedAt, String? reason});
}

/// @nodoc
class __$$RejectionInfoImplCopyWithImpl<$Res>
    extends _$RejectionInfoCopyWithImpl<$Res, _$RejectionInfoImpl>
    implements _$$RejectionInfoImplCopyWith<$Res> {
  __$$RejectionInfoImplCopyWithImpl(
    _$RejectionInfoImpl _value,
    $Res Function(_$RejectionInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RejectionInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? rejectedAt = null, Object? reason = freezed}) {
    return _then(
      _$RejectionInfoImpl(
        rejectedAt: null == rejectedAt
            ? _value.rejectedAt
            : rejectedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        reason: freezed == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$RejectionInfoImpl extends _RejectionInfo {
  const _$RejectionInfoImpl({required this.rejectedAt, this.reason})
    : super._();

  @override
  final DateTime rejectedAt;
  @override
  final String? reason;

  @override
  String toString() {
    return 'RejectionInfo(rejectedAt: $rejectedAt, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RejectionInfoImpl &&
            (identical(other.rejectedAt, rejectedAt) ||
                other.rejectedAt == rejectedAt) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode => Object.hash(runtimeType, rejectedAt, reason);

  /// Create a copy of RejectionInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RejectionInfoImplCopyWith<_$RejectionInfoImpl> get copyWith =>
      __$$RejectionInfoImplCopyWithImpl<_$RejectionInfoImpl>(this, _$identity);
}

abstract class _RejectionInfo extends RejectionInfo {
  const factory _RejectionInfo({
    required final DateTime rejectedAt,
    final String? reason,
  }) = _$RejectionInfoImpl;
  const _RejectionInfo._() : super._();

  @override
  DateTime get rejectedAt;
  @override
  String? get reason;

  /// Create a copy of RejectionInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RejectionInfoImplCopyWith<_$RejectionInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
