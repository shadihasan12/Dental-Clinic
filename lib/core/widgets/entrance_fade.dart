import 'dart:async';

import 'package:flutter/material.dart';

/// Fades and lifts [child] into place once, [index] steps after its group
/// starts.
///
/// Built for rows that arrive together: giving each one a slightly later
/// start makes the group assemble rather than snap in, which is the only
/// moment the user can actually see that fresh data landed.
///
/// It runs on the state's first frame and never again, so a rebuild - a
/// refetch swapping the rows underneath, a theme change - leaves what is on
/// screen alone. Flutter reuses elements by position, so replacing skeletons
/// with real rows builds fresh states and animates, while replacing one
/// appointment list with another does not.
///
/// Honours the platform's "reduce motion" setting: with animations disabled
/// the child is simply there, at full opacity, on the first frame.
class EntranceFade extends StatefulWidget {
  const EntranceFade({
    super.key,
    required this.child,
    this.index = 0,
    this.step = const Duration(milliseconds: 55),
    this.duration = const Duration(milliseconds: 320),
    this.slide = 0.16,
    this.enabled = true,
  });

  final Widget child;

  /// Position in the group. The start is delayed by [index] × [step], capped
  /// at [_maxDelay] so a long list never leaves the last rows crawling in.
  final int index;

  final Duration step;
  final Duration duration;

  /// Distance travelled, as a fraction of the child's own height.
  final double slide;

  /// Set false to skip the animation entirely - the child is placed
  /// immediately, as if it had always been there.
  final bool enabled;

  static const Duration _maxDelay = Duration(milliseconds: 400);

  @override
  State<EntranceFade> createState() => _EntranceFadeState();
}

class _EntranceFadeState extends State<EntranceFade> {
  Timer? _start;
  bool _visible = false;

  /// Resolved on the first frame, because [MediaQuery] is not available in
  /// [initState] - and once resolved it is not revisited, so toggling the
  /// setting mid-animation cannot strand a row at zero opacity.
  bool _animate = true;

  @override
  void initState() {
    super.initState();
    if (!widget.enabled) {
      _visible = true;
      _animate = false;
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (MediaQuery.disableAnimationsOf(context)) {
        setState(() {
          _animate = false;
          _visible = true;
        });
        return;
      }
      final delay = widget.step * widget.index;
      _start = Timer(
        delay > EntranceFade._maxDelay ? EntranceFade._maxDelay : delay,
        () {
          if (!mounted) return;
          setState(() => _visible = true);
        },
      );
    });
  }

  @override
  void dispose() {
    _start?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_animate) return widget.child;

    return AnimatedOpacity(
      opacity: _visible ? 1 : 0,
      duration: widget.duration,
      curve: Curves.easeOut,
      child: AnimatedSlide(
        offset: _visible ? Offset.zero : Offset(0, widget.slide),
        duration: widget.duration,
        curve: Curves.easeOutCubic,
        child: widget.child,
      ),
    );
  }
}
