import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/expenses/domain/entities/expense_entity.dart';

abstract class ExpenseRepository {
  Future<Either<NetworkExceptions, List<ExpenseEntity>>> getAllExpenses();
  Future<Either<NetworkExceptions, ExpenseEntity>> addExpense(
      ExpenseEntity expense);
  Future<Either<NetworkExceptions, Unit>> deleteExpense(String id);
}
