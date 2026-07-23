import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';

abstract class FcmTokenRepository {
  /// Registers (or refreshes) the device's FCM token with the backend so the
  /// authenticated user can receive pushes on this device.
  Future<Either<NetworkExceptions, Unit>> register(String token);
}
