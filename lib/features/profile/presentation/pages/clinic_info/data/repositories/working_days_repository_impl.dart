import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/data/data_sources/working_days_remote_data_source.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/data/models/user_hours_models.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/data/models/working_days_models.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/domain/repositories/working_days_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: WorkingDaysRepository)
class WorkingDaysRepositoryImpl implements WorkingDaysRepository {
  final WorkingDaysRemoteDataSource _remoteDataSource;

  WorkingDaysRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<NetworkExceptions, List<WorkingDayApiModel>>>
      getWorkingDays() async {
    try {
      final result = await _remoteDataSource.getWorkingDays();
      return Right(result);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, void>> upsertWorkingDays(
    List<WorkingDayApiModel> days,
  ) async {
    try {
      await _remoteDataSource.upsertWorkingDays(days);
      return const Right(null);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, List<HolidayApiModel>>>
      getHolidays() async {
    try {
      final result = await _remoteDataSource.getHolidays();
      return Right(result);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, void>> upsertHolidays(
    List<HolidayApiModel> holidays,
  ) async {
    try {
      await _remoteDataSource.upsertHolidays(holidays);
      return const Right(null);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, List<UserWorkingDayApiModel>>>
      getUserHours(String userId) async {
    try {
      final result = await _remoteDataSource.getUserHours(userId);
      return Right(result);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, void>> upsertUserHours(
    String userId,
    List<UserWorkingDayApiModel> days,
  ) async {
    try {
      await _remoteDataSource.upsertUserHours(userId, days);
      return const Right(null);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }
}
