import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/data/endpoints/working_hours_endpoints.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/data/models/working_hours_models.dart';
import 'package:injectable/injectable.dart';

abstract class WorkingHoursRemoteDataSource {
  Future<List<WorkingDayApiModel>> getWorkingDays();
  Future<void> upsertWorkingDays(List<WorkingDayApiModel> days);
  Future<List<HolidayApiModel>> getHolidays();
  Future<void> upsertHolidays(List<HolidayApiModel> holidays);
}

@Injectable(as: WorkingHoursRemoteDataSource)
class WorkingHoursRemoteDataSourceImpl implements WorkingHoursRemoteDataSource {
  final ApiConsumer _apiConsumer;

  WorkingHoursRemoteDataSourceImpl(this._apiConsumer);

  @override
  Future<List<WorkingDayApiModel>> getWorkingDays() async {
    final response = await _apiConsumer.get(
      WorkingHoursEndpoints.workingDays,
    );
    final data = response['data'] as List;
    return data
        .map((e) => WorkingDayApiModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> upsertWorkingDays(List<WorkingDayApiModel> days) async {
    await _apiConsumer.post(
      WorkingHoursEndpoints.upsertWorkingDays,
      body: {'days': days.map((d) => d.toJson()).toList()},
    );
  }

  @override
  Future<List<HolidayApiModel>> getHolidays() async {
    final response = await _apiConsumer.get(
      WorkingHoursEndpoints.holidays,
    );
    final data = response['data'] as List;
    return data
        .map((e) => HolidayApiModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> upsertHolidays(List<HolidayApiModel> holidays) async {
    await _apiConsumer.post(
      WorkingHoursEndpoints.upsertHolidays,
      body: {'holidays': holidays.map((h) => h.toJson()).toList()},
    );
  }
}
