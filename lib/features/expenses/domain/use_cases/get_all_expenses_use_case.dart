import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/expenses/domain/entities/expense_entity.dart';
import 'package:dental_clinic_app/features/expenses/domain/repositories/expense_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllExpensesUseCase
    implements UseCase<List<ExpenseEntity>, NoParams> {
  final ExpenseRepository _repository;

  GetAllExpensesUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, List<ExpenseEntity>>> call(
    NoParams params,
  ) {
    return _repository.getAllExpenses();
  }
}
