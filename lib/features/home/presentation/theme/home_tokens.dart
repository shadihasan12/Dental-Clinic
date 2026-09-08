import 'package:flutter/material.dart';

/// The colour set for the redesigned Home screen (design handoff 1a).
///
/// Deliberately local to this feature rather than merged into
/// [ColorManager]: this palette is a new direction - a different ink, a
/// different primary, a different page background - and folding it into the
/// app-wide tokens would silently restyle every other screen. When the
/// direction is adopted beyond Home, these move up and `DENTA_STYLE.md` gets
/// rewritten to match.
///
/// The handoff specifies light only. The dark set below is derived from it,
/// holding the same relationships - the tinted surfaces stay the quietest
/// step above the card, the primary keeps its hue, the chart ramp keeps its
/// three levels - so the screen is coherent in dark without inventing a
/// second design.
class HomeTokens {
  const HomeTokens({
    required this.pageBg,
    required this.card,
    required this.ink,
    required this.secondary,
    required this.muted,
    required this.chevron,
    required this.hairline,
    required this.hairlineStrong,
    required this.pressed,
    required this.focusBorder,
    required this.primary,
    required this.primaryDark,
    required this.tint,
    required this.tintBorder,
    required this.revenueTop,
    required this.revenueMid,
    required this.revenueEnd,
    required this.revenueBloom,
    required this.chartLow,
    required this.chartMid,
    required this.chartToday,
    required this.caption,
    required this.patientChip,
    required this.patientIcon,
    required this.paymentChip,
    required this.paymentIcon,
    required this.onPrimary,
    required this.buttonShadow,
  });

  final Color pageBg;
  final Color card;

  /// The near-black the design uses for every primary string.
  final Color ink;
  final Color secondary;
  final Color muted;
  final Color chevron;
  final Color hairline;
  final Color hairlineStrong;

  /// Fill and border under a press.
  final Color pressed;
  final Color focusBorder;

  final Color primary;
  final Color primaryDark;

  /// The pale blue behind the avatar, the active tab pill and the
  /// appointment chip.
  final Color tint;
  final Color tintBorder;

  /// The revenue card's three gradient stops and the soft disc over them.
  final Color revenueTop;
  final Color revenueMid;
  final Color revenueEnd;
  final Color revenueBloom;

  /// Trend bars: the ordinary days, the runner-up, and today.
  final Color chartLow;
  final Color chartMid;
  final Color chartToday;

  /// The micro-label under the trend bars.
  final Color caption;

  final Color patientChip;
  final Color patientIcon;
  final Color paymentChip;
  final Color paymentIcon;

  final Color onPrimary;
  final Color buttonShadow;

  static HomeTokens of(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? _dark : _light;

  static const HomeTokens _light = HomeTokens(
    pageBg: Color(0xFFF5F8FB),
    card: Color(0xFFFFFFFF),
    ink: Color(0xFF12283C),
    secondary: Color(0xFF7E93A4),
    muted: Color(0xFF8FA6B7),
    chevron: Color(0xFFC3D2DD),
    hairline: Color(0xFFE9EFF4),
    hairlineStrong: Color(0xFFE4EBF1),
    pressed: Color(0xFFF0F6FA),
    focusBorder: Color(0xFFBEDCEC),
    primary: Color(0xFF5AA9D6),
    primaryDark: Color(0xFF3E93C4),
    tint: Color(0xFFDCEEF9),
    tintBorder: Color(0xFFCDE6F5),
    revenueTop: Color(0xFFDCEEF9),
    revenueMid: Color(0xFFEAF5FC),
    revenueEnd: Color(0xFFF3FAFE),
    revenueBloom: Color(0x8CFFFFFF),
    chartLow: Color(0xFFBEDCEC),
    chartMid: Color(0xFF9FCDE6),
    chartToday: Color(0xFF5AA9D6),
    caption: Color(0xFF8FB3C8),
    patientChip: Color(0xFFE5E8FD),
    patientIcon: Color(0xFF4F5FD7),
    paymentChip: Color(0xFFE3F6E9),
    paymentIcon: Color(0xFF16A34A),
    onPrimary: Color(0xFFFFFFFF),
    buttonShadow: Color(0x595AA9D6),
  );

  static const HomeTokens _dark = HomeTokens(
    pageBg: Color(0xFF0F1721),
    card: Color(0xFF17202B),
    ink: Color(0xFFE6EDF3),
    secondary: Color(0xFF93A8B8),
    muted: Color(0xFF7E93A4),
    chevron: Color(0xFF4A5A6A),
    hairline: Color(0xFF22303D),
    hairlineStrong: Color(0xFF2A3846),
    pressed: Color(0xFF1D2935),
    focusBorder: Color(0xFF35657F),
    primary: Color(0xFF5AA9D6),
    primaryDark: Color(0xFF7BBEE2),
    tint: Color(0xFF17313F),
    tintBorder: Color(0xFF23485C),
    revenueTop: Color(0xFF1A3444),
    revenueMid: Color(0xFF162A38),
    revenueEnd: Color(0xFF131F29),
    revenueBloom: Color(0x0DFFFFFF),
    chartLow: Color(0xFF2C4A5C),
    chartMid: Color(0xFF3E7794),
    chartToday: Color(0xFF5AA9D6),
    caption: Color(0xFF6F8FA3),
    patientChip: Color(0xFF1E2340),
    patientIcon: Color(0xFF8B97F0),
    paymentChip: Color(0xFF16301F),
    paymentIcon: Color(0xFF3FBF6B),
    onPrimary: Color(0xFFFFFFFF),
    buttonShadow: Color(0x005AA9D6),
  );
}
