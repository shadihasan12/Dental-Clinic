import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/data/endpoints/working_days_endpoints.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/data/models/user_hours_models.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/data/models/working_days_models.dart';
import 'package:injectable/injectable.dart';

abstract class WorkingDaysRemoteDataSource {
  Future<List<WorkingDayApiModel>> getWorkingDays();
  Future<void> upsertWorkingDays(List<WorkingDayApiModel> days);
  Future<List<HolidayApiModel>> getHolidays();
  Future<void> upsertHolidays(List<HolidayApiModel> holidays);

  /// Reads the *current* user's working hours via the token-derived
  /// `/clinics/users/my-hours` endpoint. The server picks the user
  /// from the bearer token and the selected clinic from the
  /// X-Selected-Clinic-id header — both auto-injected by the auth
  /// interceptor — so no path params are required.
  Future<List<UserWorkingDayApiModel>> getMyHours();

  /// Reads one specific member's hours. The admin screens manage other
  /// people's schedules, so they cannot use [getMyHours] - that endpoint
  /// resolves the user from the bearer token and would hand back the
  /// *admin's* hours no matter whose page was open.
  Future<List<UserWorkingDayApiModel>> getUserHours(String userId);

  Future<void> upsertUserHours(
    String userId,
    List<UserWorkingDayApiModel> days,
  );
}

@Injectable(as: WorkingDaysRemoteDataSource)
class WorkingDaysRemoteDataSourceImpl implements WorkingDaysRemoteDataSource {
  final ApiConsumer _apiConsumer;

  WorkingDaysRemoteDataSourceImpl(this._apiConsumer);

  @override
  Future<List<WorkingDayApiModel>> getWorkingDays() async {
    final response = await _apiConsumer.get(WorkingDaysEndpoints.workingDays);
    // Tolerate either `{ "data": [...] }` or `{ "data": { "days": [...] } }`.
    final raw = response['data'];
    final List rawDays;
    if (raw is List) {
      rawDays = raw;
    } else if (raw is Map<String, dynamic>) {
      rawDays = (raw['days'] as List?) ?? const [];
    } else {
      rawDays = const [];
    }
    return rawDays
        .map((e) => WorkingDayApiModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> upsertWorkingDays(List<WorkingDayApiModel> days) async {
    await _apiConsumer.post(
      WorkingDaysEndpoints.upsertWorkingDays,
      body: {'days': days.map((d) => d.toJson()).toList()},
    );
  }

  @override
  Future<List<HolidayApiModel>> getHolidays() async {
    final response = await _apiConsumer.get(WorkingDaysEndpoints.holidays);
    final data = response['data'] as List;
    return data
        .map((e) => HolidayApiModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> upsertHolidays(List<HolidayApiModel> holidays) async {
    await _apiConsumer.post(
      WorkingDaysEndpoints.upsertHolidays,
      body: {'holidays': holidays.map((h) => h.toJson()).toList()},
    );
  }

  @override
  Future<List<UserWorkingDayApiModel>> getMyHours() async {
    final response = await _apiConsumer.get(WorkingDaysEndpoints.myHours);
    return _parseUserDays(response);
  }

  /// Tolerates either `{ "data": [...] }` or `{ "data": { "days": [...] } }`,
  /// the same two shapes the clinic working-days endpoint returns.
  List<UserWorkingDayApiModel> _parseUserDays(dynamic response) {
    final raw = response is Map ? response['data'] : null;
    final List rawDays;
    if (raw is List) {
      rawDays = raw;
    } else if (raw is Map) {
      rawDays = (raw['days'] as List?) ?? const [];
    } else {
      rawDays = const [];
    }
    return rawDays
        .whereType<Map>()
        .map(
          (e) => UserWorkingDayApiModel.fromJson(Map<String, dynamic>.from(e)),
        )
        .toList();
  }

  @override
  Future<List<UserWorkingDayApiModel>> getUserHours(String userId) async {
    final response = await _apiConsumer.get(
      WorkingDaysEndpoints.userHours(userId),
    );
    return _parseUserDays(response);
  }

  @override
  Future<void> upsertUserHours(
    String userId,
    List<UserWorkingDayApiModel> days,
  ) async {
    await _apiConsumer.post(
      WorkingDaysEndpoints.userHours(userId),
      body: {'days': days.map((d) => d.toJson()).toList()},
    );
  }
}
