import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/statistics_entities.dart';
import 'statistics_palette.dart';

class RevenueLineChart extends StatelessWidget {
  const RevenueLineChart({
    super.key,
    required this.points,
    required this.currency,
  });

  final List<RevenueTrendPoint> points;
  final String currency;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    if (points.isEmpty) {
      return SizedBox(
        height: 180.h,
        child: Center(
          child: Text(
            'No data',
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 13.sp,
              color: c.textTertiary,
            ),
          ),
        ),
      );
    }

    final spots = <FlSpot>[];
    for (var i = 0; i < points.length; i++) {
      spots.add(FlSpot(i.toDouble(), points[i].value));
    }
    final maxY = points.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    final minY = points.map((e) => e.value).reduce((a, b) => a < b ? a : b);
    final padding = (maxY - minY) * 0.15;
    final chartMaxY = maxY + padding;
    final chartMinY = (minY - padding).clamp(0, double.infinity).toDouble();
    final interval = ((chartMaxY - chartMinY) / 4).clamp(1, double.infinity);

    return SizedBox(
      height: 200.h,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: (points.length - 1).toDouble(),
          minY: chartMinY,
          maxY: chartMaxY,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: interval.toDouble(),
            getDrawingHorizontalLine: (_) => FlLine(
              color: c.borderLight,
              strokeWidth: 1,
              dashArray: const [4, 4],
            ),
          ),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 38.w,
                interval: interval.toDouble(),
                getTitlesWidget: (value, _) => Padding(
                  padding: EdgeInsets.only(right: 6.w),
                  child: Text(
                    StatisticsFormat.money(value, currency),
                    style: TextStyle(
                      fontFamily: FontHelper.fontFamily(context),
                      fontSize: 10.sp,
                      color: c.textTertiary,
                    ),
                  ),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 22.h,
                interval: 1,
                getTitlesWidget: (value, _) {
                  final i = value.toInt();
                  if (i < 0 || i >= points.length) return const SizedBox();
                  // For longer series, only show every other label.
                  if (points.length > 8 && i.isOdd) return const SizedBox();
                  return Padding(
                    padding: EdgeInsets.only(top: 6.h),
                    child: Text(
                      points[i].label,
                      style: TextStyle(
                        fontFamily: FontHelper.fontFamily(context),
                        fontSize: 10.sp,
                        color: c.textTertiary,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (_) => c.textPrimary,
              tooltipBorder: BorderSide.none,
              tooltipRoundedRadius: 8,
              tooltipPadding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 6.h,
              ),
              getTooltipItems: (touched) => touched
                  .map((s) => LineTooltipItem(
                        '${points[s.x.toInt()].label}\n',
                        TextStyle(
                          fontFamily: FontHelper.fontFamily(context),
                          fontSize: 10.sp,
                          color: c.cardBg.withValues(alpha: 0.7),
                        ),
                        children: [
                          TextSpan(
                            text: StatisticsFormat.moneyFull(
                              s.y,
                              currency,
                            ),
                            style: TextStyle(
                              fontFamily: FontHelper.fontFamily(context),
                              fontSize: 12.sp,
                              color: c.cardBg,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ))
                  .toList(),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              curveSmoothness: 0.3,
              color: ColorManager.primary,
              barWidth: 2.5,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
                  radius: 3,
                  color: c.cardBg,
                  strokeWidth: 2,
                  strokeColor: ColorManager.primary,
                ),
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    ColorManager.primary.withValues(alpha: 0.25),
                    ColorManager.primary.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
