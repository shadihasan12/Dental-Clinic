// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clinic_permissions_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ClinicPermissionsEntity {
  Set<String> get featureSlugs => throw _privateConstructorUsedError;

  /// Create a copy of ClinicPermissionsEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClinicPermissionsEntityCopyWith<ClinicPermissionsEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClinicPermissionsEntityCopyWith<$Res> {
  factory $ClinicPermissionsEntityCopyWith(
    ClinicPermissionsEntity value,
    $Res Function(ClinicPermissionsEntity) then,
  ) = _$ClinicPermissionsEntityCopyWithImpl<$Res, ClinicPermissionsEntity>;
  @useResult
  $Res call({Set<String> featureSlugs});
}

/// @nodoc
class _$ClinicPermissionsEntityCopyWithImpl<
  $Res,
  $Val extends ClinicPermissionsEntity
>
    implements $ClinicPermissionsEntityCopyWith<$Res> {
  _$ClinicPermissionsEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClinicPermissionsEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? featureSlugs = null}) {
    return _then(
      _value.copyWith(
            featureSlugs: null == featureSlugs
                ? _value.featureSlugs
                : featureSlugs // ignore: cast_nullable_to_non_nullable
                      as Set<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClinicPermissionsEntityImplCopyWith<$Res>
    implements $ClinicPermissionsEntityCopyWith<$Res> {
  factory _$$ClinicPermissionsEntityImplCopyWith(
    _$ClinicPermissionsEntityImpl value,
    $Res Function(_$ClinicPermissionsEntityImpl) then,
  ) = __$$ClinicPermissionsEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Set<String> featureSlugs});
}

/// @nodoc
class __$$ClinicPermissionsEntityImplCopyWithImpl<$Res>
    extends
        _$ClinicPermissionsEntityCopyWithImpl<
          $Res,
          _$ClinicPermissionsEntityImpl
        >
    implements _$$ClinicPermissionsEntityImplCopyWith<$Res> {
  __$$ClinicPermissionsEntityImplCopyWithImpl(
    _$ClinicPermissionsEntityImpl _value,
    $Res Function(_$ClinicPermissionsEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClinicPermissionsEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? featureSlugs = null}) {
    return _then(
      _$ClinicPermissionsEntityImpl(
        featureSlugs: null == featureSlugs
            ? _value._featureSlugs
            : featureSlugs // ignore: cast_nullable_to_non_nullable
                  as Set<String>,
      ),
    );
  }
}

/// @nodoc

class _$ClinicPermissionsEntityImpl extends _ClinicPermissionsEntity {
  const _$ClinicPermissionsEntityImpl({required final Set<String> featureSlugs})
    : _featureSlugs = featureSlugs,
      super._();

  final Set<String> _featureSlugs;
  @override
  Set<String> get featureSlugs {
    if (_featureSlugs is EqualUnmodifiableSetView) return _featureSlugs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_featureSlugs);
  }

  @override
  String toString() {
    return 'ClinicPermissionsEntity(featureSlugs: $featureSlugs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClinicPermissionsEntityImpl &&
            const DeepCollectionEquality().equals(
              other._featureSlugs,
              _featureSlugs,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_featureSlugs),
  );

  /// Create a copy of ClinicPermissionsEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClinicPermissionsEntityImplCopyWith<_$ClinicPermissionsEntityImpl>
  get copyWith =>
      __$$ClinicPermissionsEntityImplCopyWithImpl<
        _$ClinicPermissionsEntityImpl
      >(this, _$identity);
}

abstract class _ClinicPermissionsEntity extends ClinicPermissionsEntity {
  const factory _ClinicPermissionsEntity({
    required final Set<String> featureSlugs,
  }) = _$ClinicPermissionsEntityImpl;
  const _ClinicPermissionsEntity._() : super._();

  @override
  Set<String> get featureSlugs;

  /// Create a copy of ClinicPermissionsEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClinicPermissionsEntityImplCopyWith<_$ClinicPermissionsEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}
