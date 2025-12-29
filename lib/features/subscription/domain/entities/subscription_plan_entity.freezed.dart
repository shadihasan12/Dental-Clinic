// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_plan_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SubscriptionPlanEntity {
  String get id => throw _privateConstructorUsedError;
  PlanTier get tier => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get monthlyPrice => throw _privateConstructorUsedError;
  double get yearlyPrice => throw _privateConstructorUsedError; // With discount
  int get maxDentists => throw _privateConstructorUsedError;
  int get maxAssistants => throw _privateConstructorUsedError;
  int get maxBranches => throw _privateConstructorUsedError;
  List<String> get features => throw _privateConstructorUsedError;
  List<String> get limitations => throw _privateConstructorUsedError;
  bool get isPopular => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  /// Create a copy of SubscriptionPlanEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscriptionPlanEntityCopyWith<SubscriptionPlanEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionPlanEntityCopyWith<$Res> {
  factory $SubscriptionPlanEntityCopyWith(
    SubscriptionPlanEntity value,
    $Res Function(SubscriptionPlanEntity) then,
  ) = _$SubscriptionPlanEntityCopyWithImpl<$Res, SubscriptionPlanEntity>;
  @useResult
  $Res call({
    String id,
    PlanTier tier,
    String name,
    String description,
    double monthlyPrice,
    double yearlyPrice,
    int maxDentists,
    int maxAssistants,
    int maxBranches,
    List<String> features,
    List<String> limitations,
    bool isPopular,
    bool isActive,
  });
}

/// @nodoc
class _$SubscriptionPlanEntityCopyWithImpl<
  $Res,
  $Val extends SubscriptionPlanEntity
>
    implements $SubscriptionPlanEntityCopyWith<$Res> {
  _$SubscriptionPlanEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscriptionPlanEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tier = null,
    Object? name = null,
    Object? description = null,
    Object? monthlyPrice = null,
    Object? yearlyPrice = null,
    Object? maxDentists = null,
    Object? maxAssistants = null,
    Object? maxBranches = null,
    Object? features = null,
    Object? limitations = null,
    Object? isPopular = null,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            tier: null == tier
                ? _value.tier
                : tier // ignore: cast_nullable_to_non_nullable
                      as PlanTier,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            monthlyPrice: null == monthlyPrice
                ? _value.monthlyPrice
                : monthlyPrice // ignore: cast_nullable_to_non_nullable
                      as double,
            yearlyPrice: null == yearlyPrice
                ? _value.yearlyPrice
                : yearlyPrice // ignore: cast_nullable_to_non_nullable
                      as double,
            maxDentists: null == maxDentists
                ? _value.maxDentists
                : maxDentists // ignore: cast_nullable_to_non_nullable
                      as int,
            maxAssistants: null == maxAssistants
                ? _value.maxAssistants
                : maxAssistants // ignore: cast_nullable_to_non_nullable
                      as int,
            maxBranches: null == maxBranches
                ? _value.maxBranches
                : maxBranches // ignore: cast_nullable_to_non_nullable
                      as int,
            features: null == features
                ? _value.features
                : features // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            limitations: null == limitations
                ? _value.limitations
                : limitations // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isPopular: null == isPopular
                ? _value.isPopular
                : isPopular // ignore: cast_nullable_to_non_nullable
                      as bool,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SubscriptionPlanEntityImplCopyWith<$Res>
    implements $SubscriptionPlanEntityCopyWith<$Res> {
  factory _$$SubscriptionPlanEntityImplCopyWith(
    _$SubscriptionPlanEntityImpl value,
    $Res Function(_$SubscriptionPlanEntityImpl) then,
  ) = __$$SubscriptionPlanEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    PlanTier tier,
    String name,
    String description,
    double monthlyPrice,
    double yearlyPrice,
    int maxDentists,
    int maxAssistants,
    int maxBranches,
    List<String> features,
    List<String> limitations,
    bool isPopular,
    bool isActive,
  });
}

/// @nodoc
class __$$SubscriptionPlanEntityImplCopyWithImpl<$Res>
    extends
        _$SubscriptionPlanEntityCopyWithImpl<$Res, _$SubscriptionPlanEntityImpl>
    implements _$$SubscriptionPlanEntityImplCopyWith<$Res> {
  __$$SubscriptionPlanEntityImplCopyWithImpl(
    _$SubscriptionPlanEntityImpl _value,
    $Res Function(_$SubscriptionPlanEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubscriptionPlanEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tier = null,
    Object? name = null,
    Object? description = null,
    Object? monthlyPrice = null,
    Object? yearlyPrice = null,
    Object? maxDentists = null,
    Object? maxAssistants = null,
    Object? maxBranches = null,
    Object? features = null,
    Object? limitations = null,
    Object? isPopular = null,
    Object? isActive = null,
  }) {
    return _then(
      _$SubscriptionPlanEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        tier: null == tier
            ? _value.tier
            : tier // ignore: cast_nullable_to_non_nullable
                  as PlanTier,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        monthlyPrice: null == monthlyPrice
            ? _value.monthlyPrice
            : monthlyPrice // ignore: cast_nullable_to_non_nullable
                  as double,
        yearlyPrice: null == yearlyPrice
            ? _value.yearlyPrice
            : yearlyPrice // ignore: cast_nullable_to_non_nullable
                  as double,
        maxDentists: null == maxDentists
            ? _value.maxDentists
            : maxDentists // ignore: cast_nullable_to_non_nullable
                  as int,
        maxAssistants: null == maxAssistants
            ? _value.maxAssistants
            : maxAssistants // ignore: cast_nullable_to_non_nullable
                  as int,
        maxBranches: null == maxBranches
            ? _value.maxBranches
            : maxBranches // ignore: cast_nullable_to_non_nullable
                  as int,
        features: null == features
            ? _value._features
            : features // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        limitations: null == limitations
            ? _value._limitations
            : limitations // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isPopular: null == isPopular
            ? _value.isPopular
            : isPopular // ignore: cast_nullable_to_non_nullable
                  as bool,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$SubscriptionPlanEntityImpl extends _SubscriptionPlanEntity {
  const _$SubscriptionPlanEntityImpl({
    required this.id,
    required this.tier,
    required this.name,
    required this.description,
    required this.monthlyPrice,
    required this.yearlyPrice,
    required this.maxDentists,
    required this.maxAssistants,
    required this.maxBranches,
    required final List<String> features,
    required final List<String> limitations,
    this.isPopular = false,
    this.isActive = true,
  }) : _features = features,
       _limitations = limitations,
       super._();

  @override
  final String id;
  @override
  final PlanTier tier;
  @override
  final String name;
  @override
  final String description;
  @override
  final double monthlyPrice;
  @override
  final double yearlyPrice;
  // With discount
  @override
  final int maxDentists;
  @override
  final int maxAssistants;
  @override
  final int maxBranches;
  final List<String> _features;
  @override
  List<String> get features {
    if (_features is EqualUnmodifiableListView) return _features;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_features);
  }

  final List<String> _limitations;
  @override
  List<String> get limitations {
    if (_limitations is EqualUnmodifiableListView) return _limitations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_limitations);
  }

  @override
  @JsonKey()
  final bool isPopular;
  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'SubscriptionPlanEntity(id: $id, tier: $tier, name: $name, description: $description, monthlyPrice: $monthlyPrice, yearlyPrice: $yearlyPrice, maxDentists: $maxDentists, maxAssistants: $maxAssistants, maxBranches: $maxBranches, features: $features, limitations: $limitations, isPopular: $isPopular, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionPlanEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tier, tier) || other.tier == tier) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.monthlyPrice, monthlyPrice) ||
                other.monthlyPrice == monthlyPrice) &&
            (identical(other.yearlyPrice, yearlyPrice) ||
                other.yearlyPrice == yearlyPrice) &&
            (identical(other.maxDentists, maxDentists) ||
                other.maxDentists == maxDentists) &&
            (identical(other.maxAssistants, maxAssistants) ||
                other.maxAssistants == maxAssistants) &&
            (identical(other.maxBranches, maxBranches) ||
                other.maxBranches == maxBranches) &&
            const DeepCollectionEquality().equals(other._features, _features) &&
            const DeepCollectionEquality().equals(
              other._limitations,
              _limitations,
            ) &&
            (identical(other.isPopular, isPopular) ||
                other.isPopular == isPopular) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    tier,
    name,
    description,
    monthlyPrice,
    yearlyPrice,
    maxDentists,
    maxAssistants,
    maxBranches,
    const DeepCollectionEquality().hash(_features),
    const DeepCollectionEquality().hash(_limitations),
    isPopular,
    isActive,
  );

  /// Create a copy of SubscriptionPlanEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionPlanEntityImplCopyWith<_$SubscriptionPlanEntityImpl>
  get copyWith =>
      __$$SubscriptionPlanEntityImplCopyWithImpl<_$SubscriptionPlanEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _SubscriptionPlanEntity extends SubscriptionPlanEntity {
  const factory _SubscriptionPlanEntity({
    required final String id,
    required final PlanTier tier,
    required final String name,
    required final String description,
    required final double monthlyPrice,
    required final double yearlyPrice,
    required final int maxDentists,
    required final int maxAssistants,
    required final int maxBranches,
    required final List<String> features,
    required final List<String> limitations,
    final bool isPopular,
    final bool isActive,
  }) = _$SubscriptionPlanEntityImpl;
  const _SubscriptionPlanEntity._() : super._();

  @override
  String get id;
  @override
  PlanTier get tier;
  @override
  String get name;
  @override
  String get description;
  @override
  double get monthlyPrice;
  @override
  double get yearlyPrice; // With discount
  @override
  int get maxDentists;
  @override
  int get maxAssistants;
  @override
  int get maxBranches;
  @override
  List<String> get features;
  @override
  List<String> get limitations;
  @override
  bool get isPopular;
  @override
  bool get isActive;

  /// Create a copy of SubscriptionPlanEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionPlanEntityImplCopyWith<_$SubscriptionPlanEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}
