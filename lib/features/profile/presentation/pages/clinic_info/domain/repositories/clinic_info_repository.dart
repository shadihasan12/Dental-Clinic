import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/location_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/domain/entities/clinic_info_entity.dart';

abstract class ClinicInfoRepository {
  Future<Either<NetworkExceptions, ClinicInfoEntity>> getClinicInfo();
  Future<Either<NetworkExceptions, ClinicInfoEntity>> updateClinicInfo(
    ClinicInfoEntity clinicInfo,
  );
  Future<Either<NetworkExceptions, List<LocationEntity>>> searchLocations({
    required String query,
    required String countryCode,
  });
}
