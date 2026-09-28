part of 'expense_bloc.dart';

@freezed
class ExpenseState with _$ExpenseState {
  const factory ExpenseState.initial() = _Initial;
  const factory ExpenseState.loading() = _Loading;
  const factory ExpenseState.loaded({
    required List<ExpenseEntity> expenses,
    required List<ExpenseTotalEntity> totals,
    @Default(null) String? actionError,
    // Paging for the desktop table. Mobile asks for no page, so it always
    // sees page 1 of 1 and never reads these.
    @Default(1) int page,
    @Default(1) int lastPage,
    int? total,

    /// Another page is on its way; the rows shown are the previous page's.
    @Default(false) bool isPaging,
  }) = _Loaded;
  const factory ExpenseState.error(String message) = _Error;
}
