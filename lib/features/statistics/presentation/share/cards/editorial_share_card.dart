import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'share_card_common.dart';

/// "Editorial" — the dark card.
///
/// Midnight-teal ground with a coral counter-accent, a volumetric light
/// shaft, warped topographic contours, and a hero number tipped off-axis
/// with a molar cross-section graph overlapping it.
class EditorialShareCard extends StatelessWidget {
  const EditorialShareCard({super.key, required this.data});

  final ShareCardData data;

  // ─ Palette ─────────────────────────────────────────────────────────────
  static const Color _ground = Color(0xFF061412);
  static const Color _sky = Color(0xFF5EC1ED);

  /// The design's `accent` prop. Its default drives the warm glow, the
  /// sparkle, and the featured block's far gradient stop.
  static const Color _accent = Color(0xFFFF9A6B);
  static const Color _mist = Color(0x6BFFFFFF); // rgba(255,255,255,.42)
  static const Color _mistLabel = Color(0x75FFFFFF); // .46
  static const Color _mistSub = Color(0x80FFFFFF); // .50

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
              // linear-gradient(163deg, …)
              const Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: CssLinearGradient(
              degrees: 163,
              colors: [
                        Color(0xFF0C3A45),
                        Color(0xFF08222C),
                        Color(0xFF061519),
                        Color(0xFF040D10),
                      ],
                      stops: [0.0, 0.34, 0.62, 1.0],
                    ),
                  ),
                  child: SizedBox.expand(),
                ),
              ),
              // Warm counter-accent bleeding in from bottom-right.
              Positioned(
                right: -360,
                bottom: -300,
                child: ImageFiltered(
                  imageFilter: ui.ImageFilter.blur(
                    sigmaX: blurSigma(10),
                    sigmaY: blurSigma(10),
                  ),
                  child: const GlowBlob(
                    width: 1180,
                    height: 1180,
                    colors: [
                      Color(0x75FF9A6B),
                      Color(0x38FF9A6B),
                      Color(0x0FFF9A6B),
                      Color(0x00FF9A6B),
                    ],
                    stops: [0.0, 0.32, 0.58, 0.75],
                  ),
                ),
              ),
              // Cool bloom, top-left.
              const Positioned(
                left: -220,
                top: -260,
                child: GlowBlob(
                  width: 1000,
                  height: 900,
                  center: Alignment(-0.4, -0.4),
                  colors: [
                    Color(0x575EC1ED),
                    Color(0x24199ED9),
                    Color(0x00199ED9),
                  ],
                  stops: [0.0, 0.38, 0.70],
                ),
              ),
              // Volumetric light shaft from the top-left.
              Positioned(
                left: -320,
                top: -420,
                width: 1500,
                height: 1500,
                child: ImageFiltered(
                  imageFilter: ui.ImageFilter.blur(
                    sigmaX: blurSigma(24),
                    sigmaY: blurSigma(24),
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: SweepGradient(
                        center: const Alignment(-0.76, -0.84),
                        transform: conicFrom(128),
                        colors: const [
                          Color(0x21FFFFFF),
                          Color(0x05FFFFFF),
                          Color(0x00FFFFFF),
                          Color(0x00FFFFFF),
                        ],
                        // 0deg / 26deg / 48deg of a full turn.
                        stops: const [0.0, 0.0722, 0.1333, 1.0],
                      ),
                    ),
                    child: const SizedBox.expand(),
                  ),
                ),
              ),
              // Warped topographic contours — pre-rendered, see
              // ShareCardCanvas.editorialContoursAsset.
              const Positioned.fill(
                child: BlendLayer(
                  blendMode: BlendMode.screen,
                  opacity: 0.3,
                  child: Image(
                    image: AssetImage(ShareCardCanvas.editorialContoursAsset),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const _EngravedHairlines(),
              Positioned.fill(
                child: Padding(
                  // padding: 92px 84px 76px
                  padding: const EdgeInsets.fromLTRB(84, 92, 84, 76),
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
              const GrainOverlay(opacity: 0.16),
              // Closing vignette.
              const Positioned.fill(
                child: IgnorePointer(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment(0, -0.12),
                        radius: 1.28,
                        colors: [
                          Color(0x00000000),
                          Color(0x57000000),
                          Color(0x8C000000),
                        ],
                        stops: [0.42, 0.82, 1.0],
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

// ─── Engraved hairlines ──────────────────────────────────────────────────

/// `repeating-linear-gradient(74deg, …)` at 10% opacity, faded out toward
/// the edges by a radial mask so the lines only read near the centre.
class _EngravedHairlines extends StatelessWidget {
  const _EngravedHairlines();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: ShaderMask(
          blendMode: BlendMode.dstIn,
          shaderCallback: (rect) => const RadialGradient(
            center: Alignment(0.24, -0.08),
            radius: 0.9,
            colors: [
              Color(0xFF000000),
              Color(0x59000000),
              Color(0x00000000),
            ],
            stops: [0.0, 0.52, 0.78],
          ).createShader(rect),
          child: Opacity(
            opacity: 0.1,
            child: CustomPaint(painter: _HairlinePainter()),
          ),
        ),
      ),
    );
  }
}

class _HairlinePainter extends CustomPainter {
  /// 74° from 12 o'clock is -16° from the +x axis.
  static const double _axisFromX = -16 * math.pi / 180;
  static const double _period = 9;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x8CFFFFFF) // rgba(255,255,255,.55)
      ..strokeWidth = 0.7
      ..isAntiAlias = true;

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(_axisFromX);
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
  bool shouldRepaint(covariant _HairlinePainter oldDelegate) => false;
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
              diameter: 150,
              ringWidth: 2.5,
              ringStartAngle: 210,
              ringColors: const [
                Color(0xFF5EC1ED),
                Color(0xFF199ED9),
                Color(0xFF147FAF),
                Color(0xFFFF9A6B),
                Color(0xFF5EC1ED),
              ],
              ringStops: const [0.0, 0.32, 0.55, 0.80, 1.0],
              innerPadding: 5,
              innerBacking: const Color(0xFF08222A),
              avatarUrl: data.doctorAvatarUrl,
              initials: data.initials,
              initialsColor: EditorialShareCard._sky,
            ),
            const SizedBox(width: 32),
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
                      color: Colors.white,
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
                      color: EditorialShareCard._sky,
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
                    color: EditorialShareCard._mist,
                    letterSpacingEm: 0.02,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 36),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          decoration: BoxDecoration(
            color: const Color(0x660A2C38),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: const Color(0x669ED6F0), width: 1.5),
          ),
          child: Text(
            data.periodLabel,
            style: cardText(
              size: 22,
              weight: FontWeight.w500,
              color: const Color(0xE6D6F0FC),
              letterSpacingEm: 0.2,
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Hero ────────────────────────────────────────────────────────────────

/// A fixed 770-px band. The number is tipped -2.4° and the molar graph
/// overlaps it from the right, running past the canvas edge — hence the
/// [OverflowBox] cancelling the column's right padding.
class _Hero extends StatelessWidget {
  const _Hero({required this.value});

  final String value;

  /// The content column is 1080 - 84 - 84 wide; the hero reclaims the
  /// right-hand 84 via `margin: 0 -84px 0 0`.
  static const double _bandWidth = 996;
  static const double _bandHeight = 770;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _bandHeight,
      width: double.infinity,
      child: OverflowBox(
        alignment: Alignment.centerLeft,
        minWidth: _bandWidth,
        maxWidth: _bandWidth,
        child: SizedBox(
          width: _bandWidth,
          height: _bandHeight,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const Positioned(
                right: -70,
                top: 96,
                width: 540,
                height: 582,
                child: _MolarGraph(),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Transform.translate(
                  offset: const Offset(-6, 0),
                  child: Transform.rotate(
                    angle: deg(-2.4),
                    child: _HeroNumber(value: value),
                  ),
                ),
              ),
              Positioned(
                left: 2,
                bottom: 104,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 96,
                      height: 2,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0x005EC1ED), Color(0xFF5EC1ED)],
                        ),
                      ),
                    ),
                    const SizedBox(width: 26),
                    Text(
                      'VISITS',
                      style: cardText(
                        size: 40,
                        weight: FontWeight.w600,
                        color: const Color(0xF0E9F8FF),
                        letterSpacingEm: 0.44,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroNumber extends StatelessWidget {
  const _HeroNumber({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    final style = cardText(
      size: 392,
      weight: FontWeight.w800,
      color: Colors.white,
      letterSpacingEm: -0.055,
      height: 0.84,
    );
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      // drop-shadow(0 34px 60px rgba(3,18,24,.72)) follows the glyph
      // silhouette rather than a box, so it is painted as a blurred copy
      // of the number underneath the gradient fill.
      child: Stack(
        children: [
          Transform.translate(
            offset: const Offset(0, 34),
            child: ImageFiltered(
              imageFilter: ui.ImageFilter.blur(
                sigmaX: blurSigma(60),
                sigmaY: blurSigma(60),
              ),
              child: Text(
                value,
                style: style.copyWith(color: const Color(0xB8031218)),
              ),
            ),
          ),
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (rect) => CssLinearGradient(
              degrees: 148,
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFDCF3FE),
                Color(0xFF5EC1ED),
                Color(0xFF199ED9),
                Color(0xFF0E6C96),
              ],
              stops: [0.0, 0.20, 0.46, 0.66, 0.90],
            ).createShader(rect),
            child: Text(value, style: style),
          ),
        ],
      ),
    );
  }
}

/// The molar cross-section with a trend polyline running through it — the
/// design's "clinical instrument" motif.
class _MolarGraph extends StatelessWidget {
  const _MolarGraph();

  static const String _svg =
      '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 560">'
      '<defs><linearGradient id="ms" x1="0" y1="0" x2="1" y2="1">'
      '<stop offset="0" stop-color="#9BD9F5" stop-opacity="0.9"/>'
      '<stop offset="1" stop-color="#FF9A6B" stop-opacity="0.55"/>'
      '</linearGradient></defs>'
      '<path d="M120 96c34-38 84-46 140-46s106 8 140 46c26 30 26 74 12 124-12 44-20 62-30 118'
      '-8 44-14 88-42 88-26 0-30-48-38-92-6-34-18-52-42-52s-36 18-42 52c-8 44-12 92-38 92'
      '-28 0-34-44-42-88-10-56-18-74-30-118-14-50-14-94 12-124z" '
      'fill="none" stroke="url(#ms)" stroke-width="2.5"/>'
      '<path d="M156 168c26-24 66-30 104-30s78 6 104 30" fill="none" '
      'stroke="rgba(155,217,245,0.4)" stroke-width="1.6"/>'
      '<polyline points="150,300 190,268 226,296 262,214 298,252 336,190 374,222" '
      'fill="none" stroke="#5EC1ED" stroke-width="4" stroke-linecap="round" '
      'stroke-linejoin="round"/>'
      '<circle cx="374" cy="222" r="9" fill="#FF9A6B"/>'
      '<g stroke="rgba(255,255,255,0.1)" stroke-width="1">'
      '<line x1="140" y1="340" x2="384" y2="340"/>'
      '<line x1="140" y1="380" x2="384" y2="380"/>'
      '</g></svg>';

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.95,
      child: SvgPicture.string(_svg, width: 540, height: 582),
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
          top: BorderSide(color: Color(0x24FFFFFF)),
          bottom: BorderSide(color: Color(0x24FFFFFF)),
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
                        size: 44,
                        weight: FontWeight.w500,
                        color: EditorialShareCard._sky,
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
            color: EditorialShareCard._mistLabel,
            letterSpacingEm: 0.17,
          ),
        ),
      ],
    );

    if (!divided) return body;
    return Container(
      padding: const EdgeInsets.only(left: 44),
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: Color(0x1AFFFFFF))),
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
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        border: Border.all(color: const Color(0x3D9ED6F0)),
        gradient: CssLinearGradient(
              degrees: 122,
              colors: [
            Color(0xB8144656),
            Color(0x990A2630),
            Color(0x803C1E1A),
          ],
          stops: [0.0, 0.58, 1.0],
        ),
      ),
      child: Stack(
        children: [
          const Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: 1,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0x0FFFFFFF),
                    Color(0xBFFFFFFF),
                    Color(0x1AFFFFFF),
                    Color(0x80FF9A6B),
                  ],
                  stops: [0.0, 0.26, 0.70, 1.0],
                ),
              ),
              child: SizedBox.expand(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 42),
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
                          color: const Color(0xCC9ED6F0),
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
                            color: Colors.white,
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
                          color: EditorialShareCard._mistSub,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 30),
                const ToothGlyph(
                  width: 104,
                  height: 113,
                  stroke: Color(0x80FFFFFF),
                  strokeWidth: 2.4,
                  highlight: EditorialShareCard._sky,
                  sparkleColor: EditorialShareCard._accent,
                  sparkleStyle: SparkleStyle.fourPoint,
                  opacity: 0.85,
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
            const DentaMark(size: 74),
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
                    color: Colors.white,
                    letterSpacingEm: -0.03,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'SCAN TO INSTALL',
                  style: cardText(
                    size: 20,
                    weight: FontWeight.w400,
                    color: EditorialShareCard._mist,
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
          moduleColor: Color(0xFF0B1B20),
          shadows: [
            BoxShadow(
              color: Color(0x99020E12),
              blurRadius: 44,
              offset: Offset(0, 20),
            ),
          ],
        ),
      ],
    );
  }
}
