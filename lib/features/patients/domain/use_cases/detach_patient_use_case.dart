import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/patients/domain/repositories/patient_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class DetachPatientUseCase implements UseCase<void, String> {
  final PatientRepository _repository;

  DetachPatientUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, void>> call(String patientId) {
    return _repository.detachPatient(patientId);
  }
}
