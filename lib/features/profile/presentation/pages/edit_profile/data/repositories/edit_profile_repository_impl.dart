import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/specialty_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/edit_profile/data/data_sources/edit_profile_remote_data_source.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/edit_profile/data/models/user_profile_model.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/edit_profile/domain/entities/user_profile_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/edit_profile/domain/repositories/edit_profile_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EditProfileRepository)
class EditProfileRepositoryImpl implements EditProfileRepository {
  final EditProfileRemoteDataSource _remoteDataSource;

  EditProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<NetworkExceptions, UserProfileEntity>> getUserProfile() async {
    try {
      final model = await _remoteDataSource.getUserProfile();
      return Right(model.toEntity());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, UserProfileEntity>> updateUserProfile(
    UserProfileEntity profile,
  ) async {
    try {
      final model = await _remoteDataSource.updateUserProfile(
        UserProfileModel.fromEntity(profile),
      );
      return Right(model.toEntity());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, List<SpecialtyEntity>>> getSpecialties() async {
    try {
      final specialties = await _remoteDataSource.getSpecialties();
      return Right(specialties);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }
}
