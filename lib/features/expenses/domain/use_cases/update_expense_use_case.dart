import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/expenses/domain/entities/expense_entity.dart';
import 'package:dental_clinic_app/features/expenses/domain/repositories/expense_repository.dart';
import 'package:injectable/injectable.dart';

class UpdateExpenseParams {
  final String id;
  final Map<String, dynamic> body;

  const UpdateExpenseParams({required this.id, required this.body});
}

@injectable
class UpdateExpenseUseCase
    implements UseCase<ExpenseEntity, UpdateExpenseParams> {
  final ExpenseRepository _repository;

  UpdateExpenseUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, ExpenseEntity>> call(
    UpdateExpenseParams params,
  ) {
    return _repository.updateExpense(params.id, params.body);
  }
}
