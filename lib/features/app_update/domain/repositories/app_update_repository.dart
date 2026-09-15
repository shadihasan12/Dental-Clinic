import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';

import '../entities/app_update_info.dart';

abstract class AppUpdateRepository {
  Future<Either<NetworkExceptions, AppUpdateInfo>> checkForUpdate({
    required String platform,
    required String version,
    required String build,
  });
}
