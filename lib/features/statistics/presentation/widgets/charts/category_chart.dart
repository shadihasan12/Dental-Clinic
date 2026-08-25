import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/entities/statistic_result.dart';
import '../statistics_palette.dart';
import 'chart_support.dart';

/// Donut / pie chart — both share the `{labels, values}` shape; the
/// only difference is the centre hole radius.
class DonutPieChart extends StatelessWidget {
  const DonutPieChart({super.key, required this.result, required this.isDonut});

  final StatisticResult result;
  final bool isDonut;

  @override
  Widget build(BuildContext context) {
    final series = LabelledSeries.tryParse(result.data);
    if (series == null || series.isEmpty) {
      return ChartMessage(
        icon: Icons.donut_large_outlined,
        text: 'No data for this period',
      );
    }
    if (series.allZero) {
      return ChartMessage(
        icon: Icons.donut_large_outlined,
        text: 'Nothing recorded yet',
      );
    }

    final total = series.total;
    return Column(
      children: [
        SizedBox(
          height: 170.h,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: isDonut ? 46.r : 0,
              sections: [
                for (var i = 0; i < series.values.length; i++)
                  PieChartSectionData(
                    value: series.values[i],
                    color: StatisticsPalette.colorAt(i),
                    radius: 58.r,
                    title: total == 0
                        ? ''
                        : '${(series.values[i] / total * 100).round()}%',
                    titleStyle: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontFamily: FontHelper.fontFamily(context),
                    ),
                  ),
              ],
            ),
          ),
        ),
        SizedBox(height: 14.h),
        _Legend(series: series),
      ],
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.series});
  final LabelledSeries series;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Wrap(
      spacing: 14.w,
      runSpacing: 8.h,
      children: [
        for (var i = 0; i < series.labels.length; i++)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 10.w,
                height: 10.w,
                decoration: BoxDecoration(
                  color: StatisticsPalette.colorAt(i),
                  borderRadius: BorderRadius.circular(3.r),
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                '${LabelledSeries.prettyLabel(series.labels[i])} '
                '· ${ChartFormat.compact(series.values[i])}',
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 11.sp,
                  color: c.textSecondary,
                ),
              ),
            ],
          ),
      ],
    );
  }
}

/// Vertical bar chart for category comparisons (e.g. revenue per
/// doctor).
class VerticalBarChart extends StatelessWidget {
  const VerticalBarChart({super.key, required this.result});

  final StatisticResult result;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final series = LabelledSeries.tryParse(result.data);
    if (series == null || series.isEmpty) {
      return ChartMessage(
        icon: Icons.bar_chart_rounded,
        text: 'No data for this period',
      );
    }

    final maxY = series.maxValue == 0 ? 1.0 : series.maxValue * 1.25;
    return SizedBox(
      height: 200.h,
      child: BarChart(
        BarChartData(
          maxY: maxY,
          alignment: BarChartAlignment.spaceAround,
          borderData: FlBorderData(show: false),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: maxY / 4,
            getDrawingHorizontalLine: (_) =>
                FlLine(color: c.borderLight, strokeWidth: 1),
          ),
          titlesData: FlTitlesData(
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 38.w,
                interval: maxY / 4,
                getTitlesWidget: (value, _) => Text(
                  ChartFormat.compact(value),
                  style: TextStyle(fontSize: 9.sp, color: c.textTertiary),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30.h,
                getTitlesWidget: (value, _) {
                  final i = value.toInt();
                  if (i < 0 || i >= series.labels.length) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: EdgeInsets.only(top: 6.h),
                    child: Text(
                      LabelledSeries.prettyLabel(series.labels[i]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 9.sp, color: c.textTertiary),
                    ),
                  );
                },
              ),
            ),
          ),
          barGroups: [
            for (var i = 0; i < series.values.length; i++)
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: series.values[i],
                    color: StatisticsPalette.colorAt(i),
                    width: 16.w,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(4.r),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

/// Horizontal ranked bars — better than a rotated fl_chart bar chart
/// for long category labels (treatments, doctor names).
class HorizontalBarChart extends StatelessWidget {
  const HorizontalBarChart({super.key, required this.result});

  final StatisticResult result;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final series = LabelledSeries.tryParse(result.data);
    if (series == null || series.isEmpty) {
      return ChartMessage(
        icon: Icons.leaderboard_outlined,
        text: 'No data for this period',
      );
    }

    final maxValue = series.maxValue == 0 ? 1.0 : series.maxValue;
    return Column(
      children: [
        for (var i = 0; i < series.labels.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Row(
              children: [
                SizedBox(
                  width: 90.w,
                  child: Text(
                    LabelledSeries.prettyLabel(series.labels[i]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: FontHelper.fontFamily(context),
                      fontSize: 11.sp,
                      color: c.textSecondary,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.r),
                    child: LinearProgressIndicator(
                      value: series.values[i] / maxValue,
                      minHeight: 16.h,
                      backgroundColor: c.borderLight,
                      valueColor: AlwaysStoppedAnimation(
                        StatisticsPalette.colorAt(i),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                SizedBox(
                  width: 44.w,
                  child: Text(
                    ChartFormat.compact(series.values[i]),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontFamily: FontHelper.fontFamily(context),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: c.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
