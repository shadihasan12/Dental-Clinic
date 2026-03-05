// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'currency_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CurrencyEntity {
  String get id => throw _privateConstructorUsedError;
  String get currencyName => throw _privateConstructorUsedError;
  String get currencyCode => throw _privateConstructorUsedError;

  /// Create a copy of CurrencyEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CurrencyEntityCopyWith<CurrencyEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrencyEntityCopyWith<$Res> {
  factory $CurrencyEntityCopyWith(
    CurrencyEntity value,
    $Res Function(CurrencyEntity) then,
  ) = _$CurrencyEntityCopyWithImpl<$Res, CurrencyEntity>;
  @useResult
  $Res call({String id, String currencyName, String currencyCode});
}

/// @nodoc
class _$CurrencyEntityCopyWithImpl<$Res, $Val extends CurrencyEntity>
    implements $CurrencyEntityCopyWith<$Res> {
  _$CurrencyEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CurrencyEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? currencyName = null,
    Object? currencyCode = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            currencyName: null == currencyName
                ? _value.currencyName
                : currencyName // ignore: cast_nullable_to_non_nullable
                      as String,
            currencyCode: null == currencyCode
                ? _value.currencyCode
                : currencyCode // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CurrencyEntityImplCopyWith<$Res>
    implements $CurrencyEntityCopyWith<$Res> {
  factory _$$CurrencyEntityImplCopyWith(
    _$CurrencyEntityImpl value,
    $Res Function(_$CurrencyEntityImpl) then,
  ) = __$$CurrencyEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String currencyName, String currencyCode});
}

/// @nodoc
class __$$CurrencyEntityImplCopyWithImpl<$Res>
    extends _$CurrencyEntityCopyWithImpl<$Res, _$CurrencyEntityImpl>
    implements _$$CurrencyEntityImplCopyWith<$Res> {
  __$$CurrencyEntityImplCopyWithImpl(
    _$CurrencyEntityImpl _value,
    $Res Function(_$CurrencyEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CurrencyEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? currencyName = null,
    Object? currencyCode = null,
  }) {
    return _then(
      _$CurrencyEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        currencyName: null == currencyName
            ? _value.currencyName
            : currencyName // ignore: cast_nullable_to_non_nullable
                  as String,
        currencyCode: null == currencyCode
            ? _value.currencyCode
            : currencyCode // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$CurrencyEntityImpl implements _CurrencyEntity {
  const _$CurrencyEntityImpl({
    required this.id,
    required this.currencyName,
    required this.currencyCode,
  });

  @override
  final String id;
  @override
  final String currencyName;
  @override
  final String currencyCode;

  @override
  String toString() {
    return 'CurrencyEntity(id: $id, currencyName: $currencyName, currencyCode: $currencyCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CurrencyEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.currencyName, currencyName) ||
                other.currencyName == currencyName) &&
            (identical(other.currencyCode, currencyCode) ||
                other.currencyCode == currencyCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, currencyName, currencyCode);

  /// Create a copy of CurrencyEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CurrencyEntityImplCopyWith<_$CurrencyEntityImpl> get copyWith =>
      __$$CurrencyEntityImplCopyWithImpl<_$CurrencyEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _CurrencyEntity implements CurrencyEntity {
  const factory _CurrencyEntity({
    required final String id,
    required final String currencyName,
    required final String currencyCode,
  }) = _$CurrencyEntityImpl;

  @override
  String get id;
  @override
  String get currencyName;
  @override
  String get currencyCode;

  /// Create a copy of CurrencyEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CurrencyEntityImplCopyWith<_$CurrencyEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
