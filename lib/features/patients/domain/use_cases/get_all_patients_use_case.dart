import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/models/paginated_response.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/patients/domain/entities/patient_entity.dart';
import 'package:dental_clinic_app/features/patients/domain/repositories/patient_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllPatientsUseCase
    implements UseCase<PaginatedResponse<PatientEntity>, int> {
  final PatientRepository _repository;

  GetAllPatientsUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, PaginatedResponse<PatientEntity>>> call(
    int page,
  ) {
    return _repository.getAllPatients(page: page);
  }
}
