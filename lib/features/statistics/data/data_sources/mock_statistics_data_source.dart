import 'dart:math';

import '../../domain/entities/statistics_entities.dart';
import '../../domain/entities/statistics_period.dart';
import 'statistics_remote_data_source.dart';

/// Returns deterministic-looking mock statistics so the page is fully
/// interactive without a backend. The numbers are seeded off the period
/// so each tab feels distinct but every render is stable.
class MockStatisticsDataSource implements StatisticsRemoteDataSource {
  const MockStatisticsDataSource();

  @override
  Future<StatisticsSnapshot> getStatistics({
    required String clinicId,
    required StatisticsPeriod period,
  }) async {
    // Fake a network round-trip so the shimmer/loader is visible.
    await Future<void>.delayed(const Duration(milliseconds: 450));

    switch (period) {
      case StatisticsPeriod.week:
        return _weekSnapshot();
      case StatisticsPeriod.month:
        return _monthSnapshot();
      case StatisticsPeriod.year:
        return _yearSnapshot();
    }
  }

  // ─── Week ──────────────────────────────────────────────────────────
  StatisticsSnapshot _weekSnapshot() {
    final now = DateTime.now();
    final start = now.subtract(const Duration(days: 6));

    return StatisticsSnapshot(
      period: StatisticsPeriod.week,
      rangeStart: start,
      rangeEnd: now,
      currency: 'USD',
      overview: const StatisticsOverview(
        totalRevenue: 8420,
        revenueTrendPercent: 12.5,
        totalPatients: 64,
        patientsTrendPercent: 8.2,
        totalAppointments: 47,
        appointmentsTrendPercent: -2.1,
        newPatients: 9,
        newPatientsTrendPercent: 18.0,
      ),
      revenueTrend: const [
        RevenueTrendPoint(label: 'Mon', value: 950),
        RevenueTrendPoint(label: 'Tue', value: 1320),
        RevenueTrendPoint(label: 'Wed', value: 1100),
        RevenueTrendPoint(label: 'Thu', value: 1680),
        RevenueTrendPoint(label: 'Fri', value: 1420),
        RevenueTrendPoint(label: 'Sat', value: 1180),
        RevenueTrendPoint(label: 'Sun', value: 770),
      ],
      appointmentVolume: const [
        AppointmentVolumePoint(label: 'Mon', count: 7),
        AppointmentVolumePoint(label: 'Tue', count: 9),
        AppointmentVolumePoint(label: 'Wed', count: 6),
        AppointmentVolumePoint(label: 'Thu', count: 10),
        AppointmentVolumePoint(label: 'Fri', count: 8),
        AppointmentVolumePoint(label: 'Sat', count: 5),
        AppointmentVolumePoint(label: 'Sun', count: 2),
      ],
      appointmentBreakdown: const AppointmentBreakdown(
        completed: 36,
        cancelled: 4,
        noShow: 3,
        upcoming: 4,
      ),
      treatmentDistribution: _normalize(const [
        _RawSlice('Cleaning', 18, 1080),
        _RawSlice('Filling', 12, 1920),
        _RawSlice('Root Canal', 6, 2400),
        _RawSlice('Whitening', 8, 1600),
        _RawSlice('Other', 7, 1420),
      ]),
      topTreatments: const [
        TopTreatment(name: 'Root Canal', count: 6, revenue: 2400),
        TopTreatment(name: 'Filling', count: 12, revenue: 1920),
        TopTreatment(name: 'Whitening', count: 8, revenue: 1600),
        TopTreatment(name: 'Cleaning', count: 18, revenue: 1080),
        TopTreatment(name: 'Extraction', count: 3, revenue: 480),
      ],
    );
  }

  // ─── Month ─────────────────────────────────────────────────────────
  StatisticsSnapshot _monthSnapshot() {
    final now = DateTime.now();
    final start = now.subtract(const Duration(days: 29));

    // 30-day series modelled as 4 weekly buckets the backend would pre-
    // aggregate. Stays readable on small screens.
    final revenue = <RevenueTrendPoint>[
      const RevenueTrendPoint(label: 'W1', value: 8120),
      const RevenueTrendPoint(label: 'W2', value: 9450),
      const RevenueTrendPoint(label: 'W3', value: 11280),
      const RevenueTrendPoint(label: 'W4', value: 13130),
    ];

    return StatisticsSnapshot(
      period: StatisticsPeriod.month,
      rangeStart: start,
      rangeEnd: now,
      currency: 'USD',
      overview: const StatisticsOverview(
        totalRevenue: 41980,
        revenueTrendPercent: 14.2,
        totalPatients: 248,
        patientsTrendPercent: 6.5,
        totalAppointments: 192,
        appointmentsTrendPercent: 4.8,
        newPatients: 34,
        newPatientsTrendPercent: 22.1,
      ),
      revenueTrend: revenue,
      appointmentVolume: const [
        AppointmentVolumePoint(label: 'W1', count: 42),
        AppointmentVolumePoint(label: 'W2', count: 48),
        AppointmentVolumePoint(label: 'W3', count: 51),
        AppointmentVolumePoint(label: 'W4', count: 51),
      ],
      appointmentBreakdown: const AppointmentBreakdown(
        completed: 158,
        cancelled: 14,
        noShow: 9,
        upcoming: 11,
      ),
      treatmentDistribution: _normalize(const [
        _RawSlice('Cleaning', 76, 4560),
        _RawSlice('Filling', 52, 8320),
        _RawSlice('Root Canal', 21, 8400),
        _RawSlice('Whitening', 28, 5600),
        _RawSlice('Crown', 15, 9750),
        _RawSlice('Other', 12, 2400),
      ]),
      topTreatments: const [
        TopTreatment(name: 'Crown', count: 15, revenue: 9750),
        TopTreatment(name: 'Root Canal', count: 21, revenue: 8400),
        TopTreatment(name: 'Filling', count: 52, revenue: 8320),
        TopTreatment(name: 'Whitening', count: 28, revenue: 5600),
        TopTreatment(name: 'Cleaning', count: 76, revenue: 4560),
      ],
    );
  }

  // ─── Year ──────────────────────────────────────────────────────────
  StatisticsSnapshot _yearSnapshot() {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month - 11, 1);

    // 12 monthly buckets — feels like a real revenue arc with seasonal dip.
    const seed = 9123;
    final rng = Random(seed);
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    final revenue = <RevenueTrendPoint>[];
    final volume = <AppointmentVolumePoint>[];
    var base = 28000.0;
    for (var i = 0; i < 12; i++) {
      base += (rng.nextDouble() - 0.35) * 6000;
      revenue.add(RevenueTrendPoint(
        label: months[i],
        value: base.clamp(20000, 60000),
      ));
      volume.add(AppointmentVolumePoint(
        label: months[i],
        count: 140 + rng.nextInt(80),
      ));
    }

    final totalRevenue = revenue.fold<double>(0, (s, p) => s + p.value);

    return StatisticsSnapshot(
      period: StatisticsPeriod.year,
      rangeStart: start,
      rangeEnd: now,
      currency: 'USD',
      overview: StatisticsOverview(
        totalRevenue: totalRevenue.roundToDouble(),
        revenueTrendPercent: 23.4,
        totalPatients: 1842,
        patientsTrendPercent: 11.2,
        totalAppointments: 2310,
        appointmentsTrendPercent: 9.6,
        newPatients: 412,
        newPatientsTrendPercent: 15.8,
      ),
      revenueTrend: revenue,
      appointmentVolume: volume,
      appointmentBreakdown: const AppointmentBreakdown(
        completed: 1948,
        cancelled: 168,
        noShow: 102,
        upcoming: 92,
      ),
      treatmentDistribution: _normalize(const [
        _RawSlice('Cleaning', 642, 38520),
        _RawSlice('Filling', 481, 76960),
        _RawSlice('Root Canal', 196, 78400),
        _RawSlice('Whitening', 224, 44800),
        _RawSlice('Crown', 132, 85800),
        _RawSlice('Implant', 48, 96000),
        _RawSlice('Other', 87, 17400),
      ]),
      topTreatments: const [
        TopTreatment(name: 'Implant', count: 48, revenue: 96000),
        TopTreatment(name: 'Crown', count: 132, revenue: 85800),
        TopTreatment(name: 'Root Canal', count: 196, revenue: 78400),
        TopTreatment(name: 'Filling', count: 481, revenue: 76960),
        TopTreatment(name: 'Whitening', count: 224, revenue: 44800),
      ],
    );
  }

  /// Turns a list of raw treatment buckets into [TreatmentSlice]s with
  /// pre-computed percentages so the donut chart and legend agree.
  static List<TreatmentSlice> _normalize(List<_RawSlice> raw) {
    final total = raw.fold<int>(0, (s, r) => s + r.count);
    if (total == 0) return const [];
    return raw
        .map((r) => TreatmentSlice(
              name: r.name,
              count: r.count,
              revenue: r.revenue,
              percentage: (r.count / total) * 100,
            ))
        .toList(growable: false);
  }
}

class _RawSlice {
  const _RawSlice(this.name, this.count, this.revenue);
  final String name;
  final int count;
  final double revenue;
}
