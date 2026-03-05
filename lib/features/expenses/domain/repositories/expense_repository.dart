import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/expenses/domain/entities/expense_entity.dart';

abstract class ExpenseRepository {
  Future<Either<NetworkExceptions, ExpenseListResponse>> getAllExpenses();
  Future<Either<NetworkExceptions, List<ExpenseCategoryEntity>>> getCategories();
  Future<Either<NetworkExceptions, ExpenseEntity>> addExpense(
      Map<String, dynamic> body);
  Future<Either<NetworkExceptions, ExpenseEntity>> updateExpense(
      String id, Map<String, dynamic> body);
  Future<Either<NetworkExceptions, Unit>> deleteExpense(String id);
}
