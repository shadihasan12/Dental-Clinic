// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patient_details_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PatientDetailsEvent {
  String get patientId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String patientId) loadPatientDetails,
    required TResult Function(String patientId, String caseId, String? title)
    markCaseAsFinished,
    required TResult Function(
      String patientId,
      String caseId,
      double amount,
      String currencyId,
      String caseCurrencyId,
      double amountInCaseCurrency,
      double exchangeRate,
      String? notes,
    )
    addPayment,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String patientId)? loadPatientDetails,
    TResult? Function(String patientId, String caseId, String? title)?
    markCaseAsFinished,
    TResult? Function(
      String patientId,
      String caseId,
      double amount,
      String currencyId,
      String caseCurrencyId,
      double amountInCaseCurrency,
      double exchangeRate,
      String? notes,
    )?
    addPayment,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String patientId)? loadPatientDetails,
    TResult Function(String patientId, String caseId, String? title)?
    markCaseAsFinished,
    TResult Function(
      String patientId,
      String caseId,
      double amount,
      String currencyId,
      String caseCurrencyId,
      double amountInCaseCurrency,
      double exchangeRate,
      String? notes,
    )?
    addPayment,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadPatientDetails value) loadPatientDetails,
    required TResult Function(_MarkCaseAsFinished value) markCaseAsFinished,
    required TResult Function(_AddPayment value) addPayment,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadPatientDetails value)? loadPatientDetails,
    TResult? Function(_MarkCaseAsFinished value)? markCaseAsFinished,
    TResult? Function(_AddPayment value)? addPayment,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadPatientDetails value)? loadPatientDetails,
    TResult Function(_MarkCaseAsFinished value)? markCaseAsFinished,
    TResult Function(_AddPayment value)? addPayment,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of PatientDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PatientDetailsEventCopyWith<PatientDetailsEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatientDetailsEventCopyWith<$Res> {
  factory $PatientDetailsEventCopyWith(
    PatientDetailsEvent value,
    $Res Function(PatientDetailsEvent) then,
  ) = _$PatientDetailsEventCopyWithImpl<$Res, PatientDetailsEvent>;
  @useResult
  $Res call({String patientId});
}

/// @nodoc
class _$PatientDetailsEventCopyWithImpl<$Res, $Val extends PatientDetailsEvent>
    implements $PatientDetailsEventCopyWith<$Res> {
  _$PatientDetailsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PatientDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? patientId = null}) {
    return _then(
      _value.copyWith(
            patientId: null == patientId
                ? _value.patientId
                : patientId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LoadPatientDetailsImplCopyWith<$Res>
    implements $PatientDetailsEventCopyWith<$Res> {
  factory _$$LoadPatientDetailsImplCopyWith(
    _$LoadPatientDetailsImpl value,
    $Res Function(_$LoadPatientDetailsImpl) then,
  ) = __$$LoadPatientDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String patientId});
}

/// @nodoc
class __$$LoadPatientDetailsImplCopyWithImpl<$Res>
    extends _$PatientDetailsEventCopyWithImpl<$Res, _$LoadPatientDetailsImpl>
    implements _$$LoadPatientDetailsImplCopyWith<$Res> {
  __$$LoadPatientDetailsImplCopyWithImpl(
    _$LoadPatientDetailsImpl _value,
    $Res Function(_$LoadPatientDetailsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PatientDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? patientId = null}) {
    return _then(
      _$LoadPatientDetailsImpl(
        null == patientId
            ? _value.patientId
            : patientId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LoadPatientDetailsImpl implements _LoadPatientDetails {
  const _$LoadPatientDetailsImpl(this.patientId);

  @override
  final String patientId;

  @override
  String toString() {
    return 'PatientDetailsEvent.loadPatientDetails(patientId: $patientId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadPatientDetailsImpl &&
            (identical(other.patientId, patientId) ||
                other.patientId == patientId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, patientId);

  /// Create a copy of PatientDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadPatientDetailsImplCopyWith<_$LoadPatientDetailsImpl> get copyWith =>
      __$$LoadPatientDetailsImplCopyWithImpl<_$LoadPatientDetailsImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String patientId) loadPatientDetails,
    required TResult Function(String patientId, String caseId, String? title)
    markCaseAsFinished,
    required TResult Function(
      String patientId,
      String caseId,
      double amount,
      String currencyId,
      String caseCurrencyId,
      double amountInCaseCurrency,
      double exchangeRate,
      String? notes,
    )
    addPayment,
  }) {
    return loadPatientDetails(patientId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String patientId)? loadPatientDetails,
    TResult? Function(String patientId, String caseId, String? title)?
    markCaseAsFinished,
    TResult? Function(
      String patientId,
      String caseId,
      double amount,
      String currencyId,
      String caseCurrencyId,
      double amountInCaseCurrency,
      double exchangeRate,
      String? notes,
    )?
    addPayment,
  }) {
    return loadPatientDetails?.call(patientId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String patientId)? loadPatientDetails,
    TResult Function(String patientId, String caseId, String? title)?
    markCaseAsFinished,
    TResult Function(
      String patientId,
      String caseId,
      double amount,
      String currencyId,
      String caseCurrencyId,
      double amountInCaseCurrency,
      double exchangeRate,
      String? notes,
    )?
    addPayment,
    required TResult orElse(),
  }) {
    if (loadPatientDetails != null) {
      return loadPatientDetails(patientId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadPatientDetails value) loadPatientDetails,
    required TResult Function(_MarkCaseAsFinished value) markCaseAsFinished,
    required TResult Function(_AddPayment value) addPayment,
  }) {
    return loadPatientDetails(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadPatientDetails value)? loadPatientDetails,
    TResult? Function(_MarkCaseAsFinished value)? markCaseAsFinished,
    TResult? Function(_AddPayment value)? addPayment,
  }) {
    return loadPatientDetails?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadPatientDetails value)? loadPatientDetails,
    TResult Function(_MarkCaseAsFinished value)? markCaseAsFinished,
    TResult Function(_AddPayment value)? addPayment,
    required TResult orElse(),
  }) {
    if (loadPatientDetails != null) {
      return loadPatientDetails(this);
    }
    return orElse();
  }
}

abstract class _LoadPatientDetails implements PatientDetailsEvent {
  const factory _LoadPatientDetails(final String patientId) =
      _$LoadPatientDetailsImpl;

  @override
  String get patientId;

  /// Create a copy of PatientDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadPatientDetailsImplCopyWith<_$LoadPatientDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MarkCaseAsFinishedImplCopyWith<$Res>
    implements $PatientDetailsEventCopyWith<$Res> {
  factory _$$MarkCaseAsFinishedImplCopyWith(
    _$MarkCaseAsFinishedImpl value,
    $Res Function(_$MarkCaseAsFinishedImpl) then,
  ) = __$$MarkCaseAsFinishedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String patientId, String caseId, String? title});
}

/// @nodoc
class __$$MarkCaseAsFinishedImplCopyWithImpl<$Res>
    extends _$PatientDetailsEventCopyWithImpl<$Res, _$MarkCaseAsFinishedImpl>
    implements _$$MarkCaseAsFinishedImplCopyWith<$Res> {
  __$$MarkCaseAsFinishedImplCopyWithImpl(
    _$MarkCaseAsFinishedImpl _value,
    $Res Function(_$MarkCaseAsFinishedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PatientDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? patientId = null,
    Object? caseId = null,
    Object? title = freezed,
  }) {
    return _then(
      _$MarkCaseAsFinishedImpl(
        patientId: null == patientId
            ? _value.patientId
            : patientId // ignore: cast_nullable_to_non_nullable
                  as String,
        caseId: null == caseId
            ? _value.caseId
            : caseId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$MarkCaseAsFinishedImpl implements _MarkCaseAsFinished {
  const _$MarkCaseAsFinishedImpl({
    required this.patientId,
    required this.caseId,
    this.title,
  });

  @override
  final String patientId;
  @override
  final String caseId;
  @override
  final String? title;

  @override
  String toString() {
    return 'PatientDetailsEvent.markCaseAsFinished(patientId: $patientId, caseId: $caseId, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarkCaseAsFinishedImpl &&
            (identical(other.patientId, patientId) ||
                other.patientId == patientId) &&
            (identical(other.caseId, caseId) || other.caseId == caseId) &&
            (identical(other.title, title) || other.title == title));
  }

  @override
  int get hashCode => Object.hash(runtimeType, patientId, caseId, title);

  /// Create a copy of PatientDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarkCaseAsFinishedImplCopyWith<_$MarkCaseAsFinishedImpl> get copyWith =>
      __$$MarkCaseAsFinishedImplCopyWithImpl<_$MarkCaseAsFinishedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String patientId) loadPatientDetails,
    required TResult Function(String patientId, String caseId, String? title)
    markCaseAsFinished,
    required TResult Function(
      String patientId,
      String caseId,
      double amount,
      String currencyId,
      String caseCurrencyId,
      double amountInCaseCurrency,
      double exchangeRate,
      String? notes,
    )
    addPayment,
  }) {
    return markCaseAsFinished(patientId, caseId, title);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String patientId)? loadPatientDetails,
    TResult? Function(String patientId, String caseId, String? title)?
    markCaseAsFinished,
    TResult? Function(
      String patientId,
      String caseId,
      double amount,
      String currencyId,
      String caseCurrencyId,
      double amountInCaseCurrency,
      double exchangeRate,
      String? notes,
    )?
    addPayment,
  }) {
    return markCaseAsFinished?.call(patientId, caseId, title);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String patientId)? loadPatientDetails,
    TResult Function(String patientId, String caseId, String? title)?
    markCaseAsFinished,
    TResult Function(
      String patientId,
      String caseId,
      double amount,
      String currencyId,
      String caseCurrencyId,
      double amountInCaseCurrency,
      double exchangeRate,
      String? notes,
    )?
    addPayment,
    required TResult orElse(),
  }) {
    if (markCaseAsFinished != null) {
      return markCaseAsFinished(patientId, caseId, title);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadPatientDetails value) loadPatientDetails,
    required TResult Function(_MarkCaseAsFinished value) markCaseAsFinished,
    required TResult Function(_AddPayment value) addPayment,
  }) {
    return markCaseAsFinished(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadPatientDetails value)? loadPatientDetails,
    TResult? Function(_MarkCaseAsFinished value)? markCaseAsFinished,
    TResult? Function(_AddPayment value)? addPayment,
  }) {
    return markCaseAsFinished?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadPatientDetails value)? loadPatientDetails,
    TResult Function(_MarkCaseAsFinished value)? markCaseAsFinished,
    TResult Function(_AddPayment value)? addPayment,
    required TResult orElse(),
  }) {
    if (markCaseAsFinished != null) {
      return markCaseAsFinished(this);
    }
    return orElse();
  }
}

abstract class _MarkCaseAsFinished implements PatientDetailsEvent {
  const factory _MarkCaseAsFinished({
    required final String patientId,
    required final String caseId,
    final String? title,
  }) = _$MarkCaseAsFinishedImpl;

  @override
  String get patientId;
  String get caseId;
  String? get title;

  /// Create a copy of PatientDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarkCaseAsFinishedImplCopyWith<_$MarkCaseAsFinishedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddPaymentImplCopyWith<$Res>
    implements $PatientDetailsEventCopyWith<$Res> {
  factory _$$AddPaymentImplCopyWith(
    _$AddPaymentImpl value,
    $Res Function(_$AddPaymentImpl) then,
  ) = __$$AddPaymentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String patientId,
    String caseId,
    double amount,
    String currencyId,
    String caseCurrencyId,
    double amountInCaseCurrency,
    double exchangeRate,
    String? notes,
  });
}

/// @nodoc
class __$$AddPaymentImplCopyWithImpl<$Res>
    extends _$PatientDetailsEventCopyWithImpl<$Res, _$AddPaymentImpl>
    implements _$$AddPaymentImplCopyWith<$Res> {
  __$$AddPaymentImplCopyWithImpl(
    _$AddPaymentImpl _value,
    $Res Function(_$AddPaymentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PatientDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? patientId = null,
    Object? caseId = null,
    Object? amount = null,
    Object? currencyId = null,
    Object? caseCurrencyId = null,
    Object? amountInCaseCurrency = null,
    Object? exchangeRate = null,
    Object? notes = freezed,
  }) {
    return _then(
      _$AddPaymentImpl(
        patientId: null == patientId
            ? _value.patientId
            : patientId // ignore: cast_nullable_to_non_nullable
                  as String,
        caseId: null == caseId
            ? _value.caseId
            : caseId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        currencyId: null == currencyId
            ? _value.currencyId
            : currencyId // ignore: cast_nullable_to_non_nullable
                  as String,
        caseCurrencyId: null == caseCurrencyId
            ? _value.caseCurrencyId
            : caseCurrencyId // ignore: cast_nullable_to_non_nullable
                  as String,
        amountInCaseCurrency: null == amountInCaseCurrency
            ? _value.amountInCaseCurrency
            : amountInCaseCurrency // ignore: cast_nullable_to_non_nullable
                  as double,
        exchangeRate: null == exchangeRate
            ? _value.exchangeRate
            : exchangeRate // ignore: cast_nullable_to_non_nullable
                  as double,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$AddPaymentImpl implements _AddPayment {
  const _$AddPaymentImpl({
    required this.patientId,
    required this.caseId,
    required this.amount,
    required this.currencyId,
    required this.caseCurrencyId,
    required this.amountInCaseCurrency,
    required this.exchangeRate,
    this.notes,
  });

  @override
  final String patientId;
  @override
  final String caseId;
  @override
  final double amount;
  @override
  final String currencyId;
  @override
  final String caseCurrencyId;
  @override
  final double amountInCaseCurrency;
  @override
  final double exchangeRate;
  @override
  final String? notes;

  @override
  String toString() {
    return 'PatientDetailsEvent.addPayment(patientId: $patientId, caseId: $caseId, amount: $amount, currencyId: $currencyId, caseCurrencyId: $caseCurrencyId, amountInCaseCurrency: $amountInCaseCurrency, exchangeRate: $exchangeRate, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddPaymentImpl &&
            (identical(other.patientId, patientId) ||
                other.patientId == patientId) &&
            (identical(other.caseId, caseId) || other.caseId == caseId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currencyId, currencyId) ||
                other.currencyId == currencyId) &&
            (identical(other.caseCurrencyId, caseCurrencyId) ||
                other.caseCurrencyId == caseCurrencyId) &&
            (identical(other.amountInCaseCurrency, amountInCaseCurrency) ||
                other.amountInCaseCurrency == amountInCaseCurrency) &&
            (identical(other.exchangeRate, exchangeRate) ||
                other.exchangeRate == exchangeRate) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    patientId,
    caseId,
    amount,
    currencyId,
    caseCurrencyId,
    amountInCaseCurrency,
    exchangeRate,
    notes,
  );

  /// Create a copy of PatientDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddPaymentImplCopyWith<_$AddPaymentImpl> get copyWith =>
      __$$AddPaymentImplCopyWithImpl<_$AddPaymentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String patientId) loadPatientDetails,
    required TResult Function(String patientId, String caseId, String? title)
    markCaseAsFinished,
    required TResult Function(
      String patientId,
      String caseId,
      double amount,
      String currencyId,
      String caseCurrencyId,
      double amountInCaseCurrency,
      double exchangeRate,
      String? notes,
    )
    addPayment,
  }) {
    return addPayment(
      patientId,
      caseId,
      amount,
      currencyId,
      caseCurrencyId,
      amountInCaseCurrency,
      exchangeRate,
      notes,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String patientId)? loadPatientDetails,
    TResult? Function(String patientId, String caseId, String? title)?
    markCaseAsFinished,
    TResult? Function(
      String patientId,
      String caseId,
      double amount,
      String currencyId,
      String caseCurrencyId,
      double amountInCaseCurrency,
      double exchangeRate,
      String? notes,
    )?
    addPayment,
  }) {
    return addPayment?.call(
      patientId,
      caseId,
      amount,
      currencyId,
      caseCurrencyId,
      amountInCaseCurrency,
      exchangeRate,
      notes,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String patientId)? loadPatientDetails,
    TResult Function(String patientId, String caseId, String? title)?
    markCaseAsFinished,
    TResult Function(
      String patientId,
      String caseId,
      double amount,
      String currencyId,
      String caseCurrencyId,
      double amountInCaseCurrency,
      double exchangeRate,
      String? notes,
    )?
    addPayment,
    required TResult orElse(),
  }) {
    if (addPayment != null) {
      return addPayment(
        patientId,
        caseId,
        amount,
        currencyId,
        caseCurrencyId,
        amountInCaseCurrency,
        exchangeRate,
        notes,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadPatientDetails value) loadPatientDetails,
    required TResult Function(_MarkCaseAsFinished value) markCaseAsFinished,
    required TResult Function(_AddPayment value) addPayment,
  }) {
    return addPayment(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadPatientDetails value)? loadPatientDetails,
    TResult? Function(_MarkCaseAsFinished value)? markCaseAsFinished,
    TResult? Function(_AddPayment value)? addPayment,
  }) {
    return addPayment?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadPatientDetails value)? loadPatientDetails,
    TResult Function(_MarkCaseAsFinished value)? markCaseAsFinished,
    TResult Function(_AddPayment value)? addPayment,
    required TResult orElse(),
  }) {
    if (addPayment != null) {
      return addPayment(this);
    }
    return orElse();
  }
}

abstract class _AddPayment implements PatientDetailsEvent {
  const factory _AddPayment({
    required final String patientId,
    required final String caseId,
    required final double amount,
    required final String currencyId,
    required final String caseCurrencyId,
    required final double amountInCaseCurrency,
    required final double exchangeRate,
    final String? notes,
  }) = _$AddPaymentImpl;

  @override
  String get patientId;
  String get caseId;
  double get amount;
  String get currencyId;
  String get caseCurrencyId;
  double get amountInCaseCurrency;
  double get exchangeRate;
  String? get notes;

  /// Create a copy of PatientDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddPaymentImplCopyWith<_$AddPaymentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PatientDetailsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      PatientEntity patient,
      DentalCase? activeCase,
      List<DentalCase> completedCases,
    )
    loaded,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      PatientEntity patient,
      DentalCase? activeCase,
      List<DentalCase> completedCases,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      PatientEntity patient,
      DentalCase? activeCase,
      List<DentalCase> completedCases,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatientDetailsStateCopyWith<$Res> {
  factory $PatientDetailsStateCopyWith(
    PatientDetailsState value,
    $Res Function(PatientDetailsState) then,
  ) = _$PatientDetailsStateCopyWithImpl<$Res, PatientDetailsState>;
}

/// @nodoc
class _$PatientDetailsStateCopyWithImpl<$Res, $Val extends PatientDetailsState>
    implements $PatientDetailsStateCopyWith<$Res> {
  _$PatientDetailsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PatientDetailsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
    _$InitialImpl value,
    $Res Function(_$InitialImpl) then,
  ) = __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$PatientDetailsStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PatientDetailsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'PatientDetailsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      PatientEntity patient,
      DentalCase? activeCase,
      List<DentalCase> completedCases,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      PatientEntity patient,
      DentalCase? activeCase,
      List<DentalCase> completedCases,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      PatientEntity patient,
      DentalCase? activeCase,
      List<DentalCase> completedCases,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements PatientDetailsState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
    _$LoadingImpl value,
    $Res Function(_$LoadingImpl) then,
  ) = __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$PatientDetailsStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PatientDetailsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'PatientDetailsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      PatientEntity patient,
      DentalCase? activeCase,
      List<DentalCase> completedCases,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      PatientEntity patient,
      DentalCase? activeCase,
      List<DentalCase> completedCases,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      PatientEntity patient,
      DentalCase? activeCase,
      List<DentalCase> completedCases,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements PatientDetailsState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
    _$LoadedImpl value,
    $Res Function(_$LoadedImpl) then,
  ) = __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    PatientEntity patient,
    DentalCase? activeCase,
    List<DentalCase> completedCases,
  });

  $PatientEntityCopyWith<$Res> get patient;
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$PatientDetailsStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
    _$LoadedImpl _value,
    $Res Function(_$LoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PatientDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? patient = null,
    Object? activeCase = freezed,
    Object? completedCases = null,
  }) {
    return _then(
      _$LoadedImpl(
        patient: null == patient
            ? _value.patient
            : patient // ignore: cast_nullable_to_non_nullable
                  as PatientEntity,
        activeCase: freezed == activeCase
            ? _value.activeCase
            : activeCase // ignore: cast_nullable_to_non_nullable
                  as DentalCase?,
        completedCases: null == completedCases
            ? _value._completedCases
            : completedCases // ignore: cast_nullable_to_non_nullable
                  as List<DentalCase>,
      ),
    );
  }

  /// Create a copy of PatientDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PatientEntityCopyWith<$Res> get patient {
    return $PatientEntityCopyWith<$Res>(_value.patient, (value) {
      return _then(_value.copyWith(patient: value));
    });
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl({
    required this.patient,
    required this.activeCase,
    required final List<DentalCase> completedCases,
  }) : _completedCases = completedCases;

  @override
  final PatientEntity patient;
  @override
  final DentalCase? activeCase;
  final List<DentalCase> _completedCases;
  @override
  List<DentalCase> get completedCases {
    if (_completedCases is EqualUnmodifiableListView) return _completedCases;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_completedCases);
  }

  @override
  String toString() {
    return 'PatientDetailsState.loaded(patient: $patient, activeCase: $activeCase, completedCases: $completedCases)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.patient, patient) || other.patient == patient) &&
            (identical(other.activeCase, activeCase) ||
                other.activeCase == activeCase) &&
            const DeepCollectionEquality().equals(
              other._completedCases,
              _completedCases,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    patient,
    activeCase,
    const DeepCollectionEquality().hash(_completedCases),
  );

  /// Create a copy of PatientDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      PatientEntity patient,
      DentalCase? activeCase,
      List<DentalCase> completedCases,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(patient, activeCase, completedCases);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      PatientEntity patient,
      DentalCase? activeCase,
      List<DentalCase> completedCases,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(patient, activeCase, completedCases);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      PatientEntity patient,
      DentalCase? activeCase,
      List<DentalCase> completedCases,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(patient, activeCase, completedCases);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements PatientDetailsState {
  const factory _Loaded({
    required final PatientEntity patient,
    required final DentalCase? activeCase,
    required final List<DentalCase> completedCases,
  }) = _$LoadedImpl;

  PatientEntity get patient;
  DentalCase? get activeCase;
  List<DentalCase> get completedCases;

  /// Create a copy of PatientDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
    _$ErrorImpl value,
    $Res Function(_$ErrorImpl) then,
  ) = __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$PatientDetailsStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PatientDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'PatientDetailsState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of PatientDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      PatientEntity patient,
      DentalCase? activeCase,
      List<DentalCase> completedCases,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      PatientEntity patient,
      DentalCase? activeCase,
      List<DentalCase> completedCases,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      PatientEntity patient,
      DentalCase? activeCase,
      List<DentalCase> completedCases,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements PatientDetailsState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of PatientDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
