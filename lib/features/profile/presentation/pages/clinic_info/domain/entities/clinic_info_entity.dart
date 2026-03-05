import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinic_info_entity.freezed.dart';

@freezed
class ClinicInfoEntity with _$ClinicInfoEntity {
  const factory ClinicInfoEntity({
    required String id,
    required String name,
    @Default('') String locationId,
    @Default('') String locationName,
    @Default('') String locationFullName,
    @Default('') String address,
    required List<WorkingDayEntity> workingDays,
    @Default([]) List<HolidayEntity> holidays,
  }) = _ClinicInfoEntity;
}

class WorkingDayEntity {
  final String key;
  final String labelEn;
  final String labelAr;
  final bool enabled;
  final List<ShiftEntity> shifts;

  const WorkingDayEntity({
    required this.key,
    required this.labelEn,
    required this.labelAr,
    required this.enabled,
    required this.shifts,
  });
}

class ShiftEntity {
  final int fromHour;
  final int fromMinute;
  final int toHour;
  final int toMinute;

  const ShiftEntity({
    required this.fromHour,
    required this.fromMinute,
    required this.toHour,
    required this.toMinute,
  });
}

class HolidayEntity {
  final String? id;
  final String name;
  final DateTime date;
  final bool recurring;

  const HolidayEntity({
    this.id,
    required this.name,
    required this.date,
    required this.recurring,
  });
}
