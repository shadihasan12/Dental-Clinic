import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/patients/domain/repositories/patient_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

class MarkCaseAsFinishedParams extends Equatable {
  final String patientId;
  final String caseId;
  final String? title;

  const MarkCaseAsFinishedParams({
    required this.patientId,
    required this.caseId,
    this.title,
  });

  @override
  List<Object?> get props => [patientId, caseId, title];
}

@injectable
class MarkCaseAsFinishedUseCase
    implements UseCase<void, MarkCaseAsFinishedParams> {
  final PatientRepository _repository;

  MarkCaseAsFinishedUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, void>> call(
    MarkCaseAsFinishedParams params,
  ) {
    return _repository.markCaseAsFinished(
      params.patientId,
      params.caseId,
      title: params.title,
    );
  }
}
