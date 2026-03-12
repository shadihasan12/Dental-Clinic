import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/repositories/clinic_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMyClinicsUseCase {
  final ClinicRepository _repository;

  GetMyClinicsUseCase(this._repository);

  Future<Either<NetworkExceptions, List<ClinicMembershipEntity>>> call() {
    return _repository.getMyClinics();
  }
}
