import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/statistics_entities.dart';
import '../../domain/entities/statistics_period.dart';
import '../bloc/statistics_bloc.dart';
import '../share/statistics_share_sheet.dart';
import '../widgets/appointment_breakdown_card.dart';
import '../widgets/chart_section_card.dart';
import '../widgets/kpi_card.dart';
import '../widgets/period_filter.dart';
import '../widgets/revenue_line_chart.dart';
import '../widgets/statistics_palette.dart';
import '../widgets/top_treatments_list.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final clinicId = getIt<UserStorage>().getSelectedClinicId() ?? '';
        return getIt<StatisticsBloc>()
          ..add(StatisticsRequested(clinicId: clinicId));
      },
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
      body: Column(
        children: [
          BlocBuilder<StatisticsBloc, StatisticsState>(
            buildWhen: (a, b) => a.snapshot != b.snapshot,
            builder: (context, state) => PageHeader(
              title: l10n.statistics,
              actions: [
                _ShareAction(
                  enabled: state.snapshot != null,
                  onTap: () => _openShareSheet(context, state.snapshot!),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<StatisticsBloc, StatisticsState>(
              builder: (context, state) {
                return RefreshIndicator(
                  color: ColorManager.primary,
                  onRefresh: () async {
                    context.read<StatisticsBloc>()
                        .add(const StatisticsRefreshed());
                    await context
                        .read<StatisticsBloc>()
                        .stream
                        .firstWhere((s) => !s.isLoading);
                  },
                  child: _Body(state: state),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _openShareSheet(BuildContext context, StatisticsSnapshot snapshot) {
    showStatisticsShareSheet(context: context, snapshot: snapshot);
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
  final StatisticsState state;

  @override
  Widget build(BuildContext context) {
    if (state.status == StatisticsStatus.failure && !state.hasData) {
      return _ErrorView(message: state.error ?? 'Something went wrong');
    }
    if (state.isLoading && !state.hasData) {
      return const _LoadingView();
    }
    final snapshot = state.snapshot;
    if (snapshot == null) {
      return const SizedBox.shrink();
    }

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PeriodFilter(
            selected: state.period,
            onChanged: (p) => context
                .read<StatisticsBloc>()
                .add(StatisticsPeriodChanged(p)),
          ),
          SizedBox(height: 8.h),
          _RangeLabel(snapshot: snapshot),
          SizedBox(height: 16.h),
          _KpiGrid(snapshot: snapshot),
          SizedBox(height: 16.h),
          ChartSectionCard(
            title: 'Revenue Trend',
            subtitle: _periodSubtitle(snapshot.period),
            child: RevenueLineChart(
              points: snapshot.revenueTrend,
              currency: snapshot.currency,
            ),
          ),
          SizedBox(height: 16.h),
          ChartSectionCard(
            title: 'Appointment Outcomes',
            subtitle:
                '${snapshot.appointmentBreakdown.total} total appointments',
            child: AppointmentBreakdownView(
              breakdown: snapshot.appointmentBreakdown,
            ),
          ),
          SizedBox(height: 16.h),
          ChartSectionCard(
            title: 'Top Treatments',
            subtitle: 'Ranked by revenue',
            child: TopTreatmentsList(
              treatments: snapshot.topTreatments,
              currency: snapshot.currency,
            ),
          ),
        ],
      ),
    );
  }

  String _periodSubtitle(StatisticsPeriod p) {
    switch (p) {
      case StatisticsPeriod.week:
        return 'Last 7 days';
      case StatisticsPeriod.month:
        return 'Last 30 days';
      case StatisticsPeriod.year:
        return 'Last 12 months';
    }
  }
}

class _RangeLabel extends StatelessWidget {
  const _RangeLabel({required this.snapshot});
  final StatisticsSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final fmt = DateFormat('MMM d, y');
    return Text(
      '${fmt.format(snapshot.rangeStart)} — ${fmt.format(snapshot.rangeEnd)}',
      style: TextStyle(
        fontFamily: FontHelper.fontFamily(context),
        fontSize: 12.sp,
        color: c.textTertiary,
      ),
    );
  }
}

/// 2×2 KPI grid built from IntrinsicHeight rows so each card sizes to
/// its content. Avoids the GridView childAspectRatio overflow trap.
class _KpiGrid extends StatelessWidget {
  const _KpiGrid({required this.snapshot});
  final StatisticsSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final o = snapshot.overview;
    final cards = <Widget>[
      KpiCard(
        label: 'Revenue',
        value: StatisticsFormat.moneyFull(o.totalRevenue, snapshot.currency),
        trendPercent: o.revenueTrendPercent,
        icon: Icons.payments_outlined,
        accent: ColorManager.success,
      ),
      KpiCard(
        label: 'Patients',
        value: o.totalPatients.toString(),
        trendPercent: o.patientsTrendPercent,
        icon: Icons.people_alt_outlined,
        accent: ColorManager.primary,
      ),
      KpiCard(
        label: 'Appointments',
        value: o.totalAppointments.toString(),
        trendPercent: o.appointmentsTrendPercent,
        icon: Icons.event_available_outlined,
        accent: ColorManager.info,
      ),
      KpiCard(
        label: 'New Patients',
        value: o.newPatients.toString(),
        trendPercent: o.newPatientsTrendPercent,
        icon: Icons.person_add_alt_outlined,
        accent: ColorManager.purple,
      ),
    ];

    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: cards[0]),
              SizedBox(width: 12.w),
              Expanded(child: cards[1]),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: cards[2]),
              SizedBox(width: 12.w),
              Expanded(child: cards[3]),
            ],
          ),
        ),
      ],
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
      children: [
        const _ShimmerBox(heightRatio: 0.06),
        SizedBox(height: 16.h),
        Row(children: [
          Expanded(child: const _ShimmerBox(heightRatio: 0.14)),
          SizedBox(width: 12.w),
          Expanded(child: const _ShimmerBox(heightRatio: 0.14)),
        ]),
        SizedBox(height: 12.h),
        Row(children: [
          Expanded(child: const _ShimmerBox(heightRatio: 0.14)),
          SizedBox(width: 12.w),
          Expanded(child: const _ShimmerBox(heightRatio: 0.14)),
        ]),
        SizedBox(height: 16.h),
        const _ShimmerBox(heightRatio: 0.3),
        SizedBox(height: 16.h),
        const _ShimmerBox(heightRatio: 0.3),
      ],
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  const _ShimmerBox({required this.heightRatio});
  final double heightRatio;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Container(
      height: MediaQuery.of(context).size.height * heightRatio,
      decoration: BoxDecoration(
        color: c.shimmerBase,
        borderRadius: BorderRadius.circular(16.r),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message});
  final String message;

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
              message,
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
                  .read<StatisticsBloc>()
                  .add(const StatisticsRefreshed()),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
