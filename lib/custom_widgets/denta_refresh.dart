import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The one pull-to-refresh used by every scrollable screen in the app.
///
/// Unlike [RefreshIndicator], nothing floats on top of the content: the
/// spinner lives in a band that opens *above* the list and pushes it down as
/// you pull, the way iOS does it. The spinner itself is the Cupertino one, so
/// it reveals tick by tick while you drag and only starts spinning once the
/// refresh actually fires.
///
/// Wrap the page's scrollable directly:
///
///     DentaRefresh(
///       onRefresh: _refresh,
///       child: ListView(...),
///     )
///
/// The child must be the scroll view itself (or a widget whose only scrollable
/// is that view). Give it no `physics` of its own - [DentaRefresh] keeps each
/// platform's own scroll feel and only makes it always-scrollable, so a page
/// too short to scroll can still be pulled.
class DentaRefresh extends StatefulWidget {
  const DentaRefresh({
    super.key,
    required this.onRefresh,
    required this.child,
    this.enabled = true,
    this.indicatorExtent,
    this.triggerExtent,
  });

  /// Runs when the pull passes [triggerExtent]. The band stays open until the
  /// returned future completes.
  final Future<void> Function() onRefresh;

  final Widget child;

  /// Set false to freeze the gesture (e.g. while a full-screen error is up).
  final bool enabled;

  /// Height of the band while refreshing. Defaults to 44.
  final double? indicatorExtent;

  /// How far the finger must travel past the edge before it fires. Defaults to
  /// 110 - deliberately more than a nudge, so scrolling a list back to the top
  /// never reloads it by accident.
  final double? triggerExtent;

  @override
  State<DentaRefresh> createState() => _DentaRefreshState();
}

enum _RefreshPhase { idle, dragging, refreshing, settling }

class _DentaRefreshState extends State<DentaRefresh>
    with SingleTickerProviderStateMixin {
  /// Built in [initState], never with a `late` initializer: a lazy field would
  /// be constructed by the first thing that touches it, and for a DentaRefresh
  /// that is unmounted without ever being built that is [dispose] itself - by
  /// which point the element is deactivated and the ticker's TickerMode lookup
  /// throws.
  late final AnimationController _controller;

  Animation<double>? _settle;

  /// Raw finger travel past the top edge. This is what the trigger is measured
  /// against - kept separate from [_extent] so the pull can be long without the
  /// band having to grow just as tall.
  double _drag = 0;

  /// Height of the band actually drawn.
  double _extent = 0;

  _RefreshPhase _phase = _RefreshPhase.idle;

  /// True once the pull has passed the trigger, so the haptic fires once per
  /// gesture instead of on every frame that hovers around the threshold.
  bool _armed = false;

  /// The band opens at roughly half the drag. A long pull that also opened a
  /// tall band would push the content most of the way off the screen.
  static const double _bandRatio = 0.5;

  double get _hold => widget.indicatorExtent ?? 44.h;
  double get _trigger => widget.triggerExtent ?? 110.h;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 240),
    )..addListener(_onSettleTick);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSettleTick() {
    final value = _settle?.value;
    if (value == null || !mounted) return;
    setState(() => _extent = value);
  }

  void _animateTo(double target) {
    _settle = Tween<double>(
      begin: _extent,
      end: target,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward(from: 0);
  }

  void _setDrag(double value) {
    final next = value.clamp(0.0, _trigger * 1.5);
    if (next == _drag) return;
    setState(() {
      _drag = next;
      _extent = next * _bandRatio;
      _phase = _RefreshPhase.dragging;
    });
    if (next >= _trigger && !_armed) {
      _armed = true;
      HapticFeedback.lightImpact();
    } else if (next < _trigger) {
      _armed = false;
    }
  }

  bool _onNotification(ScrollNotification notification) {
    // Only the page's own vertical scrollable drives the band - a nested
    // horizontal chip row or an inner list must not open it.
    if (!widget.enabled ||
        notification.depth != 0 ||
        notification.metrics.axis != Axis.vertical) {
      return false;
    }
    if (_phase == _RefreshPhase.refreshing ||
        _phase == _RefreshPhase.settling) {
      return false;
    }

    if (notification is OverscrollNotification) {
      // Clamping physics never moves `pixels` past the edge, so on Android the
      // pull only shows up here. Accumulated 1:1 with the finger; the band is
      // what gets halved, not the distance the trigger is measured over.
      if (notification.dragDetails != null && notification.overscroll < 0) {
        _setDrag(_drag - notification.overscroll);
      }
    } else if (notification is ScrollUpdateNotification) {
      if (notification.dragDetails == null) {
        if (_phase == _RefreshPhase.dragging) _release();
      } else {
        final overscroll =
            notification.metrics.minScrollExtent - notification.metrics.pixels;
        _setDrag(overscroll > 0 ? overscroll : 0);
      }
    } else if (notification is ScrollEndNotification) {
      if (_phase == _RefreshPhase.dragging) _release();
    }
    return false;
  }

  void _release() {
    final fires = _drag >= _trigger;
    _drag = 0;
    _armed = false;
    if (fires) {
      _fire();
    } else {
      _phase = _RefreshPhase.settling;
      _animateTo(0);
      _controller.addStatusListener(_onCollapsed);
    }
  }

  void _onCollapsed(AnimationStatus status) {
    if (status != AnimationStatus.completed) return;
    _controller.removeStatusListener(_onCollapsed);
    if (!mounted) return;
    setState(() => _phase = _RefreshPhase.idle);
  }

  Future<void> _fire() async {
    setState(() => _phase = _RefreshPhase.refreshing);
    _animateTo(_hold);
    try {
      await widget.onRefresh();
    } finally {
      if (mounted) {
        setState(() => _phase = _RefreshPhase.settling);
        _animateTo(0);
        _controller.addStatusListener(_onCollapsed);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final spinning = _phase == _RefreshPhase.refreshing;

    // Read off the band rather than off [_drag], so the ticks keep tracking
    // while it settles back - _drag is already zeroed by then.
    final bandAtTrigger = _trigger * _bandRatio;
    final reveal = bandAtTrigger <= 0
        ? 0.0
        : (_extent / bandAtTrigger).clamp(0.0, 1.0);

    return ClipRect(
      child: Stack(
        children: [
          // The band. It sits behind the content and is only ever visible in
          // the strip the content has been pushed off of.
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: _extent,
            child: Center(
              child: Opacity(
                // Nothing shows until the pull is meaningful, otherwise a
                // stray one-pixel overscroll flickers a spinner.
                opacity: spinning ? 1.0 : (reveal * 2).clamp(0.0, 1.0),
                child: spinning
                    ? CupertinoActivityIndicator(
                        radius: 11.r,
                        color: c.textSecondary,
                      )
                    : CupertinoActivityIndicator.partiallyRevealed(
                        progress: reveal,
                        radius: 11.r,
                        color: c.textSecondary,
                      ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0, _extent),
            child: NotificationListener<ScrollNotification>(
              onNotification: _onNotification,
              child: ScrollConfiguration(
                behavior: const _DentaRefreshScrollBehavior(),
                child: widget.child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Keeps each platform's own scroll feel - clamping on Android, bouncing on
/// iOS - and only adds always-scrollable so a half-empty page can still be
/// pulled. Forcing bouncing everywhere made every list rubber-band, which read
/// as the page not being anchored.
///
/// The glow and stretch are dropped because the band above the content is
/// already the overscroll feedback.
class _DentaRefreshScrollBehavior extends MaterialScrollBehavior {
  const _DentaRefreshScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) => super
      .getScrollPhysics(context)
      .applyTo(const AlwaysScrollableScrollPhysics());

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) => child;
}
