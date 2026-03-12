import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/clinic/data/data_sources/clinic_remote_data_source.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_user_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/repositories/clinic_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ClinicRepository)
class ClinicRepositoryImpl implements ClinicRepository {
  final ClinicRemoteDataSource _remoteDataSource;

  ClinicRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<NetworkExceptions, List<ClinicMembershipEntity>>>
      getMyClinics() async {
    try {
      final models = await _remoteDataSource.getMyClinics();
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, List<ClinicUserEntity>>> getClinicUsers(
      String clinicId) async {
    try {
      final models = await _remoteDataSource.getClinicUsers(clinicId);
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, ClinicUserEntity>> addClinicUser({
    required String clinicId,
    required String firstName,
    required String lastName,
    required String email,
    required String mobileNumber,
    required String password,
    required String passwordConfirmation,
    required List<String> roles,
    String? specialtyId,
  }) async {
    try {
      final model = await _remoteDataSource.addClinicUser(
        clinicId: clinicId,
        firstName: firstName,
        lastName: lastName,
        email: email,
        mobileNumber: mobileNumber,
        password: password,
        passwordConfirmation: passwordConfirmation,
        roles: roles,
        specialtyId: specialtyId,
      );
      return Right(model.toEntity());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, void>> updateUserRoles({
    required String clinicId,
    required String userId,
    required List<String> roles,
  }) async {
    try {
      await _remoteDataSource.updateUserRoles(
        clinicId: clinicId,
        userId: userId,
        roles: roles,
      );
      return const Right(null);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, void>> removeClinicUser({
    required String clinicId,
    required String userId,
  }) async {
    try {
      await _remoteDataSource.removeClinicUser(
        clinicId: clinicId,
        userId: userId,
      );
      return const Right(null);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }
}
