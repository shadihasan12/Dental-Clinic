part of 'expense_bloc.dart';

@freezed
class ExpenseState with _$ExpenseState {
  const factory ExpenseState.initial() = _Initial;
  const factory ExpenseState.loading() = _Loading;
  const factory ExpenseState.loaded({
    required List<ExpenseEntity> expenses,
    required List<ExpenseTotalEntity> totals,
    @Default(null) String? actionError,
  }) = _Loaded;
  const factory ExpenseState.error(String message) = _Error;
}
