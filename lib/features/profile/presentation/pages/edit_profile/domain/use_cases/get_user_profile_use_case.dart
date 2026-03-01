import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/edit_profile/domain/entities/user_profile_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/edit_profile/domain/repositories/edit_profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserProfileUseCase extends UseCase<UserProfileEntity, NoParams> {
  final EditProfileRepository _repository;

  GetUserProfileUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, UserProfileEntity>> call(
    NoParams params,
  ) {
    return _repository.getUserProfile();
  }
}
