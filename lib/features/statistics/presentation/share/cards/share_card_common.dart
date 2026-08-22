import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../share_statistics.dart';

/// Shared vocabulary for the three shareable card designs.
///
/// Every card renders on the same absolute 1080x1920 canvas at native
/// resolution inside a `RepaintBoundary` captured at `pixelRatio: 1.0`.
/// Nothing under `cards/` may use `flutter_screenutil` `.w/.h/.sp` — the
/// capture is resolution-independent and `.sp` would distort it.
///
/// The cards are deliberately English-only regardless of app locale: the
/// designs depend on uppercase micro-labels with wide tracking, which
/// Arabic cannot express (no uppercase, and letter-spacing severs the
/// script's letter joining).
class ShareCardCanvas {
  ShareCardCanvas._();

  static const double width = 1080;
  static const double height = 1920;

  /// Landing page the QR points to. Swap this single constant when the
  /// real smartlink is ready.
  static const String appUrl = 'https://denta.pro';

  static const String fontFamily = 'Geist';

  /// Tiling noise standing in for the CSS `feTurbulence` grain, which
  /// Flutter has no equivalent for. Generated to match fractalNoise at
  /// baseFrequency ~0.85 and composited with [BlendMode.overlay].
  static const String grainAsset = 'assets/images/share/grain.png';

  /// The Editorial card's warped topographic contours. Baked to a bitmap
  /// because it is an `feTurbulence` + `feDisplacementMap` chain with a
  /// fixed seed — static output, and unreachable from Flutter's painting
  /// API. Drawn with [BlendMode.screen] at the design's 0.3 opacity.
  static const String editorialContoursAsset =
      'assets/images/share/editorial_contours.png';
}

/// Everything the cards render, gathered once by the share sheet so all
/// three templates read from an identical source.
class ShareCardData {
  const ShareCardData({
    required this.stats,
    required this.doctorName,
    required this.clinicName,
    required this.clinicCount,
    required this.daysOnPlatform,
    this.doctorAvatarUrl,
  });

  final ShareStatistics stats;
  final String doctorName;
  final String clinicName;
  final int clinicCount;
  final int daysOnPlatform;
  final String? doctorAvatarUrl;

  String get displayName {
    final n = doctorName.trim();
    return n.isEmpty ? 'Doctor' : n;
  }

  String get displayClinic {
    final c = clinicName.trim();
    return c.isEmpty ? 'Smile Center' : c;
  }

  /// "3 clinics · 214 days caring"
  String get metaLine {
    final clinicLabel = clinicCount == 1 ? 'clinic' : 'clinics';
    final daysLabel = daysOnPlatform == 1 ? 'day caring' : 'days caring';
    return '$clinicCount $clinicLabel · $daysOnPlatform $daysLabel';
  }

  /// "SMILE REPORT · MAR 15 – 21, 2026"
  String get periodLabel =>
      'SMILE REPORT · ${formatDateRange(stats.startDate, stats.endDate)}';

  String get heroValue =>
      stats.visits == null ? '—' : formatCount(stats.visits!);

  String get newPatientsValue =>
      stats.newPatients == null ? '—' : '+${formatCount(stats.newPatients!)}';

  /// Split from its `%` so the sign can be typeset smaller and in the
  /// accent colour, the way all three designs do it.
  String get completionValue => stats.completionRate == null
      ? '—'
      : '${(stats.completionRate! * 100).round()}';

  bool get hasCompletion => stats.completionRate != null;

  String get casesValue =>
      stats.completedCases == null ? '—' : formatCount(stats.completedCases!);

  String? get topTreatmentName {
    final n = stats.topTreatmentName;
    return (n == null || n.isEmpty) ? null : n;
  }

  String get topTreatmentSub => stats.topTreatmentCount == null
      ? 'Most requested'
      : '${stats.topTreatmentCount} procedures';

  /// Up to two initials, for the portrait fallback when no avatar is set.
  String get initials {
    final cleaned = displayName
        .replaceAll(RegExp(r'^(dr\.?|د\.?)\s*', caseSensitive: false), '')
        .trim();
    final parts = cleaned.split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
    if (parts.isEmpty) return 'D';
    final letters = parts.take(2).map((p) => p[0].toUpperCase()).join();
    return letters.isEmpty ? 'D' : letters;
  }
}

/// Thousands separator without a locale-aware formatter — the card is
/// English-only, so the grouping is always a comma.
String formatCount(int n) {
  final s = n.abs().toString();
  final buf = StringBuffer(n < 0 ? '-' : '');
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
    buf.write(s[i]);
  }
  return buf.toString();
}

/// English month abbreviations, spelled out rather than taken from
/// `DateFormat`. The card is English-only, and `DateFormat.MMM('en')`
/// throws `LocaleDataException` unless date symbols were initialised —
/// while the no-argument form would follow `Intl.defaultLocale` and render
/// Arabic months once the app is switched to `ar`.
const List<String> _monthAbbr = <String>[
  'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', //
  'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC',
];

/// Compact range label: "MAR 15 – 21, 2026" inside a month, "MAR 28 – APR
/// 14, 2026" across months, both years spelled out when they differ.
String formatDateRange(DateTime start, DateTime end) {
  final mon = _monthAbbr[start.month - 1];
  final monEnd = _monthAbbr[end.month - 1];
  if (start.year != end.year) {
    return '$mon ${start.day}, ${start.year} – $monEnd ${end.day}, ${end.year}';
  }
  if (start.month == end.month) {
    return '$mon ${start.day} – ${end.day}, ${end.year}';
  }
  return '$mon ${start.day} – $monEnd ${end.day}, ${end.year}';
}

/// Converts a CSS `letter-spacing` in `em` to the logical pixels Flutter
/// wants, so the card source stays readable against the original
/// stylesheet.
double tracking(double fontSize, double em) => fontSize * em;

/// CSS `filter: blur(R)` is a Gaussian with standard deviation R/2, so a
/// literal transcription of the design's blur radii needs halving.
double blurSigma(double cssRadius) => cssRadius / 2;

/// Degrees to radians, for the conic-gradient transcriptions.
double deg(double degrees) => degrees * math.pi / 180;

/// Base text style every card label derives from.
TextStyle cardText({
  required double size,
  required FontWeight weight,
  required Color color,
  double? letterSpacingEm,
  double? height,
  List<Shadow>? shadows,
}) {
  return TextStyle(
    fontFamily: ShareCardCanvas.fontFamily,
    fontSize: size,
    fontWeight: weight,
    color: color,
    letterSpacing:
        letterSpacingEm == null ? null : tracking(size, letterSpacingEm),
    height: height,
    leadingDistribution: TextLeadingDistribution.even,
    shadows: shadows,
  );
}

/// CSS `conic-gradient(from Ndeg, …)` measures clockwise from 12 o'clock;
/// Flutter's [SweepGradient] starts at 3 o'clock.
GradientRotation conicFrom(double degrees) => GradientRotation(deg(degrees - 90));

/// Shader for a CSS `linear-gradient(Ndeg, …)` across [rect].
///
/// Flutter's [LinearGradient] takes begin/end in normalised [Alignment]
/// space, so the same pair describes a different physical angle depending
/// on the box's aspect ratio — a "nearly vertical" 168° gradient turns
/// almost horizontal once the box is much wider than it is tall. CSS
/// angles are true geometric directions, with the gradient line scaled to
/// cover the box, so the endpoints have to come from the rect itself.
ui.Shader cssLinearShader(
  Rect rect,
  double degrees,
  List<Color> colors, [
  List<double>? stops,
]) {
  // CSS 0deg points up (toward -y) and increases clockwise.
  final a = deg(degrees);
  final dx = math.sin(a);
  final dy = -math.cos(a);
  final length = (rect.width * dx).abs() + (rect.height * dy).abs();
  final half = Offset(dx, dy) * (length / 2);
  return ui.Gradient.linear(
    rect.center - half,
    rect.center + half,
    colors,
    stops,
  );
}

/// [cssLinearShader] packaged as a [Gradient] so it drops into
/// [BoxDecoration.gradient].
class CssLinearGradient extends Gradient {
  const CssLinearGradient({
    required this.degrees,
    required super.colors,
    super.stops,
  });

  final double degrees;

  @override
  ui.Shader createShader(Rect rect, {TextDirection? textDirection}) =>
      cssLinearShader(rect, degrees, colors, stops);

  @override
  Gradient scale(double factor) => CssLinearGradient(
        degrees: degrees,
        colors: [
          for (final c in colors) Color.lerp(null, c, factor) ?? c,
        ],
        stops: stops,
      );

  @override
  Gradient withOpacity(double opacity) => CssLinearGradient(
        degrees: degrees,
        colors: [
          for (final c in colors) c.withValues(alpha: opacity),
        ],
        stops: stops,
      );
}

// ─── Grain ───────────────────────────────────────────────────────────────

/// Tiled film grain, composited exactly like the CSS layer it replaces:
/// `opacity: N; mix-blend-mode: overlay`.
class GrainOverlay extends StatelessWidget {
  const GrainOverlay({super.key, required this.opacity});

  final double opacity;

  @override
  Widget build(BuildContext context) {
    if (opacity <= 0) return const SizedBox.shrink();
    return Positioned.fill(
      child: BlendLayer(
        blendMode: BlendMode.overlay,
        opacity: opacity,
        child: const DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ShareCardCanvas.grainAsset),
              repeat: ImageRepeat.repeat,
              filterQuality: FilterQuality.none,
            ),
          ),
          child: SizedBox.expand(),
        ),
      ),
    );
  }
}

// ─── Blend-mode layer ────────────────────────────────────────────────────

/// Paints [child] into the tree through an arbitrary [BlendMode] — the
/// stand-in for CSS `mix-blend-mode`. The saveLayer is what lets the mode
/// see the pixels already on the canvas underneath.
class BlendLayer extends StatelessWidget {
  const BlendLayer({
    super.key,
    required this.blendMode,
    required this.child,
    this.opacity = 1.0,
  });

  final BlendMode blendMode;
  final double opacity;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: _BlendPainter(
        blendMode: blendMode,
        opacity: opacity,
        child: child,
      ),
    );
  }
}

class _BlendPainter extends SingleChildRenderObjectWidget {
  const _BlendPainter({
    required this.blendMode,
    required this.opacity,
    required Widget super.child,
  });

  final BlendMode blendMode;
  final double opacity;

  @override
  _RenderBlend createRenderObject(BuildContext context) =>
      _RenderBlend(blendMode, opacity);

  @override
  void updateRenderObject(BuildContext context, _RenderBlend renderObject) {
    renderObject
      ..blendMode = blendMode
      ..opacity = opacity;
  }
}

class _RenderBlend extends RenderProxyBox {
  _RenderBlend(this._blendMode, this._opacity);

  BlendMode _blendMode;
  set blendMode(BlendMode value) {
    if (_blendMode == value) return;
    _blendMode = value;
    markNeedsPaint();
  }

  double _opacity;
  set opacity(double value) {
    if (_opacity == value) return;
    _opacity = value;
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final target = child;
    if (target == null) return;
    // Opacity rides on the saveLayer paint rather than a wrapping Opacity
    // widget: an extra layer would give the blend mode that layer as its
    // backdrop instead of the card painted underneath.
    context.canvas.saveLayer(
      offset & size,
      Paint()
        ..blendMode = _blendMode
        ..color = Color.fromRGBO(0, 0, 0, _opacity.clamp(0.0, 1.0)),
    );
    context.paintChild(target, offset);
    context.canvas.restore();
  }
}

// ─── Soft radial glow ────────────────────────────────────────────────────

/// A CSS `radial-gradient(circle at …, colorA, transparent)` blob — the
/// atmospheric lighting every card is built on.
class GlowBlob extends StatelessWidget {
  const GlowBlob({
    super.key,
    required this.width,
    required this.height,
    required this.colors,
    required this.stops,
    this.center = Alignment.center,
  });

  final double width;
  final double height;
  final List<Color> colors;
  final List<double> stops;
  final Alignment center;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.elliptical(width / 2, height / 2),
          ),
          gradient: RadialGradient(
            center: center,
            colors: colors,
            stops: stops,
          ),
        ),
      ),
    );
  }
}

// ─── Portrait ────────────────────────────────────────────────────────────

/// The circular doctor portrait with its conic gradient ring. All three
/// designs share this construction, differing only in ring colours and the
/// inner backing plate.
class PortraitRing extends StatelessWidget {
  const PortraitRing({
    super.key,
    required this.diameter,
    required this.ringColors,
    required this.ringStops,
    required this.ringStartAngle,
    required this.ringWidth,
    required this.innerPadding,
    required this.innerBacking,
    required this.avatarUrl,
    required this.initials,
    required this.initialsColor,
    this.shadows,
  });

  final double diameter;
  final List<Color> ringColors;
  final List<double> ringStops;
  final double ringStartAngle;
  final double ringWidth;
  final double innerPadding;
  final Color innerBacking;
  final String? avatarUrl;
  final String initials;
  final Color initialsColor;
  final List<BoxShadow>? shadows;

  @override
  Widget build(BuildContext context) {
    final inner = diameter - (ringWidth * 2);
    final photo = inner - (innerPadding * 2);
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: shadows,
        gradient: SweepGradient(
          transform: conicFrom(ringStartAngle),
          colors: ringColors,
          stops: ringStops,
        ),
      ),
      child: Center(
        child: Container(
          width: inner,
          height: inner,
          padding: EdgeInsets.all(innerPadding),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: innerBacking,
          ),
          child: ClipOval(
            child: SizedBox(
              width: photo,
              height: photo,
              child: _photo(photo),
            ),
          ),
        ),
      ),
    );
  }

  Widget _photo(double size) {
    final url = avatarUrl;
    if (url == null || url.isEmpty) return _fallback(size);
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) => _fallback(size),
    );
  }

  Widget _fallback(double size) {
    return ColoredBox(
      color: innerBacking,
      child: Center(
        child: Text(
          initials,
          style: cardText(
            size: size * 0.36,
            weight: FontWeight.w700,
            color: initialsColor,
            letterSpacingEm: 0.02,
            height: 1.0,
          ),
        ),
      ),
    );
  }
}

// ─── Brand mark ──────────────────────────────────────────────────────────

/// The Denta app icon: a rounded square in the brand gradient with the
/// tooth glyph knocked out in white. Vector, so it stays crisp at the
/// card's native 1080-px scale.
class DentaMark extends StatelessWidget {
  const DentaMark({super.key, required this.size, this.shadows});

  final double size;
  final List<BoxShadow>? shadows;

  static const String _svg =
      '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64">'
      '<defs><linearGradient id="m" x1="0" y1="0" x2="1" y2="1">'
      '<stop offset="0" stop-color="#5EC1ED"/>'
      '<stop offset="0.55" stop-color="#199ED9"/>'
      '<stop offset="1" stop-color="#147FAF"/>'
      '</linearGradient></defs>'
      '<rect x="0" y="0" width="64" height="64" rx="18" fill="url(#m)"/>'
      '<path d="M32 14c-4.4 0-7.3 2.2-11.7 2.2S13 13.6 13 22.3c0 6.3 2.2 10.1 3.6 15.7 '
      '1.4 5.4 2.3 12 6 12 3.2 0 3.7-5.9 4.6-10.4.8-3.7 1.8-6 4.3-6s3.5 2.3 4.3 6c.9 4.5 '
      '1.4 10.4 4.6 10.4 3.7 0 4.6-6.6 6-12C47.8 32.4 50 28.6 50 22.3c0-8.7-2.4-6-6.8-6'
      'S36.4 14 32 14z" fill="#fff"/>'
      '</svg>';

  @override
  Widget build(BuildContext context) {
    final mark = SvgPicture.string(_svg, width: size, height: size);
    if (shadows == null) return mark;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 18 / 64),
        boxShadow: shadows,
      ),
      child: mark,
    );
  }
}

// ─── Tooth glyph ─────────────────────────────────────────────────────────

enum SparkleStyle { none, faceted, fourPoint }

/// The tooth outline beside "TOP TREATMENT". Each design tints it
/// differently and two add a sparkle, so fill, stroke and sparkle are all
/// parameterised off one shared path.
class ToothGlyph extends StatelessWidget {
  const ToothGlyph({
    super.key,
    required this.width,
    required this.height,
    required this.stroke,
    required this.strokeWidth,
    this.fill,
    this.highlight,
    this.highlightWidth = 3.4,
    this.sparkleColor,
    this.sparkleStyle = SparkleStyle.none,
    this.opacity = 1.0,
  });

  final double width;
  final double height;
  final Color stroke;
  final double strokeWidth;
  final Color? fill;
  final Color? highlight;
  final double highlightWidth;
  final Color? sparkleColor;
  final SparkleStyle sparkleStyle;
  final double opacity;

  static const String _body =
      'M22 30c9-13 22-16 38-16s29 3 38 16c8 11 6 26 2 42-4 15-6 20-9 38-2 13-4 26-12 26'
      's-9-15-12-28c-2-11-4-16-11-16s-9 5-11 16c-3 13-4 28-12 28s-10-13-12-26c-3-18-5-23-9-38'
      '-4-16-6-31 2-42z';

  @override
  Widget build(BuildContext context) {
    final buf = StringBuffer()
      ..write('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 120 130">')
      ..write('<path d="$_body" fill="${svgColor(fill)}" '
          'stroke="${svgColor(stroke)}" stroke-width="$strokeWidth"/>');
    if (highlight != null) {
      buf.write('<path d="M44 46c-9 4-13 12-11 22" fill="none" '
          'stroke="${svgColor(highlight)}" stroke-width="$highlightWidth" '
          'stroke-linecap="round"/>');
    }
    if (sparkleStyle != SparkleStyle.none && sparkleColor != null) {
      final d = sparkleStyle == SparkleStyle.faceted
          ? 'M84 20l3.4 10.6L98 34l-10.6 3.4L84 48l-3.4-10.6L70 34l10.6-3.4z'
          : 'M84 20l4 12 12 4-12 4-4 12-4-12-12-4 12-4z';
      buf.write('<path d="$d" fill="${svgColor(sparkleColor)}"/>');
    }
    buf.write('</svg>');

    final glyph =
        SvgPicture.string(buf.toString(), width: width, height: height);
    return opacity >= 1.0 ? glyph : Opacity(opacity: opacity, child: glyph);
  }
}

/// Serialises a [Color] into an SVG `rgba()` literal, alpha included.
String svgColor(Color? c) {
  if (c == null) return 'none';
  final r = (c.r * 255).round();
  final g = (c.g * 255).round();
  final b = (c.b * 255).round();
  return 'rgba($r,$g,$b,${c.a.toStringAsFixed(3)})';
}

// ─── QR ──────────────────────────────────────────────────────────────────

/// The scan-to-install tile. Unlike the mockups — which draw a decorative
/// pseudo-QR — this encodes the real URL, so the shared image actually
/// resolves when scanned.
class ShareQrTile extends StatelessWidget {
  const ShareQrTile({
    super.key,
    required this.size,
    required this.padding,
    required this.radius,
    required this.moduleColor,
    this.shadows,
  });

  final double size;
  final double padding;
  final double radius;
  final Color moduleColor;
  final List<BoxShadow>? shadows;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: shadows,
      ),
      child: QrImageView(
        data: ShareCardCanvas.appUrl,
        version: QrVersions.auto,
        size: size - (padding * 2),
        gapless: true,
        padding: EdgeInsets.zero,
        eyeStyle: QrEyeStyle(
          eyeShape: QrEyeShape.square,
          color: moduleColor,
        ),
        dataModuleStyle: QrDataModuleStyle(
          dataModuleShape: QrDataModuleShape.square,
          color: moduleColor,
        ),
      ),
    );
  }
}
