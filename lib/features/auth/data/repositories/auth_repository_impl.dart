import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/network/network_info.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/specialty_entity.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/location_entity.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/plan_entity.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/register_response_entity.dart';
import 'package:dental_clinic_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dental_clinic_app/features/auth/data/datasources/remote/auth_remote_data_source.dart';

/// Implementation of AuthRepository with network connectivity check
@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  AuthRepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<NetworkExceptions, List<SpecialtyEntity>>> getSpecialties() async {
    if (await _networkInfo.isConnected) {
      try {
        final models = await _remoteDataSource.getSpecialties();
        final entities = models.map((model) => model.toEntity()).toList();
        return Right(entities);
      } on NetworkExceptions catch (e) {
        return Left(e);
      } catch (e) {
        return const Left(NetworkExceptions.unexpectedError());
      }
    } else {
      return const Left(NetworkExceptions.noInternetConnection());
    }
  }

  @override
  Future<Either<NetworkExceptions, List<LocationEntity>>> searchLocations({
    required String query,
    required String countryCode,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final models = await _remoteDataSource.searchLocations(
          query,
          countryCode,
        );
        final entities = models.map((model) => model.toEntity()).toList();
        return Right(entities);
      } on NetworkExceptions catch (e) {
        return Left(e);
      } catch (e) {
        return const Left(NetworkExceptions.unexpectedError());
      }
    } else {
      return const Left(NetworkExceptions.noInternetConnection());
    }
  }

  @override
  Future<Either<NetworkExceptions, List<PlanEntity>>> getPlans() async {
    if (await _networkInfo.isConnected) {
      try {
        final models = await _remoteDataSource.getPlans();
        final entities = models.map((model) => model.toEntity()).toList();
        return Right(entities);
      } on NetworkExceptions catch (e) {
        return Left(e);
      } catch (e) {
        return const Left(NetworkExceptions.unexpectedError());
      }
    } else {
      return const Left(NetworkExceptions.noInternetConnection());
    }
  }

  @override
  Future<Either<NetworkExceptions, OtpResponse>> requestOtpForRegister({
    required RequestOtpParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.requestOtpForRegister(params.toJson());
        return Right(response);
      } on NetworkExceptions catch (e) {
        return Left(e);
      } catch (e) {
        return const Left(NetworkExceptions.unexpectedError());
      }
    } else {
      return const Left(NetworkExceptions.noInternetConnection());
    }
  }

  @override
  Future<Either<NetworkExceptions, VerifyOtpResponse>> verifyOtp({
    required VerifyOtpParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.verifyOtp(params.toJson());
        return Right(response);
      } on NetworkExceptions catch (e) {
        return Left(e);
      } catch (e) {
        return const Left(NetworkExceptions.unexpectedError());
      }
    } else {
      return const Left(NetworkExceptions.noInternetConnection());
    }
  }

  @override
  Future<Either<NetworkExceptions, OtpResponse>> resendOtp({
    required RequestOtpParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.resendOtp(params.toJson());
        return Right(response);
      } on NetworkExceptions catch (e) {
        return Left(e);
      } catch (e) {
        return const Left(NetworkExceptions.unexpectedError());
      }
    } else {
      return const Left(NetworkExceptions.noInternetConnection());
    }
  }

  @override
  Future<Either<NetworkExceptions, RegisterResponseEntity>> register({
    required RegisterRequestParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final requestBody = params.toJson();
        final model = await _remoteDataSource.register(requestBody);
        final entity = model.toEntity();
        return Right(entity);
      } on NetworkExceptions catch (e) {
        return Left(e);
      } catch (e) {
        return const Left(NetworkExceptions.unexpectedError());
      }
    } else {
      return const Left(NetworkExceptions.noInternetConnection());
    }
  }

  @override
  Future<Either<NetworkExceptions, LoginResult>> login({
    required LoginParams params,
  }) async {
    debugPrint('[LoginRepo] Login requested — no internet: ${!await _networkInfo.isConnected}');
    if (await _networkInfo.isConnected) {
      try {
        final model = await _remoteDataSource.login(params.toJson());
        final result = LoginResult(
          user: model.toUserEntity(),
          memberships: model.toMemberships(),
          emailVerified: model.emailVerified,
        );
        debugPrint('[LoginRepo] ✓ Success — user: ${result.user.name}, memberships: ${result.memberships.length}');
        return Right(result);
      } on NetworkExceptions catch (e) {
        debugPrint('[LoginRepo] ✗ NetworkException: ${NetworkExceptions.getErrorMessage(e)}');
        return Left(e);
      } catch (e) {
        debugPrint('[LoginRepo] ✗ Unexpected error: $e');
        return const Left(NetworkExceptions.unexpectedError());
      }
    } else {
      debugPrint('[LoginRepo] ✗ No internet connection');
      return const Left(NetworkExceptions.noInternetConnection());
    }
  }

  @override
  Future<Either<NetworkExceptions, OtpResponse>> requestOtpForVerifyEmail() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.requestOtpForVerifyEmail();
        return Right(response);
      } on NetworkExceptions catch (e) {
        return Left(e);
      } catch (e) {
        return const Left(NetworkExceptions.unexpectedError());
      }
    }
    return const Left(NetworkExceptions.noInternetConnection());
  }

  @override
  Future<Either<NetworkExceptions, OtpResponse>> requestOtpForResetPassword({
    required RequestOtpParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.requestOtpForResetPassword(params.toJson());
        return Right(response);
      } on NetworkExceptions catch (e) {
        return Left(e);
      } catch (e) {
        return const Left(NetworkExceptions.unexpectedError());
      }
    } else {
      return const Left(NetworkExceptions.noInternetConnection());
    }
  }

  @override
  Future<Either<NetworkExceptions, void>> resetPassword({
    required ResetPasswordParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.resetPassword(params.toJson());
        return const Right(null);
      } on NetworkExceptions catch (e) {
        return Left(e);
      } catch (e) {
        return const Left(NetworkExceptions.unexpectedError());
      }
    } else {
      return const Left(NetworkExceptions.noInternetConnection());
    }
  }
}
