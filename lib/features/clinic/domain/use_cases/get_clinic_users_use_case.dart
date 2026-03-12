import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_user_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/repositories/clinic_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetClinicUsersUseCase {
  final ClinicRepository _repository;
  GetClinicUsersUseCase(this._repository);

  Future<Either<NetworkExceptions, List<ClinicUserEntity>>> call(
      String clinicId) {
    return _repository.getClinicUsers(clinicId);
  }
}
