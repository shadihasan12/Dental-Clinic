import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/patients/domain/entities/patient_entity.dart';
import 'package:dental_clinic_app/features/patients/domain/repositories/patient_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdatePatientUseCase implements UseCase<PatientEntity, PatientEntity> {
  final PatientRepository _repository;

  UpdatePatientUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, PatientEntity>> call(
    PatientEntity params,
  ) {
    return _repository.updatePatient(params);
  }
}
