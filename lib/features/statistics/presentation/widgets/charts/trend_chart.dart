import 'dart:math' as math;

import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/entities/statistic_result.dart';
import '../statistics_palette.dart';
import 'chart_support.dart';

/// Area chart — a single filled trend line (e.g. patient acquisition).
class AreaChart extends StatelessWidget {
  const AreaChart({super.key, required this.result});

  final StatisticResult result;

  @override
  Widget build(BuildContext context) {
    final series = LabelledSeries.tryParse(result.data);
    if (series == null || series.isEmpty) {
      return ChartMessage(
        icon: Icons.show_chart_rounded,
        text: 'No data for this period',
      );
    }
    return _LineChartBody(
      labels: series.labels,
      series: [(name: '', values: series.values)],
      filled: true,
    );
  }
}

/// Dual (or multi) line chart — revenue vs. expenses and similar.
///
/// The payload shape isn't fully specified, so we parse defensively:
/// `labels` is the x-axis and every *other* list-valued key becomes a
/// series. That tolerates both `{labels, revenue, expenses}` and
/// `{labels, values}`.
class DualLineChart extends StatelessWidget {
  const DualLineChart({super.key, required this.result});

  final StatisticResult result;

  @override
  Widget build(BuildContext context) {
    final parsed = _parse(result.data);
    if (parsed == null || parsed.series.isEmpty) {
      return ChartMessage(
        icon: Icons.stacked_line_chart_rounded,
        text: 'No data for this period',
      );
    }
    return _LineChartBody(
      labels: parsed.labels,
      series: parsed.series,
      filled: false,
      showLegend: parsed.series.length > 1,
    );
  }

  static ({
    List<String> labels,
    List<({String name, List<double> values})> series
  })? _parse(Object? data) {
    if (data is! Map) return null;
    final rawLabels = data['labels'];
    if (rawLabels is! List) return null;
    final labels = [for (final l in rawLabels) (l ?? '').toString()];
    final series = <({String name, List<double> values})>[];
    data.forEach((key, value) {
      if (key == 'labels') return;
      if (value is List) {
        series.add((
          name: LabelledSeries.prettyLabel(key.toString()),
          values: [for (final v in value) LabelledSeries.toDouble(v)],
        ));
      }
    });
    if (series.isEmpty) return null;
    return (labels: labels, series: series);
  }
}

/// Shared fl_chart LineChart renderer for area + multi-line.
class _LineChartBody extends StatelessWidget {
  const _LineChartBody({
    required this.labels,
    required this.series,
    required this.filled,
    this.showLegend = false,
  });

  final List<String> labels;
  final List<({String name, List<double> values})> series;
  final bool filled;
  final bool showLegend;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);

    double maxY = 0;
    for (final s in series) {
      for (final v in s.values) {
        maxY = math.max(maxY, v);
      }
    }
    if (maxY == 0) maxY = 1;
    final chartMaxY = maxY * 1.25;
    final pointCount =
        series.isEmpty ? 0 : series.first.values.length;
    final labelStride = pointCount > 7 ? (pointCount / 6).ceil() : 1;

    return Column(
      children: [
        SizedBox(
          height: 190.h,
          child: LineChart(
            LineChartData(
              minY: 0,
              maxY: chartMaxY,
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: chartMaxY / 4,
                getDrawingHorizontalLine: (_) =>
                    FlLine(color: c.borderLight, strokeWidth: 1),
              ),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 38.w,
                    interval: chartMaxY / 4,
                    getTitlesWidget: (value, _) => Text(
                      ChartFormat.compact(value),
                      style:
                          TextStyle(fontSize: 9.sp, color: c.textTertiary),
                    ),
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 26.h,
                    getTitlesWidget: (value, _) {
                      final i = value.toInt();
                      if (i < 0 ||
                          i >= labels.length ||
                          i % labelStride != 0) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: EdgeInsets.only(top: 6.h),
                        child: Text(
                          labels[i],
                          style: TextStyle(
                              fontSize: 9.sp, color: c.textTertiary),
                        ),
                      );
                    },
                  ),
                ),
              ),
              lineBarsData: [
                for (var s = 0; s < series.length; s++)
                  LineChartBarData(
                    isCurved: true,
                    curveSmoothness: 0.3,
                    color: StatisticsPalette.colorAt(s),
                    barWidth: 3,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: filled,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          StatisticsPalette.colorAt(s)
                              .withValues(alpha: 0.28),
                          StatisticsPalette.colorAt(s)
                              .withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                    spots: [
                      for (var i = 0; i < series[s].values.length; i++)
                        FlSpot(i.toDouble(), series[s].values[i]),
                    ],
                  ),
              ],
            ),
          ),
        ),
        if (showLegend) ...[
          SizedBox(height: 12.h),
          Wrap(
            spacing: 16.w,
            runSpacing: 6.h,
            children: [
              for (var s = 0; s < series.length; s++)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 10.w,
                      height: 10.w,
                      decoration: BoxDecoration(
                        color: StatisticsPalette.colorAt(s),
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      series[s].name,
                      style: TextStyle(
                        fontFamily: FontHelper.fontFamily(context),
                        fontSize: 11.sp,
                        color: c.textSecondary,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ],
    );
  }
}
