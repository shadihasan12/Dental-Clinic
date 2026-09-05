import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/domain/entities/clinic_info_entity.dart';

class ClinicInfoModel {
  final String id;
  final String name;
  final String locationId;
  final String locationName;
  final String locationFullName;
  final String address;
  final List<WorkingDayModel> workingDays;
  final List<HolidayModel> holidays;

  const ClinicInfoModel({
    required this.id,
    required this.name,
    this.locationId = '',
    this.locationName = '',
    this.locationFullName = '',
    this.address = '',
    required this.workingDays,
    required this.holidays,
  });

  factory ClinicInfoModel.fromJson(Map<String, dynamic> json) {
    return ClinicInfoModel(
      id: json['id'] as String,
      name: json['name'] as String,
      locationId: json['location_id'] as String? ?? '',
      locationName: json['location_name'] as String? ?? '',
      locationFullName: json['location_full_name'] as String? ?? '',
      address: json['address'] as String? ?? '',
      workingDays: (json['workingDays'] as List)
          .map((e) => WorkingDayModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      holidays: (json['holidays'] as List? ?? [])
          .map((e) => HolidayModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location_id': locationId,
      'location_name': locationName,
      'location_full_name': locationFullName,
      'address': address,
      'workingDays': workingDays.map((d) => d.toJson()).toList(),
      'holidays': holidays.map((h) => h.toJson()).toList(),
    };
  }

  factory ClinicInfoModel.fromEntity(ClinicInfoEntity entity) {
    return ClinicInfoModel(
      id: entity.id,
      name: entity.name,
      locationId: entity.locationId,
      locationName: entity.locationName,
      locationFullName: entity.locationFullName,
      address: entity.address,
      workingDays:
          entity.workingDays.map((d) => WorkingDayModel.fromEntity(d)).toList(),
      holidays: entity.holidays.map((h) => HolidayModel.fromEntity(h)).toList(),
    );
  }

  ClinicInfoEntity toEntity() {
    return ClinicInfoEntity(
      id: id,
      name: name,
      locationId: locationId,
      locationName: locationName,
      locationFullName: locationFullName,
      address: address,
      workingDays: workingDays.map((d) => d.toEntity()).toList(),
      holidays: holidays.map((h) => h.toEntity()).toList(),
    );
  }
}

class WorkingDayModel {
  final String key;
  final String labelEn;
  final String labelAr;
  final bool enabled;
  final List<ShiftModel> shifts;

  const WorkingDayModel({
    required this.key,
    required this.labelEn,
    required this.labelAr,
    required this.enabled,
    required this.shifts,
  });

  factory WorkingDayModel.fromJson(Map<String, dynamic> json) {
    return WorkingDayModel(
      key: json['key'] as String,
      labelEn: json['labelEn'] as String,
      labelAr: json['labelAr'] as String,
      enabled: json['enabled'] as bool,
      shifts: (json['shifts'] as List)
          .map((e) => ShiftModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'labelEn': labelEn,
      'labelAr': labelAr,
      'enabled': enabled,
      'shifts': shifts.map((s) => s.toJson()).toList(),
    };
  }

  factory WorkingDayModel.fromEntity(WorkingDayEntity entity) {
    return WorkingDayModel(
      key: entity.key,
      labelEn: entity.labelEn,
      labelAr: entity.labelAr,
      enabled: entity.enabled,
      shifts: entity.shifts.map((s) => ShiftModel.fromEntity(s)).toList(),
    );
  }

  WorkingDayEntity toEntity() {
    return WorkingDayEntity(
      key: key,
      labelEn: labelEn,
      labelAr: labelAr,
      enabled: enabled,
      shifts: shifts.map((s) => s.toEntity()).toList(),
    );
  }
}

class ShiftModel {
  final String from;
  final String to;

  const ShiftModel({required this.from, required this.to});

  factory ShiftModel.fromJson(Map<String, dynamic> json) {
    return ShiftModel(from: json['from'] as String, to: json['to'] as String);
  }

  Map<String, dynamic> toJson() => {'from': from, 'to': to};

  factory ShiftModel.fromEntity(ShiftEntity entity) {
    return ShiftModel(
      from: _timeToString(entity.fromHour, entity.fromMinute),
      to: _timeToString(entity.toHour, entity.toMinute),
    );
  }

  ShiftEntity toEntity() {
    final fromParts = _parseTime(from);
    final toParts = _parseTime(to);
    return ShiftEntity(
      fromHour: fromParts[0],
      fromMinute: fromParts[1],
      toHour: toParts[0],
      toMinute: toParts[1],
    );
  }

  static String _timeToString(int hour, int minute) {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  static List<int> _parseTime(String time) {
    final parts = time.split(':');
    return [int.parse(parts[0]), int.parse(parts[1])];
  }
}

class HolidayModel {
  final String? id;
  final String name;
  final String date;
  final bool recurring;

  const HolidayModel({
    this.id,
    required this.name,
    required this.date,
    required this.recurring,
  });

  factory HolidayModel.fromJson(Map<String, dynamic> json) {
    return HolidayModel(
      id: json['id'] as String?,
      name: json['name'] as String,
      date: json['date'] as String,
      recurring: json['recurring'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'date': date, 'recurring': recurring};
  }

  factory HolidayModel.fromEntity(HolidayEntity entity) {
    return HolidayModel(
      id: entity.id,
      name: entity.name,
      date: entity.date.toIso8601String(),
      recurring: entity.recurring,
    );
  }

  HolidayEntity toEntity() {
    return HolidayEntity(
      id: id,
      name: name,
      date: DateTime.parse(date),
      recurring: recurring,
    );
  }
}
