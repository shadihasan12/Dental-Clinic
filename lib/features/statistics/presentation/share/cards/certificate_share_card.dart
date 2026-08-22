import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'share_card_common.dart';

/// "Certificate" — the formal card.
///
/// Navy ground with engraved guilloché rosettes, a gold-to-blue foil
/// hairline border with corner ticks, and an embossed hero number. Reads
/// like something a doctor would frame rather than post.
class CertificateShareCard extends StatelessWidget {
  const CertificateShareCard({super.key, required this.data});

  final ShareCardData data;

  // ─ Palette ─────────────────────────────────────────────────────────────
  static const Color _ground = Color(0xFF08132E);
  static const Color _gold = Color(0xFFE8C87A);
  static const Color _sky = Color(0xFF5EC1ED);
  static const Color _mist = Color(0x6BCEDEF7); // rgba(206,222,247,.42)
  static const Color _mistLabel = Color(0x75CEDEF7); // .46
  static const Color _mistSub = Color(0x80CEDEF7); // .50
  static const Color _plate = Color(0xFF0B1C3A);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ShareCardCanvas.width,
      height: ShareCardCanvas.height,
      child: ClipRect(
        child: ColoredBox(
          color: _ground,
          child: Stack(
            children: [
              // radial-gradient(ellipse at 50% 26%, …)
              const Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment(0, -0.48),
                      radius: 1.41,
                      colors: [
                        Color(0xFF123056),
                        Color(0xFF0C2144),
                        Color(0xFF08152F),
                        Color(0xFF050C1E),
                      ],
                      stops: [0.0, 0.34, 0.62, 1.0],
                    ),
                  ),
                  child: SizedBox.expand(),
                ),
              ),
              const _Guilloche(opacity: 0.26),
              const _EngravedHatching(),
              const _FoilBorder(),
              Positioned.fill(
                child: Padding(
                  // padding: 120px 116px 108px
                  padding: const EdgeInsets.fromLTRB(116, 120, 116, 108),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _Masthead(data: data),
                      _Hero(value: data.heroValue),
                      _SecondaryStats(data: data),
                      _FeaturedTreatment(data: data),
                      const _Footer(),
                    ],
                  ),
                ),
              ),
              const GrainOverlay(opacity: 0.13),
              // Closing vignette.
              const Positioned.fill(
                child: IgnorePointer(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment(0, -0.2),
                        radius: 1.30,
                        colors: [
                          Color(0x00020610),
                          Color(0x6B020610),
                          Color(0x9E020610),
                        ],
                        stops: [0.46, 0.84, 1.0],
                      ),
                    ),
                    child: SizedBox.expand(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Guilloché ───────────────────────────────────────────────────────────

/// The engine-turned rosettes. Twenty wide ellipses stepped 9° apart plus
/// six inner ones stepped 30°, stamped four times at different scales —
/// exactly the `<use>` set from the source SVG. Kept as vector markup
/// because the stroke gradient and sub-pixel line weight matter.
class _Guilloche extends StatelessWidget {
  const _Guilloche({required this.opacity});

  final double opacity;

  static String _markup() {
    final b = StringBuffer()
      ..write('<svg xmlns="http://www.w3.org/2000/svg" '
          'xmlns:xlink="http://www.w3.org/1999/xlink" '
          'viewBox="0 0 1080 1920" width="1080" height="1920">')
      ..write('<defs>')
      ..write('<linearGradient id="engrave" x1="0" y1="0" x2="0.4" y2="1">')
      ..write('<stop offset="0" stop-color="#8FC8EE" stop-opacity="0.9"/>')
      ..write('<stop offset="0.5" stop-color="#E8C87A" stop-opacity="0.55"/>')
      ..write('<stop offset="1" stop-color="#5EC1ED" stop-opacity="0.5"/>')
      ..write('</linearGradient>')
      ..write('<g id="rosette" fill="none" stroke="url(#engrave)" '
          'stroke-width="0.85">');
    for (var a = 0; a < 180; a += 9) {
      b.write('<ellipse rx="330" ry="128"'
          '${a == 0 ? '' : ' transform="rotate($a)"'}/>');
    }
    for (var a = 0; a < 180; a += 30) {
      b.write('<ellipse rx="180" ry="70"'
          '${a == 0 ? '' : ' transform="rotate($a)"'}/>');
    }
    b
      ..write('</g></defs>')
      ..write('<use xlink:href="#rosette" '
          'transform="translate(540 880) scale(1.62)"/>')
      ..write('<use xlink:href="#rosette" '
          'transform="translate(540 880) scale(0.9) rotate(4.5)"/>')
      ..write('<use xlink:href="#rosette" '
          'transform="translate(120 1780) scale(0.52)" opacity="0.6"/>')
      ..write('<use xlink:href="#rosette" '
          'transform="translate(980 250) scale(0.46)" opacity="0.5"/>')
      ..write('</svg>');
    return b.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: Opacity(
          opacity: opacity,
          child: SvgPicture.string(
            _markup(),
            width: ShareCardCanvas.width,
            height: ShareCardCanvas.height,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

// ─── Engraved hatching ───────────────────────────────────────────────────

/// `repeating-linear-gradient(112deg, white 0-0.6px, transparent to 7px)`
/// at 7% opacity. Flutter has no repeating gradient, so the hairlines are
/// stroked directly on a rotated canvas.
class _EngravedHatching extends StatelessWidget {
  const _EngravedHatching();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: Opacity(
          opacity: 0.07,
          child: CustomPaint(painter: _HatchPainter()),
        ),
      ),
    );
  }
}

class _HatchPainter extends CustomPainter {
  /// The CSS gradient axis runs at 112° from 12 o'clock, which is 22° from
  /// the +x axis; the stripes sit perpendicular to it.
  static const double _axisFromX = 22 * math.pi / 180;
  static const double _period = 7;
  static const double _lineWidth = 0.6;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xB3FFFFFF) // rgba(255,255,255,.7)
      ..strokeWidth = _lineWidth
      ..isAntiAlias = true;

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(_axisFromX);
    // Half-diagonal, so the rotated lines still cover every corner.
    final reach = math.sqrt(
          size.width * size.width + size.height * size.height,
        ) /
        2;
    for (double x = -reach; x <= reach; x += _period) {
      canvas.drawLine(Offset(x, -reach), Offset(x, reach), paint);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _HatchPainter oldDelegate) => false;
}

// ─── Foil border ─────────────────────────────────────────────────────────

/// The `border-image` foil hairline at inset 38, its inset shadow, the
/// thin gold rule at inset 56, and the four corner ticks.
class _FoilBorder extends StatelessWidget {
  const _FoilBorder();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(child: CustomPaint(painter: _FoilPainter())),
    );
  }
}

class _FoilPainter extends CustomPainter {
  static const double _outerInset = 38;
  static const double _innerInset = 56;
  static const double _tick = 44;

  @override
  void paint(Canvas canvas, Size size) {
    final outer = Rect.fromLTRB(
      _outerInset,
      _outerInset,
      size.width - _outerInset,
      size.height - _outerInset,
    );

    // inset 0 0 60px rgba(4,10,26,.55) — a blurred stroke hugging the
    // inside edge, clipped so it only darkens inward.
    canvas.save();
    canvas.clipRect(outer);
    canvas.drawRect(
      outer.deflate(30),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 60
        ..color = const Color(0x8C040A1A)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20),
    );
    canvas.restore();

    // border-image: linear-gradient(146deg, …)
    canvas.drawRect(
      outer,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6
        ..shader = CssLinearGradient(
              degrees: 146,
              colors: [
            Color(0xFFF5E3B3),
            Color(0xFFC9A24A),
            Color(0xFF7E6A3A),
            Color(0xFF2E5B84),
            Color(0xFF5EC1ED),
            Color(0xFF199ED9),
            Color(0xFFE8C87A),
          ],
          stops: [0.0, 0.18, 0.34, 0.52, 0.68, 0.82, 1.0],
        ).createShader(outer),
    );

    // Inner hairline rule.
    final inner = Rect.fromLTRB(
      _innerInset,
      _innerInset,
      size.width - _innerInset,
      size.height - _innerInset,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(inner, const Radius.circular(3)),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8
        ..color = const Color(0x47E8C87A),
    );

    // Corner ticks.
    final tickPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = const Color(0xBFE8C87A);
    void corner(double x, double y, double dx, double dy) {
      canvas.drawLine(Offset(x, y), Offset(x + dx * _tick, y), tickPaint);
      canvas.drawLine(Offset(x, y), Offset(x, y + dy * _tick), tickPaint);
    }

    corner(inner.left, inner.top, 1, 1);
    corner(inner.right, inner.top, -1, 1);
    corner(inner.left, inner.bottom, 1, -1);
    corner(inner.right, inner.bottom, -1, -1);
  }

  @override
  bool shouldRepaint(covariant _FoilPainter oldDelegate) => false;
}

// ─── Masthead ────────────────────────────────────────────────────────────

class _Masthead extends StatelessWidget {
  const _Masthead({required this.data});

  final ShareCardData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PortraitRing(
          diameter: 146,
          ringWidth: 2,
          ringStartAngle: 200,
          ringColors: const [
            Color(0xFFF5E3B3),
            Color(0xFFC9A24A),
            Color(0xFF2E5B84),
            Color(0xFF5EC1ED),
            Color(0xFFF5E3B3),
          ],
          ringStops: const [0.0, 0.24, 0.48, 0.72, 1.0],
          innerPadding: 5,
          innerBacking: CertificateShareCard._plate,
          avatarUrl: data.doctorAvatarUrl,
          initials: data.initials,
          initialsColor: CertificateShareCard._sky,
        ),
        const SizedBox(height: 26),
        SizedBox(
          width: 848,
          child: Text(
            data.displayName,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: cardText(
              size: 58,
              weight: FontWeight.w700,
              color: Colors.white,
              letterSpacingEm: -0.035,
              height: 1.0,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 848,
          child: Text(
            data.displayClinic,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: cardText(
              size: 31,
              weight: FontWeight.w500,
              color: CertificateShareCard._sky,
              letterSpacingEm: -0.01,
              height: 1.0,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          data.metaLine,
          textAlign: TextAlign.center,
          maxLines: 1,
          style: cardText(
            size: 22,
            weight: FontWeight.w400,
            color: CertificateShareCard._mist,
            letterSpacingEm: 0.04,
          ),
        ),
        const SizedBox(height: 26),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0x800A1A36),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: const Color(0x73E8C87A)),
          ),
          child: Text(
            data.periodLabel,
            style: cardText(
              size: 21,
              weight: FontWeight.w500,
              color: const Color(0xEBF4E5C4),
              letterSpacingEm: 0.22,
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Hero ────────────────────────────────────────────────────────────────

class _Hero extends StatelessWidget {
  const _Hero({required this.value});

  final String value;

  static const double _size = 330;

  TextStyle get _metrics => cardText(
        size: _size,
        weight: FontWeight.w800,
        color: const Color(0xFF0B1B3A),
        letterSpacingEm: -0.055,
        height: 0.86,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Stack(
            children: [
              // Embossed base — a dark lip above, a cool highlight below.
              Text(
                value,
                style: _metrics.copyWith(
                  shadows: const [
                    Shadow(
                      offset: Offset(0, -2),
                      blurRadius: 1,
                      color: Color(0xE6040916),
                    ),
                    Shadow(
                      offset: Offset(0, 2),
                      blurRadius: 1,
                      color: Color(0x52A3C5E8),
                    ),
                    Shadow(
                      offset: Offset(0, 3),
                      color: Color(0x29C8DEF7),
                    ),
                  ],
                ),
              ),
              // Foil fill over the emboss.
              //
              // The stylesheet screens this layer, but a `ShaderMask`
              // pushes its own compositing layer, which would make the
              // enclosing blend a no-op. It costs nothing here: the base
              // underneath is near-black navy, and screening a bright
              // gradient over near-black returns the gradient essentially
              // unchanged, so drawing it straight is the same picture.
              Positioned.fill(
                child: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (rect) => CssLinearGradient(
                    degrees: 168,
                    colors: [
                        Color(0xFFFFFFFF),
                        Color(0xFFEAF6FF),
                        Color(0xFF9CCBE9),
                        Color(0xFF5EC1ED),
                        Color(0xFF199ED9),
                        Color(0xFFE8C87A),
                        Color(0xFFC9A24A),
                      ],
                    stops: [0.0, 0.14, 0.34, 0.50, 0.64, 0.84, 1.0],
                  ).createShader(rect),
                  child: Text(value, style: _metrics),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 34),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 120,
              height: 1,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0x00E8C87A), Color(0xD9E8C87A)],
                ),
              ),
            ),
            const SizedBox(width: 24),
            Text(
              'VISITS',
              style: cardText(
                size: 36,
                weight: FontWeight.w600,
                color: const Color(0xF2EEF6FF),
                letterSpacingEm: 0.5,
              ),
            ),
            const SizedBox(width: 24),
            Container(
              width: 120,
              height: 1,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xD9E8C87A), Color(0x00E8C87A)],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ─── Secondary stats ─────────────────────────────────────────────────────

class _SecondaryStats extends StatelessWidget {
  const _SecondaryStats({required this.data});

  final ShareCardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 36),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0x38E8C87A)),
          bottom: BorderSide(color: Color(0x38E8C87A)),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: _Stat(value: data.newPatientsValue, label: 'NEW SMILES'),
            ),
            Expanded(
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  border: Border(
                    left: BorderSide(color: Color(0x17FFFFFF)),
                    right: BorderSide(color: Color(0x17FFFFFF)),
                  ),
                ),
                child: _Stat(
                  value: data.completionValue,
                  suffix: data.hasCompletion ? '%' : null,
                  label: 'COMPLETED',
                ),
              ),
            ),
            Expanded(
              child: _Stat(value: data.casesValue, label: 'CASES DONE'),
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label, this.suffix});

  final String value;
  final String? suffix;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text.rich(
          TextSpan(
            text: value,
            style: cardText(
              size: 70,
              weight: FontWeight.w700,
              color: Colors.white,
              letterSpacingEm: -0.04,
              height: 0.9,
            ),
            children: suffix == null
                ? null
                : [
                    TextSpan(
                      text: suffix,
                      style: cardText(
                        size: 42,
                        weight: FontWeight.w500,
                        color: CertificateShareCard._gold,
                        height: 0.9,
                      ),
                    ),
                  ],
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
        ),
        const SizedBox(height: 12),
        Text(
          label,
          textAlign: TextAlign.center,
          maxLines: 1,
          style: cardText(
            size: 20,
            weight: FontWeight.w500,
            color: CertificateShareCard._mistLabel,
            letterSpacingEm: 0.2,
          ),
        ),
      ],
    );
  }
}

// ─── Featured treatment ──────────────────────────────────────────────────

class _FeaturedTreatment extends StatelessWidget {
  const _FeaturedTreatment({required this.data});

  final ShareCardData data;

  @override
  Widget build(BuildContext context) {
    final name = data.topTreatmentName;
    if (name == null) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0x4DE8C87A)),
        gradient: CssLinearGradient(
              degrees: 160,
              colors: [Color(0xB8122C50), Color(0x9908142C)],
        ),
      ),
      child: Stack(
        children: [
          // Lit top edge.
          const Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: 1,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0x1AE8C87A),
                    Color(0xCCF5E3B3),
                    Color(0x805EC1ED),
                    Color(0x1AE8C87A),
                  ],
                  stops: [0.0, 0.30, 0.78, 1.0],
                ),
              ),
              child: SizedBox.expand(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'TOP TREATMENT',
                        style: cardText(
                          size: 19,
                          weight: FontWeight.w600,
                          color: const Color(0xD9E8C87A),
                          letterSpacingEm: 0.26,
                        ),
                      ),
                      const SizedBox(height: 12),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          name,
                          maxLines: 1,
                          style: cardText(
                            size: 62,
                            weight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacingEm: -0.035,
                            height: 1.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        data.topTreatmentSub,
                        maxLines: 1,
                        style: cardText(
                          size: 24,
                          weight: FontWeight.w400,
                          color: CertificateShareCard._mistSub,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 28),
                const ToothGlyph(
                  width: 98,
                  height: 106,
                  stroke: Color(0x99E8C87A),
                  strokeWidth: 2.2,
                  highlight: CertificateShareCard._sky,
                  highlightWidth: 3.2,
                  sparkleColor: CertificateShareCard._gold,
                  sparkleStyle: SparkleStyle.faceted,
                  opacity: 0.9,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Footer ──────────────────────────────────────────────────────────────

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const DentaMark(size: 70),
            const SizedBox(width: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Denta',
                  style: cardText(
                    size: 32,
                    weight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacingEm: -0.03,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'SCAN TO INSTALL',
                  style: cardText(
                    size: 19,
                    weight: FontWeight.w400,
                    color: const Color(0x70CEDEF7),
                    letterSpacingEm: 0.15,
                  ),
                ),
              ],
            ),
          ],
        ),
        const ShareQrTile(
          size: 126,
          padding: 11,
          // The certificate keeps its QR square — no rounding.
          radius: 0,
          moduleColor: CertificateShareCard._plate,
          shadows: [
            BoxShadow(
              color: Color(0x99030814),
              blurRadius: 40,
              offset: Offset(0, 18),
            ),
          ],
        ),
      ],
    );
  }
}
