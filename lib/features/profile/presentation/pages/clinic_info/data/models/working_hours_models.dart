class WorkingDayApiModel {
  final String id;
  final int dayOfWeek;
  final bool isOpen;
  final List<TimeRangeModel> ranges;

  const WorkingDayApiModel({
    required this.id,
    required this.dayOfWeek,
    required this.isOpen,
    required this.ranges,
  });

  factory WorkingDayApiModel.fromJson(Map<String, dynamic> json) {
    return WorkingDayApiModel(
      id: json['id'] as String,
      dayOfWeek: json['day_of_week'] as int,
      isOpen: json['is_open'] as bool,
      ranges: (json['ranges'] as List)
          .map((e) => TimeRangeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'day_of_week': dayOfWeek,
        'is_open': isOpen,
        'ranges': ranges.map((r) => r.toJson()).toList(),
      };
}

class TimeRangeModel {
  final String startTime;
  final String endTime;

  const TimeRangeModel({required this.startTime, required this.endTime});

  factory TimeRangeModel.fromJson(Map<String, dynamic> json) {
    return TimeRangeModel(
      startTime: _normalizeTime(json['start_time'] as String),
      endTime: _normalizeTime(json['end_time'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'start_time': startTime,
        'end_time': endTime,
      };

  /// API may return "09:00:00" or "09:00" — normalize to "HH:mm"
  static String _normalizeTime(String time) {
    final parts = time.split(':');
    return '${parts[0]}:${parts[1]}';
  }
}

class HolidayApiModel {
  final String? id;
  final String name;
  final String date;
  final bool isRecurring;

  const HolidayApiModel({
    this.id,
    required this.name,
    required this.date,
    required this.isRecurring,
  });

  factory HolidayApiModel.fromJson(Map<String, dynamic> json) {
    return HolidayApiModel(
      id: json['id'] as String?,
      name: json['name'] as String,
      date: json['date'] as String,
      isRecurring: json['is_recurring'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'name': name,
      'date': date,
      'is_recurring': isRecurring,
    };
    if (id != null) map['id'] = id;
    return map;
  }
}
