// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ExpenseEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, dynamic>? queryParameters)
    loadExpenses,
    required TResult Function(Map<String, dynamic> body) addExpense,
    required TResult Function(String id, Map<String, dynamic> body)
    updateExpense,
    required TResult Function(String id) deleteExpense,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, dynamic>? queryParameters)? loadExpenses,
    TResult? Function(Map<String, dynamic> body)? addExpense,
    TResult? Function(String id, Map<String, dynamic> body)? updateExpense,
    TResult? Function(String id)? deleteExpense,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, dynamic>? queryParameters)? loadExpenses,
    TResult Function(Map<String, dynamic> body)? addExpense,
    TResult Function(String id, Map<String, dynamic> body)? updateExpense,
    TResult Function(String id)? deleteExpense,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadExpenses value) loadExpenses,
    required TResult Function(_AddExpense value) addExpense,
    required TResult Function(_UpdateExpense value) updateExpense,
    required TResult Function(_DeleteExpense value) deleteExpense,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadExpenses value)? loadExpenses,
    TResult? Function(_AddExpense value)? addExpense,
    TResult? Function(_UpdateExpense value)? updateExpense,
    TResult? Function(_DeleteExpense value)? deleteExpense,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadExpenses value)? loadExpenses,
    TResult Function(_AddExpense value)? addExpense,
    TResult Function(_UpdateExpense value)? updateExpense,
    TResult Function(_DeleteExpense value)? deleteExpense,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseEventCopyWith<$Res> {
  factory $ExpenseEventCopyWith(
    ExpenseEvent value,
    $Res Function(ExpenseEvent) then,
  ) = _$ExpenseEventCopyWithImpl<$Res, ExpenseEvent>;
}

/// @nodoc
class _$ExpenseEventCopyWithImpl<$Res, $Val extends ExpenseEvent>
    implements $ExpenseEventCopyWith<$Res> {
  _$ExpenseEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExpenseEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadExpensesImplCopyWith<$Res> {
  factory _$$LoadExpensesImplCopyWith(
    _$LoadExpensesImpl value,
    $Res Function(_$LoadExpensesImpl) then,
  ) = __$$LoadExpensesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<String, dynamic>? queryParameters});
}

/// @nodoc
class __$$LoadExpensesImplCopyWithImpl<$Res>
    extends _$ExpenseEventCopyWithImpl<$Res, _$LoadExpensesImpl>
    implements _$$LoadExpensesImplCopyWith<$Res> {
  __$$LoadExpensesImplCopyWithImpl(
    _$LoadExpensesImpl _value,
    $Res Function(_$LoadExpensesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExpenseEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? queryParameters = freezed}) {
    return _then(
      _$LoadExpensesImpl(
        queryParameters: freezed == queryParameters
            ? _value._queryParameters
            : queryParameters // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc

class _$LoadExpensesImpl implements _LoadExpenses {
  const _$LoadExpensesImpl({final Map<String, dynamic>? queryParameters})
    : _queryParameters = queryParameters;

  final Map<String, dynamic>? _queryParameters;
  @override
  Map<String, dynamic>? get queryParameters {
    final value = _queryParameters;
    if (value == null) return null;
    if (_queryParameters is EqualUnmodifiableMapView) return _queryParameters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ExpenseEvent.loadExpenses(queryParameters: $queryParameters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadExpensesImpl &&
            const DeepCollectionEquality().equals(
              other._queryParameters,
              _queryParameters,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_queryParameters),
  );

  /// Create a copy of ExpenseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadExpensesImplCopyWith<_$LoadExpensesImpl> get copyWith =>
      __$$LoadExpensesImplCopyWithImpl<_$LoadExpensesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, dynamic>? queryParameters)
    loadExpenses,
    required TResult Function(Map<String, dynamic> body) addExpense,
    required TResult Function(String id, Map<String, dynamic> body)
    updateExpense,
    required TResult Function(String id) deleteExpense,
  }) {
    return loadExpenses(queryParameters);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, dynamic>? queryParameters)? loadExpenses,
    TResult? Function(Map<String, dynamic> body)? addExpense,
    TResult? Function(String id, Map<String, dynamic> body)? updateExpense,
    TResult? Function(String id)? deleteExpense,
  }) {
    return loadExpenses?.call(queryParameters);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, dynamic>? queryParameters)? loadExpenses,
    TResult Function(Map<String, dynamic> body)? addExpense,
    TResult Function(String id, Map<String, dynamic> body)? updateExpense,
    TResult Function(String id)? deleteExpense,
    required TResult orElse(),
  }) {
    if (loadExpenses != null) {
      return loadExpenses(queryParameters);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadExpenses value) loadExpenses,
    required TResult Function(_AddExpense value) addExpense,
    required TResult Function(_UpdateExpense value) updateExpense,
    required TResult Function(_DeleteExpense value) deleteExpense,
  }) {
    return loadExpenses(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadExpenses value)? loadExpenses,
    TResult? Function(_AddExpense value)? addExpense,
    TResult? Function(_UpdateExpense value)? updateExpense,
    TResult? Function(_DeleteExpense value)? deleteExpense,
  }) {
    return loadExpenses?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadExpenses value)? loadExpenses,
    TResult Function(_AddExpense value)? addExpense,
    TResult Function(_UpdateExpense value)? updateExpense,
    TResult Function(_DeleteExpense value)? deleteExpense,
    required TResult orElse(),
  }) {
    if (loadExpenses != null) {
      return loadExpenses(this);
    }
    return orElse();
  }
}

abstract class _LoadExpenses implements ExpenseEvent {
  const factory _LoadExpenses({final Map<String, dynamic>? queryParameters}) =
      _$LoadExpensesImpl;

  Map<String, dynamic>? get queryParameters;

  /// Create a copy of ExpenseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadExpensesImplCopyWith<_$LoadExpensesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddExpenseImplCopyWith<$Res> {
  factory _$$AddExpenseImplCopyWith(
    _$AddExpenseImpl value,
    $Res Function(_$AddExpenseImpl) then,
  ) = __$$AddExpenseImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<String, dynamic> body});
}

/// @nodoc
class __$$AddExpenseImplCopyWithImpl<$Res>
    extends _$ExpenseEventCopyWithImpl<$Res, _$AddExpenseImpl>
    implements _$$AddExpenseImplCopyWith<$Res> {
  __$$AddExpenseImplCopyWithImpl(
    _$AddExpenseImpl _value,
    $Res Function(_$AddExpenseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExpenseEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? body = null}) {
    return _then(
      _$AddExpenseImpl(
        null == body
            ? _value._body
            : body // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc

class _$AddExpenseImpl implements _AddExpense {
  const _$AddExpenseImpl(final Map<String, dynamic> body) : _body = body;

  final Map<String, dynamic> _body;
  @override
  Map<String, dynamic> get body {
    if (_body is EqualUnmodifiableMapView) return _body;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_body);
  }

  @override
  String toString() {
    return 'ExpenseEvent.addExpense(body: $body)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddExpenseImpl &&
            const DeepCollectionEquality().equals(other._body, _body));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_body));

  /// Create a copy of ExpenseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddExpenseImplCopyWith<_$AddExpenseImpl> get copyWith =>
      __$$AddExpenseImplCopyWithImpl<_$AddExpenseImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, dynamic>? queryParameters)
    loadExpenses,
    required TResult Function(Map<String, dynamic> body) addExpense,
    required TResult Function(String id, Map<String, dynamic> body)
    updateExpense,
    required TResult Function(String id) deleteExpense,
  }) {
    return addExpense(body);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, dynamic>? queryParameters)? loadExpenses,
    TResult? Function(Map<String, dynamic> body)? addExpense,
    TResult? Function(String id, Map<String, dynamic> body)? updateExpense,
    TResult? Function(String id)? deleteExpense,
  }) {
    return addExpense?.call(body);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, dynamic>? queryParameters)? loadExpenses,
    TResult Function(Map<String, dynamic> body)? addExpense,
    TResult Function(String id, Map<String, dynamic> body)? updateExpense,
    TResult Function(String id)? deleteExpense,
    required TResult orElse(),
  }) {
    if (addExpense != null) {
      return addExpense(body);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadExpenses value) loadExpenses,
    required TResult Function(_AddExpense value) addExpense,
    required TResult Function(_UpdateExpense value) updateExpense,
    required TResult Function(_DeleteExpense value) deleteExpense,
  }) {
    return addExpense(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadExpenses value)? loadExpenses,
    TResult? Function(_AddExpense value)? addExpense,
    TResult? Function(_UpdateExpense value)? updateExpense,
    TResult? Function(_DeleteExpense value)? deleteExpense,
  }) {
    return addExpense?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadExpenses value)? loadExpenses,
    TResult Function(_AddExpense value)? addExpense,
    TResult Function(_UpdateExpense value)? updateExpense,
    TResult Function(_DeleteExpense value)? deleteExpense,
    required TResult orElse(),
  }) {
    if (addExpense != null) {
      return addExpense(this);
    }
    return orElse();
  }
}

abstract class _AddExpense implements ExpenseEvent {
  const factory _AddExpense(final Map<String, dynamic> body) = _$AddExpenseImpl;

  Map<String, dynamic> get body;

  /// Create a copy of ExpenseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddExpenseImplCopyWith<_$AddExpenseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateExpenseImplCopyWith<$Res> {
  factory _$$UpdateExpenseImplCopyWith(
    _$UpdateExpenseImpl value,
    $Res Function(_$UpdateExpenseImpl) then,
  ) = __$$UpdateExpenseImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id, Map<String, dynamic> body});
}

/// @nodoc
class __$$UpdateExpenseImplCopyWithImpl<$Res>
    extends _$ExpenseEventCopyWithImpl<$Res, _$UpdateExpenseImpl>
    implements _$$UpdateExpenseImplCopyWith<$Res> {
  __$$UpdateExpenseImplCopyWithImpl(
    _$UpdateExpenseImpl _value,
    $Res Function(_$UpdateExpenseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExpenseEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? body = null}) {
    return _then(
      _$UpdateExpenseImpl(
        null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        null == body
            ? _value._body
            : body // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc

class _$UpdateExpenseImpl implements _UpdateExpense {
  const _$UpdateExpenseImpl(this.id, final Map<String, dynamic> body)
    : _body = body;

  @override
  final String id;
  final Map<String, dynamic> _body;
  @override
  Map<String, dynamic> get body {
    if (_body is EqualUnmodifiableMapView) return _body;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_body);
  }

  @override
  String toString() {
    return 'ExpenseEvent.updateExpense(id: $id, body: $body)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateExpenseImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._body, _body));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, const DeepCollectionEquality().hash(_body));

  /// Create a copy of ExpenseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateExpenseImplCopyWith<_$UpdateExpenseImpl> get copyWith =>
      __$$UpdateExpenseImplCopyWithImpl<_$UpdateExpenseImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, dynamic>? queryParameters)
    loadExpenses,
    required TResult Function(Map<String, dynamic> body) addExpense,
    required TResult Function(String id, Map<String, dynamic> body)
    updateExpense,
    required TResult Function(String id) deleteExpense,
  }) {
    return updateExpense(id, body);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, dynamic>? queryParameters)? loadExpenses,
    TResult? Function(Map<String, dynamic> body)? addExpense,
    TResult? Function(String id, Map<String, dynamic> body)? updateExpense,
    TResult? Function(String id)? deleteExpense,
  }) {
    return updateExpense?.call(id, body);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, dynamic>? queryParameters)? loadExpenses,
    TResult Function(Map<String, dynamic> body)? addExpense,
    TResult Function(String id, Map<String, dynamic> body)? updateExpense,
    TResult Function(String id)? deleteExpense,
    required TResult orElse(),
  }) {
    if (updateExpense != null) {
      return updateExpense(id, body);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadExpenses value) loadExpenses,
    required TResult Function(_AddExpense value) addExpense,
    required TResult Function(_UpdateExpense value) updateExpense,
    required TResult Function(_DeleteExpense value) deleteExpense,
  }) {
    return updateExpense(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadExpenses value)? loadExpenses,
    TResult? Function(_AddExpense value)? addExpense,
    TResult? Function(_UpdateExpense value)? updateExpense,
    TResult? Function(_DeleteExpense value)? deleteExpense,
  }) {
    return updateExpense?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadExpenses value)? loadExpenses,
    TResult Function(_AddExpense value)? addExpense,
    TResult Function(_UpdateExpense value)? updateExpense,
    TResult Function(_DeleteExpense value)? deleteExpense,
    required TResult orElse(),
  }) {
    if (updateExpense != null) {
      return updateExpense(this);
    }
    return orElse();
  }
}

abstract class _UpdateExpense implements ExpenseEvent {
  const factory _UpdateExpense(
    final String id,
    final Map<String, dynamic> body,
  ) = _$UpdateExpenseImpl;

  String get id;
  Map<String, dynamic> get body;

  /// Create a copy of ExpenseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateExpenseImplCopyWith<_$UpdateExpenseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteExpenseImplCopyWith<$Res> {
  factory _$$DeleteExpenseImplCopyWith(
    _$DeleteExpenseImpl value,
    $Res Function(_$DeleteExpenseImpl) then,
  ) = __$$DeleteExpenseImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$DeleteExpenseImplCopyWithImpl<$Res>
    extends _$ExpenseEventCopyWithImpl<$Res, _$DeleteExpenseImpl>
    implements _$$DeleteExpenseImplCopyWith<$Res> {
  __$$DeleteExpenseImplCopyWithImpl(
    _$DeleteExpenseImpl _value,
    $Res Function(_$DeleteExpenseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExpenseEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null}) {
    return _then(
      _$DeleteExpenseImpl(
        null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$DeleteExpenseImpl implements _DeleteExpense {
  const _$DeleteExpenseImpl(this.id);

  @override
  final String id;

  @override
  String toString() {
    return 'ExpenseEvent.deleteExpense(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteExpenseImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of ExpenseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteExpenseImplCopyWith<_$DeleteExpenseImpl> get copyWith =>
      __$$DeleteExpenseImplCopyWithImpl<_$DeleteExpenseImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, dynamic>? queryParameters)
    loadExpenses,
    required TResult Function(Map<String, dynamic> body) addExpense,
    required TResult Function(String id, Map<String, dynamic> body)
    updateExpense,
    required TResult Function(String id) deleteExpense,
  }) {
    return deleteExpense(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, dynamic>? queryParameters)? loadExpenses,
    TResult? Function(Map<String, dynamic> body)? addExpense,
    TResult? Function(String id, Map<String, dynamic> body)? updateExpense,
    TResult? Function(String id)? deleteExpense,
  }) {
    return deleteExpense?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, dynamic>? queryParameters)? loadExpenses,
    TResult Function(Map<String, dynamic> body)? addExpense,
    TResult Function(String id, Map<String, dynamic> body)? updateExpense,
    TResult Function(String id)? deleteExpense,
    required TResult orElse(),
  }) {
    if (deleteExpense != null) {
      return deleteExpense(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadExpenses value) loadExpenses,
    required TResult Function(_AddExpense value) addExpense,
    required TResult Function(_UpdateExpense value) updateExpense,
    required TResult Function(_DeleteExpense value) deleteExpense,
  }) {
    return deleteExpense(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadExpenses value)? loadExpenses,
    TResult? Function(_AddExpense value)? addExpense,
    TResult? Function(_UpdateExpense value)? updateExpense,
    TResult? Function(_DeleteExpense value)? deleteExpense,
  }) {
    return deleteExpense?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadExpenses value)? loadExpenses,
    TResult Function(_AddExpense value)? addExpense,
    TResult Function(_UpdateExpense value)? updateExpense,
    TResult Function(_DeleteExpense value)? deleteExpense,
    required TResult orElse(),
  }) {
    if (deleteExpense != null) {
      return deleteExpense(this);
    }
    return orElse();
  }
}

abstract class _DeleteExpense implements ExpenseEvent {
  const factory _DeleteExpense(final String id) = _$DeleteExpenseImpl;

  String get id;

  /// Create a copy of ExpenseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteExpenseImplCopyWith<_$DeleteExpenseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ExpenseState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<ExpenseEntity> expenses,
      List<ExpenseTotalEntity> totals,
      String? actionError,
    )
    loaded,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<ExpenseEntity> expenses,
      List<ExpenseTotalEntity> totals,
      String? actionError,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<ExpenseEntity> expenses,
      List<ExpenseTotalEntity> totals,
      String? actionError,
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
abstract class $ExpenseStateCopyWith<$Res> {
  factory $ExpenseStateCopyWith(
    ExpenseState value,
    $Res Function(ExpenseState) then,
  ) = _$ExpenseStateCopyWithImpl<$Res, ExpenseState>;
}

/// @nodoc
class _$ExpenseStateCopyWithImpl<$Res, $Val extends ExpenseState>
    implements $ExpenseStateCopyWith<$Res> {
  _$ExpenseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExpenseState
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
    extends _$ExpenseStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExpenseState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'ExpenseState.initial()';
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
      List<ExpenseEntity> expenses,
      List<ExpenseTotalEntity> totals,
      String? actionError,
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
      List<ExpenseEntity> expenses,
      List<ExpenseTotalEntity> totals,
      String? actionError,
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
      List<ExpenseEntity> expenses,
      List<ExpenseTotalEntity> totals,
      String? actionError,
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

abstract class _Initial implements ExpenseState {
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
    extends _$ExpenseStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExpenseState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'ExpenseState.loading()';
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
      List<ExpenseEntity> expenses,
      List<ExpenseTotalEntity> totals,
      String? actionError,
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
      List<ExpenseEntity> expenses,
      List<ExpenseTotalEntity> totals,
      String? actionError,
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
      List<ExpenseEntity> expenses,
      List<ExpenseTotalEntity> totals,
      String? actionError,
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

abstract class _Loading implements ExpenseState {
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
    List<ExpenseEntity> expenses,
    List<ExpenseTotalEntity> totals,
    String? actionError,
  });
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$ExpenseStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
    _$LoadedImpl _value,
    $Res Function(_$LoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExpenseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expenses = null,
    Object? totals = null,
    Object? actionError = freezed,
  }) {
    return _then(
      _$LoadedImpl(
        expenses: null == expenses
            ? _value._expenses
            : expenses // ignore: cast_nullable_to_non_nullable
                  as List<ExpenseEntity>,
        totals: null == totals
            ? _value._totals
            : totals // ignore: cast_nullable_to_non_nullable
                  as List<ExpenseTotalEntity>,
        actionError: freezed == actionError
            ? _value.actionError
            : actionError // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl({
    required final List<ExpenseEntity> expenses,
    required final List<ExpenseTotalEntity> totals,
    this.actionError = null,
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
  @JsonKey()
  final String? actionError;

  @override
  String toString() {
    return 'ExpenseState.loaded(expenses: $expenses, totals: $totals, actionError: $actionError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(other._expenses, _expenses) &&
            const DeepCollectionEquality().equals(other._totals, _totals) &&
            (identical(other.actionError, actionError) ||
                other.actionError == actionError));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_expenses),
    const DeepCollectionEquality().hash(_totals),
    actionError,
  );

  /// Create a copy of ExpenseState
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
      List<ExpenseEntity> expenses,
      List<ExpenseTotalEntity> totals,
      String? actionError,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(expenses, totals, actionError);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<ExpenseEntity> expenses,
      List<ExpenseTotalEntity> totals,
      String? actionError,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(expenses, totals, actionError);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<ExpenseEntity> expenses,
      List<ExpenseTotalEntity> totals,
      String? actionError,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(expenses, totals, actionError);
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

abstract class _Loaded implements ExpenseState {
  const factory _Loaded({
    required final List<ExpenseEntity> expenses,
    required final List<ExpenseTotalEntity> totals,
    final String? actionError,
  }) = _$LoadedImpl;

  List<ExpenseEntity> get expenses;
  List<ExpenseTotalEntity> get totals;
  String? get actionError;

  /// Create a copy of ExpenseState
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
    extends _$ExpenseStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExpenseState
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
    return 'ExpenseState.error(message: $message)';
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

  /// Create a copy of ExpenseState
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
      List<ExpenseEntity> expenses,
      List<ExpenseTotalEntity> totals,
      String? actionError,
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
      List<ExpenseEntity> expenses,
      List<ExpenseTotalEntity> totals,
      String? actionError,
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
      List<ExpenseEntity> expenses,
      List<ExpenseTotalEntity> totals,
      String? actionError,
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

abstract class _Error implements ExpenseState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of ExpenseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
