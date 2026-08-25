import '../../domain/entities/statistic_result.dart';
import '../bloc/statistics_dashboard_bloc.dart';
import '../widgets/charts/chart_support.dart';

/// The figures the share card renders, distilled from the dynamic
/// statistics dashboard.
///
/// Built from whatever the dashboard has *already fetched* — no extra
/// network call. Any metric that isn't loaded (or that the server
/// doesn't expose) simply leaves its slot null and the card shows a
/// dash. Deliberately volume / outcome only: no revenue, profit or
/// expense figures ever reach the shareable image.
class ShareStatistics {
  const ShareStatistics({
    required this.startDate,
    required this.endDate,
    this.visits,
    this.newPatients,
    this.completedCases,
    this.completionRate,
    this.topTreatmentName,
    this.topTreatmentCount,
  });

  final DateTime startDate;
  final DateTime endDate;

  /// Hero number — total appointments in the period.
  final int? visits;

  /// New patients acquired in the period.
  final int? newPatients;

  /// Medical cases marked completed.
  final int? completedCases;

  /// Share of appointments completed, 0..1.
  final double? completionRate;

  /// Most-requested treatment of the period.
  final String? topTreatmentName;
  final int? topTreatmentCount;

  // Metric keys pulled from the catalog — non-financial by design.
  static const _kVisits = 'total_appointments_kpi';
  static const _kStatusBreakdown = 'appointment_status_breakdown';
  static const _kAcquisition = 'patient_acquisition_rate';
  static const _kCasesRatio = 'medical_cases_status_ratio';
  static const _kTopTreatments = 'top_requested_treatments';

  /// Distills a [ShareStatistics] from the dashboard's current state.
  factory ShareStatistics.fromDashboard(StatisticsDashboardState state) {
    StatisticResult? resultOf(String key) => state.results[key]?.result;

    // Hero — total appointments KPI.
    final visits = _kpiInt(resultOf(_kVisits));

    // Completion rate from the appointment-status donut.
    double? completionRate;
    final breakdown =
        LabelledSeries.tryParse(resultOf(_kStatusBreakdown)?.data);
    if (breakdown != null && !breakdown.isEmpty && breakdown.total > 0) {
      final completed = _valueForLabel(breakdown, 'complet');
      if (completed != null) {
        completionRate = (completed / breakdown.total).clamp(0.0, 1.0);
      }
    }

    // New patients — sum of the acquisition area series.
    int? newPatients;
    final acquisition =
        LabelledSeries.tryParse(resultOf(_kAcquisition)?.data);
    if (acquisition != null && !acquisition.isEmpty) {
      newPatients = acquisition.total.round();
    }

    // Completed medical cases from the cases-status pie.
    int? completedCases;
    final cases = LabelledSeries.tryParse(resultOf(_kCasesRatio)?.data);
    if (cases != null && !cases.isEmpty) {
      final v = _valueForLabel(cases, 'complet');
      if (v != null) completedCases = v.round();
    }

    // Featured treatment — first ranked entry.
    String? topName;
    int? topCount;
    final top = LabelledSeries.tryParse(resultOf(_kTopTreatments)?.data);
    if (top != null && top.labels.isNotEmpty) {
      topName = LabelledSeries.prettyLabel(top.labels.first);
      topCount = top.values.first.round();
    }

    return ShareStatistics(
      startDate: state.startDate,
      endDate: state.endDate,
      visits: visits,
      newPatients: newPatients,
      completedCases: completedCases,
      completionRate: completionRate,
      topTreatmentName: topName,
      topTreatmentCount: topCount,
    );
  }

  /// Defensive integer extraction for a KPI metric — the exact payload
  /// keys aren't pinned server-side, so try `data` then `meta`.
  static int? _kpiInt(StatisticResult? r) {
    if (r == null) return null;
    final sources = <Map<String, dynamic>>[r.dataMap, r.meta];
    for (final src in sources) {
      for (final k in const [
        'value',
        'current',
        'current_value',
        'total',
        'amount',
        'count',
      ]) {
        final v = src[k];
        if (v is num) return v.round();
        if (v is String) {
          final p = double.tryParse(v);
          if (p != null) return p.round();
        }
      }
    }
    return null;
  }

  /// First value whose label contains [needle] (case-insensitive) —
  /// tolerates `COMPLETED`, `Completed`, `completed_or_archived`, …
  static double? _valueForLabel(LabelledSeries s, String needle) {
    for (var i = 0; i < s.labels.length; i++) {
      if (s.labels[i].toLowerCase().contains(needle)) return s.values[i];
    }
    return null;
  }
}
