import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/statistic_metric.dart';
import '../bloc/statistics_dashboard_bloc.dart';
import 'charts/chart_support.dart';
import 'charts/metric_chart.dart';

/// One dashboard card: title + description, an optional inline `limit`
/// control, and the chart body that swaps between loading / error /
/// chart based on the metric's own fetch state.
class MetricCard extends StatelessWidget {
  const MetricCard({super.key, required this.metric});

  final StatisticMetric metric;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);

    return BlocBuilder<StatisticsDashboardBloc, StatisticsDashboardState>(
      buildWhen: (a, b) => a.results[metric.key] != b.results[metric.key],
      builder: (context, state) {
        final metricState =
            state.results[metric.key] ?? const MetricState.loading();

        return Container(
          margin: EdgeInsets.only(bottom: 14.h),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: c.cardBg,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: c.borderLight),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(metric: metric, metricState: metricState),
              SizedBox(height: 14.h),
              _Body(metric: metric, metricState: metricState),
            ],
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.metric, required this.metricState});

  final StatisticMetric metric;
  final MetricState metricState;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                metric.name,
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: c.textPrimary,
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                metric.description,
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 11.sp,
                  color: c.textTertiary,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
        if (metric.limitFilter != null) ...[
          SizedBox(width: 10.w),
          _LimitStepper(metric: metric, metricState: metricState),
        ],
      ],
    );
  }
}

/// Inline "− N +" control for metrics that expose a `limit` filter
/// (e.g. top-treatments). Clamps to the filter's min/max.
class _LimitStepper extends StatelessWidget {
  const _LimitStepper({required this.metric, required this.metricState});

  final StatisticMetric metric;
  final MetricState metricState;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final filter = metric.limitFilter!;
    final min = (filter.min ?? 1).toInt();
    final max = (filter.max ?? 20).toInt();
    final current =
        metricState.limit ?? (filter.defaultValue as num?)?.toInt() ?? 5;
    final busy = metricState.status == MetricStatus.loading;

    void change(int next) {
      if (busy || next < min || next > max || next == current) return;
      context
          .read<StatisticsDashboardBloc>()
          .add(DashboardMetricLimitChanged(key: metric.key, limit: next));
    }

    return Container(
      decoration: BoxDecoration(
        color: c.cardBgSecondary,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: c.borderLight),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepButton(
            icon: Icons.remove_rounded,
            onTap: () => change(current - 1),
          ),
          Text(
            'Top $current',
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: c.textPrimary,
            ),
          ),
          _StepButton(
            icon: Icons.add_rounded,
            onTap: () => change(current + 1),
          ),
        ],
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.all(6.w),
        child: Icon(icon, size: 14.w, color: ColorManager.primary),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.metric, required this.metricState});

  final StatisticMetric metric;
  final MetricState metricState;

  @override
  Widget build(BuildContext context) {
    switch (metricState.status) {
      case MetricStatus.loading:
        return SizedBox(
          height: 120.h,
          child: const Center(child: CircularProgressIndicator()),
        );
      case MetricStatus.failure:
        return ChartMessage(
          icon: Icons.error_outline_rounded,
          text: metricState.error ?? 'Failed to load',
          action: TextButton(
            onPressed: () => context
                .read<StatisticsDashboardBloc>()
                .add(DashboardMetricRetried(metric.key)),
            child: const Text('Retry'),
          ),
        );
      case MetricStatus.success:
        final result = metricState.result;
        if (result == null) {
          return const ChartMessage(
            icon: Icons.inbox_outlined,
            text: 'No data for this period',
          );
        }
        return MetricChart(metric: metric, result: result);
    }
  }
}
