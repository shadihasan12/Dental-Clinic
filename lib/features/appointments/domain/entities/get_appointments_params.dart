/// Date range for fetching appointments. `from == to` means a single day.
class GetAppointmentsParams {
  final DateTime from;
  final DateTime to;

  const GetAppointmentsParams({required this.from, required this.to});

  factory GetAppointmentsParams.day(DateTime date) =>
      GetAppointmentsParams(from: date, to: date);

  /// Calendar week (Mon → Sun) containing [date].
  factory GetAppointmentsParams.weekContaining(DateTime date) {
    final start = DateTime(date.year, date.month, date.day)
        .subtract(Duration(days: date.weekday - 1));
    final end = start.add(const Duration(days: 6));
    return GetAppointmentsParams(from: start, to: end);
  }

  bool get isSingleDay =>
      from.year == to.year && from.month == to.month && from.day == to.day;
}
