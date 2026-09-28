import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';

import 'package:dental_clinic_app/features/expenses/domain/entities/expense_entity.dart';
import 'package:dental_clinic_app/features/expenses/domain/use_cases/get_all_expenses_use_case.dart';
import 'package:dental_clinic_app/features/expenses/domain/use_cases/add_expense_use_case.dart';
import 'package:dental_clinic_app/features/expenses/domain/use_cases/update_expense_use_case.dart';
import 'package:dental_clinic_app/features/expenses/domain/use_cases/delete_expense_use_case.dart';
import 'package:injectable/injectable.dart';

part 'expense_bloc.freezed.dart';
part 'expense_event.dart';
part 'expense_state.dart';

@injectable
class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final GetAllExpensesUseCase _getAllExpenses;
  final AddExpenseUseCase _addExpense;
  final UpdateExpenseUseCase _updateExpense;
  final DeleteExpenseUseCase _deleteExpense;

  Map<String, dynamic>? _lastQueryParameters;

  /// Rows per request. Null asks for no page at all - the whole month in
  /// one response, as mobile always has; the desktop table sets a size and
  /// pages through it instead.
  int? pageSize;

  int _page = 1;

  /// Bumped by every load, so a page that lands after the month changed
  /// is dropped instead of shown under the wrong month.
  int _generation = 0;

  ExpenseBloc({
    required GetAllExpensesUseCase getAllExpenses,
    required AddExpenseUseCase addExpense,
    required UpdateExpenseUseCase updateExpense,
    required DeleteExpenseUseCase deleteExpense,
  })  : _getAllExpenses = getAllExpenses,
        _addExpense = addExpense,
        _updateExpense = updateExpense,
        _deleteExpense = deleteExpense,
        super(const ExpenseState.initial()) {
    on<_LoadExpenses>(_onLoadExpenses);
    on<_AddExpense>(_onAddExpense);
    on<_UpdateExpense>(_onUpdateExpense);
    on<_DeleteExpense>(_onDeleteExpense);
    on<_GoToPage>(_onGoToPage);
  }

  Future<Either<NetworkExceptions, ExpenseListResponse>> _fetch(int page) {
    final size = pageSize;
    return _getAllExpenses(
      GetAllExpensesParams(
        queryParameters: {
          ...?_lastQueryParameters,
          if (size != null) ...{'page': page, 'size': size},
        },
      ),
    );
  }

  ExpenseState _loadedFrom(ExpenseListResponse response) {
    _page = response.page;
    return ExpenseState.loaded(
      expenses: _newestFirst(response.expenses),
      totals: response.totals,
      page: response.page,
      lastPage: response.lastPage,
      total: response.total,
    );
  }

  /// The server already sorts by entry date, newest first, but takes only
  /// that one field - so expenses entered on the same day come back in no
  /// set order. Settle those by when they were recorded. Stable, so it never
  /// undoes the server's order between different days.
  static List<ExpenseEntity> _newestFirst(List<ExpenseEntity> expenses) {
    int byDateDesc(String a, String b) {
      final da = DateTime.tryParse(a);
      final db = DateTime.tryParse(b);
      if (da == null || db == null) return 0;
      return db.compareTo(da);
    }

    final indexed = expenses.asMap().entries.toList()
      ..sort((a, b) {
        final byEntry = byDateDesc(a.value.entryDate, b.value.entryDate);
        if (byEntry != 0) return byEntry;
        final byCreated = byDateDesc(a.value.createdAt, b.value.createdAt);
        return byCreated != 0 ? byCreated : a.key.compareTo(b.key);
      });
    return [for (final e in indexed) e.value];
  }

  /// After a change, reload what is on screen: the page the desktop table
  /// is on, or the whole month on mobile.
  void _reloadAfterChange() {
    add(
      pageSize != null
          ? ExpenseEvent.goToPage(_page)
          : const ExpenseEvent.loadExpenses(),
    );
  }

  Future<void> _onGoToPage(
    _GoToPage event,
    Emitter<ExpenseState> emit,
  ) async {
    final generation = ++_generation;
    final current = state;
    // Keep the rows up, dimmed, rather than blanking the table per click.
    if (current is _Loaded) {
      emit(current.copyWith(isPaging: true, actionError: null));
    } else {
      emit(const ExpenseState.loading());
    }

    var page = event.page < 1 ? 1 : event.page;
    var result = await _fetch(page);
    if (generation != _generation) return;

    // Deleting the only expense on the last page leaves it empty; step back
    // to what is now the last page instead of showing nothing.
    final shrunk = result.fold(
      (_) => null,
      (r) => r.expenses.isEmpty && page > 1 && r.lastPage < page
          ? r.lastPage
          : null,
    );
    if (shrunk != null) {
      page = shrunk < 1 ? 1 : shrunk;
      result = await _fetch(page);
      if (generation != _generation) return;
    }

    result.fold(
      (error) => emit(
        ExpenseState.error(NetworkExceptions.getErrorMessage(error)),
      ),
      (response) => emit(_loadedFrom(response)),
    );
  }

  Future<void> _onLoadExpenses(
    _LoadExpenses event,
    Emitter<ExpenseState> emit,
  ) async {
    if (event.queryParameters != null) {
      _lastQueryParameters = event.queryParameters;
    }
    final generation = ++_generation;
    emit(const ExpenseState.loading());

    final result = await _fetch(1);
    if (generation != _generation) return;

    result.fold(
      (error) => emit(
        ExpenseState.error(NetworkExceptions.getErrorMessage(error)),
      ),
      (response) => emit(_loadedFrom(response)),
    );
  }

  Future<void> _onAddExpense(
    _AddExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    final currentState = state;
    // Clear previous action error
    if (currentState is _Loaded) {
      emit(currentState.copyWith(actionError: null));
    }

    final result = await _addExpense(event.body);

    result.fold(
      (error) {
        if (state is _Loaded) {
          emit((state as _Loaded).copyWith(
            actionError: NetworkExceptions.getErrorMessage(error),
          ));
        }
      },
      (_) => _reloadAfterChange(),
    );
  }

  Future<void> _onUpdateExpense(
    _UpdateExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    final currentState = state;
    if (currentState is _Loaded) {
      emit(currentState.copyWith(actionError: null));
    }

    final result = await _updateExpense(
      UpdateExpenseParams(id: event.id, body: event.body),
    );

    result.fold(
      (error) {
        if (state is _Loaded) {
          emit((state as _Loaded).copyWith(
            actionError: NetworkExceptions.getErrorMessage(error),
          ));
        }
      },
      (_) => _reloadAfterChange(),
    );
  }

  Future<void> _onDeleteExpense(
    _DeleteExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    final currentState = state;
    if (currentState is! _Loaded) return;
    emit(currentState.copyWith(actionError: null));

    final result = await _deleteExpense(event.id);

    result.fold(
      (error) {
        if (state is _Loaded) {
          emit((state as _Loaded).copyWith(
            actionError: NetworkExceptions.getErrorMessage(error),
          ));
        }
      },
      (_) => _reloadAfterChange(),
    );
  }
}
