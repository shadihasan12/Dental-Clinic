import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/expenses/domain/entities/expense_entity.dart';
import 'package:dental_clinic_app/features/expenses/domain/repositories/expense_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

class GetAllExpensesParams extends Equatable {
  final Map<String, dynamic>? queryParameters;

  const GetAllExpensesParams({this.queryParameters});

  @override
  List<Object?> get props => [queryParameters];
}

@injectable
class GetAllExpensesUseCase
    implements UseCase<ExpenseListResponse, GetAllExpensesParams> {
  final ExpenseRepository _repository;

  GetAllExpensesUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, ExpenseListResponse>> call(
    GetAllExpensesParams params,
  ) {
    return _repository.getAllExpenses(
      queryParameters: params.queryParameters,
    );
  }
}
