import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/app_update_info.dart';
import '../../domain/repositories/app_update_repository.dart';
import '../data_sources/app_update_remote_data_source.dart';

@Injectable(as: AppUpdateRepository)
class AppUpdateRepositoryImpl implements AppUpdateRepository {
  AppUpdateRepositoryImpl(this._remoteDataSource);

  final AppUpdateRemoteDataSource _remoteDataSource;

  @override
  Future<Either<NetworkExceptions, AppUpdateInfo>> checkForUpdate({
    required String platform,
    required String version,
  }) async {
    try {
      return Right(
        await _remoteDataSource.checkForUpdate(
          platform: platform,
          version: version,
        ),
      );
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }
}
