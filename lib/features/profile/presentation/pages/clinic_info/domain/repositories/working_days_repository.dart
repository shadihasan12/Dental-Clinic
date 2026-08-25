import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/data/models/user_hours_models.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/data/models/working_days_models.dart';

abstract class WorkingDaysRepository {
  Future<Either<NetworkExceptions, List<WorkingDayApiModel>>> getWorkingDays();
  Future<Either<NetworkExceptions, void>> upsertWorkingDays(
    List<WorkingDayApiModel> days,
  );
  Future<Either<NetworkExceptions, List<HolidayApiModel>>> getHolidays();
  Future<Either<NetworkExceptions, void>> upsertHolidays(
    List<HolidayApiModel> holidays,
  );
  Future<Either<NetworkExceptions, List<UserWorkingDayApiModel>>> getMyHours();
  Future<Either<NetworkExceptions, void>> upsertUserHours(
    String userId,
    List<UserWorkingDayApiModel> days,
  );
}
