import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/features/home/domain/entities/home_summary.dart';
import 'package:dental_clinic_app/features/home/presentation/theme/home_tokens.dart';
import 'package:dental_clinic_app/features/statistics/presentation/widgets/charts/chart_support.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The three figures the owner opened the app for, one card at a time.
///
/// Patients, then revenue per currency - a clinic billing in both USD and SYP
/// gets a card each, because the two totals cannot be added and a single
/// "revenue" number would be wrong in whichever currency it claimed to be in.
///
/// The card count is the server's, not the app's: [HomeSummary.stats] is
/// rendered in order and the dots follow it, so a clinic that starts billing
/// in a third currency gets a fourth card without an app release.
///
/// Absent only when there is genuinely nothing to say - no stats at all, or a
/// failed load. A month with no takings is not one of those: that is a fact
/// about the month and it reads as zero, because vanishing would leave the
/// owner unable to tell an empty month from a broken card.
class HomeStatsCarousel extends StatefulWidget {
  const HomeStatsCarousel({
    super.key,
    required this.summary,
    this.isLoading = false,
    this.onTap,
  });

  final HomeSummary? summary;
  final bool isLoading;
  final VoidCallback? onTap;

  /// Tall enough for the tallest card at the 1.2 text scale the app clamps
  /// to. Fixed because a PageView needs a bounded height, and because cards
  /// that resized as the user swiped would make the page below them jump.
  static double get cardHeight => 186.h;

  static double get _dotsGap => 12.h;
  static double get _dotsSize => 6.w;

  /// What the widget occupies in *every* state - loading, one card, or five.
  ///
  /// The dots strip is reserved even when there are no dots to draw, so the
  /// page below does not shift when the figures land and the skeleton gives
  /// way to them. A lone card is left with a little air under it; a page that
  /// jumps as it loads is the worse of the two.
  static double get totalHeight => cardHeight + _dotsGap + _dotsSize;

  @override
  State<HomeStatsCarousel> createState() => _HomeStatsCarouselState();
}

class _HomeStatsCarouselState extends State<HomeStatsCarousel> {
  final PageController _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant HomeStatsCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);

    // A refresh can return fewer cards than the last one did - a currency the
    // clinic stopped billing in, or a role that lost sight of money. Landing
    // back on a page that no longer exists leaves the dots pointing at
    // nothing, so the view snaps to the last real card instead.
    final count = widget.summary?.stats.length ?? 0;
    if (count > 0 && _page >= count) {
      _page = count - 1;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _controller.hasClients) _controller.jumpToPage(_page);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) return const _StatSkeleton();

    final stats = widget.summary?.stats ?? const <HomeStat>[];
    if (stats.isEmpty) return const SizedBox.shrink();

    // One figure is not a carousel: no PageView to swipe and no dot, which
    // would only advertise a second card that does not exist.
    final isSingle = stats.length == 1;

    return SizedBox(
      height: HomeStatsCarousel.totalHeight,
      child: Column(
        children: [
          SizedBox(
            height: HomeStatsCarousel.cardHeight,
            child: isSingle
                ? HomeStatCard(stat: stats.first, onTap: widget.onTap)
                : PageView.builder(
                    controller: _controller,
                    itemCount: stats.length,
                    onPageChanged: (i) => setState(() => _page = i),
                    itemBuilder: (context, i) =>
                        HomeStatCard(stat: stats[i], onTap: widget.onTap),
                  ),
          ),
          if (!isSingle) ...[
            SizedBox(height: HomeStatsCarousel._dotsGap),
            _Dots(count: stats.length, active: _page),
          ],
        ],
      ),
    );
  }
}

/// The page indicator. The active dot stretches into a pill rather than only
/// changing colour, so it still reads as "you are here" for a user who cannot
/// separate the two tints.
class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.active});

  final int count;
  final int active;

  @override
  Widget build(BuildContext context) {
    final t = HomeTokens.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++) ...[
          if (i > 0) SizedBox(width: 5.w),
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            width: i == active ? 18.w : HomeStatsCarousel._dotsSize,
            height: HomeStatsCarousel._dotsSize,
            decoration: BoxDecoration(
              color: i == active ? t.primary : t.chartLow,
              borderRadius: BorderRadius.circular(3.r),
            ),
          ),
        ],
      ],
    );
  }
}

/// One figure: a tinted gradient panel with a soft disc bleeding off the
/// trailing corner, the number at 44/w800, and seven bars for the shape of
/// the week.
class HomeStatCard extends StatelessWidget {
  const HomeStatCard({super.key, required this.stat, this.onTap});

  final HomeStat stat;
  final VoidCallback? onTap;

  /// Keyed so a test can measure the drawn bar heights - the rule that an
  /// absent series stays flat rather than borrowing the design reference's
  /// shape is only worth having if it is checked.
  static ValueKey<String> barKey(int index) => ValueKey('stat-bar-$index');

  @override
  Widget build(BuildContext context) {
    final t = HomeTokens.of(context);
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);

    final label = stat.isRevenue ? l10n.totalRevenue : l10n.totalPatients;
    final caption = _caption(l10n);

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label.toUpperCase(),
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
                  // Flexible so the figure gives way first when the card is
                  // short - a large OS text scale, or a device whose height
                  // ratio squeezes the fixed card. The FittedBox inside then
                  // scales the number rather than letting the column overflow.
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Scaled down rather than ellipsised: an SYP total
                        // runs to eight digits, and "12,500,0…" is not a
                        // number the owner can act on.
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              ChartFormat.grouped(stat.value),
                              maxLines: 1,
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
                        ),
                        if (caption != null) ...[
                          SizedBox(width: 10.w),
                          Padding(
                            padding: EdgeInsets.only(bottom: 6.h),
                            child: Text(
                              caption,
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
                      ],
                    ),
                  ),
                  _TrendBars(points: stat.recentDaily),
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

  /// The line beside the figure. Null when there is nothing true to put
  /// there - a revenue total whose currency the server did not name still
  /// says "this month", but a patient count with no intake figure says
  /// nothing rather than an invented zero.
  String? _caption(AppLocalizations l10n) {
    if (stat.isRevenue) {
      final code = stat.currencyCode;
      // The currency is only ever the one the server sent; a bare number is
      // honest about not knowing, where a guessed symbol would not be.
      return code == null ? l10n.thisMonth : '$code · ${l10n.thisMonth}';
    }
    final added = stat.newInPeriod;
    return added == null ? null : l10n.newPatientsThisMonth(added);
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
                  key: HomeStatCard.barKey(i),
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

/// Holds the carousel's real height while the first load runs, so nothing
/// below it jumps when the figures land.
class _StatSkeleton extends StatelessWidget {
  const _StatSkeleton();

  @override
  Widget build(BuildContext context) {
    final t = HomeTokens.of(context);

    // The panel keeps the card's own height and the box keeps the widget's,
    // so the placeholder is the same shape as what replaces it and the dots
    // strip below it is already accounted for.
    return SizedBox(
      height: HomeStatsCarousel.totalHeight,
      child: Container(
        width: double.infinity,
        height: HomeStatsCarousel.cardHeight,
        padding: EdgeInsets.all(22.w),
        decoration: BoxDecoration(
          color: t.revenueMid,
          borderRadius: BorderRadius.circular(26.r),
          border: Border.all(color: t.tintBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShimmerBox(width: 108.w, height: 10.h),
            ShimmerBox(width: 150.w, height: 40.h),
            ShimmerBox(width: double.infinity, height: 34.h),
            ShimmerBox(width: 74.w, height: 10.h),
          ],
        ),
      ),
    );
  }
}
