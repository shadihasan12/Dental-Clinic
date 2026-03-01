import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/domain/entities/clinic_info_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/domain/repositories/clinic_info_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetClinicInfoUseCase extends UseCase<ClinicInfoEntity, NoParams> {
  final ClinicInfoRepository _repository;

  GetClinicInfoUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, ClinicInfoEntity>> call(
    NoParams params,
  ) {
    return _repository.getClinicInfo();
  }
}
