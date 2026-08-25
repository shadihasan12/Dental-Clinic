import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/home/domain/repositories/fcm_token_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterFcmTokenUseCase implements UseCase<Unit, String> {
  final FcmTokenRepository _repository;

  RegisterFcmTokenUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, Unit>> call(String token) {
    return _repository.register(token);
  }
}
