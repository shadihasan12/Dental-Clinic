import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/expenses/domain/entities/expense_entity.dart';
import 'package:dental_clinic_app/features/expenses/domain/repositories/expense_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddExpenseUseCase implements UseCase<ExpenseEntity, ExpenseEntity> {
  final ExpenseRepository _repository;

  AddExpenseUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, ExpenseEntity>> call(
    ExpenseEntity params,
  ) {
    return _repository.addExpense(params);
  }
}
