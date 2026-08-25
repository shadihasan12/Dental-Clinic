import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A "drill in" chevron that always points at the text it belongs to.
///
/// One icon - `Icons.chevron_right` - flipped horizontally rather than
/// swapped for `chevron_left`, so the widget never changes identity.
///
/// The glyph is mirrored in exactly one case: a row whose order has been
/// pinned to LTR (see [pinLtr]) while the locale is RTL. There the chevron
/// stays on the physical right, so it has to point left to sit against its
/// label. In a normal row the layout has already moved the chevron to the
/// other edge, and mirroring the glyph on top of that would aim it off the
/// screen instead of at the row's content - so it is left as drawn.
class DirectionalChevron extends StatelessWidget {
  const DirectionalChevron({super.key, this.size, this.color});

  final double? size;
  final Color? color;

  /// Languages written right-to-left that this app ships or may ship.
  static const _rtlLanguages = {'ar', 'fa', 'he', 'ur'};

  /// True in an RTL locale, regardless of the ambient [Directionality] -
  /// so it stays correct inside a subtree pinned to LTR, which is exactly
  /// what [pinLtr] does.
  static bool isRtl(BuildContext context) {
    final locale = Localizations.maybeLocaleOf(context);
    if (locale != null && _rtlLanguages.contains(locale.languageCode)) {
      return true;
    }
    return Directionality.of(context) == TextDirection.rtl;
  }

  /// Locks [child] to left-to-right layout order. Use it on a row that must
  /// keep the same physical arrangement in both languages - the text inside
  /// still renders right-to-left, only the order of the row's children is
  /// held still.
  static Widget pinLtr({required Widget child}) =>
      Directionality(textDirection: TextDirection.ltr, child: child);

  @override
  Widget build(BuildContext context) {
    final icon = Icon(
      Icons.chevron_right,
      size: size ?? 16.w,
      color: color,
    );

    // Only a pinned row needs the mirror: the locale is RTL but this
    // subtree still lays out left-to-right, so the chevron did not move to
    // the other edge and the glyph has to turn around instead.
    final pinnedAgainstLocale =
        isRtl(context) && Directionality.of(context) == TextDirection.ltr;
    if (!pinnedAgainstLocale) return icon;

    // scaleX: -1 mirrors the glyph about its own centre, so it occupies the
    // identical box and never shifts the row.
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()..scaleByDouble(-1.0, 1.0, 1.0, 1.0),
      child: icon,
    );
  }
}
