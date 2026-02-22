import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:dental_clinic_app/features/patients/domain/repositories/patient_repository.dart';

class PatientCasesParams {
  final String patientId;

  const PatientCasesParams({required this.patientId});
}

class PatientCasesResult {
  final DentalCase? activeCase;
  final List<DentalCase> completedCases;

  const PatientCasesResult({
    this.activeCase,
    required this.completedCases,
  });
}

class GetPatientCasesUseCase
    implements UseCase<PatientCasesResult, PatientCasesParams> {
  final PatientRepository _repository;

  GetPatientCasesUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, PatientCasesResult>> call(
    PatientCasesParams params,
  ) async {
    final activeCaseResult =
        await _repository.getActiveCase(params.patientId);

    // Extract error early to avoid async fold type mismatch
    NetworkExceptions? activeCaseError;
    DentalCase? activeCase;
    activeCaseResult.fold(
      (error) => activeCaseError = error,
      (value) => activeCase = value,
    );
    if (activeCaseError != null) return Left(activeCaseError!);

    final completedCasesResult =
        await _repository.getCompletedCases(params.patientId);

    return completedCasesResult.fold(
      Left.new,
      (completedCases) => Right(
        PatientCasesResult(
          activeCase: activeCase,
          completedCases: completedCases,
        ),
      ),
    );
  }
}
