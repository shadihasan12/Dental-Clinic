import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
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
        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 32.h),
          child: StateCard(
            icon: Icons.cloud_off_rounded,
            tone: ColorManager.error,
            title: l10n.statisticsLoadFailed,
            message: state.catalogError,
            actionLabel: l10n.retry,
            onAction: () => context
                .read<StatisticsDashboardBloc>()
                .add(const DashboardStarted()),
          ),
        );
      case CatalogStatus.success:
        if (state.metrics.isEmpty) {
          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 32.h),
            child: StateCard(
              icon: Icons.bar_chart_rounded,
              title: l10n.noStatisticsYet,
              message: l10n.noStatisticsYetHint,
            ),
          );
        }
        return RefreshIndicator(
          color: ColorManager.primaryDarker,
          onRefresh: () async {
            context
                .read<StatisticsDashboardBloc>()
                .add(const DashboardStarted());
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
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
}

/// Holds the shape of the loaded screen - filter rail, then metric cards -
/// so the layout does not jump when the catalog lands.
class _CatalogSkeleton extends StatelessWidget {
  const _CatalogSkeleton();

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
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
          Container(
            height: 118.h,
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
          ),
        ],
      ],
    );
  }
}
