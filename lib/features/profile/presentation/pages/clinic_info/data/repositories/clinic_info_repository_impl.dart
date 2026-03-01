import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/data/data_sources/clinic_info_remote_data_source.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/data/models/clinic_info_model.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/domain/entities/clinic_info_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/domain/repositories/clinic_info_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ClinicInfoRepository)
class ClinicInfoRepositoryImpl implements ClinicInfoRepository {
  final ClinicInfoRemoteDataSource _remoteDataSource;

  ClinicInfoRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<NetworkExceptions, ClinicInfoEntity>> getClinicInfo() async {
    try {
      final model = await _remoteDataSource.getClinicInfo();
      return Right(model.toEntity());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, ClinicInfoEntity>> updateClinicInfo(
    ClinicInfoEntity clinicInfo,
  ) async {
    try {
      final model = await _remoteDataSource.updateClinicInfo(
        ClinicInfoModel.fromEntity(clinicInfo),
      );
      return Right(model.toEntity());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }
}
