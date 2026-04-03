import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/patients/domain/repositories/patient_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

class AddPaymentParams extends Equatable {
  final String patientId;
  final String caseId;
  final double amount;
  final String currencyId;
  final String caseCurrencyId;
  final double amountInCaseCurrency;
  final double exchangeRate;
  final String? notes;

  const AddPaymentParams({
    required this.patientId,
    required this.caseId,
    required this.amount,
    required this.currencyId,
    required this.caseCurrencyId,
    required this.amountInCaseCurrency,
    required this.exchangeRate,
    this.notes,
  });

  @override
  List<Object?> get props => [patientId, caseId, amount, currencyId, caseCurrencyId, amountInCaseCurrency, exchangeRate, notes];
}

@injectable
class AddPaymentUseCase implements UseCase<void, AddPaymentParams> {
  final PatientRepository _repository;

  AddPaymentUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, void>> call(AddPaymentParams params) {
    return _repository.addPayment(
      params.patientId,
      params.caseId,
      params.amount,
      currencyId: params.currencyId,
      caseCurrencyId: params.caseCurrencyId,
      amountInCaseCurrency: params.amountInCaseCurrency,
      exchangeRate: params.exchangeRate,
      notes: params.notes,
    );
  }
}
