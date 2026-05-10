import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/data/models/working_days_models.dart';

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
      clinicWorkingDayId:
          (json['clinic_working_day_id'] ?? '').toString(),
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
