import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'share_card_common.dart';

/// "Enamel" — the light card.
///
/// A blurred pearlescent ground with iridescent oil-slick highlights and a
/// specular sweep, with the hero number carved into the surface by paired
/// dark-above / light-below text shadows. Direct transcription of the
/// design's stylesheet; the comments carry the original CSS wherever the
/// Flutter equivalent is not self-evident.
class EnamelShareCard extends StatelessWidget {
  const EnamelShareCard({super.key, required this.data});

  final ShareCardData data;

  // ─ Palette ─────────────────────────────────────────────────────────────
  static const Color _ground = Color(0xFFE6F1F7);
  static const Color _ink = Color(0xFF08293A);
  static const Color _inkSoft = Color(0x800B3448); // rgba(11,52,72,0.5)
  static const Color _inkSofter = Color(0x850B3448); // rgba(11,52,72,0.52)
  static const Color _inkSubtle = Color(0x8C0B3448); // rgba(11,52,72,0.55)
  static const Color _brand = Color(0xFF199ED9);
  static const Color _brandDark = Color(0xFF147FAF);
  static const Color _brandDeep = Color(0xFF0E5C80);
  static const Color _rule = Color(0x330E4662); // rgba(14,70,98,0.2)
  static const Color _ruleFaint = Color(0x240E4662); // rgba(14,70,98,0.14)

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
              const _EnamelGround(),
              const _Iridescence(),
              const _SpecularSheen(),
              const _WetDepth(),
              Positioned.fill(
                child: Padding(
                  // padding: 96px 88px 80px
                  padding: const EdgeInsets.fromLTRB(88, 96, 88, 80),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
              const GrainOverlay(opacity: 0.1),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Ground ──────────────────────────────────────────────────────────────

/// `inset:-160px; filter: blur(90px) saturate(1.15)` over a base gradient
/// and four soft colour blobs. The oversized inset keeps the blur from
/// pulling transparent edges into the canvas.
class _EnamelGround extends StatelessWidget {
  const _EnamelGround();

  // The inset container measures 1080+320 x 1920+320; every percentage in
  // the source stylesheet is relative to that, so they are resolved here.
  static const double _w = ShareCardCanvas.width + 320;
  static const double _h = ShareCardCanvas.height + 320;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: -160,
      top: -160,
      width: _w,
      height: _h,
      child: ColorFiltered(
        colorFilter: _saturate(1.15),
        child: ImageFiltered(
          imageFilter: ui.ImageFilter.blur(
            sigmaX: blurSigma(90),
            sigmaY: blurSigma(90),
          ),
          child: Stack(
            children: [
              // linear-gradient(158deg, …)
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: CssLinearGradient(
              degrees: 158,
              colors: const [
                        Color(0xFFFBFEFF),
                        Color(0xFFDDEEF7),
                        Color(0xFFBFDCEC),
                        Color(0xFF9CC7DE),
                        Color(0xFFD6EAF4),
                      ],
                      stops: const [0.0, 0.26, 0.52, 0.74, 1.0],
                    ),
                  ),
                ),
              ),
              // White bloom, top-left.
              Positioned(
                left: -0.14 * _w,
                top: -0.08 * _h,
                child: GlowBlob(
                  width: 0.78 * _w,
                  height: 0.56 * _h,
                  center: const Alignment(-0.2, -0.2),
                  colors: const [
                    Color(0xF2FFFFFF),
                    Color(0x00FFFFFF),
                    Color(0x00FFFFFF),
                  ],
                  stops: const [0.0, 0.68, 1.0],
                ),
              ),
              // Brand-blue bloom, upper right.
              Positioned(
                right: -0.16 * _w,
                top: 0.18 * _h,
                child: GlowBlob(
                  width: 0.70 * _w,
                  height: 0.48 * _h,
                  colors: const [
                    Color(0x8C5EC1ED),
                    Color(0x2E199ED9),
                    Color(0x00199ED9),
                  ],
                  stops: const [0.0, 0.46, 0.72],
                ),
              ),
              // Cool bloom, lower left.
              Positioned(
                left: -0.10 * _w,
                bottom: -0.12 * _h,
                child: GlowBlob(
                  width: 0.86 * _w,
                  height: 0.52 * _h,
                  colors: const [
                    Color(0xCCA3D6EC),
                    Color(0x0078B4D2),
                    Color(0x0078B4D2),
                  ],
                  stops: const [0.0, 0.70, 1.0],
                ),
              ),
              // Warm counter-accent, lower right.
              Positioned(
                right: -0.08 * _w,
                bottom: 0.04 * _h,
                child: GlowBlob(
                  width: 0.64 * _w,
                  height: 0.40 * _h,
                  colors: const [
                    Color(0x99FFECD6),
                    Color(0x00FFE1BE),
                    Color(0x00FFE1BE),
                  ],
                  stops: const [0.0, 0.70, 1.0],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// CSS `filter: saturate(s)` as a colour matrix.
ColorFilter _saturate(double s) {
  const lr = 0.213, lg = 0.715, lb = 0.072;
  final ir = lr * (1 - s), ig = lg * (1 - s), ib = lb * (1 - s);
  return ColorFilter.matrix(<double>[
    ir + s, ig, ib, 0, 0, //
    ir, ig + s, ib, 0, 0, //
    ir, ig, ib + s, 0, 0, //
    0, 0, 0, 1, 0, //
  ]);
}

// ─── Iridescence ─────────────────────────────────────────────────────────

/// The two conic "oil slick" sweeps.
///
/// Painted rather than composed from widgets on purpose. `mix-blend-mode`
/// needs the sweep to blend against the ground already on the canvas, and
/// a widget subtree that pushes its own layer — which `ImageFiltered`
/// does — makes `PaintingContext.paintChild` append that layer to the
/// layer tree instead of drawing into the enclosing `saveLayer`, silently
/// dropping the blend mode. Keeping the blur on the `Paint` keeps
/// everything on one canvas, so the blend actually applies: `color-dodge`
/// over this pale ground blows out to white, which is the subtle sheen the
/// design wants — not the coloured haze a plain src-over composite gives.
class _Iridescence extends StatelessWidget {
  const _Iridescence();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(child: CustomPaint(painter: _IridescencePainter())),
    );
  }
}

class _IridescencePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // inset:-80px; conic from 40deg at 30% 22%;
    // mix-blend-mode: color-dodge; opacity:.34; filter: blur(58px)
    final a = Rect.fromLTWH(-80, -80, size.width + 160, size.height + 160);
    _sweep(
      canvas,
      rect: a,
      center: const Alignment(-0.4, -0.56),
      fromDegrees: 40,
      colors: const [
        Color(0x8C78FFF0),
        Color(0x8096BEFF),
        Color(0x73FFAADC),
        Color(0x66FFE6A0),
        Color(0x808CFFD2),
        Color(0x80A0C8FF),
        Color(0x8C78FFF0),
      ],
      stops: const [0.0, 0.18, 0.34, 0.50, 0.68, 0.84, 1.0],
      blur: blurSigma(58),
      blendMode: BlendMode.colorDodge,
      opacity: 0.34,
    );

    // left:-140; bottom:-260; 1200x900; conic from 200deg at 60% 50%;
    // mix-blend-mode: screen; opacity:.28; filter: blur(70px)
    final b = Rect.fromLTWH(-140, size.height - 900 + 260, 1200, 900);
    _sweep(
      canvas,
      rect: b,
      center: const Alignment(0.2, 0.0),
      fromDegrees: 200,
      colors: const [
        Color(0x80FF96C8),
        Color(0x73B4FFF0),
        Color(0x66FFF0AA),
        Color(0x80AABEFF),
        Color(0x80FF96C8),
      ],
      stops: const [0.0, 0.26, 0.54, 0.78, 1.0],
      blur: blurSigma(70),
      blendMode: BlendMode.screen,
      opacity: 0.28,
    );
  }

  void _sweep(
    Canvas canvas, {
    required Rect rect,
    required Alignment center,
    required double fromDegrees,
    required List<Color> colors,
    required List<double> stops,
    required double blur,
    required BlendMode blendMode,
    required double opacity,
  }) {
    canvas.saveLayer(
      rect,
      Paint()
        ..blendMode = blendMode
        ..color = Color.fromRGBO(0, 0, 0, opacity),
    );
    canvas.drawRect(
      rect,
      Paint()
        ..shader = SweepGradient(
          center: center,
          transform: conicFrom(fromDegrees),
          colors: colors,
          stops: stops,
        ).createShader(rect)
        ..imageFilter = ui.ImageFilter.blur(sigmaX: blur, sigmaY: blur),
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _IridescencePainter oldDelegate) => false;
}

/// `linear-gradient(118deg, transparent 26%, rgba(255,255,255,.62) 40%,
/// transparent 52%)` at 50% opacity — the highlight raking across the
/// surface.
class _SpecularSheen extends StatelessWidget {
  const _SpecularSheen();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Opacity(
        opacity: 0.5,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: CssLinearGradient(
              degrees: 118,
              colors: const [
                Color(0x00FFFFFF),
                Color(0x9EFFFFFF),
                Color(0x00FFFFFF),
              ],
              stops: const [0.26, 0.40, 0.52],
            ),
          ),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

/// `radial-gradient(ellipse at 52% 38%, …)` — a light core that falls off
/// into wet, darkened edges.
class _WetDepth extends StatelessWidget {
  const _WetDepth();

  @override
  Widget build(BuildContext context) {
    return const Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.04, -0.24),
            // Reaches the farthest corner of the 1080x1920 canvas.
            radius: 1.22,
            colors: [
              Color(0x2EFFFFFF),
              Color(0x00FFFFFF),
              Color(0x472E698C),
              Color(0x6B1C4A68),
            ],
            stops: [0.0, 0.44, 0.88, 1.0],
          ),
        ),
        child: SizedBox.expand(),
      ),
    );
  }
}

// ─── Masthead ────────────────────────────────────────────────────────────

class _Masthead extends StatelessWidget {
  const _Masthead({required this.data});

  final ShareCardData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PortraitRing(
              diameter: 148,
              ringWidth: 2.5,
              ringStartAngle: 190,
              ringColors: const [
                Color(0xFFFFFFFF),
                Color(0xFF5EC1ED),
                Color(0xFF147FAF),
                Color(0xFFFFE3C8),
                Color(0xFFFFFFFF),
              ],
              ringStops: const [0.0, 0.28, 0.52, 0.76, 1.0],
              innerPadding: 5,
              innerBacking: const Color(0xCCFFFFFF),
              avatarUrl: data.doctorAvatarUrl,
              initials: data.initials,
              initialsColor: EnamelShareCard._brandDark,
            ),
            const SizedBox(width: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 660,
                  child: Text(
                    data.displayName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: cardText(
                      size: 60,
                      weight: FontWeight.w700,
                      color: EnamelShareCard._ink,
                      letterSpacingEm: -0.035,
                      height: 1.0,
                    ),
                  ),
                ),
                const SizedBox(height: 9),
                SizedBox(
                  width: 660,
                  child: Text(
                    data.displayClinic,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: cardText(
                      size: 33,
                      weight: FontWeight.w500,
                      color: EnamelShareCard._brandDark,
                      letterSpacingEm: -0.01,
                      height: 1.0,
                    ),
                  ),
                ),
                const SizedBox(height: 9),
                Text(
                  data.metaLine,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: cardText(
                    size: 23,
                    weight: FontWeight.w400,
                    color: EnamelShareCard._inkSoft,
                    letterSpacingEm: 0.02,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 34),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          decoration: BoxDecoration(
            color: const Color(0x6BFFFFFF),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: const Color(0x6B147FAF), // rgba(20,127,175,.42)
              width: 1.5,
            ),
          ),
          child: Text(
            data.periodLabel,
            style: cardText(
              size: 22,
              weight: FontWeight.w500,
              color: EnamelShareCard._brandDeep,
              letterSpacingEm: 0.2,
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Hero ────────────────────────────────────────────────────────────────

/// Three superimposed copies of the number: a shadowed base that does the
/// carving, a brand gradient fill, and a top-light sheen.
class _Hero extends StatelessWidget {
  const _Hero({required this.value});

  final String value;

  static const double _size = 392;

  TextStyle get _metrics => cardText(
        size: _size,
        weight: FontWeight.w800,
        color: const Color(0xFF0F5478),
        letterSpacingEm: -0.055,
        height: 0.86,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.translate(
          offset: const Offset(-8, 0),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Stack(
              children: [
                // Carved base: dark above, light below.
                Text(
                  value,
                  style: _metrics.copyWith(
                    shadows: const [
                      Shadow(
                        offset: Offset(0, -3),
                        blurRadius: 3,
                        color: Color(0x99062638),
                      ),
                      Shadow(
                        offset: Offset(0, -9),
                        blurRadius: 20,
                        color: Color(0x4D062638),
                      ),
                      Shadow(
                        offset: Offset(0, 4),
                        blurRadius: 2,
                        color: Color(0xF2FFFFFF),
                      ),
                      Shadow(
                        offset: Offset(0, 12),
                        blurRadius: 28,
                        color: Color(0xA6FFFFFF),
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.92,
                    child: ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (rect) => CssLinearGradient(
              degrees: 166,
              colors: [
                          Color(0xFF8FD6F4),
                          Color(0xFF5EC1ED),
                          Color(0xFF199ED9),
                          Color(0xFF147FAF),
                          Color(0xFF0C5F86),
                        ],
                        stops: [0.0, 0.24, 0.52, 0.76, 1.0],
                      ).createShader(rect),
                      child: Text(value, style: _metrics),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (rect) => CssLinearGradient(
              degrees: 178,
              colors: [
                        Color(0xD9FFFFFF),
                        Color(0x1FFFFFFF),
                        Color(0x00FFFFFF),
                        Color(0x4DFFFFFF),
                      ],
                      stops: [0.0, 0.26, 0.46, 0.96],
                    ).createShader(rect),
                    child: Text(value, style: _metrics),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        Transform.translate(
          offset: const Offset(6, 0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 104,
                height: 2,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0x00147FAF), Color(0xFF199ED9)],
                  ),
                ),
              ),
              const SizedBox(width: 26),
              Text(
                'VISITS',
                style: cardText(
                  size: 40,
                  weight: FontWeight.w600,
                  color: const Color(0xFF0B3D57),
                  letterSpacingEm: 0.44,
                ),
              ),
            ],
          ),
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
      padding: const EdgeInsets.symmetric(vertical: 38),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: EnamelShareCard._rule),
          bottom: BorderSide(color: EnamelShareCard._rule),
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
              child: _Stat(
                value: data.completionValue,
                suffix: data.hasCompletion ? '%' : null,
                label: 'COMPLETED',
                divided: true,
              ),
            ),
            Expanded(
              child: _Stat(
                value: data.casesValue,
                label: 'CASES DONE',
                divided: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({
    required this.value,
    required this.label,
    this.suffix,
    this.divided = false,
  });

  final String value;
  final String? suffix;
  final String label;
  final bool divided;

  @override
  Widget build(BuildContext context) {
    final body = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text.rich(
          TextSpan(
            text: value,
            style: cardText(
              size: 74,
              weight: FontWeight.w700,
              color: EnamelShareCard._ink,
              letterSpacingEm: -0.04,
              height: 0.9,
            ),
            children: suffix == null
                ? null
                : [
                    TextSpan(
                      text: suffix,
                      style: cardText(
                        size: 44,
                        weight: FontWeight.w500,
                        color: EnamelShareCard._brand,
                        height: 0.9,
                      ),
                    ),
                  ],
          ),
          maxLines: 1,
        ),
        const SizedBox(height: 12),
        Text(
          label,
          maxLines: 1,
          style: cardText(
            size: 21,
            weight: FontWeight.w500,
            color: EnamelShareCard._inkSofter,
            letterSpacingEm: 0.17,
          ),
        ),
      ],
    );

    if (!divided) return body;
    return Container(
      padding: const EdgeInsets.only(left: 44),
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(color: EnamelShareCard._ruleFaint),
        ),
      ),
      child: body,
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
      padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 42),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        border: Border.all(color: const Color(0xBFFFFFFF)),
        gradient: CssLinearGradient(
              degrees: 140,
              colors: [
            Color(0x9EFFFFFF),
            Color(0x6BD6ECF7),
            Color(0x66FFE8CE),
          ],
          stops: [0.0, 0.6, 1.0],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x2E1C4A68),
            blurRadius: 60,
            offset: Offset(0, 26),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'TOP TREATMENT',
                  style: cardText(
                    size: 20,
                    weight: FontWeight.w600,
                    color: const Color(0xFF127198),
                    letterSpacingEm: 0.24,
                  ),
                ),
                const SizedBox(height: 14),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    name,
                    maxLines: 1,
                    style: cardText(
                      size: 66,
                      weight: FontWeight.w700,
                      color: EnamelShareCard._ink,
                      letterSpacingEm: -0.035,
                      height: 1.0,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  data.topTreatmentSub,
                  maxLines: 1,
                  style: cardText(
                    size: 25,
                    weight: FontWeight.w400,
                    color: EnamelShareCard._inkSubtle,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 30),
          const ToothGlyph(
            width: 104,
            height: 113,
            fill: Color(0x80FFFFFF),
            stroke: Color(0x8C147FAF),
            strokeWidth: 2.2,
            highlight: EnamelShareCard._brand,
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const DentaMark(
              size: 74,
              shadows: [
                BoxShadow(
                  color: Color(0x59145A82),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            const SizedBox(width: 26),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Denta',
                  style: cardText(
                    size: 34,
                    weight: FontWeight.w700,
                    color: EnamelShareCard._ink,
                    letterSpacingEm: -0.03,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'SCAN TO INSTALL',
                  style: cardText(
                    size: 20,
                    weight: FontWeight.w400,
                    color: EnamelShareCard._inkSoft,
                    letterSpacingEm: 0.13,
                  ),
                ),
              ],
            ),
          ],
        ),
        const ShareQrTile(
          size: 132,
          padding: 12,
          radius: 14,
          moduleColor: Color(0xFF0A2B3D),
          shadows: [
            BoxShadow(
              color: Color(0x471C4A68),
              blurRadius: 44,
              offset: Offset(0, 20),
            ),
          ],
        ),
      ],
    );
  }
}
