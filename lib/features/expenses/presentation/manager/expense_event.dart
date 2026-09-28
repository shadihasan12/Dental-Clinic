part of 'expense_bloc.dart';

@freezed
class ExpenseEvent with _$ExpenseEvent {
  const factory ExpenseEvent.loadExpenses({
    Map<String, dynamic>? queryParameters,
  }) = _LoadExpenses;
  const factory ExpenseEvent.addExpense(Map<String, dynamic> body) =
      _AddExpense;
  const factory ExpenseEvent.updateExpense(
      String id, Map<String, dynamic> body) = _UpdateExpense;
  const factory ExpenseEvent.deleteExpense(String id) = _DeleteExpense;

  /// Show exactly this page of the current month - the desktop table's
  /// paging. Only meaningful once the bloc has a [ExpenseBloc.pageSize].
  const factory ExpenseEvent.goToPage(int page) = _GoToPage;
}
