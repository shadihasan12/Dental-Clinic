import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/home/data/data_sources/fcm_token_remote_data_source.dart';
import 'package:dental_clinic_app/features/home/domain/repositories/fcm_token_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: FcmTokenRepository)
class FcmTokenRepositoryImpl implements FcmTokenRepository {
  final FcmTokenRemoteDataSource _remoteDataSource;

  FcmTokenRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<NetworkExceptions, Unit>> register(String token) async {
    try {
      await _remoteDataSource.register(token);
      return const Right(unit);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }
}
