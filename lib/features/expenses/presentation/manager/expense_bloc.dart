import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/expenses/domain/entities/expense_entity.dart';
import 'package:dental_clinic_app/features/expenses/domain/use_cases/get_all_expenses_use_case.dart';
import 'package:dental_clinic_app/features/expenses/domain/use_cases/add_expense_use_case.dart';
import 'package:dental_clinic_app/features/expenses/domain/use_cases/delete_expense_use_case.dart';
import 'package:injectable/injectable.dart';

part 'expense_bloc.freezed.dart';
part 'expense_event.dart';
part 'expense_state.dart';

@injectable
class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final GetAllExpensesUseCase _getAllExpenses;
  final AddExpenseUseCase _addExpense;
  final DeleteExpenseUseCase _deleteExpense;

  ExpenseBloc({
    required GetAllExpensesUseCase getAllExpenses,
    required AddExpenseUseCase addExpense,
    required DeleteExpenseUseCase deleteExpense,
  })  : _getAllExpenses = getAllExpenses,
        _addExpense = addExpense,
        _deleteExpense = deleteExpense,
        super(const ExpenseState.initial()) {
    on<_LoadExpenses>(_onLoadExpenses);
    on<_AddExpense>(_onAddExpense);
    on<_DeleteExpense>(_onDeleteExpense);
  }

  Future<void> _onLoadExpenses(
    _LoadExpenses event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(const ExpenseState.loading());

    final result = await _getAllExpenses(NoParams());

    result.fold(
      (error) => emit(
        ExpenseState.error(NetworkExceptions.getErrorMessage(error)),
      ),
      (expenses) => emit(ExpenseState.loaded(expenses)),
    );
  }

  Future<void> _onAddExpense(
    _AddExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    final currentState = state;
    if (currentState is! _Loaded) return;

    final result = await _addExpense(event.expense);

    result.fold(
      (_) {},
      (newExpense) {
        final updated = [newExpense, ...currentState.expenses];
        emit(ExpenseState.loaded(updated));
      },
    );
  }

  Future<void> _onDeleteExpense(
    _DeleteExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    final currentState = state;
    if (currentState is! _Loaded) return;

    final result = await _deleteExpense(event.id);

    result.fold(
      (_) {},
      (_) {
        final updated =
            currentState.expenses.where((e) => e.id != event.id).toList();
        emit(ExpenseState.loaded(updated));
      },
    );
  }
}
