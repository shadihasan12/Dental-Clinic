import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/features/home/domain/entities/home_card.dart';
import 'package:dental_clinic_app/features/home/presentation/theme/home_tokens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The figures the owner opened the app for, one card at a time.
///
/// Revenue per currency, then the month's cases - a clinic billing in both USD
/// and SYP gets a card each, because the two totals cannot be added and a
/// single "revenue" number would be wrong in whichever currency it claimed.
///
/// The card count, their wording and their order are all the server's: the
/// list is rendered exactly as it arrives and the dots follow it, so a clinic
/// that starts billing in a third currency gets a fourth card without an app
/// release. Nothing here reads [HomeCard.key].
///
/// Absent only when the list is empty - which the contract reserves for a
/// secretary, who is not meant to see these figures at all. A clinic with no
/// takings yet is not that case: it gets a full set of zeros, and shows them,
/// because vanishing would leave the owner unable to tell an empty month from
/// a broken card.
class HomeStatsCarousel extends StatefulWidget {
  const HomeStatsCarousel({
    super.key,
    required this.cards,
    this.isLoading = false,
    this.onTap,
  });

  final List<HomeCard> cards;
  final bool isLoading;
  final VoidCallback? onTap;

  /// Tall enough for the tallest card at the 1.2 text scale the app clamps
  /// to. Fixed because a PageView needs a bounded height, and because cards
  /// that resized as the user swiped would make the page below them jump.
  static double get cardHeight => 104.h;

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
    final count = widget.cards.length;
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

    final cards = widget.cards;
    if (cards.isEmpty) return const SizedBox.shrink();

    // One figure is not a carousel: no PageView to swipe and no dot, which
    // would only advertise a second card that does not exist.
    final isSingle = cards.length == 1;

    return SizedBox(
      height: HomeStatsCarousel.totalHeight,
      child: Column(
        children: [
          SizedBox(
            height: HomeStatsCarousel.cardHeight,
            child: isSingle
                ? HomeStatCard(card: cards.first, onTap: widget.onTap)
                : PageView.builder(
                    controller: _controller,
                    itemCount: cards.length,
                    onPageChanged: (i) => setState(() => _page = i),
                    itemBuilder: (context, i) => HomeStatCard(
                      key: ValueKey(cards[i].key),
                      card: cards[i],
                      onTap: widget.onTap,
                    ),
                  ),
          ),
          if (!isSingle) ...[
            SizedBox(height: HomeStatsCarousel._dotsGap),
            _Dots(count: cards.length, active: _page),
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
              color: i == active ? t.primary : t.dotIdle,
              borderRadius: BorderRadius.circular(3.r),
            ),
          ),
        ],
      ],
    );
  }
}

/// One card: the brand's tinted surface, a 9.5 uppercase micro-label, the
/// figure at 26/700 with its currency beside it, and the period underneath -
/// the shape `ValueTile` gives every pinned number, at the size the style
/// reserves for a hero figure.
///
/// Tinted rather than white so the row reads as the screen's answer and not
/// as the first of the cards below it. The gradient it used to carry is gone -
/// the style allows one only on a deliberate dark hero surface - but the soft
/// disc stays: the figure sits at the start of a wide card, and without it the
/// trailing two thirds are a blank field of tint.
///
/// Every string on it came from the server, so the same widget draws a money
/// card and a count without being told which it has.
class HomeStatCard extends StatelessWidget {
  const HomeStatCard({super.key, required this.card, this.onTap});

  final HomeCard card;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = HomeTokens.of(context);
    final family = FontHelper.fontFamily(context);
    final unit = card.unit;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        // 16px card, 1px hairline in its own hue. No shadow: elevation on
        // this screen is the border.
        decoration: BoxDecoration(
          color: t.tint,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: t.tintBorder),
        ),
        child: Stack(
          children: [
            // Behind the type and clipped by the card, so no string ever
            // lands on the bright part of it.
            PositionedDirectional(
              end: -34.w,
              top: -38.h,
              child: Container(
                width: 132.w,
                height: 132.w,
                decoration: BoxDecoration(
                  color: t.bloom,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    // Upper-cased for the micro-label the style puts above
                    // every pinned value. Arabic has no case, so this is a
                    // no-op there and the label simply reads as itself.
                    card.title.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: family,
                      fontSize: 9.5.sp,
                      height: 1.3,
                      letterSpacing: 0.4,
                      fontWeight: FontWeight.w500,
                      color: t.caption,
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
                        // runs to eight digits, and "4,000,0…" is not a
                        // number the owner can act on.
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              // Printed exactly as sent: already grouped and
                              // rounded, and reformatting it here could only
                              // disagree with the server.
                              card.value,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: family,
                                fontSize: 26.sp,
                                height: 1,
                                letterSpacing: -0.8,
                                fontWeight: FontWeight.w700,
                                color: t.ink,
                              ),
                            ),
                          ),
                        ),
                        // Null on a count card, and then nothing is drawn -
                        // not an empty chip, and never the text "null".
                        if (unit != null) ...[
                          SizedBox(width: 6.w),
                          Padding(
                            padding: EdgeInsets.only(bottom: 3.h),
                            child: Text(
                              unit,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: family,
                                fontSize: 11.sp,
                                height: 1.2,
                                fontWeight: FontWeight.w400,
                                color: t.secondary,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Text(
                    card.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: family,
                      fontSize: 11.sp,
                      height: 1.3,
                      fontWeight: FontWeight.w400,
                      color: t.secondary,
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
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: t.tint,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: t.tintBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // One box per line of the real card, at its height, so the
            // placeholder is the same shape as what replaces it.
            ShimmerBox(width: 96.w, height: 10.h),
            ShimmerBox(width: 140.w, height: 26.h),
            ShimmerBox(width: 68.w, height: 11.h),
          ],
        ),
      ),
    );
  }
}
