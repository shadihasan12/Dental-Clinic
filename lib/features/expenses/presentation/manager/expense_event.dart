part of 'expense_bloc.dart';

@freezed
class ExpenseEvent with _$ExpenseEvent {
  const factory ExpenseEvent.loadExpenses() = _LoadExpenses;
  const factory ExpenseEvent.addExpense(ExpenseEntity expense) = _AddExpense;
  const factory ExpenseEvent.deleteExpense(String id) = _DeleteExpense;
}
