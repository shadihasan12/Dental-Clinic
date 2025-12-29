// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_subscription_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$UserSubscriptionEntity {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError; // or clinicId
  PlanTier get planTier => throw _privateConstructorUsedError;
  SubscriptionStatus get status => throw _privateConstructorUsedError;
  BillingCycle get billingCycle => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get currentPeriodEnd => throw _privateConstructorUsedError;
  DateTime? get trialEndDate => throw _privateConstructorUsedError;
  DateTime? get cancelledAt => throw _privateConstructorUsedError;
  bool get autoRenew => throw _privateConstructorUsedError;
  String? get paymentMethodId => throw _privateConstructorUsedError;
  String? get lastPaymentId => throw _privateConstructorUsedError;
  DateTime? get lastPaymentDate => throw _privateConstructorUsedError;
  double? get lastPaymentAmount =>
      throw _privateConstructorUsedError; // Usage tracking
  int get currentDentistCount => throw _privateConstructorUsedError;
  int get currentAssistantCount => throw _privateConstructorUsedError;
  int get currentBranchCount => throw _privateConstructorUsedError;
  int get currentPatientCount => throw _privateConstructorUsedError;

  /// Create a copy of UserSubscriptionEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSubscriptionEntityCopyWith<UserSubscriptionEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSubscriptionEntityCopyWith<$Res> {
  factory $UserSubscriptionEntityCopyWith(
    UserSubscriptionEntity value,
    $Res Function(UserSubscriptionEntity) then,
  ) = _$UserSubscriptionEntityCopyWithImpl<$Res, UserSubscriptionEntity>;
  @useResult
  $Res call({
    String id,
    String userId,
    PlanTier planTier,
    SubscriptionStatus status,
    BillingCycle billingCycle,
    DateTime startDate,
    DateTime currentPeriodEnd,
    DateTime? trialEndDate,
    DateTime? cancelledAt,
    bool autoRenew,
    String? paymentMethodId,
    String? lastPaymentId,
    DateTime? lastPaymentDate,
    double? lastPaymentAmount,
    int currentDentistCount,
    int currentAssistantCount,
    int currentBranchCount,
    int currentPatientCount,
  });
}

/// @nodoc
class _$UserSubscriptionEntityCopyWithImpl<
  $Res,
  $Val extends UserSubscriptionEntity
>
    implements $UserSubscriptionEntityCopyWith<$Res> {
  _$UserSubscriptionEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSubscriptionEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? planTier = null,
    Object? status = null,
    Object? billingCycle = null,
    Object? startDate = null,
    Object? currentPeriodEnd = null,
    Object? trialEndDate = freezed,
    Object? cancelledAt = freezed,
    Object? autoRenew = null,
    Object? paymentMethodId = freezed,
    Object? lastPaymentId = freezed,
    Object? lastPaymentDate = freezed,
    Object? lastPaymentAmount = freezed,
    Object? currentDentistCount = null,
    Object? currentAssistantCount = null,
    Object? currentBranchCount = null,
    Object? currentPatientCount = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            planTier: null == planTier
                ? _value.planTier
                : planTier // ignore: cast_nullable_to_non_nullable
                      as PlanTier,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as SubscriptionStatus,
            billingCycle: null == billingCycle
                ? _value.billingCycle
                : billingCycle // ignore: cast_nullable_to_non_nullable
                      as BillingCycle,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            currentPeriodEnd: null == currentPeriodEnd
                ? _value.currentPeriodEnd
                : currentPeriodEnd // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            trialEndDate: freezed == trialEndDate
                ? _value.trialEndDate
                : trialEndDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            cancelledAt: freezed == cancelledAt
                ? _value.cancelledAt
                : cancelledAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            autoRenew: null == autoRenew
                ? _value.autoRenew
                : autoRenew // ignore: cast_nullable_to_non_nullable
                      as bool,
            paymentMethodId: freezed == paymentMethodId
                ? _value.paymentMethodId
                : paymentMethodId // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastPaymentId: freezed == lastPaymentId
                ? _value.lastPaymentId
                : lastPaymentId // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastPaymentDate: freezed == lastPaymentDate
                ? _value.lastPaymentDate
                : lastPaymentDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            lastPaymentAmount: freezed == lastPaymentAmount
                ? _value.lastPaymentAmount
                : lastPaymentAmount // ignore: cast_nullable_to_non_nullable
                      as double?,
            currentDentistCount: null == currentDentistCount
                ? _value.currentDentistCount
                : currentDentistCount // ignore: cast_nullable_to_non_nullable
                      as int,
            currentAssistantCount: null == currentAssistantCount
                ? _value.currentAssistantCount
                : currentAssistantCount // ignore: cast_nullable_to_non_nullable
                      as int,
            currentBranchCount: null == currentBranchCount
                ? _value.currentBranchCount
                : currentBranchCount // ignore: cast_nullable_to_non_nullable
                      as int,
            currentPatientCount: null == currentPatientCount
                ? _value.currentPatientCount
                : currentPatientCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserSubscriptionEntityImplCopyWith<$Res>
    implements $UserSubscriptionEntityCopyWith<$Res> {
  factory _$$UserSubscriptionEntityImplCopyWith(
    _$UserSubscriptionEntityImpl value,
    $Res Function(_$UserSubscriptionEntityImpl) then,
  ) = __$$UserSubscriptionEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    PlanTier planTier,
    SubscriptionStatus status,
    BillingCycle billingCycle,
    DateTime startDate,
    DateTime currentPeriodEnd,
    DateTime? trialEndDate,
    DateTime? cancelledAt,
    bool autoRenew,
    String? paymentMethodId,
    String? lastPaymentId,
    DateTime? lastPaymentDate,
    double? lastPaymentAmount,
    int currentDentistCount,
    int currentAssistantCount,
    int currentBranchCount,
    int currentPatientCount,
  });
}

/// @nodoc
class __$$UserSubscriptionEntityImplCopyWithImpl<$Res>
    extends
        _$UserSubscriptionEntityCopyWithImpl<$Res, _$UserSubscriptionEntityImpl>
    implements _$$UserSubscriptionEntityImplCopyWith<$Res> {
  __$$UserSubscriptionEntityImplCopyWithImpl(
    _$UserSubscriptionEntityImpl _value,
    $Res Function(_$UserSubscriptionEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserSubscriptionEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? planTier = null,
    Object? status = null,
    Object? billingCycle = null,
    Object? startDate = null,
    Object? currentPeriodEnd = null,
    Object? trialEndDate = freezed,
    Object? cancelledAt = freezed,
    Object? autoRenew = null,
    Object? paymentMethodId = freezed,
    Object? lastPaymentId = freezed,
    Object? lastPaymentDate = freezed,
    Object? lastPaymentAmount = freezed,
    Object? currentDentistCount = null,
    Object? currentAssistantCount = null,
    Object? currentBranchCount = null,
    Object? currentPatientCount = null,
  }) {
    return _then(
      _$UserSubscriptionEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        planTier: null == planTier
            ? _value.planTier
            : planTier // ignore: cast_nullable_to_non_nullable
                  as PlanTier,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as SubscriptionStatus,
        billingCycle: null == billingCycle
            ? _value.billingCycle
            : billingCycle // ignore: cast_nullable_to_non_nullable
                  as BillingCycle,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        currentPeriodEnd: null == currentPeriodEnd
            ? _value.currentPeriodEnd
            : currentPeriodEnd // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        trialEndDate: freezed == trialEndDate
            ? _value.trialEndDate
            : trialEndDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        cancelledAt: freezed == cancelledAt
            ? _value.cancelledAt
            : cancelledAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        autoRenew: null == autoRenew
            ? _value.autoRenew
            : autoRenew // ignore: cast_nullable_to_non_nullable
                  as bool,
        paymentMethodId: freezed == paymentMethodId
            ? _value.paymentMethodId
            : paymentMethodId // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastPaymentId: freezed == lastPaymentId
            ? _value.lastPaymentId
            : lastPaymentId // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastPaymentDate: freezed == lastPaymentDate
            ? _value.lastPaymentDate
            : lastPaymentDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        lastPaymentAmount: freezed == lastPaymentAmount
            ? _value.lastPaymentAmount
            : lastPaymentAmount // ignore: cast_nullable_to_non_nullable
                  as double?,
        currentDentistCount: null == currentDentistCount
            ? _value.currentDentistCount
            : currentDentistCount // ignore: cast_nullable_to_non_nullable
                  as int,
        currentAssistantCount: null == currentAssistantCount
            ? _value.currentAssistantCount
            : currentAssistantCount // ignore: cast_nullable_to_non_nullable
                  as int,
        currentBranchCount: null == currentBranchCount
            ? _value.currentBranchCount
            : currentBranchCount // ignore: cast_nullable_to_non_nullable
                  as int,
        currentPatientCount: null == currentPatientCount
            ? _value.currentPatientCount
            : currentPatientCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$UserSubscriptionEntityImpl extends _UserSubscriptionEntity {
  const _$UserSubscriptionEntityImpl({
    required this.id,
    required this.userId,
    required this.planTier,
    required this.status,
    required this.billingCycle,
    required this.startDate,
    required this.currentPeriodEnd,
    this.trialEndDate,
    this.cancelledAt,
    this.autoRenew = false,
    this.paymentMethodId,
    this.lastPaymentId,
    this.lastPaymentDate,
    this.lastPaymentAmount,
    this.currentDentistCount = 0,
    this.currentAssistantCount = 0,
    this.currentBranchCount = 0,
    this.currentPatientCount = 0,
  }) : super._();

  @override
  final String id;
  @override
  final String userId;
  // or clinicId
  @override
  final PlanTier planTier;
  @override
  final SubscriptionStatus status;
  @override
  final BillingCycle billingCycle;
  @override
  final DateTime startDate;
  @override
  final DateTime currentPeriodEnd;
  @override
  final DateTime? trialEndDate;
  @override
  final DateTime? cancelledAt;
  @override
  @JsonKey()
  final bool autoRenew;
  @override
  final String? paymentMethodId;
  @override
  final String? lastPaymentId;
  @override
  final DateTime? lastPaymentDate;
  @override
  final double? lastPaymentAmount;
  // Usage tracking
  @override
  @JsonKey()
  final int currentDentistCount;
  @override
  @JsonKey()
  final int currentAssistantCount;
  @override
  @JsonKey()
  final int currentBranchCount;
  @override
  @JsonKey()
  final int currentPatientCount;

  @override
  String toString() {
    return 'UserSubscriptionEntity(id: $id, userId: $userId, planTier: $planTier, status: $status, billingCycle: $billingCycle, startDate: $startDate, currentPeriodEnd: $currentPeriodEnd, trialEndDate: $trialEndDate, cancelledAt: $cancelledAt, autoRenew: $autoRenew, paymentMethodId: $paymentMethodId, lastPaymentId: $lastPaymentId, lastPaymentDate: $lastPaymentDate, lastPaymentAmount: $lastPaymentAmount, currentDentistCount: $currentDentistCount, currentAssistantCount: $currentAssistantCount, currentBranchCount: $currentBranchCount, currentPatientCount: $currentPatientCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSubscriptionEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.planTier, planTier) ||
                other.planTier == planTier) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.billingCycle, billingCycle) ||
                other.billingCycle == billingCycle) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.currentPeriodEnd, currentPeriodEnd) ||
                other.currentPeriodEnd == currentPeriodEnd) &&
            (identical(other.trialEndDate, trialEndDate) ||
                other.trialEndDate == trialEndDate) &&
            (identical(other.cancelledAt, cancelledAt) ||
                other.cancelledAt == cancelledAt) &&
            (identical(other.autoRenew, autoRenew) ||
                other.autoRenew == autoRenew) &&
            (identical(other.paymentMethodId, paymentMethodId) ||
                other.paymentMethodId == paymentMethodId) &&
            (identical(other.lastPaymentId, lastPaymentId) ||
                other.lastPaymentId == lastPaymentId) &&
            (identical(other.lastPaymentDate, lastPaymentDate) ||
                other.lastPaymentDate == lastPaymentDate) &&
            (identical(other.lastPaymentAmount, lastPaymentAmount) ||
                other.lastPaymentAmount == lastPaymentAmount) &&
            (identical(other.currentDentistCount, currentDentistCount) ||
                other.currentDentistCount == currentDentistCount) &&
            (identical(other.currentAssistantCount, currentAssistantCount) ||
                other.currentAssistantCount == currentAssistantCount) &&
            (identical(other.currentBranchCount, currentBranchCount) ||
                other.currentBranchCount == currentBranchCount) &&
            (identical(other.currentPatientCount, currentPatientCount) ||
                other.currentPatientCount == currentPatientCount));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    planTier,
    status,
    billingCycle,
    startDate,
    currentPeriodEnd,
    trialEndDate,
    cancelledAt,
    autoRenew,
    paymentMethodId,
    lastPaymentId,
    lastPaymentDate,
    lastPaymentAmount,
    currentDentistCount,
    currentAssistantCount,
    currentBranchCount,
    currentPatientCount,
  );

  /// Create a copy of UserSubscriptionEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSubscriptionEntityImplCopyWith<_$UserSubscriptionEntityImpl>
  get copyWith =>
      __$$UserSubscriptionEntityImplCopyWithImpl<_$UserSubscriptionEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _UserSubscriptionEntity extends UserSubscriptionEntity {
  const factory _UserSubscriptionEntity({
    required final String id,
    required final String userId,
    required final PlanTier planTier,
    required final SubscriptionStatus status,
    required final BillingCycle billingCycle,
    required final DateTime startDate,
    required final DateTime currentPeriodEnd,
    final DateTime? trialEndDate,
    final DateTime? cancelledAt,
    final bool autoRenew,
    final String? paymentMethodId,
    final String? lastPaymentId,
    final DateTime? lastPaymentDate,
    final double? lastPaymentAmount,
    final int currentDentistCount,
    final int currentAssistantCount,
    final int currentBranchCount,
    final int currentPatientCount,
  }) = _$UserSubscriptionEntityImpl;
  const _UserSubscriptionEntity._() : super._();

  @override
  String get id;
  @override
  String get userId; // or clinicId
  @override
  PlanTier get planTier;
  @override
  SubscriptionStatus get status;
  @override
  BillingCycle get billingCycle;
  @override
  DateTime get startDate;
  @override
  DateTime get currentPeriodEnd;
  @override
  DateTime? get trialEndDate;
  @override
  DateTime? get cancelledAt;
  @override
  bool get autoRenew;
  @override
  String? get paymentMethodId;
  @override
  String? get lastPaymentId;
  @override
  DateTime? get lastPaymentDate;
  @override
  double? get lastPaymentAmount; // Usage tracking
  @override
  int get currentDentistCount;
  @override
  int get currentAssistantCount;
  @override
  int get currentBranchCount;
  @override
  int get currentPatientCount;

  /// Create a copy of UserSubscriptionEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSubscriptionEntityImplCopyWith<_$UserSubscriptionEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}
