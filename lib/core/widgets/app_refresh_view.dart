import 'package:flutter/cupertino.dart';

import 'package:dental_clinic_app/core/resources/color_manager.dart';

/// The app's single pull-to-refresh treatment.
///
/// One iOS-style control, used on every scrollable screen, so the gesture
/// looks and behaves the same everywhere and the design lives in one file.
///
/// Two things it deliberately does differently from Material's
/// [RefreshIndicator]:
///
///  * The spinner is **not** floating. It occupies real space that opens up
///    above the content as you drag, so nothing is ever drawn on top of the
///    first row.
///  * The physics are bouncing on every platform. [CupertinoSliverRefreshControl]
///    only ever sees the gesture while the viewport is overscrolled, and
///    Android's default clamping physics never overscrolls - without this the
///    control would silently never fire off iOS.
///
/// Usage - box content (the common case):
///
/// ```dart
/// AppRefreshView(
///   onRefresh: _refresh,
///   padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 24.h),
///   child: Column(children: [...]),
/// )
/// ```
///
/// Usage - a lazily built list, so rows are not all created at once:
///
/// ```dart
/// AppRefreshView.slivers(
///   onRefresh: _refresh,
///   slivers: [SliverList.builder(...)],
/// )
/// ```
///
/// A page that already owns its [CustomScrollView] (pinned headers, nested
/// slivers) should drop in [AppRefreshControl] as its first sliver instead of
/// restructuring around this widget.
class AppRefreshView extends StatelessWidget {
  /// Wraps ordinary box content - a [Column], a card, a fixed set of rows.
  const AppRefreshView({
    super.key,
    required this.onRefresh,
    required Widget this.child,
    this.padding = EdgeInsets.zero,
    this.controller,
    this.fillViewport = false,
  }) : slivers = null;

  /// Wraps slivers, for lists long enough that lazy building matters.
  const AppRefreshView.slivers({
    super.key,
    required this.onRefresh,
    required List<Widget> this.slivers,
    this.controller,
  })  : child = null,
        padding = EdgeInsets.zero,
        fillViewport = false;

  /// Runs on pull. The spinner stays up until this future completes, so hand
  /// it something that actually tracks the request rather than firing an
  /// event and returning immediately.
  final Future<void> Function() onRefresh;

  final Widget? child;
  final List<Widget>? slivers;

  /// Applied around [child] only. Sliver callers pad their own slivers.
  final EdgeInsetsGeometry padding;

  final ScrollController? controller;

  /// Stretches [child] to at least the viewport height - use it for empty and
  /// error states that should sit centred instead of hugging the top.
  final bool fillViewport;

  /// Bouncing everywhere, and always scrollable so short pages still pull.
  static const ScrollPhysics physics = AlwaysScrollableScrollPhysics(
    parent: BouncingScrollPhysics(),
  );

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: controller,
      physics: physics,
      slivers: [
        AppRefreshControl(onRefresh: onRefresh),
        if (slivers != null)
          ...slivers!
        else if (fillViewport)
          SliverPadding(
            padding: padding,
            sliver: SliverFillRemaining(
              hasScrollBody: false,
              child: child,
            ),
          )
        else
          SliverPadding(
            padding: padding,
            sliver: SliverToBoxAdapter(child: child),
          ),
      ],
    );
  }
}

/// The refresh control on its own, for pages that already build a
/// [CustomScrollView]. Place it first in the sliver list, and give the scroll
/// view [AppRefreshView.physics] so the gesture reaches it on Android too.
class AppRefreshControl extends StatelessWidget {
  const AppRefreshControl({super.key, required this.onRefresh});

  final Future<void> Function() onRefresh;

  /// How far the drag has to travel before the pull arms.
  static const double triggerPullDistance = 100;

  /// How much room the spinner holds open while the refresh runs.
  static const double indicatorExtent = 62;

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverRefreshControl(
      onRefresh: onRefresh,
      refreshTriggerPullDistance: triggerPullDistance,
      refreshIndicatorExtent: indicatorExtent,
      builder: _build,
    );
  }

  static Widget _build(
    BuildContext context,
    RefreshIndicatorMode mode,
    double pulledExtent,
    double triggerPullDistance,
    double indicatorExtent,
  ) {
    // Clipped to the space actually opened up, so the spinner is revealed by
    // the drag rather than sliding over the content above it.
    return Center(
      child: _RefreshSpinner(
        mode: mode,
        // The spinner starts drawing once the pull is a third of the way in,
        // which keeps a stray one-pixel scroll from flashing it.
        progress: ((pulledExtent - indicatorExtent / 3) /
                (triggerPullDistance - indicatorExtent / 3))
            .clamp(0.0, 1.0),
      ),
    );
  }
}

class _RefreshSpinner extends StatelessWidget {
  const _RefreshSpinner({required this.mode, required this.progress});

  final RefreshIndicatorMode mode;
  final double progress;

  static const double _radius = 12;

  @override
  Widget build(BuildContext context) {
    final color = ColorManager.primaryDarker;

    switch (mode) {
      case RefreshIndicatorMode.drag:
        // Ticks light up one by one as you pull - the iOS "you are getting
        // there" read, with no spin until it is armed.
        return Opacity(
          opacity: progress,
          child: CupertinoActivityIndicator.partiallyRevealed(
            progress: progress,
            radius: _radius,
            color: color,
          ),
        );
      case RefreshIndicatorMode.armed:
      case RefreshIndicatorMode.refresh:
        return CupertinoActivityIndicator(radius: _radius, color: color);
      case RefreshIndicatorMode.done:
        // Fades with the collapsing extent instead of popping out.
        return Opacity(
          opacity: progress,
          child: CupertinoActivityIndicator(radius: _radius, color: color),
        );
      case RefreshIndicatorMode.inactive:
        return const SizedBox.shrink();
    }
  }
}
