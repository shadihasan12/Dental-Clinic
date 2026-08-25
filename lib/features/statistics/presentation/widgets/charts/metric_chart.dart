import 'package:flutter/material.dart';

import '../../../domain/entities/statistic_metric.dart';
import '../../../domain/entities/statistic_result.dart';
import 'basic_metric_views.dart';
import 'category_chart.dart';
import 'chart_support.dart';
import 'kpi_views.dart';
import 'trend_chart.dart';

/// Dispatches a fetched [StatisticResult] to the chart widget for its
/// [StatisticMetric.type]. A new server-side type lands on [unknown]
/// and renders a graceful "unsupported" message instead of crashing.
class MetricChart extends StatelessWidget {
  const MetricChart({
    super.key,
    required this.metric,
    required this.result,
  });

  final StatisticMetric metric;
  final StatisticResult result;

  @override
  Widget build(BuildContext context) {
    switch (metric.type) {
      case StatisticChartType.kpiCard:
        return KpiCardView(result: result);
      case StatisticChartType.kpiWithList:
        return KpiWithListView(result: result);
      case StatisticChartType.donutChart:
        return DonutPieChart(result: result, isDonut: true);
      case StatisticChartType.pieChart:
        return DonutPieChart(result: result, isDonut: false);
      case StatisticChartType.barChart:
        return VerticalBarChart(result: result);
      case StatisticChartType.horizontalBarChart:
        return HorizontalBarChart(result: result);
      case StatisticChartType.areaChart:
        return AreaChart(result: result);
      case StatisticChartType.dualLineChart:
        return DualLineChart(result: result);
      case StatisticChartType.heatmap:
        return HeatmapView(result: result);
      case StatisticChartType.dentalChartHeatmap:
        return DentalHeatmapView(result: result);
      case StatisticChartType.demographicsBreakdown:
        return DemographicsView(result: result);
      case StatisticChartType.unknown:
        return const ChartMessage(
          icon: Icons.help_outline_rounded,
          text: 'This chart type isn\'t supported yet',
        );
    }
  }
}
