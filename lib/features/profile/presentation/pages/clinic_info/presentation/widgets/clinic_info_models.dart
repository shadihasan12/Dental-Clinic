import 'package:flutter/material.dart';

class WorkingShift {
  TimeOfDay from;
  TimeOfDay to;

  WorkingShift({required this.from, required this.to});
}

class WorkingDay {
  final String key;
  final String labelEn;
  final String labelAr;
  bool enabled;
  List<WorkingShift> shifts;

  WorkingDay({
    required this.key,
    required this.labelEn,
    required this.labelAr,
    required this.enabled,
    required this.shifts,
  });
}

class HolidayEntry {
  String name;
  DateTime date;
  bool recurring;

  HolidayEntry({required this.name, required this.date, required this.recurring});
}
