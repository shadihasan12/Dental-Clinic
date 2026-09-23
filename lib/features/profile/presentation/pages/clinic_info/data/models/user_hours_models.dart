import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/data/models/working_days_models.dart';

/// A member's week in this clinic, from `GET /clinics/users/my-hours` or
/// `GET /clinics/users/{id}/hours`.
///
/// A member who has never had hours written **follows the clinic**: the
/// server sends the clinic's week as [days] with [followsClinicHours] set,
/// and changing the clinic's schedule changes theirs with it. So a full week
/// here is not necessarily a schedule they chose, and there is nothing for
/// them to "set up". Once any row of their own is written - by saving this
/// form - they stop following, and a day with no row is a day off.
class UserHoursApiModel {
  const UserHoursApiModel({
    required this.followsClinicHours,
    required this.days,
  });

  final bool followsClinicHours;
  final List<UserWorkingDayApiModel> days;

  /// Tolerates `{ "data": { "follows_clinic_hours", "days": [...] } }` and the
  /// older bare `{ "data": [...] }`.
  factory UserHoursApiModel.fromResponse(dynamic response) {
    final raw = response is Map ? response['data'] : null;
    final List rawDays;
    var follows = false;
    if (raw is List) {
      rawDays = raw;
    } else if (raw is Map) {
      rawDays = (raw['days'] as List?) ?? const [];
      follows = raw['follows_clinic_hours'] as bool? ?? false;
    } else {
      rawDays = const [];
    }
    return UserHoursApiModel(
      followsClinicHours: follows,
      days: rawDays
          .whereType<Map>()
          .map(
            (e) =>
                UserWorkingDayApiModel.fromJson(Map<String, dynamic>.from(e)),
          )
          .toList(),
    );
  }
}

class UserWorkingDayApiModel {
  final String? id;
  final String clinicWorkingDayId;
  final int dayOfWeek;
  final bool isWorking;
  final bool isFullTime;
  final List<TimeRangeModel> ranges;

  const UserWorkingDayApiModel({
    this.id,
    required this.clinicWorkingDayId,
    required this.dayOfWeek,
    required this.isWorking,
    required this.isFullTime,
    required this.ranges,
  });

  factory UserWorkingDayApiModel.fromJson(Map<String, dynamic> json) {
    final rawRanges = json['ranges'] as List? ?? const [];
    return UserWorkingDayApiModel(
      id: json['id'] as String?,
      clinicWorkingDayId: (json['clinic_working_day_id'] ?? '').toString(),
      dayOfWeek: (json['day_of_week'] as num?)?.toInt() ?? 1,
      isWorking: json['is_working'] as bool? ?? false,
      isFullTime: json['is_full_time'] as bool? ?? false,
      ranges: rawRanges
          .map((e) => TimeRangeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'clinic_working_day_id': clinicWorkingDayId,
        'day_of_week': dayOfWeek,
        'is_working': isWorking,
        'is_full_time': isFullTime,
        'ranges': ranges.map((r) => r.toJson()).toList(),
      };
}
