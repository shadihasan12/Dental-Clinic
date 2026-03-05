import 'package:flutter/material.dart';

class WorkingShift {
  TimeOfDay from;
  TimeOfDay to;

  WorkingShift({required this.from, required this.to});
}

class WorkingDay {
  final String id;
  final int dayOfWeek; // 1=Monday ... 7=Sunday
  bool enabled;
  List<WorkingShift> shifts;

  WorkingDay({
    required this.id,
    required this.dayOfWeek,
    required this.enabled,
    required this.shifts,
  });

  static const _dayLabelsEn = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  static const _dayLabelsAr = [
    'الاثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
    'السبت',
    'الأحد',
  ];

  String get labelEn => _dayLabelsEn[dayOfWeek - 1];
  String get labelAr => _dayLabelsAr[dayOfWeek - 1];
}

class HolidayEntry {
  String? id;
  String name;
  DateTime date;
  bool recurring;

  HolidayEntry({
    this.id,
    required this.name,
    required this.date,
    required this.recurring,
  });
}
