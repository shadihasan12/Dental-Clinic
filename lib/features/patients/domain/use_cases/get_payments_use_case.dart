import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/patients/data/models/payment.dart';
import 'package:dental_clinic_app/features/patients/domain/repositories/patient_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

class GetPaymentsParams extends Equatable {
  final String patientId;
  final String caseId;

  const GetPaymentsParams({
    required this.patientId,
    required this.caseId,
  });

  @override
  List<Object?> get props => [patientId, caseId];
}

@injectable
class GetPaymentsUseCase implements UseCase<List<Payment>, GetPaymentsParams> {
  final PatientRepository _repository;

  GetPaymentsUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, List<Payment>>> call(
    GetPaymentsParams params,
  ) {
    return _repository.getPayments(params.patientId, params.caseId);
  }
}
