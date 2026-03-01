import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/patients/data/models/core_treatment.dart';
import 'package:dental_clinic_app/features/patients/domain/repositories/patient_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllCoreTreatmentsUseCase
    implements UseCase<List<CoreTreatment>, NoParams> {
  final PatientRepository _repository;

  GetAllCoreTreatmentsUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, List<CoreTreatment>>> call(
    NoParams params,
  ) {
    return _repository.getAllCoreTreatments();
  }
}
