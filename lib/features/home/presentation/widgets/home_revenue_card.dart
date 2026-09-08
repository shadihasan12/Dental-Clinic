import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/features/home/presentation/theme/home_tokens.dart';
import 'package:dental_clinic_app/features/statistics/domain/entities/revenue_summary.dart';
import 'package:dental_clinic_app/features/statistics/presentation/widgets/charts/chart_support.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Month-to-date revenue - the reason the owner opened the app.
///
/// Handoff section 3: a tinted gradient panel with a soft disc bleeding off
/// the trailing corner, the figure at 44/w800, and seven bars underneath for
/// the shape of the week.
///
/// Absent only when there is genuinely nothing to say - no revenue metric in
/// the clinic's statistics catalog, or a failed load. A month with no
/// takings is not one of those: that is a fact about the month and it reads
/// as zero, because vanishing would leave the owner unable to tell an empty
/// month from a broken card.
class HomeRevenueCard extends StatelessWidget {
  const HomeRevenueCard({
    super.key,
    required this.summary,
    this.isLoading = false,
    this.onTap,
  });

  final RevenueSummary? summary;
  final bool isLoading;
  final VoidCallback? onTap;

  /// Keyed so a test can measure the drawn bar heights - the rule that an
  /// absent series stays flat rather than borrowing the design reference's
  /// shape is only worth having if it is checked.
  static ValueKey<String> barKey(int index) => ValueKey('revenue-bar-$index');

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const _RevenueSkeleton();

    final data = summary;
    if (data == null) return const SizedBox.shrink();

    final t = HomeTokens.of(context);
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);
    final code = data.currencyCode;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26.r),
          border: Border.all(color: t.tintBorder),
          gradient: LinearGradient(
            // 160° in CSS runs top-ish to bottom-ish, leaning trailing.
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
            stops: const [0, 0.6, 1],
            colors: [t.revenueTop, t.revenueMid, t.revenueEnd],
          ),
        ),
        child: Stack(
          children: [
            // Clipped by the card, so it reads as light falling across the
            // panel rather than as a circle someone drew.
            PositionedDirectional(
              end: -40.w,
              top: -50.h,
              child: Container(
                width: 170.w,
                height: 170.w,
                decoration: BoxDecoration(
                  color: t.revenueBloom,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(22.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.totalRevenue.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: family,
                      fontSize: 10.5.sp,
                      height: 1,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w500,
                      color: t.primaryDark,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          ChartFormat.grouped(data.value),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: family,
                            fontSize: 44.sp,
                            height: 1,
                            letterSpacing: -0.9,
                            fontWeight: FontWeight.w800,
                            color: t.ink,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Padding(
                        padding: EdgeInsets.only(bottom: 6.h),
                        child: Text(
                          // The currency is only ever the one the server
                          // sent; a bare number is honest about not knowing,
                          // where a guessed symbol would not be.
                          code == null
                              ? l10n.thisMonth
                              : '$code · ${l10n.thisMonth}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: family,
                            fontSize: 13.sp,
                            height: 1.2,
                            fontWeight: FontWeight.w600,
                            color: t.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  _TrendBars(points: data.recentDaily),
                  SizedBox(height: 8.h),
                  Text(
                    l10n.lastSevenDays.toUpperCase(),
                    style: TextStyle(
                      fontFamily: family,
                      fontSize: 10.sp,
                      height: 1,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w500,
                      color: t.caption,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Seven bars, oldest to newest, the last one being today.
///
/// With no series to draw they sit flat at the minimum height rather than
/// taking the reference's shape - those heights are a designer's example,
/// and rendering them would be drawing data the clinic does not have.
class _TrendBars extends StatelessWidget {
  const _TrendBars({required this.points});

  final List<double> points;

  static const int _barCount = 7;

  static const double _height = 34;

  /// A bar never disappears completely: a zero day is still a day, and a
  /// gap in the row would read as missing rather than as nothing earned.
  static const double _minFraction = 0.08;

  @override
  Widget build(BuildContext context) {
    final t = HomeTokens.of(context);

    // Padded at the front so a short series still fills the row, with the
    // most recent day always in the last slot.
    final values = <double>[
      ...List.filled((_barCount - points.length).clamp(0, _barCount), 0.0),
      ...points.length > _barCount
          ? points.sublist(points.length - _barCount)
          : points,
    ];

    final peak = values.fold<double>(0, (a, b) => b > a ? b : a);
    final runnerUp = _runnerUpIndex(values);

    return SizedBox(
      height: _height.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (var i = 0; i < _barCount; i++) ...[
            if (i > 0) SizedBox(width: 5.w),
            Expanded(
              child: TweenAnimationBuilder<double>(
                tween: Tween(
                  begin: _minFraction,
                  end: peak <= 0
                      ? _minFraction
                      : (values[i] / peak).clamp(_minFraction, 1.0),
                ),
                duration: Duration(milliseconds: 420 + i * 40),
                curve: Curves.easeOutCubic,
                builder: (context, fraction, _) => Container(
                  key: HomeRevenueCard.barKey(i),
                  height: _height.h * fraction,
                  decoration: BoxDecoration(
                    color: i == _barCount - 1
                        ? t.chartToday
                        : (i == runnerUp ? t.chartMid : t.chartLow),
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// The tallest bar that is not today - picked out a shade darker, which is
  /// what gives the row a reference point to read today against.
  static int _runnerUpIndex(List<double> values) {
    var best = -1;
    var bestValue = 0.0;
    for (var i = 0; i < values.length - 1; i++) {
      if (values[i] > bestValue) {
        bestValue = values[i];
        best = i;
      }
    }
    return best;
  }
}

/// Holds the card's real height while the first load runs, so nothing below
/// it jumps when the figure lands.
class _RevenueSkeleton extends StatelessWidget {
  const _RevenueSkeleton();

  @override
  Widget build(BuildContext context) {
    final t = HomeTokens.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        color: t.revenueMid,
        borderRadius: BorderRadius.circular(26.r),
        border: Border.all(color: t.tintBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerBox(width: 108.w, height: 10.h),
          SizedBox(height: 10.h),
          ShimmerBox(width: 150.w, height: 40.h),
          SizedBox(height: 16.h),
          ShimmerBox(width: double.infinity, height: 34.h),
          SizedBox(height: 10.h),
          ShimmerBox(width: 74.w, height: 10.h),
        ],
      ),
    );
  }
}
