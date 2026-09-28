import 'dart:math' as math;

import 'package:dental_clinic_app/core/utils/bloc_settled.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/statistic_metric.dart';
import '../bloc/statistics_dashboard_bloc.dart';
import '../share/share_statistics.dart';
import '../share/statistics_share_sheet.dart';
import '../widgets/metric_card.dart';
import '../widgets/statistics_filter_bar.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<StatisticsDashboardBloc>()..add(const DashboardStarted()),
      child: const _StatisticsView(),
    );
  }
}

class _StatisticsView extends StatelessWidget {
  const _StatisticsView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);

    return BlocBuilder<StatisticsDashboardBloc, StatisticsDashboardState>(
      builder: (context, state) {
        // Share is offered once the catalog has loaded; the card is
        // built from whatever metrics have streamed in so far.
        final canShare = state.catalogStatus == CatalogStatus.success;
        return AdaptivePageScaffold(
          title: l10n.statistics,
          backgroundColor: c.scaffoldBg,
          actions: [
            _ShareAction(
              enabled: canShare,
              onTap: () => showStatisticsShareSheet(
                context: context,
                stats: ShareStatistics.fromDashboard(state),
              ),
            ),
          ],
          body: _Body(state: state),
        );
      },
    );
  }
}

class _ShareAction extends StatelessWidget {
  const _ShareAction({required this.enabled, required this.onTap});

  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    // A bare glyph in a wide desktop top bar is easy to miss; there it gets
    // the labelled button the other desktop pages use for their main action.
    if (Responsive.isDesktop(context)) {
      return DesktopPrimaryButton(
        label: AppLocalizations.of(context)!.share,
        icon: Icons.ios_share_rounded,
        onPressed: enabled ? onTap : null,
      );
    }
    return IconButton(
      onPressed: enabled ? onTap : null,
      tooltip: AppLocalizations.of(context)!.share,
      icon: Icon(
        Icons.ios_share_rounded,
        size: 22.w,
        color: enabled ? c.textPrimary : c.textSubtle,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.state});
  final StatisticsDashboardState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    switch (state.catalogStatus) {
      case CatalogStatus.initial:
      case CatalogStatus.loading:
        return const _CatalogSkeleton();
      case CatalogStatus.failure:
        return DentaRefresh(
          onRefresh: () => _refresh(context),
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 32.h),
            child: StateCard(
              icon: Icons.cloud_off_rounded,
              tone: ColorManager.error,
              title: l10n.statisticsLoadFailed,
              message: state.catalogError,
              actionLabel: l10n.retry,
              onAction: () => context.read<StatisticsDashboardBloc>().add(
                const DashboardStarted(),
              ),
            ),
          ),
        );
      case CatalogStatus.success:
        if (state.metrics.isEmpty) {
          return DentaRefresh(
            onRefresh: () => _refresh(context),
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 32.h),
              child: StateCard(
                icon: Icons.bar_chart_rounded,
                title: l10n.noStatisticsYet,
                message: l10n.noStatisticsYetHint,
              ),
            ),
          );
        }
        if (Responsive.isDesktop(context)) {
          return DentaRefresh(
            onRefresh: () => _refresh(context),
            child: _DesktopDashboard(metrics: state.metrics),
          );
        }
        return DentaRefresh(
          onRefresh: () => _refresh(context),
          child: ListView(
            padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 32.h),
            children: [
              const StatisticsFilterBar(),
              SizedBox(height: 14.h),
              for (final metric in state.metrics)
                MetricCard(key: ValueKey(metric.key), metric: metric),
            ],
          ),
        );
    }
  }

  /// Re-runs the catalog fetch. Every card reloads off the back of it, so the
  /// band only has to track the catalog call.
  Future<void> _refresh(BuildContext context) async {
    final bloc = context.read<StatisticsDashboardBloc>();
    bloc.add(const DashboardStarted());
    await bloc.stream.settled((s) => s.catalogStatus != CatalogStatus.loading);
  }
}

/// Holds the shape of the loaded screen - filter rail, then metric cards -
/// so the layout does not jump when the catalog lands.
class _CatalogSkeleton extends StatelessWidget {
  const _CatalogSkeleton();

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context)) return const _DesktopCatalogSkeleton();
    return ListView(
      padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 32.h),
      children: [
        AppShimmer(
          child: ShimmerBox(
            width: double.infinity,
            height: 42.h,
            radius: BorderRadius.circular(12.r),
          ),
        ),
        SizedBox(height: 14.h),
        for (var i = 0; i < 4; i++) ...[
          if (i > 0) SizedBox(height: 8.h),
          _SkeletonCard(height: 118.h),
        ],
      ],
    );
  }
}

class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard({required this.height});
  final double height;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: c.borderLight),
      ),
      padding: EdgeInsets.all(12.w),
      child: AppShimmer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerBox(width: 120.w, height: 12.h),
            SizedBox(height: 10.h),
            ShimmerBox(width: 90.w, height: 22.h),
            SizedBox(height: 12.h),
            ShimmerBox(width: double.infinity, height: 10.h),
          ],
        ),
      ),
    );
  }
}

// ─── Desktop ─────────────────────────────────────────────────────────────

/// How much of the desktop grid a metric takes, by what its chart needs.
enum _Span {
  /// A headline number - one tile in the KPI strip.
  kpi,

  /// Donuts, ranked bars, lists: legible at half the content width, and
  /// stretched thin and sparse at full.
  half,

  /// Time series and the day×hour grid, whose x-axis is the point.
  full;

  static _Span of(StatisticChartType type) {
    switch (type) {
      case StatisticChartType.kpiCard:
        return kpi;
      case StatisticChartType.areaChart:
      case StatisticChartType.dualLineChart:
      case StatisticChartType.heatmap:
        return full;
      case StatisticChartType.kpiWithList:
      case StatisticChartType.donutChart:
      case StatisticChartType.pieChart:
      case StatisticChartType.barChart:
      case StatisticChartType.horizontalBarChart:
      case StatisticChartType.dentalChartHeatmap:
      case StatisticChartType.demographicsBreakdown:
      case StatisticChartType.unknown:
        return half;
    }
  }
}

/// Shared desktop measurements, so the grid, its skeleton and the filter
/// rail all sit on the same column edges.
abstract final class _DesktopGrid {
  static const double maxContentWidth = 1280;
  static const double sidePadding = 24;
  static const double gutter = 16;
  static const double filterWidth = 380;

  /// Four headline tiles once there is room for them to read as tiles;
  /// three below that, so a number never gets squeezed against its chip.
  static int kpiColumns(double contentWidth) => contentWidth >= 1100 ? 4 : 3;

  /// The side inset that centres a [maxContentWidth] column in [available].
  /// Applied as list padding rather than by narrowing the list, so the wheel
  /// and the scrollbar still work across the whole window.
  static double inset(double available) {
    final content = math.min(available - 2 * sidePadding, maxContentWidth);
    return math.max(sidePadding, (available - content) / 2);
  }
}

/// The desktop dashboard: a KPI strip, then the charts two to a row, with
/// the time series and the booking heatmap given the full width.
///
/// Headline numbers are pulled to the top whatever their catalog position -
/// they are the at-a-glance read. The rest keep catalog order, except that a
/// half-width chart waits past a full-width one for its partner rather than
/// leaving a hole beside itself.
class _DesktopDashboard extends StatelessWidget {
  const _DesktopDashboard({required this.metrics});
  final List<StatisticMetric> metrics;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final inset = _DesktopGrid.inset(constraints.maxWidth);
        final contentWidth = constraints.maxWidth - 2 * inset;
        return ListView(
          padding: EdgeInsets.fromLTRB(inset, 20, inset, 40),
          children: [
            // A date range reads fine in a few hundred pixels; across the
            // whole column it is one short line lost in a long bar.
            const Align(
              alignment: AlignmentDirectional.centerStart,
              child: SizedBox(
                width: _DesktopGrid.filterWidth,
                child: StatisticsFilterBar(),
              ),
            ),
            const SizedBox(height: 20),
            ..._rows(_DesktopGrid.kpiColumns(contentWidth)),
          ],
        );
      },
    );
  }

  List<Widget> _rows(int kpiColumns) {
    final kpis = <StatisticMetric>[];
    final rest = <StatisticMetric>[];
    for (final m in metrics) {
      (_Span.of(m.type) == _Span.kpi ? kpis : rest).add(m);
    }

    final rows = <Widget>[];
    for (var i = 0; i < kpis.length; i += kpiColumns) {
      rows.add(
        // Headline tiles share a row height so the strip reads as one band.
        // Their bodies are plain text and safe to measure intrinsically; the
        // fl_chart charts below are not, so those rows stay top-aligned.
        IntrinsicHeight(
          child: _GridRow(
            stretch: true,
            cells: [
              for (var j = i; j < i + kpiColumns; j++)
                j < kpis.length ? _card(kpis[j]) : null,
            ],
          ),
        ),
      );
    }

    StatisticMetric? waiting;
    for (final m in rest) {
      if (_Span.of(m.type) == _Span.full) {
        rows.add(_card(m));
      } else if (waiting == null) {
        waiting = m;
      } else {
        rows.add(_GridRow(cells: [_card(waiting), _card(m)]));
        waiting = null;
      }
    }
    // An odd one out keeps its half width: a donut or ranked list pulled
    // across the whole column is the stretch this layout exists to avoid.
    if (waiting != null) rows.add(_GridRow(cells: [_card(waiting), null]));

    return [
      for (var i = 0; i < rows.length; i++) ...[
        if (i > 0) const SizedBox(height: _DesktopGrid.gutter),
        rows[i],
      ],
    ];
  }

  Widget _card(StatisticMetric m) =>
      MetricCard(key: ValueKey(m.key), metric: m);
}

/// Equal-width cells split by the grid gutter. A null cell is an empty slot,
/// so a short last row keeps the column widths of the rows above it.
class _GridRow extends StatelessWidget {
  const _GridRow({required this.cells, this.stretch = false});

  final List<Widget?> cells;
  final bool stretch;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment:
          stretch ? CrossAxisAlignment.stretch : CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < cells.length; i++) ...[
          if (i > 0) const SizedBox(width: _DesktopGrid.gutter),
          Expanded(child: cells[i] ?? const SizedBox.shrink()),
        ],
      ],
    );
  }
}

/// Holds the desktop grid's shape while the catalog loads: filter rail, a
/// strip of headline tiles, then two rows of chart cards.
class _DesktopCatalogSkeleton extends StatelessWidget {
  const _DesktopCatalogSkeleton();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final inset = _DesktopGrid.inset(constraints.maxWidth);
        final columns = _DesktopGrid.kpiColumns(
          constraints.maxWidth - 2 * inset,
        );
        return ListView(
          padding: EdgeInsets.fromLTRB(inset, 20, inset, 40),
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: AppShimmer(
                child: ShimmerBox(
                  width: _DesktopGrid.filterWidth,
                  height: 42,
                  radius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _GridRow(
              cells: [
                for (var i = 0; i < columns; i++)
                  const _SkeletonCard(height: 118),
              ],
            ),
            for (var r = 0; r < 2; r++) ...[
              const SizedBox(height: _DesktopGrid.gutter),
              const _GridRow(
                cells: [
                  _SkeletonCard(height: 260),
                  _SkeletonCard(height: 260),
                ],
              ),
            ],
          ],
        );
      },
    );
  }
}
