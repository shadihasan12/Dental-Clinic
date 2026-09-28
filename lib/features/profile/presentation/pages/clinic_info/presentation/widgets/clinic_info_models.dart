import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// `9:00 AM` in every language. Working hours are read like a sign on the
/// clinic door, and the picker wheel that sets them is English too (see
/// `EnglishPicker`), so the value shown must match what was picked rather
/// than switch to ص/م under Arabic. Render the result with
/// [TextDirection.ltr] - in an RTL paragraph the bidi algorithm would put
/// the leading digits after the AM/PM marker.
String hoursTime(TimeOfDay time) =>
    DateFormat.jm('en').format(DateTime(2000, 1, 1, time.hour, time.minute));

/// `9:00 AM – 5:00 PM`, formatted as [hoursTime].
String hoursRange(TimeOfDay from, TimeOfDay to, {String separator = ' – '}) =>
    '${hoursTime(from)}$separator${hoursTime(to)}';

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
