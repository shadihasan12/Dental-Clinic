import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/clinic/domain/repositories/clinic_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class RemoveClinicUserUseCase {
  final ClinicRepository _repository;
  RemoveClinicUserUseCase(this._repository);

  Future<Either<NetworkExceptions, void>> call({
    required String clinicId,
    required String userId,
  }) {
    return _repository.removeClinicUser(
      clinicId: clinicId,
      userId: userId,
    );
  }
}
