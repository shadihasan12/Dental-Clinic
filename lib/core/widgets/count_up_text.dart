import 'package:flutter/material.dart';

/// A whole number that counts to its new value instead of jumping to it.
///
/// Used for the small counts that change while the user is looking at them -
/// today's appointment total, the number handled so far. The movement is the
/// point: it says the number just changed, which a silent swap does not.
///
/// [TweenAnimationBuilder] runs from the currently displayed number to the
/// new one whenever [value] changes, so the first build counts up from
/// [from] and every later change animates from wherever it had got to.
class CountUpText extends StatelessWidget {
  const CountUpText({
    super.key,
    required this.value,
    this.from = 0,
    this.style,
    this.duration = const Duration(milliseconds: 600),
    this.textAlign,
  });

  final int value;

  /// Where the very first count starts. Zero reads as "counting up to it".
  final int from;

  final TextStyle? style;
  final Duration duration;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    // Reduce-motion users get the final number with no travel.
    if (MediaQuery.disableAnimationsOf(context)) {
      return Text('$value', style: style, textAlign: textAlign);
    }
    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: from, end: value),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, shown, _) =>
          Text('$shown', style: style, textAlign: textAlign),
    );
  }
}
