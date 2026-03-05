part of 'expense_bloc.dart';

@freezed
class ExpenseEvent with _$ExpenseEvent {
  const factory ExpenseEvent.loadExpenses() = _LoadExpenses;
  const factory ExpenseEvent.addExpense(Map<String, dynamic> body) =
      _AddExpense;
  const factory ExpenseEvent.updateExpense(
      String id, Map<String, dynamic> body) = _UpdateExpense;
  const factory ExpenseEvent.deleteExpense(String id) = _DeleteExpense;
}
