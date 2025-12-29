// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SubscriptionEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadSubscription,
    required TResult Function() loadPlans,
    required TResult Function(SubscriptionPlanEntity plan) selectPlan,
    required TResult Function(BillingCycle cycle) changeBillingCycle,
    required TResult Function(String userId) startTrial,
    required TResult Function(String userId, String paymentMethodId) subscribe,
    required TResult Function() cancelSubscription,
    required TResult Function() reactivateSubscription,
    required TResult Function(SubscriptionPlanEntity newPlan) upgradePlan,
    required TResult Function(SubscriptionPlanEntity newPlan) downgradePlan,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadSubscription,
    TResult? Function()? loadPlans,
    TResult? Function(SubscriptionPlanEntity plan)? selectPlan,
    TResult? Function(BillingCycle cycle)? changeBillingCycle,
    TResult? Function(String userId)? startTrial,
    TResult? Function(String userId, String paymentMethodId)? subscribe,
    TResult? Function()? cancelSubscription,
    TResult? Function()? reactivateSubscription,
    TResult? Function(SubscriptionPlanEntity newPlan)? upgradePlan,
    TResult? Function(SubscriptionPlanEntity newPlan)? downgradePlan,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadSubscription,
    TResult Function()? loadPlans,
    TResult Function(SubscriptionPlanEntity plan)? selectPlan,
    TResult Function(BillingCycle cycle)? changeBillingCycle,
    TResult Function(String userId)? startTrial,
    TResult Function(String userId, String paymentMethodId)? subscribe,
    TResult Function()? cancelSubscription,
    TResult Function()? reactivateSubscription,
    TResult Function(SubscriptionPlanEntity newPlan)? upgradePlan,
    TResult Function(SubscriptionPlanEntity newPlan)? downgradePlan,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSubscription value) loadSubscription,
    required TResult Function(_LoadPlans value) loadPlans,
    required TResult Function(_SelectPlan value) selectPlan,
    required TResult Function(_ChangeBillingCycle value) changeBillingCycle,
    required TResult Function(_StartTrial value) startTrial,
    required TResult Function(_Subscribe value) subscribe,
    required TResult Function(_CancelSubscription value) cancelSubscription,
    required TResult Function(_ReactivateSubscription value)
    reactivateSubscription,
    required TResult Function(_UpgradePlan value) upgradePlan,
    required TResult Function(_DowngradePlan value) downgradePlan,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSubscription value)? loadSubscription,
    TResult? Function(_LoadPlans value)? loadPlans,
    TResult? Function(_SelectPlan value)? selectPlan,
    TResult? Function(_ChangeBillingCycle value)? changeBillingCycle,
    TResult? Function(_StartTrial value)? startTrial,
    TResult? Function(_Subscribe value)? subscribe,
    TResult? Function(_CancelSubscription value)? cancelSubscription,
    TResult? Function(_ReactivateSubscription value)? reactivateSubscription,
    TResult? Function(_UpgradePlan value)? upgradePlan,
    TResult? Function(_DowngradePlan value)? downgradePlan,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSubscription value)? loadSubscription,
    TResult Function(_LoadPlans value)? loadPlans,
    TResult Function(_SelectPlan value)? selectPlan,
    TResult Function(_ChangeBillingCycle value)? changeBillingCycle,
    TResult Function(_StartTrial value)? startTrial,
    TResult Function(_Subscribe value)? subscribe,
    TResult Function(_CancelSubscription value)? cancelSubscription,
    TResult Function(_ReactivateSubscription value)? reactivateSubscription,
    TResult Function(_UpgradePlan value)? upgradePlan,
    TResult Function(_DowngradePlan value)? downgradePlan,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionEventCopyWith<$Res> {
  factory $SubscriptionEventCopyWith(
    SubscriptionEvent value,
    $Res Function(SubscriptionEvent) then,
  ) = _$SubscriptionEventCopyWithImpl<$Res, SubscriptionEvent>;
}

/// @nodoc
class _$SubscriptionEventCopyWithImpl<$Res, $Val extends SubscriptionEvent>
    implements $SubscriptionEventCopyWith<$Res> {
  _$SubscriptionEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscriptionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadSubscriptionImplCopyWith<$Res> {
  factory _$$LoadSubscriptionImplCopyWith(
    _$LoadSubscriptionImpl value,
    $Res Function(_$LoadSubscriptionImpl) then,
  ) = __$$LoadSubscriptionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userId});
}

/// @nodoc
class __$$LoadSubscriptionImplCopyWithImpl<$Res>
    extends _$SubscriptionEventCopyWithImpl<$Res, _$LoadSubscriptionImpl>
    implements _$$LoadSubscriptionImplCopyWith<$Res> {
  __$$LoadSubscriptionImplCopyWithImpl(
    _$LoadSubscriptionImpl _value,
    $Res Function(_$LoadSubscriptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubscriptionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? userId = null}) {
    return _then(
      _$LoadSubscriptionImpl(
        null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LoadSubscriptionImpl implements _LoadSubscription {
  const _$LoadSubscriptionImpl(this.userId);

  @override
  final String userId;

  @override
  String toString() {
    return 'SubscriptionEvent.loadSubscription(userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadSubscriptionImpl &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId);

  /// Create a copy of SubscriptionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadSubscriptionImplCopyWith<_$LoadSubscriptionImpl> get copyWith =>
      __$$LoadSubscriptionImplCopyWithImpl<_$LoadSubscriptionImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadSubscription,
    required TResult Function() loadPlans,
    required TResult Function(SubscriptionPlanEntity plan) selectPlan,
    required TResult Function(BillingCycle cycle) changeBillingCycle,
    required TResult Function(String userId) startTrial,
    required TResult Function(String userId, String paymentMethodId) subscribe,
    required TResult Function() cancelSubscription,
    required TResult Function() reactivateSubscription,
    required TResult Function(SubscriptionPlanEntity newPlan) upgradePlan,
    required TResult Function(SubscriptionPlanEntity newPlan) downgradePlan,
  }) {
    return loadSubscription(userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadSubscription,
    TResult? Function()? loadPlans,
    TResult? Function(SubscriptionPlanEntity plan)? selectPlan,
    TResult? Function(BillingCycle cycle)? changeBillingCycle,
    TResult? Function(String userId)? startTrial,
    TResult? Function(String userId, String paymentMethodId)? subscribe,
    TResult? Function()? cancelSubscription,
    TResult? Function()? reactivateSubscription,
    TResult? Function(SubscriptionPlanEntity newPlan)? upgradePlan,
    TResult? Function(SubscriptionPlanEntity newPlan)? downgradePlan,
  }) {
    return loadSubscription?.call(userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadSubscription,
    TResult Function()? loadPlans,
    TResult Function(SubscriptionPlanEntity plan)? selectPlan,
    TResult Function(BillingCycle cycle)? changeBillingCycle,
    TResult Function(String userId)? startTrial,
    TResult Function(String userId, String paymentMethodId)? subscribe,
    TResult Function()? cancelSubscription,
    TResult Function()? reactivateSubscription,
    TResult Function(SubscriptionPlanEntity newPlan)? upgradePlan,
    TResult Function(SubscriptionPlanEntity newPlan)? downgradePlan,
    required TResult orElse(),
  }) {
    if (loadSubscription != null) {
      return loadSubscription(userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSubscription value) loadSubscription,
    required TResult Function(_LoadPlans value) loadPlans,
    required TResult Function(_SelectPlan value) selectPlan,
    required TResult Function(_ChangeBillingCycle value) changeBillingCycle,
    required TResult Function(_StartTrial value) startTrial,
    required TResult Function(_Subscribe value) subscribe,
    required TResult Function(_CancelSubscription value) cancelSubscription,
    required TResult Function(_ReactivateSubscription value)
    reactivateSubscription,
    required TResult Function(_UpgradePlan value) upgradePlan,
    required TResult Function(_DowngradePlan value) downgradePlan,
  }) {
    return loadSubscription(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSubscription value)? loadSubscription,
    TResult? Function(_LoadPlans value)? loadPlans,
    TResult? Function(_SelectPlan value)? selectPlan,
    TResult? Function(_ChangeBillingCycle value)? changeBillingCycle,
    TResult? Function(_StartTrial value)? startTrial,
    TResult? Function(_Subscribe value)? subscribe,
    TResult? Function(_CancelSubscription value)? cancelSubscription,
    TResult? Function(_ReactivateSubscription value)? reactivateSubscription,
    TResult? Function(_UpgradePlan value)? upgradePlan,
    TResult? Function(_DowngradePlan value)? downgradePlan,
  }) {
    return loadSubscription?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSubscription value)? loadSubscription,
    TResult Function(_LoadPlans value)? loadPlans,
    TResult Function(_SelectPlan value)? selectPlan,
    TResult Function(_ChangeBillingCycle value)? changeBillingCycle,
    TResult Function(_StartTrial value)? startTrial,
    TResult Function(_Subscribe value)? subscribe,
    TResult Function(_CancelSubscription value)? cancelSubscription,
    TResult Function(_ReactivateSubscription value)? reactivateSubscription,
    TResult Function(_UpgradePlan value)? upgradePlan,
    TResult Function(_DowngradePlan value)? downgradePlan,
    required TResult orElse(),
  }) {
    if (loadSubscription != null) {
      return loadSubscription(this);
    }
    return orElse();
  }
}

abstract class _LoadSubscription implements SubscriptionEvent {
  const factory _LoadSubscription(final String userId) = _$LoadSubscriptionImpl;

  String get userId;

  /// Create a copy of SubscriptionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadSubscriptionImplCopyWith<_$LoadSubscriptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadPlansImplCopyWith<$Res> {
  factory _$$LoadPlansImplCopyWith(
    _$LoadPlansImpl value,
    $Res Function(_$LoadPlansImpl) then,
  ) = __$$LoadPlansImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadPlansImplCopyWithImpl<$Res>
    extends _$SubscriptionEventCopyWithImpl<$Res, _$LoadPlansImpl>
    implements _$$LoadPlansImplCopyWith<$Res> {
  __$$LoadPlansImplCopyWithImpl(
    _$LoadPlansImpl _value,
    $Res Function(_$LoadPlansImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubscriptionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadPlansImpl implements _LoadPlans {
  const _$LoadPlansImpl();

  @override
  String toString() {
    return 'SubscriptionEvent.loadPlans()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadPlansImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadSubscription,
    required TResult Function() loadPlans,
    required TResult Function(SubscriptionPlanEntity plan) selectPlan,
    required TResult Function(BillingCycle cycle) changeBillingCycle,
    required TResult Function(String userId) startTrial,
    required TResult Function(String userId, String paymentMethodId) subscribe,
    required TResult Function() cancelSubscription,
    required TResult Function() reactivateSubscription,
    required TResult Function(SubscriptionPlanEntity newPlan) upgradePlan,
    required TResult Function(SubscriptionPlanEntity newPlan) downgradePlan,
  }) {
    return loadPlans();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadSubscription,
    TResult? Function()? loadPlans,
    TResult? Function(SubscriptionPlanEntity plan)? selectPlan,
    TResult? Function(BillingCycle cycle)? changeBillingCycle,
    TResult? Function(String userId)? startTrial,
    TResult? Function(String userId, String paymentMethodId)? subscribe,
    TResult? Function()? cancelSubscription,
    TResult? Function()? reactivateSubscription,
    TResult? Function(SubscriptionPlanEntity newPlan)? upgradePlan,
    TResult? Function(SubscriptionPlanEntity newPlan)? downgradePlan,
  }) {
    return loadPlans?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadSubscription,
    TResult Function()? loadPlans,
    TResult Function(SubscriptionPlanEntity plan)? selectPlan,
    TResult Function(BillingCycle cycle)? changeBillingCycle,
    TResult Function(String userId)? startTrial,
    TResult Function(String userId, String paymentMethodId)? subscribe,
    TResult Function()? cancelSubscription,
    TResult Function()? reactivateSubscription,
    TResult Function(SubscriptionPlanEntity newPlan)? upgradePlan,
    TResult Function(SubscriptionPlanEntity newPlan)? downgradePlan,
    required TResult orElse(),
  }) {
    if (loadPlans != null) {
      return loadPlans();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSubscription value) loadSubscription,
    required TResult Function(_LoadPlans value) loadPlans,
    required TResult Function(_SelectPlan value) selectPlan,
    required TResult Function(_ChangeBillingCycle value) changeBillingCycle,
    required TResult Function(_StartTrial value) startTrial,
    required TResult Function(_Subscribe value) subscribe,
    required TResult Function(_CancelSubscription value) cancelSubscription,
    required TResult Function(_ReactivateSubscription value)
    reactivateSubscription,
    required TResult Function(_UpgradePlan value) upgradePlan,
    required TResult Function(_DowngradePlan value) downgradePlan,
  }) {
    return loadPlans(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSubscription value)? loadSubscription,
    TResult? Function(_LoadPlans value)? loadPlans,
    TResult? Function(_SelectPlan value)? selectPlan,
    TResult? Function(_ChangeBillingCycle value)? changeBillingCycle,
    TResult? Function(_StartTrial value)? startTrial,
    TResult? Function(_Subscribe value)? subscribe,
    TResult? Function(_CancelSubscription value)? cancelSubscription,
    TResult? Function(_ReactivateSubscription value)? reactivateSubscription,
    TResult? Function(_UpgradePlan value)? upgradePlan,
    TResult? Function(_DowngradePlan value)? downgradePlan,
  }) {
    return loadPlans?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSubscription value)? loadSubscription,
    TResult Function(_LoadPlans value)? loadPlans,
    TResult Function(_SelectPlan value)? selectPlan,
    TResult Function(_ChangeBillingCycle value)? changeBillingCycle,
    TResult Function(_StartTrial value)? startTrial,
    TResult Function(_Subscribe value)? subscribe,
    TResult Function(_CancelSubscription value)? cancelSubscription,
    TResult Function(_ReactivateSubscription value)? reactivateSubscription,
    TResult Function(_UpgradePlan value)? upgradePlan,
    TResult Function(_DowngradePlan value)? downgradePlan,
    required TResult orElse(),
  }) {
    if (loadPlans != null) {
      return loadPlans(this);
    }
    return orElse();
  }
}

abstract class _LoadPlans implements SubscriptionEvent {
  const factory _LoadPlans() = _$LoadPlansImpl;
}

/// @nodoc
abstract class _$$SelectPlanImplCopyWith<$Res> {
  factory _$$SelectPlanImplCopyWith(
    _$SelectPlanImpl value,
    $Res Function(_$SelectPlanImpl) then,
  ) = __$$SelectPlanImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SubscriptionPlanEntity plan});

  $SubscriptionPlanEntityCopyWith<$Res> get plan;
}

/// @nodoc
class __$$SelectPlanImplCopyWithImpl<$Res>
    extends _$SubscriptionEventCopyWithImpl<$Res, _$SelectPlanImpl>
    implements _$$SelectPlanImplCopyWith<$Res> {
  __$$SelectPlanImplCopyWithImpl(
    _$SelectPlanImpl _value,
    $Res Function(_$SelectPlanImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubscriptionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? plan = null}) {
    return _then(
      _$SelectPlanImpl(
        null == plan
            ? _value.plan
            : plan // ignore: cast_nullable_to_non_nullable
                  as SubscriptionPlanEntity,
      ),
    );
  }

  /// Create a copy of SubscriptionEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SubscriptionPlanEntityCopyWith<$Res> get plan {
    return $SubscriptionPlanEntityCopyWith<$Res>(_value.plan, (value) {
      return _then(_value.copyWith(plan: value));
    });
  }
}

/// @nodoc

class _$SelectPlanImpl implements _SelectPlan {
  const _$SelectPlanImpl(this.plan);

  @override
  final SubscriptionPlanEntity plan;

  @override
  String toString() {
    return 'SubscriptionEvent.selectPlan(plan: $plan)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectPlanImpl &&
            (identical(other.plan, plan) || other.plan == plan));
  }

  @override
  int get hashCode => Object.hash(runtimeType, plan);

  /// Create a copy of SubscriptionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectPlanImplCopyWith<_$SelectPlanImpl> get copyWith =>
      __$$SelectPlanImplCopyWithImpl<_$SelectPlanImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadSubscription,
    required TResult Function() loadPlans,
    required TResult Function(SubscriptionPlanEntity plan) selectPlan,
    required TResult Function(BillingCycle cycle) changeBillingCycle,
    required TResult Function(String userId) startTrial,
    required TResult Function(String userId, String paymentMethodId) subscribe,
    required TResult Function() cancelSubscription,
    required TResult Function() reactivateSubscription,
    required TResult Function(SubscriptionPlanEntity newPlan) upgradePlan,
    required TResult Function(SubscriptionPlanEntity newPlan) downgradePlan,
  }) {
    return selectPlan(plan);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadSubscription,
    TResult? Function()? loadPlans,
    TResult? Function(SubscriptionPlanEntity plan)? selectPlan,
    TResult? Function(BillingCycle cycle)? changeBillingCycle,
    TResult? Function(String userId)? startTrial,
    TResult? Function(String userId, String paymentMethodId)? subscribe,
    TResult? Function()? cancelSubscription,
    TResult? Function()? reactivateSubscription,
    TResult? Function(SubscriptionPlanEntity newPlan)? upgradePlan,
    TResult? Function(SubscriptionPlanEntity newPlan)? downgradePlan,
  }) {
    return selectPlan?.call(plan);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadSubscription,
    TResult Function()? loadPlans,
    TResult Function(SubscriptionPlanEntity plan)? selectPlan,
    TResult Function(BillingCycle cycle)? changeBillingCycle,
    TResult Function(String userId)? startTrial,
    TResult Function(String userId, String paymentMethodId)? subscribe,
    TResult Function()? cancelSubscription,
    TResult Function()? reactivateSubscription,
    TResult Function(SubscriptionPlanEntity newPlan)? upgradePlan,
    TResult Function(SubscriptionPlanEntity newPlan)? downgradePlan,
    required TResult orElse(),
  }) {
    if (selectPlan != null) {
      return selectPlan(plan);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSubscription value) loadSubscription,
    required TResult Function(_LoadPlans value) loadPlans,
    required TResult Function(_SelectPlan value) selectPlan,
    required TResult Function(_ChangeBillingCycle value) changeBillingCycle,
    required TResult Function(_StartTrial value) startTrial,
    required TResult Function(_Subscribe value) subscribe,
    required TResult Function(_CancelSubscription value) cancelSubscription,
    required TResult Function(_ReactivateSubscription value)
    reactivateSubscription,
    required TResult Function(_UpgradePlan value) upgradePlan,
    required TResult Function(_DowngradePlan value) downgradePlan,
  }) {
    return selectPlan(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSubscription value)? loadSubscription,
    TResult? Function(_LoadPlans value)? loadPlans,
    TResult? Function(_SelectPlan value)? selectPlan,
    TResult? Function(_ChangeBillingCycle value)? changeBillingCycle,
    TResult? Function(_StartTrial value)? startTrial,
    TResult? Function(_Subscribe value)? subscribe,
    TResult? Function(_CancelSubscription value)? cancelSubscription,
    TResult? Function(_ReactivateSubscription value)? reactivateSubscription,
    TResult? Function(_UpgradePlan value)? upgradePlan,
    TResult? Function(_DowngradePlan value)? downgradePlan,
  }) {
    return selectPlan?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSubscription value)? loadSubscription,
    TResult Function(_LoadPlans value)? loadPlans,
    TResult Function(_SelectPlan value)? selectPlan,
    TResult Function(_ChangeBillingCycle value)? changeBillingCycle,
    TResult Function(_StartTrial value)? startTrial,
    TResult Function(_Subscribe value)? subscribe,
    TResult Function(_CancelSubscription value)? cancelSubscription,
    TResult Function(_ReactivateSubscription value)? reactivateSubscription,
    TResult Function(_UpgradePlan value)? upgradePlan,
    TResult Function(_DowngradePlan value)? downgradePlan,
    required TResult orElse(),
  }) {
    if (selectPlan != null) {
      return selectPlan(this);
    }
    return orElse();
  }
}

abstract class _SelectPlan implements SubscriptionEvent {
  const factory _SelectPlan(final SubscriptionPlanEntity plan) =
      _$SelectPlanImpl;

  SubscriptionPlanEntity get plan;

  /// Create a copy of SubscriptionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectPlanImplCopyWith<_$SelectPlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChangeBillingCycleImplCopyWith<$Res> {
  factory _$$ChangeBillingCycleImplCopyWith(
    _$ChangeBillingCycleImpl value,
    $Res Function(_$ChangeBillingCycleImpl) then,
  ) = __$$ChangeBillingCycleImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BillingCycle cycle});
}

/// @nodoc
class __$$ChangeBillingCycleImplCopyWithImpl<$Res>
    extends _$SubscriptionEventCopyWithImpl<$Res, _$ChangeBillingCycleImpl>
    implements _$$ChangeBillingCycleImplCopyWith<$Res> {
  __$$ChangeBillingCycleImplCopyWithImpl(
    _$ChangeBillingCycleImpl _value,
    $Res Function(_$ChangeBillingCycleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubscriptionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? cycle = null}) {
    return _then(
      _$ChangeBillingCycleImpl(
        null == cycle
            ? _value.cycle
            : cycle // ignore: cast_nullable_to_non_nullable
                  as BillingCycle,
      ),
    );
  }
}

/// @nodoc

class _$ChangeBillingCycleImpl implements _ChangeBillingCycle {
  const _$ChangeBillingCycleImpl(this.cycle);

  @override
  final BillingCycle cycle;

  @override
  String toString() {
    return 'SubscriptionEvent.changeBillingCycle(cycle: $cycle)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeBillingCycleImpl &&
            (identical(other.cycle, cycle) || other.cycle == cycle));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cycle);

  /// Create a copy of SubscriptionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeBillingCycleImplCopyWith<_$ChangeBillingCycleImpl> get copyWith =>
      __$$ChangeBillingCycleImplCopyWithImpl<_$ChangeBillingCycleImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadSubscription,
    required TResult Function() loadPlans,
    required TResult Function(SubscriptionPlanEntity plan) selectPlan,
    required TResult Function(BillingCycle cycle) changeBillingCycle,
    required TResult Function(String userId) startTrial,
    required TResult Function(String userId, String paymentMethodId) subscribe,
    required TResult Function() cancelSubscription,
    required TResult Function() reactivateSubscription,
    required TResult Function(SubscriptionPlanEntity newPlan) upgradePlan,
    required TResult Function(SubscriptionPlanEntity newPlan) downgradePlan,
  }) {
    return changeBillingCycle(cycle);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadSubscription,
    TResult? Function()? loadPlans,
    TResult? Function(SubscriptionPlanEntity plan)? selectPlan,
    TResult? Function(BillingCycle cycle)? changeBillingCycle,
    TResult? Function(String userId)? startTrial,
    TResult? Function(String userId, String paymentMethodId)? subscribe,
    TResult? Function()? cancelSubscription,
    TResult? Function()? reactivateSubscription,
    TResult? Function(SubscriptionPlanEntity newPlan)? upgradePlan,
    TResult? Function(SubscriptionPlanEntity newPlan)? downgradePlan,
  }) {
    return changeBillingCycle?.call(cycle);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadSubscription,
    TResult Function()? loadPlans,
    TResult Function(SubscriptionPlanEntity plan)? selectPlan,
    TResult Function(BillingCycle cycle)? changeBillingCycle,
    TResult Function(String userId)? startTrial,
    TResult Function(String userId, String paymentMethodId)? subscribe,
    TResult Function()? cancelSubscription,
    TResult Function()? reactivateSubscription,
    TResult Function(SubscriptionPlanEntity newPlan)? upgradePlan,
    TResult Function(SubscriptionPlanEntity newPlan)? downgradePlan,
    required TResult orElse(),
  }) {
    if (changeBillingCycle != null) {
      return changeBillingCycle(cycle);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSubscription value) loadSubscription,
    required TResult Function(_LoadPlans value) loadPlans,
    required TResult Function(_SelectPlan value) selectPlan,
    required TResult Function(_ChangeBillingCycle value) changeBillingCycle,
    required TResult Function(_StartTrial value) startTrial,
    required TResult Function(_Subscribe value) subscribe,
    required TResult Function(_CancelSubscription value) cancelSubscription,
    required TResult Function(_ReactivateSubscription value)
    reactivateSubscription,
    required TResult Function(_UpgradePlan value) upgradePlan,
    required TResult Function(_DowngradePlan value) downgradePlan,
  }) {
    return changeBillingCycle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSubscription value)? loadSubscription,
    TResult? Function(_LoadPlans value)? loadPlans,
    TResult? Function(_SelectPlan value)? selectPlan,
    TResult? Function(_ChangeBillingCycle value)? changeBillingCycle,
    TResult? Function(_StartTrial value)? startTrial,
    TResult? Function(_Subscribe value)? subscribe,
    TResult? Function(_CancelSubscription value)? cancelSubscription,
    TResult? Function(_ReactivateSubscription value)? reactivateSubscription,
    TResult? Function(_UpgradePlan value)? upgradePlan,
    TResult? Function(_DowngradePlan value)? downgradePlan,
  }) {
    return changeBillingCycle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSubscription value)? loadSubscription,
    TResult Function(_LoadPlans value)? loadPlans,
    TResult Function(_SelectPlan value)? selectPlan,
    TResult Function(_ChangeBillingCycle value)? changeBillingCycle,
    TResult Function(_StartTrial value)? startTrial,
    TResult Function(_Subscribe value)? subscribe,
    TResult Function(_CancelSubscription value)? cancelSubscription,
    TResult Function(_ReactivateSubscription value)? reactivateSubscription,
    TResult Function(_UpgradePlan value)? upgradePlan,
    TResult Function(_DowngradePlan value)? downgradePlan,
    required TResult orElse(),
  }) {
    if (changeBillingCycle != null) {
      return changeBillingCycle(this);
    }
    return orElse();
  }
}

abstract class _ChangeBillingCycle implements SubscriptionEvent {
  const factory _ChangeBillingCycle(final BillingCycle cycle) =
      _$ChangeBillingCycleImpl;

  BillingCycle get cycle;

  /// Create a copy of SubscriptionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangeBillingCycleImplCopyWith<_$ChangeBillingCycleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StartTrialImplCopyWith<$Res> {
  factory _$$StartTrialImplCopyWith(
    _$StartTrialImpl value,
    $Res Function(_$StartTrialImpl) then,
  ) = __$$StartTrialImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userId});
}

/// @nodoc
class __$$StartTrialImplCopyWithImpl<$Res>
    extends _$SubscriptionEventCopyWithImpl<$Res, _$StartTrialImpl>
    implements _$$StartTrialImplCopyWith<$Res> {
  __$$StartTrialImplCopyWithImpl(
    _$StartTrialImpl _value,
    $Res Function(_$StartTrialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubscriptionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? userId = null}) {
    return _then(
      _$StartTrialImpl(
        null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$StartTrialImpl implements _StartTrial {
  const _$StartTrialImpl(this.userId);

  @override
  final String userId;

  @override
  String toString() {
    return 'SubscriptionEvent.startTrial(userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StartTrialImpl &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId);

  /// Create a copy of SubscriptionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StartTrialImplCopyWith<_$StartTrialImpl> get copyWith =>
      __$$StartTrialImplCopyWithImpl<_$StartTrialImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadSubscription,
    required TResult Function() loadPlans,
    required TResult Function(SubscriptionPlanEntity plan) selectPlan,
    required TResult Function(BillingCycle cycle) changeBillingCycle,
    required TResult Function(String userId) startTrial,
    required TResult Function(String userId, String paymentMethodId) subscribe,
    required TResult Function() cancelSubscription,
    required TResult Function() reactivateSubscription,
    required TResult Function(SubscriptionPlanEntity newPlan) upgradePlan,
    required TResult Function(SubscriptionPlanEntity newPlan) downgradePlan,
  }) {
    return startTrial(userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadSubscription,
    TResult? Function()? loadPlans,
    TResult? Function(SubscriptionPlanEntity plan)? selectPlan,
    TResult? Function(BillingCycle cycle)? changeBillingCycle,
    TResult? Function(String userId)? startTrial,
    TResult? Function(String userId, String paymentMethodId)? subscribe,
    TResult? Function()? cancelSubscription,
    TResult? Function()? reactivateSubscription,
    TResult? Function(SubscriptionPlanEntity newPlan)? upgradePlan,
    TResult? Function(SubscriptionPlanEntity newPlan)? downgradePlan,
  }) {
    return startTrial?.call(userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadSubscription,
    TResult Function()? loadPlans,
    TResult Function(SubscriptionPlanEntity plan)? selectPlan,
    TResult Function(BillingCycle cycle)? changeBillingCycle,
    TResult Function(String userId)? startTrial,
    TResult Function(String userId, String paymentMethodId)? subscribe,
    TResult Function()? cancelSubscription,
    TResult Function()? reactivateSubscription,
    TResult Function(SubscriptionPlanEntity newPlan)? upgradePlan,
    TResult Function(SubscriptionPlanEntity newPlan)? downgradePlan,
    required TResult orElse(),
  }) {
    if (startTrial != null) {
      return startTrial(userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSubscription value) loadSubscription,
    required TResult Function(_LoadPlans value) loadPlans,
    required TResult Function(_SelectPlan value) selectPlan,
    required TResult Function(_ChangeBillingCycle value) changeBillingCycle,
    required TResult Function(_StartTrial value) startTrial,
    required TResult Function(_Subscribe value) subscribe,
    required TResult Function(_CancelSubscription value) cancelSubscription,
    required TResult Function(_ReactivateSubscription value)
    reactivateSubscription,
    required TResult Function(_UpgradePlan value) upgradePlan,
    required TResult Function(_DowngradePlan value) downgradePlan,
  }) {
    return startTrial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSubscription value)? loadSubscription,
    TResult? Function(_LoadPlans value)? loadPlans,
    TResult? Function(_SelectPlan value)? selectPlan,
    TResult? Function(_ChangeBillingCycle value)? changeBillingCycle,
    TResult? Function(_StartTrial value)? startTrial,
    TResult? Function(_Subscribe value)? subscribe,
    TResult? Function(_CancelSubscription value)? cancelSubscription,
    TResult? Function(_ReactivateSubscription value)? reactivateSubscription,
    TResult? Function(_UpgradePlan value)? upgradePlan,
    TResult? Function(_DowngradePlan value)? downgradePlan,
  }) {
    return startTrial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSubscription value)? loadSubscription,
    TResult Function(_LoadPlans value)? loadPlans,
    TResult Function(_SelectPlan value)? selectPlan,
    TResult Function(_ChangeBillingCycle value)? changeBillingCycle,
    TResult Function(_StartTrial value)? startTrial,
    TResult Function(_Subscribe value)? subscribe,
    TResult Function(_CancelSubscription value)? cancelSubscription,
    TResult Function(_ReactivateSubscription value)? reactivateSubscription,
    TResult Function(_UpgradePlan value)? upgradePlan,
    TResult Function(_DowngradePlan value)? downgradePlan,
    required TResult orElse(),
  }) {
    if (startTrial != null) {
      return startTrial(this);
    }
    return orElse();
  }
}

abstract class _StartTrial implements SubscriptionEvent {
  const factory _StartTrial(final String userId) = _$StartTrialImpl;

  String get userId;

  /// Create a copy of SubscriptionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StartTrialImplCopyWith<_$StartTrialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SubscribeImplCopyWith<$Res> {
  factory _$$SubscribeImplCopyWith(
    _$SubscribeImpl value,
    $Res Function(_$SubscribeImpl) then,
  ) = __$$SubscribeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userId, String paymentMethodId});
}

/// @nodoc
class __$$SubscribeImplCopyWithImpl<$Res>
    extends _$SubscriptionEventCopyWithImpl<$Res, _$SubscribeImpl>
    implements _$$SubscribeImplCopyWith<$Res> {
  __$$SubscribeImplCopyWithImpl(
    _$SubscribeImpl _value,
    $Res Function(_$SubscribeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubscriptionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? userId = null, Object? paymentMethodId = null}) {
    return _then(
      _$SubscribeImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        paymentMethodId: null == paymentMethodId
            ? _value.paymentMethodId
            : paymentMethodId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SubscribeImpl implements _Subscribe {
  const _$SubscribeImpl({required this.userId, required this.paymentMethodId});

  @override
  final String userId;
  @override
  final String paymentMethodId;

  @override
  String toString() {
    return 'SubscriptionEvent.subscribe(userId: $userId, paymentMethodId: $paymentMethodId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscribeImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.paymentMethodId, paymentMethodId) ||
                other.paymentMethodId == paymentMethodId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId, paymentMethodId);

  /// Create a copy of SubscriptionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscribeImplCopyWith<_$SubscribeImpl> get copyWith =>
      __$$SubscribeImplCopyWithImpl<_$SubscribeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadSubscription,
    required TResult Function() loadPlans,
    required TResult Function(SubscriptionPlanEntity plan) selectPlan,
    required TResult Function(BillingCycle cycle) changeBillingCycle,
    required TResult Function(String userId) startTrial,
    required TResult Function(String userId, String paymentMethodId) subscribe,
    required TResult Function() cancelSubscription,
    required TResult Function() reactivateSubscription,
    required TResult Function(SubscriptionPlanEntity newPlan) upgradePlan,
    required TResult Function(SubscriptionPlanEntity newPlan) downgradePlan,
  }) {
    return subscribe(userId, paymentMethodId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadSubscription,
    TResult? Function()? loadPlans,
    TResult? Function(SubscriptionPlanEntity plan)? selectPlan,
    TResult? Function(BillingCycle cycle)? changeBillingCycle,
    TResult? Function(String userId)? startTrial,
    TResult? Function(String userId, String paymentMethodId)? subscribe,
    TResult? Function()? cancelSubscription,
    TResult? Function()? reactivateSubscription,
    TResult? Function(SubscriptionPlanEntity newPlan)? upgradePlan,
    TResult? Function(SubscriptionPlanEntity newPlan)? downgradePlan,
  }) {
    return subscribe?.call(userId, paymentMethodId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadSubscription,
    TResult Function()? loadPlans,
    TResult Function(SubscriptionPlanEntity plan)? selectPlan,
    TResult Function(BillingCycle cycle)? changeBillingCycle,
    TResult Function(String userId)? startTrial,
    TResult Function(String userId, String paymentMethodId)? subscribe,
    TResult Function()? cancelSubscription,
    TResult Function()? reactivateSubscription,
    TResult Function(SubscriptionPlanEntity newPlan)? upgradePlan,
    TResult Function(SubscriptionPlanEntity newPlan)? downgradePlan,
    required TResult orElse(),
  }) {
    if (subscribe != null) {
      return subscribe(userId, paymentMethodId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSubscription value) loadSubscription,
    required TResult Function(_LoadPlans value) loadPlans,
    required TResult Function(_SelectPlan value) selectPlan,
    required TResult Function(_ChangeBillingCycle value) changeBillingCycle,
    required TResult Function(_StartTrial value) startTrial,
    required TResult Function(_Subscribe value) subscribe,
    required TResult Function(_CancelSubscription value) cancelSubscription,
    required TResult Function(_ReactivateSubscription value)
    reactivateSubscription,
    required TResult Function(_UpgradePlan value) upgradePlan,
    required TResult Function(_DowngradePlan value) downgradePlan,
  }) {
    return subscribe(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSubscription value)? loadSubscription,
    TResult? Function(_LoadPlans value)? loadPlans,
    TResult? Function(_SelectPlan value)? selectPlan,
    TResult? Function(_ChangeBillingCycle value)? changeBillingCycle,
    TResult? Function(_StartTrial value)? startTrial,
    TResult? Function(_Subscribe value)? subscribe,
    TResult? Function(_CancelSubscription value)? cancelSubscription,
    TResult? Function(_ReactivateSubscription value)? reactivateSubscription,
    TResult? Function(_UpgradePlan value)? upgradePlan,
    TResult? Function(_DowngradePlan value)? downgradePlan,
  }) {
    return subscribe?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSubscription value)? loadSubscription,
    TResult Function(_LoadPlans value)? loadPlans,
    TResult Function(_SelectPlan value)? selectPlan,
    TResult Function(_ChangeBillingCycle value)? changeBillingCycle,
    TResult Function(_StartTrial value)? startTrial,
    TResult Function(_Subscribe value)? subscribe,
    TResult Function(_CancelSubscription value)? cancelSubscription,
    TResult Function(_ReactivateSubscription value)? reactivateSubscription,
    TResult Function(_UpgradePlan value)? upgradePlan,
    TResult Function(_DowngradePlan value)? downgradePlan,
    required TResult orElse(),
  }) {
    if (subscribe != null) {
      return subscribe(this);
    }
    return orElse();
  }
}

abstract class _Subscribe implements SubscriptionEvent {
  const factory _Subscribe({
    required final String userId,
    required final String paymentMethodId,
  }) = _$SubscribeImpl;

  String get userId;
  String get paymentMethodId;

  /// Create a copy of SubscriptionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscribeImplCopyWith<_$SubscribeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CancelSubscriptionImplCopyWith<$Res> {
  factory _$$CancelSubscriptionImplCopyWith(
    _$CancelSubscriptionImpl value,
    $Res Function(_$CancelSubscriptionImpl) then,
  ) = __$$CancelSubscriptionImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CancelSubscriptionImplCopyWithImpl<$Res>
    extends _$SubscriptionEventCopyWithImpl<$Res, _$CancelSubscriptionImpl>
    implements _$$CancelSubscriptionImplCopyWith<$Res> {
  __$$CancelSubscriptionImplCopyWithImpl(
    _$CancelSubscriptionImpl _value,
    $Res Function(_$CancelSubscriptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubscriptionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CancelSubscriptionImpl implements _CancelSubscription {
  const _$CancelSubscriptionImpl();

  @override
  String toString() {
    return 'SubscriptionEvent.cancelSubscription()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CancelSubscriptionImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadSubscription,
    required TResult Function() loadPlans,
    required TResult Function(SubscriptionPlanEntity plan) selectPlan,
    required TResult Function(BillingCycle cycle) changeBillingCycle,
    required TResult Function(String userId) startTrial,
    required TResult Function(String userId, String paymentMethodId) subscribe,
    required TResult Function() cancelSubscription,
    required TResult Function() reactivateSubscription,
    required TResult Function(SubscriptionPlanEntity newPlan) upgradePlan,
    required TResult Function(SubscriptionPlanEntity newPlan) downgradePlan,
  }) {
    return cancelSubscription();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadSubscription,
    TResult? Function()? loadPlans,
    TResult? Function(SubscriptionPlanEntity plan)? selectPlan,
    TResult? Function(BillingCycle cycle)? changeBillingCycle,
    TResult? Function(String userId)? startTrial,
    TResult? Function(String userId, String paymentMethodId)? subscribe,
    TResult? Function()? cancelSubscription,
    TResult? Function()? reactivateSubscription,
    TResult? Function(SubscriptionPlanEntity newPlan)? upgradePlan,
    TResult? Function(SubscriptionPlanEntity newPlan)? downgradePlan,
  }) {
    return cancelSubscription?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadSubscription,
    TResult Function()? loadPlans,
    TResult Function(SubscriptionPlanEntity plan)? selectPlan,
    TResult Function(BillingCycle cycle)? changeBillingCycle,
    TResult Function(String userId)? startTrial,
    TResult Function(String userId, String paymentMethodId)? subscribe,
    TResult Function()? cancelSubscription,
    TResult Function()? reactivateSubscription,
    TResult Function(SubscriptionPlanEntity newPlan)? upgradePlan,
    TResult Function(SubscriptionPlanEntity newPlan)? downgradePlan,
    required TResult orElse(),
  }) {
    if (cancelSubscription != null) {
      return cancelSubscription();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSubscription value) loadSubscription,
    required TResult Function(_LoadPlans value) loadPlans,
    required TResult Function(_SelectPlan value) selectPlan,
    required TResult Function(_ChangeBillingCycle value) changeBillingCycle,
    required TResult Function(_StartTrial value) startTrial,
    required TResult Function(_Subscribe value) subscribe,
    required TResult Function(_CancelSubscription value) cancelSubscription,
    required TResult Function(_ReactivateSubscription value)
    reactivateSubscription,
    required TResult Function(_UpgradePlan value) upgradePlan,
    required TResult Function(_DowngradePlan value) downgradePlan,
  }) {
    return cancelSubscription(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSubscription value)? loadSubscription,
    TResult? Function(_LoadPlans value)? loadPlans,
    TResult? Function(_SelectPlan value)? selectPlan,
    TResult? Function(_ChangeBillingCycle value)? changeBillingCycle,
    TResult? Function(_StartTrial value)? startTrial,
    TResult? Function(_Subscribe value)? subscribe,
    TResult? Function(_CancelSubscription value)? cancelSubscription,
    TResult? Function(_ReactivateSubscription value)? reactivateSubscription,
    TResult? Function(_UpgradePlan value)? upgradePlan,
    TResult? Function(_DowngradePlan value)? downgradePlan,
  }) {
    return cancelSubscription?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSubscription value)? loadSubscription,
    TResult Function(_LoadPlans value)? loadPlans,
    TResult Function(_SelectPlan value)? selectPlan,
    TResult Function(_ChangeBillingCycle value)? changeBillingCycle,
    TResult Function(_StartTrial value)? startTrial,
    TResult Function(_Subscribe value)? subscribe,
    TResult Function(_CancelSubscription value)? cancelSubscription,
    TResult Function(_ReactivateSubscription value)? reactivateSubscription,
    TResult Function(_UpgradePlan value)? upgradePlan,
    TResult Function(_DowngradePlan value)? downgradePlan,
    required TResult orElse(),
  }) {
    if (cancelSubscription != null) {
      return cancelSubscription(this);
    }
    return orElse();
  }
}

abstract class _CancelSubscription implements SubscriptionEvent {
  const factory _CancelSubscription() = _$CancelSubscriptionImpl;
}

/// @nodoc
abstract class _$$ReactivateSubscriptionImplCopyWith<$Res> {
  factory _$$ReactivateSubscriptionImplCopyWith(
    _$ReactivateSubscriptionImpl value,
    $Res Function(_$ReactivateSubscriptionImpl) then,
  ) = __$$ReactivateSubscriptionImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ReactivateSubscriptionImplCopyWithImpl<$Res>
    extends _$SubscriptionEventCopyWithImpl<$Res, _$ReactivateSubscriptionImpl>
    implements _$$ReactivateSubscriptionImplCopyWith<$Res> {
  __$$ReactivateSubscriptionImplCopyWithImpl(
    _$ReactivateSubscriptionImpl _value,
    $Res Function(_$ReactivateSubscriptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubscriptionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ReactivateSubscriptionImpl implements _ReactivateSubscription {
  const _$ReactivateSubscriptionImpl();

  @override
  String toString() {
    return 'SubscriptionEvent.reactivateSubscription()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReactivateSubscriptionImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadSubscription,
    required TResult Function() loadPlans,
    required TResult Function(SubscriptionPlanEntity plan) selectPlan,
    required TResult Function(BillingCycle cycle) changeBillingCycle,
    required TResult Function(String userId) startTrial,
    required TResult Function(String userId, String paymentMethodId) subscribe,
    required TResult Function() cancelSubscription,
    required TResult Function() reactivateSubscription,
    required TResult Function(SubscriptionPlanEntity newPlan) upgradePlan,
    required TResult Function(SubscriptionPlanEntity newPlan) downgradePlan,
  }) {
    return reactivateSubscription();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadSubscription,
    TResult? Function()? loadPlans,
    TResult? Function(SubscriptionPlanEntity plan)? selectPlan,
    TResult? Function(BillingCycle cycle)? changeBillingCycle,
    TResult? Function(String userId)? startTrial,
    TResult? Function(String userId, String paymentMethodId)? subscribe,
    TResult? Function()? cancelSubscription,
    TResult? Function()? reactivateSubscription,
    TResult? Function(SubscriptionPlanEntity newPlan)? upgradePlan,
    TResult? Function(SubscriptionPlanEntity newPlan)? downgradePlan,
  }) {
    return reactivateSubscription?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadSubscription,
    TResult Function()? loadPlans,
    TResult Function(SubscriptionPlanEntity plan)? selectPlan,
    TResult Function(BillingCycle cycle)? changeBillingCycle,
    TResult Function(String userId)? startTrial,
    TResult Function(String userId, String paymentMethodId)? subscribe,
    TResult Function()? cancelSubscription,
    TResult Function()? reactivateSubscription,
    TResult Function(SubscriptionPlanEntity newPlan)? upgradePlan,
    TResult Function(SubscriptionPlanEntity newPlan)? downgradePlan,
    required TResult orElse(),
  }) {
    if (reactivateSubscription != null) {
      return reactivateSubscription();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSubscription value) loadSubscription,
    required TResult Function(_LoadPlans value) loadPlans,
    required TResult Function(_SelectPlan value) selectPlan,
    required TResult Function(_ChangeBillingCycle value) changeBillingCycle,
    required TResult Function(_StartTrial value) startTrial,
    required TResult Function(_Subscribe value) subscribe,
    required TResult Function(_CancelSubscription value) cancelSubscription,
    required TResult Function(_ReactivateSubscription value)
    reactivateSubscription,
    required TResult Function(_UpgradePlan value) upgradePlan,
    required TResult Function(_DowngradePlan value) downgradePlan,
  }) {
    return reactivateSubscription(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSubscription value)? loadSubscription,
    TResult? Function(_LoadPlans value)? loadPlans,
    TResult? Function(_SelectPlan value)? selectPlan,
    TResult? Function(_ChangeBillingCycle value)? changeBillingCycle,
    TResult? Function(_StartTrial value)? startTrial,
    TResult? Function(_Subscribe value)? subscribe,
    TResult? Function(_CancelSubscription value)? cancelSubscription,
    TResult? Function(_ReactivateSubscription value)? reactivateSubscription,
    TResult? Function(_UpgradePlan value)? upgradePlan,
    TResult? Function(_DowngradePlan value)? downgradePlan,
  }) {
    return reactivateSubscription?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSubscription value)? loadSubscription,
    TResult Function(_LoadPlans value)? loadPlans,
    TResult Function(_SelectPlan value)? selectPlan,
    TResult Function(_ChangeBillingCycle value)? changeBillingCycle,
    TResult Function(_StartTrial value)? startTrial,
    TResult Function(_Subscribe value)? subscribe,
    TResult Function(_CancelSubscription value)? cancelSubscription,
    TResult Function(_ReactivateSubscription value)? reactivateSubscription,
    TResult Function(_UpgradePlan value)? upgradePlan,
    TResult Function(_DowngradePlan value)? downgradePlan,
    required TResult orElse(),
  }) {
    if (reactivateSubscription != null) {
      return reactivateSubscription(this);
    }
    return orElse();
  }
}

abstract class _ReactivateSubscription implements SubscriptionEvent {
  const factory _ReactivateSubscription() = _$ReactivateSubscriptionImpl;
}

/// @nodoc
abstract class _$$UpgradePlanImplCopyWith<$Res> {
  factory _$$UpgradePlanImplCopyWith(
    _$UpgradePlanImpl value,
    $Res Function(_$UpgradePlanImpl) then,
  ) = __$$UpgradePlanImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SubscriptionPlanEntity newPlan});

  $SubscriptionPlanEntityCopyWith<$Res> get newPlan;
}

/// @nodoc
class __$$UpgradePlanImplCopyWithImpl<$Res>
    extends _$SubscriptionEventCopyWithImpl<$Res, _$UpgradePlanImpl>
    implements _$$UpgradePlanImplCopyWith<$Res> {
  __$$UpgradePlanImplCopyWithImpl(
    _$UpgradePlanImpl _value,
    $Res Function(_$UpgradePlanImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubscriptionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? newPlan = null}) {
    return _then(
      _$UpgradePlanImpl(
        null == newPlan
            ? _value.newPlan
            : newPlan // ignore: cast_nullable_to_non_nullable
                  as SubscriptionPlanEntity,
      ),
    );
  }

  /// Create a copy of SubscriptionEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SubscriptionPlanEntityCopyWith<$Res> get newPlan {
    return $SubscriptionPlanEntityCopyWith<$Res>(_value.newPlan, (value) {
      return _then(_value.copyWith(newPlan: value));
    });
  }
}

/// @nodoc

class _$UpgradePlanImpl implements _UpgradePlan {
  const _$UpgradePlanImpl(this.newPlan);

  @override
  final SubscriptionPlanEntity newPlan;

  @override
  String toString() {
    return 'SubscriptionEvent.upgradePlan(newPlan: $newPlan)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpgradePlanImpl &&
            (identical(other.newPlan, newPlan) || other.newPlan == newPlan));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newPlan);

  /// Create a copy of SubscriptionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpgradePlanImplCopyWith<_$UpgradePlanImpl> get copyWith =>
      __$$UpgradePlanImplCopyWithImpl<_$UpgradePlanImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadSubscription,
    required TResult Function() loadPlans,
    required TResult Function(SubscriptionPlanEntity plan) selectPlan,
    required TResult Function(BillingCycle cycle) changeBillingCycle,
    required TResult Function(String userId) startTrial,
    required TResult Function(String userId, String paymentMethodId) subscribe,
    required TResult Function() cancelSubscription,
    required TResult Function() reactivateSubscription,
    required TResult Function(SubscriptionPlanEntity newPlan) upgradePlan,
    required TResult Function(SubscriptionPlanEntity newPlan) downgradePlan,
  }) {
    return upgradePlan(newPlan);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadSubscription,
    TResult? Function()? loadPlans,
    TResult? Function(SubscriptionPlanEntity plan)? selectPlan,
    TResult? Function(BillingCycle cycle)? changeBillingCycle,
    TResult? Function(String userId)? startTrial,
    TResult? Function(String userId, String paymentMethodId)? subscribe,
    TResult? Function()? cancelSubscription,
    TResult? Function()? reactivateSubscription,
    TResult? Function(SubscriptionPlanEntity newPlan)? upgradePlan,
    TResult? Function(SubscriptionPlanEntity newPlan)? downgradePlan,
  }) {
    return upgradePlan?.call(newPlan);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadSubscription,
    TResult Function()? loadPlans,
    TResult Function(SubscriptionPlanEntity plan)? selectPlan,
    TResult Function(BillingCycle cycle)? changeBillingCycle,
    TResult Function(String userId)? startTrial,
    TResult Function(String userId, String paymentMethodId)? subscribe,
    TResult Function()? cancelSubscription,
    TResult Function()? reactivateSubscription,
    TResult Function(SubscriptionPlanEntity newPlan)? upgradePlan,
    TResult Function(SubscriptionPlanEntity newPlan)? downgradePlan,
    required TResult orElse(),
  }) {
    if (upgradePlan != null) {
      return upgradePlan(newPlan);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSubscription value) loadSubscription,
    required TResult Function(_LoadPlans value) loadPlans,
    required TResult Function(_SelectPlan value) selectPlan,
    required TResult Function(_ChangeBillingCycle value) changeBillingCycle,
    required TResult Function(_StartTrial value) startTrial,
    required TResult Function(_Subscribe value) subscribe,
    required TResult Function(_CancelSubscription value) cancelSubscription,
    required TResult Function(_ReactivateSubscription value)
    reactivateSubscription,
    required TResult Function(_UpgradePlan value) upgradePlan,
    required TResult Function(_DowngradePlan value) downgradePlan,
  }) {
    return upgradePlan(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSubscription value)? loadSubscription,
    TResult? Function(_LoadPlans value)? loadPlans,
    TResult? Function(_SelectPlan value)? selectPlan,
    TResult? Function(_ChangeBillingCycle value)? changeBillingCycle,
    TResult? Function(_StartTrial value)? startTrial,
    TResult? Function(_Subscribe value)? subscribe,
    TResult? Function(_CancelSubscription value)? cancelSubscription,
    TResult? Function(_ReactivateSubscription value)? reactivateSubscription,
    TResult? Function(_UpgradePlan value)? upgradePlan,
    TResult? Function(_DowngradePlan value)? downgradePlan,
  }) {
    return upgradePlan?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSubscription value)? loadSubscription,
    TResult Function(_LoadPlans value)? loadPlans,
    TResult Function(_SelectPlan value)? selectPlan,
    TResult Function(_ChangeBillingCycle value)? changeBillingCycle,
    TResult Function(_StartTrial value)? startTrial,
    TResult Function(_Subscribe value)? subscribe,
    TResult Function(_CancelSubscription value)? cancelSubscription,
    TResult Function(_ReactivateSubscription value)? reactivateSubscription,
    TResult Function(_UpgradePlan value)? upgradePlan,
    TResult Function(_DowngradePlan value)? downgradePlan,
    required TResult orElse(),
  }) {
    if (upgradePlan != null) {
      return upgradePlan(this);
    }
    return orElse();
  }
}

abstract class _UpgradePlan implements SubscriptionEvent {
  const factory _UpgradePlan(final SubscriptionPlanEntity newPlan) =
      _$UpgradePlanImpl;

  SubscriptionPlanEntity get newPlan;

  /// Create a copy of SubscriptionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpgradePlanImplCopyWith<_$UpgradePlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DowngradePlanImplCopyWith<$Res> {
  factory _$$DowngradePlanImplCopyWith(
    _$DowngradePlanImpl value,
    $Res Function(_$DowngradePlanImpl) then,
  ) = __$$DowngradePlanImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SubscriptionPlanEntity newPlan});

  $SubscriptionPlanEntityCopyWith<$Res> get newPlan;
}

/// @nodoc
class __$$DowngradePlanImplCopyWithImpl<$Res>
    extends _$SubscriptionEventCopyWithImpl<$Res, _$DowngradePlanImpl>
    implements _$$DowngradePlanImplCopyWith<$Res> {
  __$$DowngradePlanImplCopyWithImpl(
    _$DowngradePlanImpl _value,
    $Res Function(_$DowngradePlanImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubscriptionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? newPlan = null}) {
    return _then(
      _$DowngradePlanImpl(
        null == newPlan
            ? _value.newPlan
            : newPlan // ignore: cast_nullable_to_non_nullable
                  as SubscriptionPlanEntity,
      ),
    );
  }

  /// Create a copy of SubscriptionEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SubscriptionPlanEntityCopyWith<$Res> get newPlan {
    return $SubscriptionPlanEntityCopyWith<$Res>(_value.newPlan, (value) {
      return _then(_value.copyWith(newPlan: value));
    });
  }
}

/// @nodoc

class _$DowngradePlanImpl implements _DowngradePlan {
  const _$DowngradePlanImpl(this.newPlan);

  @override
  final SubscriptionPlanEntity newPlan;

  @override
  String toString() {
    return 'SubscriptionEvent.downgradePlan(newPlan: $newPlan)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DowngradePlanImpl &&
            (identical(other.newPlan, newPlan) || other.newPlan == newPlan));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newPlan);

  /// Create a copy of SubscriptionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DowngradePlanImplCopyWith<_$DowngradePlanImpl> get copyWith =>
      __$$DowngradePlanImplCopyWithImpl<_$DowngradePlanImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadSubscription,
    required TResult Function() loadPlans,
    required TResult Function(SubscriptionPlanEntity plan) selectPlan,
    required TResult Function(BillingCycle cycle) changeBillingCycle,
    required TResult Function(String userId) startTrial,
    required TResult Function(String userId, String paymentMethodId) subscribe,
    required TResult Function() cancelSubscription,
    required TResult Function() reactivateSubscription,
    required TResult Function(SubscriptionPlanEntity newPlan) upgradePlan,
    required TResult Function(SubscriptionPlanEntity newPlan) downgradePlan,
  }) {
    return downgradePlan(newPlan);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadSubscription,
    TResult? Function()? loadPlans,
    TResult? Function(SubscriptionPlanEntity plan)? selectPlan,
    TResult? Function(BillingCycle cycle)? changeBillingCycle,
    TResult? Function(String userId)? startTrial,
    TResult? Function(String userId, String paymentMethodId)? subscribe,
    TResult? Function()? cancelSubscription,
    TResult? Function()? reactivateSubscription,
    TResult? Function(SubscriptionPlanEntity newPlan)? upgradePlan,
    TResult? Function(SubscriptionPlanEntity newPlan)? downgradePlan,
  }) {
    return downgradePlan?.call(newPlan);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadSubscription,
    TResult Function()? loadPlans,
    TResult Function(SubscriptionPlanEntity plan)? selectPlan,
    TResult Function(BillingCycle cycle)? changeBillingCycle,
    TResult Function(String userId)? startTrial,
    TResult Function(String userId, String paymentMethodId)? subscribe,
    TResult Function()? cancelSubscription,
    TResult Function()? reactivateSubscription,
    TResult Function(SubscriptionPlanEntity newPlan)? upgradePlan,
    TResult Function(SubscriptionPlanEntity newPlan)? downgradePlan,
    required TResult orElse(),
  }) {
    if (downgradePlan != null) {
      return downgradePlan(newPlan);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSubscription value) loadSubscription,
    required TResult Function(_LoadPlans value) loadPlans,
    required TResult Function(_SelectPlan value) selectPlan,
    required TResult Function(_ChangeBillingCycle value) changeBillingCycle,
    required TResult Function(_StartTrial value) startTrial,
    required TResult Function(_Subscribe value) subscribe,
    required TResult Function(_CancelSubscription value) cancelSubscription,
    required TResult Function(_ReactivateSubscription value)
    reactivateSubscription,
    required TResult Function(_UpgradePlan value) upgradePlan,
    required TResult Function(_DowngradePlan value) downgradePlan,
  }) {
    return downgradePlan(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSubscription value)? loadSubscription,
    TResult? Function(_LoadPlans value)? loadPlans,
    TResult? Function(_SelectPlan value)? selectPlan,
    TResult? Function(_ChangeBillingCycle value)? changeBillingCycle,
    TResult? Function(_StartTrial value)? startTrial,
    TResult? Function(_Subscribe value)? subscribe,
    TResult? Function(_CancelSubscription value)? cancelSubscription,
    TResult? Function(_ReactivateSubscription value)? reactivateSubscription,
    TResult? Function(_UpgradePlan value)? upgradePlan,
    TResult? Function(_DowngradePlan value)? downgradePlan,
  }) {
    return downgradePlan?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSubscription value)? loadSubscription,
    TResult Function(_LoadPlans value)? loadPlans,
    TResult Function(_SelectPlan value)? selectPlan,
    TResult Function(_ChangeBillingCycle value)? changeBillingCycle,
    TResult Function(_StartTrial value)? startTrial,
    TResult Function(_Subscribe value)? subscribe,
    TResult Function(_CancelSubscription value)? cancelSubscription,
    TResult Function(_ReactivateSubscription value)? reactivateSubscription,
    TResult Function(_UpgradePlan value)? upgradePlan,
    TResult Function(_DowngradePlan value)? downgradePlan,
    required TResult orElse(),
  }) {
    if (downgradePlan != null) {
      return downgradePlan(this);
    }
    return orElse();
  }
}

abstract class _DowngradePlan implements SubscriptionEvent {
  const factory _DowngradePlan(final SubscriptionPlanEntity newPlan) =
      _$DowngradePlanImpl;

  SubscriptionPlanEntity get newPlan;

  /// Create a copy of SubscriptionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DowngradePlanImplCopyWith<_$DowngradePlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SubscriptionState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingPlans => throw _privateConstructorUsedError;
  bool get isProcessing => throw _privateConstructorUsedError;
  UserSubscriptionEntity? get currentSubscription =>
      throw _privateConstructorUsedError;
  List<SubscriptionPlanEntity> get availablePlans =>
      throw _privateConstructorUsedError;
  SubscriptionPlanEntity? get selectedPlan =>
      throw _privateConstructorUsedError;
  BillingCycle get selectedBillingCycle => throw _privateConstructorUsedError;
  SubscriptionPlanEntity? get pendingDowngrade =>
      throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError; // Success flags
  bool get trialStarted => throw _privateConstructorUsedError;
  bool get subscribeSuccess => throw _privateConstructorUsedError;
  bool get cancelSuccess => throw _privateConstructorUsedError;
  bool get reactivateSuccess => throw _privateConstructorUsedError;
  bool get upgradeSuccess => throw _privateConstructorUsedError;
  bool get downgradeSuccess => throw _privateConstructorUsedError;

  /// Create a copy of SubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscriptionStateCopyWith<SubscriptionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionStateCopyWith<$Res> {
  factory $SubscriptionStateCopyWith(
    SubscriptionState value,
    $Res Function(SubscriptionState) then,
  ) = _$SubscriptionStateCopyWithImpl<$Res, SubscriptionState>;
  @useResult
  $Res call({
    bool isLoading,
    bool isLoadingPlans,
    bool isProcessing,
    UserSubscriptionEntity? currentSubscription,
    List<SubscriptionPlanEntity> availablePlans,
    SubscriptionPlanEntity? selectedPlan,
    BillingCycle selectedBillingCycle,
    SubscriptionPlanEntity? pendingDowngrade,
    String? error,
    bool trialStarted,
    bool subscribeSuccess,
    bool cancelSuccess,
    bool reactivateSuccess,
    bool upgradeSuccess,
    bool downgradeSuccess,
  });

  $UserSubscriptionEntityCopyWith<$Res>? get currentSubscription;
  $SubscriptionPlanEntityCopyWith<$Res>? get selectedPlan;
  $SubscriptionPlanEntityCopyWith<$Res>? get pendingDowngrade;
}

/// @nodoc
class _$SubscriptionStateCopyWithImpl<$Res, $Val extends SubscriptionState>
    implements $SubscriptionStateCopyWith<$Res> {
  _$SubscriptionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isLoadingPlans = null,
    Object? isProcessing = null,
    Object? currentSubscription = freezed,
    Object? availablePlans = null,
    Object? selectedPlan = freezed,
    Object? selectedBillingCycle = null,
    Object? pendingDowngrade = freezed,
    Object? error = freezed,
    Object? trialStarted = null,
    Object? subscribeSuccess = null,
    Object? cancelSuccess = null,
    Object? reactivateSuccess = null,
    Object? upgradeSuccess = null,
    Object? downgradeSuccess = null,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoadingPlans: null == isLoadingPlans
                ? _value.isLoadingPlans
                : isLoadingPlans // ignore: cast_nullable_to_non_nullable
                      as bool,
            isProcessing: null == isProcessing
                ? _value.isProcessing
                : isProcessing // ignore: cast_nullable_to_non_nullable
                      as bool,
            currentSubscription: freezed == currentSubscription
                ? _value.currentSubscription
                : currentSubscription // ignore: cast_nullable_to_non_nullable
                      as UserSubscriptionEntity?,
            availablePlans: null == availablePlans
                ? _value.availablePlans
                : availablePlans // ignore: cast_nullable_to_non_nullable
                      as List<SubscriptionPlanEntity>,
            selectedPlan: freezed == selectedPlan
                ? _value.selectedPlan
                : selectedPlan // ignore: cast_nullable_to_non_nullable
                      as SubscriptionPlanEntity?,
            selectedBillingCycle: null == selectedBillingCycle
                ? _value.selectedBillingCycle
                : selectedBillingCycle // ignore: cast_nullable_to_non_nullable
                      as BillingCycle,
            pendingDowngrade: freezed == pendingDowngrade
                ? _value.pendingDowngrade
                : pendingDowngrade // ignore: cast_nullable_to_non_nullable
                      as SubscriptionPlanEntity?,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
            trialStarted: null == trialStarted
                ? _value.trialStarted
                : trialStarted // ignore: cast_nullable_to_non_nullable
                      as bool,
            subscribeSuccess: null == subscribeSuccess
                ? _value.subscribeSuccess
                : subscribeSuccess // ignore: cast_nullable_to_non_nullable
                      as bool,
            cancelSuccess: null == cancelSuccess
                ? _value.cancelSuccess
                : cancelSuccess // ignore: cast_nullable_to_non_nullable
                      as bool,
            reactivateSuccess: null == reactivateSuccess
                ? _value.reactivateSuccess
                : reactivateSuccess // ignore: cast_nullable_to_non_nullable
                      as bool,
            upgradeSuccess: null == upgradeSuccess
                ? _value.upgradeSuccess
                : upgradeSuccess // ignore: cast_nullable_to_non_nullable
                      as bool,
            downgradeSuccess: null == downgradeSuccess
                ? _value.downgradeSuccess
                : downgradeSuccess // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of SubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserSubscriptionEntityCopyWith<$Res>? get currentSubscription {
    if (_value.currentSubscription == null) {
      return null;
    }

    return $UserSubscriptionEntityCopyWith<$Res>(_value.currentSubscription!, (
      value,
    ) {
      return _then(_value.copyWith(currentSubscription: value) as $Val);
    });
  }

  /// Create a copy of SubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SubscriptionPlanEntityCopyWith<$Res>? get selectedPlan {
    if (_value.selectedPlan == null) {
      return null;
    }

    return $SubscriptionPlanEntityCopyWith<$Res>(_value.selectedPlan!, (value) {
      return _then(_value.copyWith(selectedPlan: value) as $Val);
    });
  }

  /// Create a copy of SubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SubscriptionPlanEntityCopyWith<$Res>? get pendingDowngrade {
    if (_value.pendingDowngrade == null) {
      return null;
    }

    return $SubscriptionPlanEntityCopyWith<$Res>(_value.pendingDowngrade!, (
      value,
    ) {
      return _then(_value.copyWith(pendingDowngrade: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SubscriptionStateImplCopyWith<$Res>
    implements $SubscriptionStateCopyWith<$Res> {
  factory _$$SubscriptionStateImplCopyWith(
    _$SubscriptionStateImpl value,
    $Res Function(_$SubscriptionStateImpl) then,
  ) = __$$SubscriptionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    bool isLoadingPlans,
    bool isProcessing,
    UserSubscriptionEntity? currentSubscription,
    List<SubscriptionPlanEntity> availablePlans,
    SubscriptionPlanEntity? selectedPlan,
    BillingCycle selectedBillingCycle,
    SubscriptionPlanEntity? pendingDowngrade,
    String? error,
    bool trialStarted,
    bool subscribeSuccess,
    bool cancelSuccess,
    bool reactivateSuccess,
    bool upgradeSuccess,
    bool downgradeSuccess,
  });

  @override
  $UserSubscriptionEntityCopyWith<$Res>? get currentSubscription;
  @override
  $SubscriptionPlanEntityCopyWith<$Res>? get selectedPlan;
  @override
  $SubscriptionPlanEntityCopyWith<$Res>? get pendingDowngrade;
}

/// @nodoc
class __$$SubscriptionStateImplCopyWithImpl<$Res>
    extends _$SubscriptionStateCopyWithImpl<$Res, _$SubscriptionStateImpl>
    implements _$$SubscriptionStateImplCopyWith<$Res> {
  __$$SubscriptionStateImplCopyWithImpl(
    _$SubscriptionStateImpl _value,
    $Res Function(_$SubscriptionStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isLoadingPlans = null,
    Object? isProcessing = null,
    Object? currentSubscription = freezed,
    Object? availablePlans = null,
    Object? selectedPlan = freezed,
    Object? selectedBillingCycle = null,
    Object? pendingDowngrade = freezed,
    Object? error = freezed,
    Object? trialStarted = null,
    Object? subscribeSuccess = null,
    Object? cancelSuccess = null,
    Object? reactivateSuccess = null,
    Object? upgradeSuccess = null,
    Object? downgradeSuccess = null,
  }) {
    return _then(
      _$SubscriptionStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingPlans: null == isLoadingPlans
            ? _value.isLoadingPlans
            : isLoadingPlans // ignore: cast_nullable_to_non_nullable
                  as bool,
        isProcessing: null == isProcessing
            ? _value.isProcessing
            : isProcessing // ignore: cast_nullable_to_non_nullable
                  as bool,
        currentSubscription: freezed == currentSubscription
            ? _value.currentSubscription
            : currentSubscription // ignore: cast_nullable_to_non_nullable
                  as UserSubscriptionEntity?,
        availablePlans: null == availablePlans
            ? _value._availablePlans
            : availablePlans // ignore: cast_nullable_to_non_nullable
                  as List<SubscriptionPlanEntity>,
        selectedPlan: freezed == selectedPlan
            ? _value.selectedPlan
            : selectedPlan // ignore: cast_nullable_to_non_nullable
                  as SubscriptionPlanEntity?,
        selectedBillingCycle: null == selectedBillingCycle
            ? _value.selectedBillingCycle
            : selectedBillingCycle // ignore: cast_nullable_to_non_nullable
                  as BillingCycle,
        pendingDowngrade: freezed == pendingDowngrade
            ? _value.pendingDowngrade
            : pendingDowngrade // ignore: cast_nullable_to_non_nullable
                  as SubscriptionPlanEntity?,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        trialStarted: null == trialStarted
            ? _value.trialStarted
            : trialStarted // ignore: cast_nullable_to_non_nullable
                  as bool,
        subscribeSuccess: null == subscribeSuccess
            ? _value.subscribeSuccess
            : subscribeSuccess // ignore: cast_nullable_to_non_nullable
                  as bool,
        cancelSuccess: null == cancelSuccess
            ? _value.cancelSuccess
            : cancelSuccess // ignore: cast_nullable_to_non_nullable
                  as bool,
        reactivateSuccess: null == reactivateSuccess
            ? _value.reactivateSuccess
            : reactivateSuccess // ignore: cast_nullable_to_non_nullable
                  as bool,
        upgradeSuccess: null == upgradeSuccess
            ? _value.upgradeSuccess
            : upgradeSuccess // ignore: cast_nullable_to_non_nullable
                  as bool,
        downgradeSuccess: null == downgradeSuccess
            ? _value.downgradeSuccess
            : downgradeSuccess // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$SubscriptionStateImpl extends _SubscriptionState {
  const _$SubscriptionStateImpl({
    this.isLoading = false,
    this.isLoadingPlans = false,
    this.isProcessing = false,
    this.currentSubscription,
    final List<SubscriptionPlanEntity> availablePlans = const [],
    this.selectedPlan,
    this.selectedBillingCycle = BillingCycle.monthly,
    this.pendingDowngrade,
    this.error,
    this.trialStarted = false,
    this.subscribeSuccess = false,
    this.cancelSuccess = false,
    this.reactivateSuccess = false,
    this.upgradeSuccess = false,
    this.downgradeSuccess = false,
  }) : _availablePlans = availablePlans,
       super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingPlans;
  @override
  @JsonKey()
  final bool isProcessing;
  @override
  final UserSubscriptionEntity? currentSubscription;
  final List<SubscriptionPlanEntity> _availablePlans;
  @override
  @JsonKey()
  List<SubscriptionPlanEntity> get availablePlans {
    if (_availablePlans is EqualUnmodifiableListView) return _availablePlans;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availablePlans);
  }

  @override
  final SubscriptionPlanEntity? selectedPlan;
  @override
  @JsonKey()
  final BillingCycle selectedBillingCycle;
  @override
  final SubscriptionPlanEntity? pendingDowngrade;
  @override
  final String? error;
  // Success flags
  @override
  @JsonKey()
  final bool trialStarted;
  @override
  @JsonKey()
  final bool subscribeSuccess;
  @override
  @JsonKey()
  final bool cancelSuccess;
  @override
  @JsonKey()
  final bool reactivateSuccess;
  @override
  @JsonKey()
  final bool upgradeSuccess;
  @override
  @JsonKey()
  final bool downgradeSuccess;

  @override
  String toString() {
    return 'SubscriptionState(isLoading: $isLoading, isLoadingPlans: $isLoadingPlans, isProcessing: $isProcessing, currentSubscription: $currentSubscription, availablePlans: $availablePlans, selectedPlan: $selectedPlan, selectedBillingCycle: $selectedBillingCycle, pendingDowngrade: $pendingDowngrade, error: $error, trialStarted: $trialStarted, subscribeSuccess: $subscribeSuccess, cancelSuccess: $cancelSuccess, reactivateSuccess: $reactivateSuccess, upgradeSuccess: $upgradeSuccess, downgradeSuccess: $downgradeSuccess)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingPlans, isLoadingPlans) ||
                other.isLoadingPlans == isLoadingPlans) &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            (identical(other.currentSubscription, currentSubscription) ||
                other.currentSubscription == currentSubscription) &&
            const DeepCollectionEquality().equals(
              other._availablePlans,
              _availablePlans,
            ) &&
            (identical(other.selectedPlan, selectedPlan) ||
                other.selectedPlan == selectedPlan) &&
            (identical(other.selectedBillingCycle, selectedBillingCycle) ||
                other.selectedBillingCycle == selectedBillingCycle) &&
            (identical(other.pendingDowngrade, pendingDowngrade) ||
                other.pendingDowngrade == pendingDowngrade) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.trialStarted, trialStarted) ||
                other.trialStarted == trialStarted) &&
            (identical(other.subscribeSuccess, subscribeSuccess) ||
                other.subscribeSuccess == subscribeSuccess) &&
            (identical(other.cancelSuccess, cancelSuccess) ||
                other.cancelSuccess == cancelSuccess) &&
            (identical(other.reactivateSuccess, reactivateSuccess) ||
                other.reactivateSuccess == reactivateSuccess) &&
            (identical(other.upgradeSuccess, upgradeSuccess) ||
                other.upgradeSuccess == upgradeSuccess) &&
            (identical(other.downgradeSuccess, downgradeSuccess) ||
                other.downgradeSuccess == downgradeSuccess));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    isLoadingPlans,
    isProcessing,
    currentSubscription,
    const DeepCollectionEquality().hash(_availablePlans),
    selectedPlan,
    selectedBillingCycle,
    pendingDowngrade,
    error,
    trialStarted,
    subscribeSuccess,
    cancelSuccess,
    reactivateSuccess,
    upgradeSuccess,
    downgradeSuccess,
  );

  /// Create a copy of SubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionStateImplCopyWith<_$SubscriptionStateImpl> get copyWith =>
      __$$SubscriptionStateImplCopyWithImpl<_$SubscriptionStateImpl>(
        this,
        _$identity,
      );
}

abstract class _SubscriptionState extends SubscriptionState {
  const factory _SubscriptionState({
    final bool isLoading,
    final bool isLoadingPlans,
    final bool isProcessing,
    final UserSubscriptionEntity? currentSubscription,
    final List<SubscriptionPlanEntity> availablePlans,
    final SubscriptionPlanEntity? selectedPlan,
    final BillingCycle selectedBillingCycle,
    final SubscriptionPlanEntity? pendingDowngrade,
    final String? error,
    final bool trialStarted,
    final bool subscribeSuccess,
    final bool cancelSuccess,
    final bool reactivateSuccess,
    final bool upgradeSuccess,
    final bool downgradeSuccess,
  }) = _$SubscriptionStateImpl;
  const _SubscriptionState._() : super._();

  @override
  bool get isLoading;
  @override
  bool get isLoadingPlans;
  @override
  bool get isProcessing;
  @override
  UserSubscriptionEntity? get currentSubscription;
  @override
  List<SubscriptionPlanEntity> get availablePlans;
  @override
  SubscriptionPlanEntity? get selectedPlan;
  @override
  BillingCycle get selectedBillingCycle;
  @override
  SubscriptionPlanEntity? get pendingDowngrade;
  @override
  String? get error; // Success flags
  @override
  bool get trialStarted;
  @override
  bool get subscribeSuccess;
  @override
  bool get cancelSuccess;
  @override
  bool get reactivateSuccess;
  @override
  bool get upgradeSuccess;
  @override
  bool get downgradeSuccess;

  /// Create a copy of SubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionStateImplCopyWith<_$SubscriptionStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
