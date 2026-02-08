// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PriceEntity {
  double get amount => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String get display => throw _privateConstructorUsedError;

  /// Create a copy of PriceEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PriceEntityCopyWith<PriceEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriceEntityCopyWith<$Res> {
  factory $PriceEntityCopyWith(
    PriceEntity value,
    $Res Function(PriceEntity) then,
  ) = _$PriceEntityCopyWithImpl<$Res, PriceEntity>;
  @useResult
  $Res call({double amount, String currency, String display});
}

/// @nodoc
class _$PriceEntityCopyWithImpl<$Res, $Val extends PriceEntity>
    implements $PriceEntityCopyWith<$Res> {
  _$PriceEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PriceEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? currency = null,
    Object? display = null,
  }) {
    return _then(
      _value.copyWith(
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String,
            display: null == display
                ? _value.display
                : display // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PriceEntityImplCopyWith<$Res>
    implements $PriceEntityCopyWith<$Res> {
  factory _$$PriceEntityImplCopyWith(
    _$PriceEntityImpl value,
    $Res Function(_$PriceEntityImpl) then,
  ) = __$$PriceEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double amount, String currency, String display});
}

/// @nodoc
class __$$PriceEntityImplCopyWithImpl<$Res>
    extends _$PriceEntityCopyWithImpl<$Res, _$PriceEntityImpl>
    implements _$$PriceEntityImplCopyWith<$Res> {
  __$$PriceEntityImplCopyWithImpl(
    _$PriceEntityImpl _value,
    $Res Function(_$PriceEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PriceEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? currency = null,
    Object? display = null,
  }) {
    return _then(
      _$PriceEntityImpl(
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String,
        display: null == display
            ? _value.display
            : display // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$PriceEntityImpl extends _PriceEntity {
  const _$PriceEntityImpl({
    required this.amount,
    required this.currency,
    required this.display,
  }) : super._();

  @override
  final double amount;
  @override
  final String currency;
  @override
  final String display;

  @override
  String toString() {
    return 'PriceEntity(amount: $amount, currency: $currency, display: $display)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PriceEntityImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.display, display) || other.display == display));
  }

  @override
  int get hashCode => Object.hash(runtimeType, amount, currency, display);

  /// Create a copy of PriceEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PriceEntityImplCopyWith<_$PriceEntityImpl> get copyWith =>
      __$$PriceEntityImplCopyWithImpl<_$PriceEntityImpl>(this, _$identity);
}

abstract class _PriceEntity extends PriceEntity {
  const factory _PriceEntity({
    required final double amount,
    required final String currency,
    required final String display,
  }) = _$PriceEntityImpl;
  const _PriceEntity._() : super._();

  @override
  double get amount;
  @override
  String get currency;
  @override
  String get display;

  /// Create a copy of PriceEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PriceEntityImplCopyWith<_$PriceEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PlanEntity {
  String get id => throw _privateConstructorUsedError;
  String get versionId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<PriceEntity> get priceMonthly => throw _privateConstructorUsedError;
  List<PriceEntity> get priceYearly => throw _privateConstructorUsedError;
  bool get supportsTrial => throw _privateConstructorUsedError;
  int get trialPeriodDays => throw _privateConstructorUsedError;
  int get gracePeriodDays => throw _privateConstructorUsedError;
  String get clinicType => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;

  /// Create a copy of PlanEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlanEntityCopyWith<PlanEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlanEntityCopyWith<$Res> {
  factory $PlanEntityCopyWith(
    PlanEntity value,
    $Res Function(PlanEntity) then,
  ) = _$PlanEntityCopyWithImpl<$Res, PlanEntity>;
  @useResult
  $Res call({
    String id,
    String versionId,
    String name,
    String description,
    List<PriceEntity> priceMonthly,
    List<PriceEntity> priceYearly,
    bool supportsTrial,
    int trialPeriodDays,
    int gracePeriodDays,
    String clinicType,
    String type,
    int sortOrder,
  });
}

/// @nodoc
class _$PlanEntityCopyWithImpl<$Res, $Val extends PlanEntity>
    implements $PlanEntityCopyWith<$Res> {
  _$PlanEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlanEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? versionId = null,
    Object? name = null,
    Object? description = null,
    Object? priceMonthly = null,
    Object? priceYearly = null,
    Object? supportsTrial = null,
    Object? trialPeriodDays = null,
    Object? gracePeriodDays = null,
    Object? clinicType = null,
    Object? type = null,
    Object? sortOrder = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            versionId: null == versionId
                ? _value.versionId
                : versionId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            priceMonthly: null == priceMonthly
                ? _value.priceMonthly
                : priceMonthly // ignore: cast_nullable_to_non_nullable
                      as List<PriceEntity>,
            priceYearly: null == priceYearly
                ? _value.priceYearly
                : priceYearly // ignore: cast_nullable_to_non_nullable
                      as List<PriceEntity>,
            supportsTrial: null == supportsTrial
                ? _value.supportsTrial
                : supportsTrial // ignore: cast_nullable_to_non_nullable
                      as bool,
            trialPeriodDays: null == trialPeriodDays
                ? _value.trialPeriodDays
                : trialPeriodDays // ignore: cast_nullable_to_non_nullable
                      as int,
            gracePeriodDays: null == gracePeriodDays
                ? _value.gracePeriodDays
                : gracePeriodDays // ignore: cast_nullable_to_non_nullable
                      as int,
            clinicType: null == clinicType
                ? _value.clinicType
                : clinicType // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PlanEntityImplCopyWith<$Res>
    implements $PlanEntityCopyWith<$Res> {
  factory _$$PlanEntityImplCopyWith(
    _$PlanEntityImpl value,
    $Res Function(_$PlanEntityImpl) then,
  ) = __$$PlanEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String versionId,
    String name,
    String description,
    List<PriceEntity> priceMonthly,
    List<PriceEntity> priceYearly,
    bool supportsTrial,
    int trialPeriodDays,
    int gracePeriodDays,
    String clinicType,
    String type,
    int sortOrder,
  });
}

/// @nodoc
class __$$PlanEntityImplCopyWithImpl<$Res>
    extends _$PlanEntityCopyWithImpl<$Res, _$PlanEntityImpl>
    implements _$$PlanEntityImplCopyWith<$Res> {
  __$$PlanEntityImplCopyWithImpl(
    _$PlanEntityImpl _value,
    $Res Function(_$PlanEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlanEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? versionId = null,
    Object? name = null,
    Object? description = null,
    Object? priceMonthly = null,
    Object? priceYearly = null,
    Object? supportsTrial = null,
    Object? trialPeriodDays = null,
    Object? gracePeriodDays = null,
    Object? clinicType = null,
    Object? type = null,
    Object? sortOrder = null,
  }) {
    return _then(
      _$PlanEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        versionId: null == versionId
            ? _value.versionId
            : versionId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        priceMonthly: null == priceMonthly
            ? _value._priceMonthly
            : priceMonthly // ignore: cast_nullable_to_non_nullable
                  as List<PriceEntity>,
        priceYearly: null == priceYearly
            ? _value._priceYearly
            : priceYearly // ignore: cast_nullable_to_non_nullable
                  as List<PriceEntity>,
        supportsTrial: null == supportsTrial
            ? _value.supportsTrial
            : supportsTrial // ignore: cast_nullable_to_non_nullable
                  as bool,
        trialPeriodDays: null == trialPeriodDays
            ? _value.trialPeriodDays
            : trialPeriodDays // ignore: cast_nullable_to_non_nullable
                  as int,
        gracePeriodDays: null == gracePeriodDays
            ? _value.gracePeriodDays
            : gracePeriodDays // ignore: cast_nullable_to_non_nullable
                  as int,
        clinicType: null == clinicType
            ? _value.clinicType
            : clinicType // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$PlanEntityImpl extends _PlanEntity {
  const _$PlanEntityImpl({
    required this.id,
    required this.versionId,
    required this.name,
    required this.description,
    required final List<PriceEntity> priceMonthly,
    required final List<PriceEntity> priceYearly,
    required this.supportsTrial,
    required this.trialPeriodDays,
    required this.gracePeriodDays,
    required this.clinicType,
    required this.type,
    required this.sortOrder,
  }) : _priceMonthly = priceMonthly,
       _priceYearly = priceYearly,
       super._();

  @override
  final String id;
  @override
  final String versionId;
  @override
  final String name;
  @override
  final String description;
  final List<PriceEntity> _priceMonthly;
  @override
  List<PriceEntity> get priceMonthly {
    if (_priceMonthly is EqualUnmodifiableListView) return _priceMonthly;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_priceMonthly);
  }

  final List<PriceEntity> _priceYearly;
  @override
  List<PriceEntity> get priceYearly {
    if (_priceYearly is EqualUnmodifiableListView) return _priceYearly;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_priceYearly);
  }

  @override
  final bool supportsTrial;
  @override
  final int trialPeriodDays;
  @override
  final int gracePeriodDays;
  @override
  final String clinicType;
  @override
  final String type;
  @override
  final int sortOrder;

  @override
  String toString() {
    return 'PlanEntity(id: $id, versionId: $versionId, name: $name, description: $description, priceMonthly: $priceMonthly, priceYearly: $priceYearly, supportsTrial: $supportsTrial, trialPeriodDays: $trialPeriodDays, gracePeriodDays: $gracePeriodDays, clinicType: $clinicType, type: $type, sortOrder: $sortOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlanEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.versionId, versionId) ||
                other.versionId == versionId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(
              other._priceMonthly,
              _priceMonthly,
            ) &&
            const DeepCollectionEquality().equals(
              other._priceYearly,
              _priceYearly,
            ) &&
            (identical(other.supportsTrial, supportsTrial) ||
                other.supportsTrial == supportsTrial) &&
            (identical(other.trialPeriodDays, trialPeriodDays) ||
                other.trialPeriodDays == trialPeriodDays) &&
            (identical(other.gracePeriodDays, gracePeriodDays) ||
                other.gracePeriodDays == gracePeriodDays) &&
            (identical(other.clinicType, clinicType) ||
                other.clinicType == clinicType) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    versionId,
    name,
    description,
    const DeepCollectionEquality().hash(_priceMonthly),
    const DeepCollectionEquality().hash(_priceYearly),
    supportsTrial,
    trialPeriodDays,
    gracePeriodDays,
    clinicType,
    type,
    sortOrder,
  );

  /// Create a copy of PlanEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlanEntityImplCopyWith<_$PlanEntityImpl> get copyWith =>
      __$$PlanEntityImplCopyWithImpl<_$PlanEntityImpl>(this, _$identity);
}

abstract class _PlanEntity extends PlanEntity {
  const factory _PlanEntity({
    required final String id,
    required final String versionId,
    required final String name,
    required final String description,
    required final List<PriceEntity> priceMonthly,
    required final List<PriceEntity> priceYearly,
    required final bool supportsTrial,
    required final int trialPeriodDays,
    required final int gracePeriodDays,
    required final String clinicType,
    required final String type,
    required final int sortOrder,
  }) = _$PlanEntityImpl;
  const _PlanEntity._() : super._();

  @override
  String get id;
  @override
  String get versionId;
  @override
  String get name;
  @override
  String get description;
  @override
  List<PriceEntity> get priceMonthly;
  @override
  List<PriceEntity> get priceYearly;
  @override
  bool get supportsTrial;
  @override
  int get trialPeriodDays;
  @override
  int get gracePeriodDays;
  @override
  String get clinicType;
  @override
  String get type;
  @override
  int get sortOrder;

  /// Create a copy of PlanEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlanEntityImplCopyWith<_$PlanEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
