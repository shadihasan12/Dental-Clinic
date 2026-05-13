import 'package:equatable/equatable.dart';

import 'statistics_period.dart';

/// Top-level KPI numbers shown on the cards row.
///
/// Each *trendPercent* is the relative change vs. the previous comparable
/// window (week-over-week, month-over-month, year-over-year). The sign
/// determines the up/down arrow on the UI.
class StatisticsOverview extends Equatable {
  const StatisticsOverview({
    required this.totalRevenue,
    required this.revenueTrendPercent,
    required this.totalPatients,
    required this.patientsTrendPercent,
    required this.totalAppointments,
    required this.appointmentsTrendPercent,
    required this.newPatients,
    required this.newPatientsTrendPercent,
  });

  final double totalRevenue;
  final double revenueTrendPercent;

  final int totalPatients;
  final double patientsTrendPercent;

  final int totalAppointments;
  final double appointmentsTrendPercent;

  final int newPatients;
  final double newPatientsTrendPercent;

  @override
  List<Object?> get props => [
        totalRevenue,
        revenueTrendPercent,
        totalPatients,
        patientsTrendPercent,
        totalAppointments,
        appointmentsTrendPercent,
        newPatients,
        newPatientsTrendPercent,
      ];
}

/// One bucket on the revenue trend line chart.
///
/// [label] is the short axis label ("Mon", "W1", "Jan") — the backend
/// produces this so the client doesn't have to know about locale-specific
/// date formatting for axis ticks.
class RevenueTrendPoint extends Equatable {
  const RevenueTrendPoint({
    required this.label,
    required this.value,
  });

  final String label;
  final double value;

  @override
  List<Object?> get props => [label, value];
}

/// One bar on the appointment volume chart.
class AppointmentVolumePoint extends Equatable {
  const AppointmentVolumePoint({
    required this.label,
    required this.count,
  });

  final String label;
  final int count;

  @override
  List<Object?> get props => [label, count];
}

/// Aggregate outcomes for appointments in the selected window.
class AppointmentBreakdown extends Equatable {
  const AppointmentBreakdown({
    required this.completed,
    required this.cancelled,
    required this.noShow,
    required this.upcoming,
  });

  final int completed;
  final int cancelled;
  final int noShow;
  final int upcoming;

  int get total => completed + cancelled + noShow + upcoming;

  @override
  List<Object?> get props => [completed, cancelled, noShow, upcoming];
}

/// One slice of the treatment distribution donut.
class TreatmentSlice extends Equatable {
  const TreatmentSlice({
    required this.name,
    required this.count,
    required this.revenue,
    required this.percentage,
  });

  final String name;
  final int count;
  final double revenue;

  /// Pre-computed percentage (0..100) so the UI doesn't redo the math.
  final double percentage;

  @override
  List<Object?> get props => [name, count, revenue, percentage];
}

/// One row in the "Top Treatments" leaderboard.
class TopTreatment extends Equatable {
  const TopTreatment({
    required this.name,
    required this.count,
    required this.revenue,
  });

  final String name;
  final int count;
  final double revenue;

  @override
  List<Object?> get props => [name, count, revenue];
}

/// A full statistics snapshot for one period.
///
/// The page makes a single request per period change and renders all
/// charts off this snapshot. Keeping it as one entity keeps the bloc
/// simple and avoids spinner-per-card noise.
class StatisticsSnapshot extends Equatable {
  const StatisticsSnapshot({
    required this.period,
    required this.rangeStart,
    required this.rangeEnd,
    required this.currency,
    required this.overview,
    required this.revenueTrend,
    required this.appointmentVolume,
    required this.appointmentBreakdown,
    required this.treatmentDistribution,
    required this.topTreatments,
  });

  final StatisticsPeriod period;
  final DateTime rangeStart;
  final DateTime rangeEnd;
  final String currency;
  final StatisticsOverview overview;
  final List<RevenueTrendPoint> revenueTrend;
  final List<AppointmentVolumePoint> appointmentVolume;
  final AppointmentBreakdown appointmentBreakdown;
  final List<TreatmentSlice> treatmentDistribution;
  final List<TopTreatment> topTreatments;

  @override
  List<Object?> get props => [
        period,
        rangeStart,
        rangeEnd,
        currency,
        overview,
        revenueTrend,
        appointmentVolume,
        appointmentBreakdown,
        treatmentDistribution,
        topTreatments,
      ];
}
