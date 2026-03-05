// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ExpenseCategoryEntity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Create a copy of ExpenseCategoryEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExpenseCategoryEntityCopyWith<ExpenseCategoryEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseCategoryEntityCopyWith<$Res> {
  factory $ExpenseCategoryEntityCopyWith(
    ExpenseCategoryEntity value,
    $Res Function(ExpenseCategoryEntity) then,
  ) = _$ExpenseCategoryEntityCopyWithImpl<$Res, ExpenseCategoryEntity>;
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class _$ExpenseCategoryEntityCopyWithImpl<
  $Res,
  $Val extends ExpenseCategoryEntity
>
    implements $ExpenseCategoryEntityCopyWith<$Res> {
  _$ExpenseCategoryEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExpenseCategoryEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExpenseCategoryEntityImplCopyWith<$Res>
    implements $ExpenseCategoryEntityCopyWith<$Res> {
  factory _$$ExpenseCategoryEntityImplCopyWith(
    _$ExpenseCategoryEntityImpl value,
    $Res Function(_$ExpenseCategoryEntityImpl) then,
  ) = __$$ExpenseCategoryEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class __$$ExpenseCategoryEntityImplCopyWithImpl<$Res>
    extends
        _$ExpenseCategoryEntityCopyWithImpl<$Res, _$ExpenseCategoryEntityImpl>
    implements _$$ExpenseCategoryEntityImplCopyWith<$Res> {
  __$$ExpenseCategoryEntityImplCopyWithImpl(
    _$ExpenseCategoryEntityImpl _value,
    $Res Function(_$ExpenseCategoryEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExpenseCategoryEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _$ExpenseCategoryEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ExpenseCategoryEntityImpl implements _ExpenseCategoryEntity {
  const _$ExpenseCategoryEntityImpl({required this.id, required this.name});

  @override
  final String id;
  @override
  final String name;

  @override
  String toString() {
    return 'ExpenseCategoryEntity(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpenseCategoryEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of ExpenseCategoryEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpenseCategoryEntityImplCopyWith<_$ExpenseCategoryEntityImpl>
  get copyWith =>
      __$$ExpenseCategoryEntityImplCopyWithImpl<_$ExpenseCategoryEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _ExpenseCategoryEntity implements ExpenseCategoryEntity {
  const factory _ExpenseCategoryEntity({
    required final String id,
    required final String name,
  }) = _$ExpenseCategoryEntityImpl;

  @override
  String get id;
  @override
  String get name;

  /// Create a copy of ExpenseCategoryEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExpenseCategoryEntityImplCopyWith<_$ExpenseCategoryEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AttachmentEntity {
  String get viewUrl => throw _privateConstructorUsedError;
  String get downloadUrl => throw _privateConstructorUsedError;

  /// Create a copy of AttachmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttachmentEntityCopyWith<AttachmentEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttachmentEntityCopyWith<$Res> {
  factory $AttachmentEntityCopyWith(
    AttachmentEntity value,
    $Res Function(AttachmentEntity) then,
  ) = _$AttachmentEntityCopyWithImpl<$Res, AttachmentEntity>;
  @useResult
  $Res call({String viewUrl, String downloadUrl});
}

/// @nodoc
class _$AttachmentEntityCopyWithImpl<$Res, $Val extends AttachmentEntity>
    implements $AttachmentEntityCopyWith<$Res> {
  _$AttachmentEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttachmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? viewUrl = null, Object? downloadUrl = null}) {
    return _then(
      _value.copyWith(
            viewUrl: null == viewUrl
                ? _value.viewUrl
                : viewUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            downloadUrl: null == downloadUrl
                ? _value.downloadUrl
                : downloadUrl // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AttachmentEntityImplCopyWith<$Res>
    implements $AttachmentEntityCopyWith<$Res> {
  factory _$$AttachmentEntityImplCopyWith(
    _$AttachmentEntityImpl value,
    $Res Function(_$AttachmentEntityImpl) then,
  ) = __$$AttachmentEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String viewUrl, String downloadUrl});
}

/// @nodoc
class __$$AttachmentEntityImplCopyWithImpl<$Res>
    extends _$AttachmentEntityCopyWithImpl<$Res, _$AttachmentEntityImpl>
    implements _$$AttachmentEntityImplCopyWith<$Res> {
  __$$AttachmentEntityImplCopyWithImpl(
    _$AttachmentEntityImpl _value,
    $Res Function(_$AttachmentEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttachmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? viewUrl = null, Object? downloadUrl = null}) {
    return _then(
      _$AttachmentEntityImpl(
        viewUrl: null == viewUrl
            ? _value.viewUrl
            : viewUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        downloadUrl: null == downloadUrl
            ? _value.downloadUrl
            : downloadUrl // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AttachmentEntityImpl implements _AttachmentEntity {
  const _$AttachmentEntityImpl({
    required this.viewUrl,
    required this.downloadUrl,
  });

  @override
  final String viewUrl;
  @override
  final String downloadUrl;

  @override
  String toString() {
    return 'AttachmentEntity(viewUrl: $viewUrl, downloadUrl: $downloadUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttachmentEntityImpl &&
            (identical(other.viewUrl, viewUrl) || other.viewUrl == viewUrl) &&
            (identical(other.downloadUrl, downloadUrl) ||
                other.downloadUrl == downloadUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, viewUrl, downloadUrl);

  /// Create a copy of AttachmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttachmentEntityImplCopyWith<_$AttachmentEntityImpl> get copyWith =>
      __$$AttachmentEntityImplCopyWithImpl<_$AttachmentEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _AttachmentEntity implements AttachmentEntity {
  const factory _AttachmentEntity({
    required final String viewUrl,
    required final String downloadUrl,
  }) = _$AttachmentEntityImpl;

  @override
  String get viewUrl;
  @override
  String get downloadUrl;

  /// Create a copy of AttachmentEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttachmentEntityImplCopyWith<_$AttachmentEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ExpenseEntity {
  String get id => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;
  CurrencyEntity get currency => throw _privateConstructorUsedError;
  String get entryDate => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;
  ExpenseCategoryEntity get category => throw _privateConstructorUsedError;
  List<AttachmentEntity> get attachments => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;

  /// Create a copy of ExpenseEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExpenseEntityCopyWith<ExpenseEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseEntityCopyWith<$Res> {
  factory $ExpenseEntityCopyWith(
    ExpenseEntity value,
    $Res Function(ExpenseEntity) then,
  ) = _$ExpenseEntityCopyWithImpl<$Res, ExpenseEntity>;
  @useResult
  $Res call({
    String id,
    String amount,
    CurrencyEntity currency,
    String entryDate,
    String notes,
    ExpenseCategoryEntity category,
    List<AttachmentEntity> attachments,
    String createdAt,
  });

  $CurrencyEntityCopyWith<$Res> get currency;
  $ExpenseCategoryEntityCopyWith<$Res> get category;
}

/// @nodoc
class _$ExpenseEntityCopyWithImpl<$Res, $Val extends ExpenseEntity>
    implements $ExpenseEntityCopyWith<$Res> {
  _$ExpenseEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExpenseEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? currency = null,
    Object? entryDate = null,
    Object? notes = null,
    Object? category = null,
    Object? attachments = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as String,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as CurrencyEntity,
            entryDate: null == entryDate
                ? _value.entryDate
                : entryDate // ignore: cast_nullable_to_non_nullable
                      as String,
            notes: null == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as ExpenseCategoryEntity,
            attachments: null == attachments
                ? _value.attachments
                : attachments // ignore: cast_nullable_to_non_nullable
                      as List<AttachmentEntity>,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }

  /// Create a copy of ExpenseEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CurrencyEntityCopyWith<$Res> get currency {
    return $CurrencyEntityCopyWith<$Res>(_value.currency, (value) {
      return _then(_value.copyWith(currency: value) as $Val);
    });
  }

  /// Create a copy of ExpenseEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExpenseCategoryEntityCopyWith<$Res> get category {
    return $ExpenseCategoryEntityCopyWith<$Res>(_value.category, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExpenseEntityImplCopyWith<$Res>
    implements $ExpenseEntityCopyWith<$Res> {
  factory _$$ExpenseEntityImplCopyWith(
    _$ExpenseEntityImpl value,
    $Res Function(_$ExpenseEntityImpl) then,
  ) = __$$ExpenseEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String amount,
    CurrencyEntity currency,
    String entryDate,
    String notes,
    ExpenseCategoryEntity category,
    List<AttachmentEntity> attachments,
    String createdAt,
  });

  @override
  $CurrencyEntityCopyWith<$Res> get currency;
  @override
  $ExpenseCategoryEntityCopyWith<$Res> get category;
}

/// @nodoc
class __$$ExpenseEntityImplCopyWithImpl<$Res>
    extends _$ExpenseEntityCopyWithImpl<$Res, _$ExpenseEntityImpl>
    implements _$$ExpenseEntityImplCopyWith<$Res> {
  __$$ExpenseEntityImplCopyWithImpl(
    _$ExpenseEntityImpl _value,
    $Res Function(_$ExpenseEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExpenseEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? currency = null,
    Object? entryDate = null,
    Object? notes = null,
    Object? category = null,
    Object? attachments = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$ExpenseEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as String,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as CurrencyEntity,
        entryDate: null == entryDate
            ? _value.entryDate
            : entryDate // ignore: cast_nullable_to_non_nullable
                  as String,
        notes: null == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as ExpenseCategoryEntity,
        attachments: null == attachments
            ? _value._attachments
            : attachments // ignore: cast_nullable_to_non_nullable
                  as List<AttachmentEntity>,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ExpenseEntityImpl implements _ExpenseEntity {
  const _$ExpenseEntityImpl({
    required this.id,
    required this.amount,
    required this.currency,
    required this.entryDate,
    this.notes = '',
    required this.category,
    final List<AttachmentEntity> attachments = const [],
    this.createdAt = '',
  }) : _attachments = attachments;

  @override
  final String id;
  @override
  final String amount;
  @override
  final CurrencyEntity currency;
  @override
  final String entryDate;
  @override
  @JsonKey()
  final String notes;
  @override
  final ExpenseCategoryEntity category;
  final List<AttachmentEntity> _attachments;
  @override
  @JsonKey()
  List<AttachmentEntity> get attachments {
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachments);
  }

  @override
  @JsonKey()
  final String createdAt;

  @override
  String toString() {
    return 'ExpenseEntity(id: $id, amount: $amount, currency: $currency, entryDate: $entryDate, notes: $notes, category: $category, attachments: $attachments, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpenseEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.entryDate, entryDate) ||
                other.entryDate == entryDate) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality().equals(
              other._attachments,
              _attachments,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    amount,
    currency,
    entryDate,
    notes,
    category,
    const DeepCollectionEquality().hash(_attachments),
    createdAt,
  );

  /// Create a copy of ExpenseEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpenseEntityImplCopyWith<_$ExpenseEntityImpl> get copyWith =>
      __$$ExpenseEntityImplCopyWithImpl<_$ExpenseEntityImpl>(this, _$identity);
}

abstract class _ExpenseEntity implements ExpenseEntity {
  const factory _ExpenseEntity({
    required final String id,
    required final String amount,
    required final CurrencyEntity currency,
    required final String entryDate,
    final String notes,
    required final ExpenseCategoryEntity category,
    final List<AttachmentEntity> attachments,
    final String createdAt,
  }) = _$ExpenseEntityImpl;

  @override
  String get id;
  @override
  String get amount;
  @override
  CurrencyEntity get currency;
  @override
  String get entryDate;
  @override
  String get notes;
  @override
  ExpenseCategoryEntity get category;
  @override
  List<AttachmentEntity> get attachments;
  @override
  String get createdAt;

  /// Create a copy of ExpenseEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExpenseEntityImplCopyWith<_$ExpenseEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ExpenseTotalEntity {
  String get currencyId => throw _privateConstructorUsedError;
  String get currencyCode => throw _privateConstructorUsedError;
  String get currencyName => throw _privateConstructorUsedError;
  String get total => throw _privateConstructorUsedError;

  /// Create a copy of ExpenseTotalEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExpenseTotalEntityCopyWith<ExpenseTotalEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseTotalEntityCopyWith<$Res> {
  factory $ExpenseTotalEntityCopyWith(
    ExpenseTotalEntity value,
    $Res Function(ExpenseTotalEntity) then,
  ) = _$ExpenseTotalEntityCopyWithImpl<$Res, ExpenseTotalEntity>;
  @useResult
  $Res call({
    String currencyId,
    String currencyCode,
    String currencyName,
    String total,
  });
}

/// @nodoc
class _$ExpenseTotalEntityCopyWithImpl<$Res, $Val extends ExpenseTotalEntity>
    implements $ExpenseTotalEntityCopyWith<$Res> {
  _$ExpenseTotalEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExpenseTotalEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currencyId = null,
    Object? currencyCode = null,
    Object? currencyName = null,
    Object? total = null,
  }) {
    return _then(
      _value.copyWith(
            currencyId: null == currencyId
                ? _value.currencyId
                : currencyId // ignore: cast_nullable_to_non_nullable
                      as String,
            currencyCode: null == currencyCode
                ? _value.currencyCode
                : currencyCode // ignore: cast_nullable_to_non_nullable
                      as String,
            currencyName: null == currencyName
                ? _value.currencyName
                : currencyName // ignore: cast_nullable_to_non_nullable
                      as String,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExpenseTotalEntityImplCopyWith<$Res>
    implements $ExpenseTotalEntityCopyWith<$Res> {
  factory _$$ExpenseTotalEntityImplCopyWith(
    _$ExpenseTotalEntityImpl value,
    $Res Function(_$ExpenseTotalEntityImpl) then,
  ) = __$$ExpenseTotalEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String currencyId,
    String currencyCode,
    String currencyName,
    String total,
  });
}

/// @nodoc
class __$$ExpenseTotalEntityImplCopyWithImpl<$Res>
    extends _$ExpenseTotalEntityCopyWithImpl<$Res, _$ExpenseTotalEntityImpl>
    implements _$$ExpenseTotalEntityImplCopyWith<$Res> {
  __$$ExpenseTotalEntityImplCopyWithImpl(
    _$ExpenseTotalEntityImpl _value,
    $Res Function(_$ExpenseTotalEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExpenseTotalEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currencyId = null,
    Object? currencyCode = null,
    Object? currencyName = null,
    Object? total = null,
  }) {
    return _then(
      _$ExpenseTotalEntityImpl(
        currencyId: null == currencyId
            ? _value.currencyId
            : currencyId // ignore: cast_nullable_to_non_nullable
                  as String,
        currencyCode: null == currencyCode
            ? _value.currencyCode
            : currencyCode // ignore: cast_nullable_to_non_nullable
                  as String,
        currencyName: null == currencyName
            ? _value.currencyName
            : currencyName // ignore: cast_nullable_to_non_nullable
                  as String,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ExpenseTotalEntityImpl implements _ExpenseTotalEntity {
  const _$ExpenseTotalEntityImpl({
    required this.currencyId,
    required this.currencyCode,
    required this.currencyName,
    required this.total,
  });

  @override
  final String currencyId;
  @override
  final String currencyCode;
  @override
  final String currencyName;
  @override
  final String total;

  @override
  String toString() {
    return 'ExpenseTotalEntity(currencyId: $currencyId, currencyCode: $currencyCode, currencyName: $currencyName, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpenseTotalEntityImpl &&
            (identical(other.currencyId, currencyId) ||
                other.currencyId == currencyId) &&
            (identical(other.currencyCode, currencyCode) ||
                other.currencyCode == currencyCode) &&
            (identical(other.currencyName, currencyName) ||
                other.currencyName == currencyName) &&
            (identical(other.total, total) || other.total == total));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, currencyId, currencyCode, currencyName, total);

  /// Create a copy of ExpenseTotalEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpenseTotalEntityImplCopyWith<_$ExpenseTotalEntityImpl> get copyWith =>
      __$$ExpenseTotalEntityImplCopyWithImpl<_$ExpenseTotalEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _ExpenseTotalEntity implements ExpenseTotalEntity {
  const factory _ExpenseTotalEntity({
    required final String currencyId,
    required final String currencyCode,
    required final String currencyName,
    required final String total,
  }) = _$ExpenseTotalEntityImpl;

  @override
  String get currencyId;
  @override
  String get currencyCode;
  @override
  String get currencyName;
  @override
  String get total;

  /// Create a copy of ExpenseTotalEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExpenseTotalEntityImplCopyWith<_$ExpenseTotalEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ExpenseListResponse {
  List<ExpenseEntity> get expenses => throw _privateConstructorUsedError;
  List<ExpenseTotalEntity> get totals => throw _privateConstructorUsedError;

  /// Create a copy of ExpenseListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExpenseListResponseCopyWith<ExpenseListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseListResponseCopyWith<$Res> {
  factory $ExpenseListResponseCopyWith(
    ExpenseListResponse value,
    $Res Function(ExpenseListResponse) then,
  ) = _$ExpenseListResponseCopyWithImpl<$Res, ExpenseListResponse>;
  @useResult
  $Res call({List<ExpenseEntity> expenses, List<ExpenseTotalEntity> totals});
}

/// @nodoc
class _$ExpenseListResponseCopyWithImpl<$Res, $Val extends ExpenseListResponse>
    implements $ExpenseListResponseCopyWith<$Res> {
  _$ExpenseListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExpenseListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? expenses = null, Object? totals = null}) {
    return _then(
      _value.copyWith(
            expenses: null == expenses
                ? _value.expenses
                : expenses // ignore: cast_nullable_to_non_nullable
                      as List<ExpenseEntity>,
            totals: null == totals
                ? _value.totals
                : totals // ignore: cast_nullable_to_non_nullable
                      as List<ExpenseTotalEntity>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExpenseListResponseImplCopyWith<$Res>
    implements $ExpenseListResponseCopyWith<$Res> {
  factory _$$ExpenseListResponseImplCopyWith(
    _$ExpenseListResponseImpl value,
    $Res Function(_$ExpenseListResponseImpl) then,
  ) = __$$ExpenseListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ExpenseEntity> expenses, List<ExpenseTotalEntity> totals});
}

/// @nodoc
class __$$ExpenseListResponseImplCopyWithImpl<$Res>
    extends _$ExpenseListResponseCopyWithImpl<$Res, _$ExpenseListResponseImpl>
    implements _$$ExpenseListResponseImplCopyWith<$Res> {
  __$$ExpenseListResponseImplCopyWithImpl(
    _$ExpenseListResponseImpl _value,
    $Res Function(_$ExpenseListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExpenseListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? expenses = null, Object? totals = null}) {
    return _then(
      _$ExpenseListResponseImpl(
        expenses: null == expenses
            ? _value._expenses
            : expenses // ignore: cast_nullable_to_non_nullable
                  as List<ExpenseEntity>,
        totals: null == totals
            ? _value._totals
            : totals // ignore: cast_nullable_to_non_nullable
                  as List<ExpenseTotalEntity>,
      ),
    );
  }
}

/// @nodoc

class _$ExpenseListResponseImpl implements _ExpenseListResponse {
  const _$ExpenseListResponseImpl({
    required final List<ExpenseEntity> expenses,
    required final List<ExpenseTotalEntity> totals,
  }) : _expenses = expenses,
       _totals = totals;

  final List<ExpenseEntity> _expenses;
  @override
  List<ExpenseEntity> get expenses {
    if (_expenses is EqualUnmodifiableListView) return _expenses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_expenses);
  }

  final List<ExpenseTotalEntity> _totals;
  @override
  List<ExpenseTotalEntity> get totals {
    if (_totals is EqualUnmodifiableListView) return _totals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_totals);
  }

  @override
  String toString() {
    return 'ExpenseListResponse(expenses: $expenses, totals: $totals)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpenseListResponseImpl &&
            const DeepCollectionEquality().equals(other._expenses, _expenses) &&
            const DeepCollectionEquality().equals(other._totals, _totals));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_expenses),
    const DeepCollectionEquality().hash(_totals),
  );

  /// Create a copy of ExpenseListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpenseListResponseImplCopyWith<_$ExpenseListResponseImpl> get copyWith =>
      __$$ExpenseListResponseImplCopyWithImpl<_$ExpenseListResponseImpl>(
        this,
        _$identity,
      );
}

abstract class _ExpenseListResponse implements ExpenseListResponse {
  const factory _ExpenseListResponse({
    required final List<ExpenseEntity> expenses,
    required final List<ExpenseTotalEntity> totals,
  }) = _$ExpenseListResponseImpl;

  @override
  List<ExpenseEntity> get expenses;
  @override
  List<ExpenseTotalEntity> get totals;

  /// Create a copy of ExpenseListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExpenseListResponseImplCopyWith<_$ExpenseListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
