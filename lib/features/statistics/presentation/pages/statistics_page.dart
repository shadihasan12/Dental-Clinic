import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

    return Scaffold(
      backgroundColor: c.scaffoldBg,
      body: BlocBuilder<StatisticsDashboardBloc, StatisticsDashboardState>(
        builder: (context, state) {
          // Share is offered once the catalog has loaded; the card is
          // built from whatever metrics have streamed in so far.
          final canShare = state.catalogStatus == CatalogStatus.success;
          return Column(
            children: [
              PageHeader(
                title: l10n.statistics,
                actions: [
                  _ShareAction(
                    enabled: canShare,
                    onTap: () => showStatisticsShareSheet(
                      context: context,
                      stats: ShareStatistics.fromDashboard(state),
                    ),
                  ),
                ],
              ),
              Expanded(child: _Body(state: state)),
            ],
          );
        },
      ),
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
    return IconButton(
      onPressed: enabled ? onTap : null,
      tooltip: 'Share',
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
    switch (state.catalogStatus) {
      case CatalogStatus.initial:
      case CatalogStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case CatalogStatus.failure:
        return _CatalogError(message: state.catalogError);
      case CatalogStatus.success:
        if (state.metrics.isEmpty) {
          return const _CatalogEmpty();
        }
        return RefreshIndicator(
          color: ColorManager.primary,
          onRefresh: () async {
            context
                .read<StatisticsDashboardBloc>()
                .add(const DashboardStarted());
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
            children: [
              const StatisticsFilterBar(),
              SizedBox(height: 16.h),
              for (final metric in state.metrics)
                MetricCard(key: ValueKey(metric.key), metric: metric),
            ],
          ),
        );
    }
  }
}

class _CatalogError extends StatelessWidget {
  const _CatalogError({this.message});
  final String? message;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 48.w,
              color: ColorManager.error,
            ),
            SizedBox(height: 12.h),
            Text(
              message ?? 'Could not load statistics',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 14.sp,
                color: c.textSecondary,
              ),
            ),
            SizedBox(height: 16.h),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: ColorManager.primary,
              ),
              onPressed: () => context
                  .read<StatisticsDashboardBloc>()
                  .add(const DashboardStarted()),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class _CatalogEmpty extends StatelessWidget {
  const _CatalogEmpty();

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.bar_chart_rounded, size: 48.w, color: c.textSubtle),
            SizedBox(height: 12.h),
            Text(
              'No statistics are available yet',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 14.sp,
                color: c.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
