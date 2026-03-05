import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/expenses/data/data_sources/expense_remote_data_source.dart';
import 'package:dental_clinic_app/features/expenses/data/models/expense_model.dart';
import 'package:dental_clinic_app/features/expenses/domain/entities/expense_entity.dart';
import 'package:dental_clinic_app/features/expenses/domain/repositories/expense_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExpenseRepository)
class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseRemoteDataSource _remoteDataSource;

  ExpenseRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<NetworkExceptions, ExpenseListResponse>>
      getAllExpenses() async {
    try {
      final result = await _remoteDataSource.getAllExpenses();
      final expenses = (result['expenses'] as List<ExpenseModel>)
          .map((m) => m.toEntity())
          .toList();
      final totals = (result['totals'] as List<ExpenseTotalModel>)
          .map((m) => m.toEntity())
          .toList();
      return Right(ExpenseListResponse(expenses: expenses, totals: totals));
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, List<ExpenseCategoryEntity>>>
      getCategories() async {
    try {
      final models = await _remoteDataSource.getCategories();
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, ExpenseEntity>> addExpense(
    Map<String, dynamic> body,
  ) async {
    try {
      final model = await _remoteDataSource.addExpense(body);
      return Right(model.toEntity());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, ExpenseEntity>> updateExpense(
    String id,
    Map<String, dynamic> body,
  ) async {
    try {
      final model = await _remoteDataSource.updateExpense(id, body);
      return Right(model.toEntity());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, Unit>> deleteExpense(String id) async {
    try {
      await _remoteDataSource.deleteExpense(id);
      return const Right(unit);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }
}
