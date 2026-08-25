import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/home/domain/repositories/fcm_token_repository.dart';
import 'package:injectable/injectable.dart';

/// POST /auth/logout - ends the session and unregisters this device's push
/// token. The token is optional; pass null when we never had one.
///
/// Must run while the auth token is still in storage: the endpoint is
/// authenticated.
@injectable
class LogoutDeviceUseCase implements UseCase<Unit, String?> {
  final FcmTokenRepository _repository;

  LogoutDeviceUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, Unit>> call(String? token) {
    return _repository.logout(token);
  }
}
