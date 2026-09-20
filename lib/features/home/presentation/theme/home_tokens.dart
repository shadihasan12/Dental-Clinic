import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:flutter/material.dart';

/// Home's names for the app palette.
///
/// Home was built to its own handoff - a different ink, a different primary,
/// a different page background - and ran on a private colour set while that
/// direction was being tried. It now follows `DENTA_STYLE.md` like every other
/// screen, so each name below resolves to the app token that carries the same
/// meaning rather than to a colour of its own.
///
/// The class survives the change on purpose: the widgets below it read
/// `t.ink`, `t.hairline`, `t.tint`, and those names say what the colour is
/// *for*, which `c.textPrimary` and `c.borderLight` also do but from the app's
/// vocabulary rather than the screen's. Keeping the indirection means one file
/// decides the mapping, and a widget cannot quietly reach for a colour that is
/// not in the system.
class HomeTokens {
  const HomeTokens._(this._c, this._isDark);

  factory HomeTokens.of(BuildContext context) => HomeTokens._(
        ColorManager.of(context),
        Theme.of(context).brightness == Brightness.dark,
      );

  final AppColors _c;
  final bool _isDark;

  Color get pageBg => _c.scaffoldBg;
  Color get card => _c.cardBg;

  /// The near-black every primary string is set in.
  Color get ink => _c.textPrimary;
  Color get secondary => _c.textSecondary;
  Color get muted => _c.textTertiary;
  Color get chevron => _c.textSubtle;

  /// Elevation is a hairline, never a shadow - so these two are the only
  /// edges Home draws.
  Color get hairline => _c.borderLight;
  Color get hairlineStrong => _c.border;

  /// Fill under a press, and the 1.5px edge a pressed or focused element
  /// takes in its own hue.
  Color get pressed => _c.cardBgSecondary;
  Color get focusBorder => ColorManager.primary;

  Color get primary => ColorManager.primary;

  /// The step of the ramp that is legible as text on white. Dark theme runs
  /// the other way: the darker steps disappear into the card, so it takes the
  /// light one.
  Color get primaryDark =>
      _isDark ? ColorManager.primaryLight : ColorManager.primaryDarker;

  /// The 50-level of the brand hue, and its edge. The only tinted surface
  /// Home uses for itself; the quick actions carry their own hues.
  Color get tint => _c.primaryTintBg;
  Color get tintBorder => _c.primaryTintBorder;

  /// The soft disc that bleeds off the trailing corner of a tinted card.
  ///
  /// White, and only just there: it is light falling across the surface, not
  /// a shape with a meaning. Clipped by the card it sits in, so it reads as
  /// the card being lit rather than as a circle someone drew. Dark theme
  /// keeps the same idea at a tenth of the strength - the same lift over a
  /// near-black surface would be a glare.
  Color get bloom => Colors.white.withValues(alpha: _isDark ? 0.05 : 0.55);

  /// The inactive page dot - a hairline that has to read as a filled shape.
  Color get dotIdle => _c.border;

  /// The micro-label under a figure.
  Color get caption => _c.textTertiary;

  Color get onPrimary => ColorManager.white;
}
