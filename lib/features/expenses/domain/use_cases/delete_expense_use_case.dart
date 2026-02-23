import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/expenses/domain/repositories/expense_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteExpenseUseCase implements UseCase<Unit, String> {
  final ExpenseRepository _repository;

  DeleteExpenseUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, Unit>> call(String params) {
    return _repository.deleteExpense(params);
  }
}
