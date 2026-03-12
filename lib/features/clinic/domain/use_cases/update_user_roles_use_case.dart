import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/clinic/domain/repositories/clinic_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateUserRolesUseCase {
  final ClinicRepository _repository;
  UpdateUserRolesUseCase(this._repository);

  Future<Either<NetworkExceptions, void>> call({
    required String clinicId,
    required String userId,
    required List<String> roles,
  }) {
    return _repository.updateUserRoles(
      clinicId: clinicId,
      userId: userId,
      roles: roles,
    );
  }
}
