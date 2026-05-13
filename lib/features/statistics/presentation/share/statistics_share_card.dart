import 'dart:math' as math;
import 'dart:ui' show ImageFilter;

import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../domain/entities/statistics_entities.dart';
import '../../domain/entities/statistics_period.dart';

/// Pixel-perfect 9:16 (1080×1920) marketing share card for SmylOS Pro.
///
/// Designed to be eye-catching: rainbow tooth smile-arc, vibrant
/// gradient stat cards, a progress bar visualization on the
/// completion card, and a strong brand mark at the bottom.
///
/// Money is deliberately absent — dentists generally won't share
/// revenue publicly, so every metric is volume- or outcome-based.
///
/// All sizes are absolute px — the card renders at native resolution
/// inside a `RepaintBoundary` captured at `pixelRatio: 1.0`. Don't add
/// `flutter_screenutil` `.w/.h/.sp` calls in here.
class StatisticsShareCard extends StatelessWidget {
  const StatisticsShareCard({
    super.key,
    required this.snapshot,
    required this.clinicName,
  });

  static const double canvasWidth = 1080;
  static const double canvasHeight = 1920;

  static const String _brandName = 'SmylOS Pro';
  static const String _brandTagline = 'Professional Clinic Management';

  // ─ Per-card gradient palette ───────────────────────────────────────
  // Picked for harmony (each pair stays in one hue family) and contrast
  // (every pair sits comfortably on the cream background).
  static const LinearGradient _gTeal = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF22D3EE), Color(0xFF0E7490)],
  );
  static const LinearGradient _gCoral = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF9966), Color(0xFFE53E5C)],
  );
  static const LinearGradient _gPurple = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFB388FF), Color(0xFF5B21B6)],
  );
  static const LinearGradient _gAmber = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFD15C), Color(0xFFEA580C)],
  );
  static const LinearGradient _gBrandMono = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF22D3EE), Color(0xFF7C3AED)],
  );

  // Shadow / pop colors for each card.
  static const Color _sTeal = Color(0xFF0E7490);
  static const Color _sCoral = Color(0xFFE53E5C);
  static const Color _sPurple = Color(0xFF6D28D9);
  static const Color _sAmber = Color(0xFFEA580C);

  // Page palette.
  static const Color _bgTop = Color(0xFFFFF7ED);
  static const Color _bgBottom = Color(0xFFFFE0CF);
  static const Color _ink = Color(0xFF1F1F1F);
  static const Color _inkMuted = Color(0xFF6B6B6B);

  // Smile-arc tooth tints (different from card gradients so the smile
  // and the cards don't look like they're repeating themselves).
  static const Color _toothTeal = Color(0xFF14B8A6);
  static const Color _toothCoral = Color(0xFFFB6F92);
  static const Color _toothPurple = Color(0xFF8B5CF6);
  static const Color _toothAmber = Color(0xFFF59E0B);
  static const Color _toothPink = Color(0xFFEC4899);

  final StatisticsSnapshot snapshot;
  final String clinicName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: canvasWidth,
      height: canvasHeight,
      child: Stack(
        children: [
          const _Background(),
          const _BackgroundOrnaments(),
          const _Sparkles(),
          Padding(
            padding: const EdgeInsets.fromLTRB(72, 110, 72, 90),
            child: Column(
              children: [
                _SmileRow(),
                const SizedBox(height: 60),
                _Title(clinicName: clinicName, period: snapshot.period),
                const SizedBox(height: 72),
                _StatGrid(snapshot: snapshot),
                const SizedBox(height: 50),
                _Highlight(snapshot: snapshot),
                const Spacer(),
                const _BrandFooter(
                  brand: _brandName,
                  tagline: _brandTagline,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Background ──────────────────────────────────────────────────────────

class _Background extends StatelessWidget {
  const _Background();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            StatisticsShareCard._bgTop,
            StatisticsShareCard._bgBottom,
          ],
        ),
      ),
      child: SizedBox.expand(),
    );
  }
}

/// Soft colored blobs in the corners — broad strokes of brand color
/// that don't compete with the cards (under 22 % opacity).
class _BackgroundOrnaments extends StatelessWidget {
  const _BackgroundOrnaments();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -180,
          left: -200,
          child: _Blob(
            color: StatisticsShareCard._sCoral.withValues(alpha: 0.20),
            size: 720,
          ),
        ),
        Positioned(
          top: 280,
          right: -260,
          child: _Blob(
            color: StatisticsShareCard._sTeal.withValues(alpha: 0.18),
            size: 760,
          ),
        ),
        Positioned(
          bottom: -240,
          left: -200,
          child: _Blob(
            color: StatisticsShareCard._sPurple.withValues(alpha: 0.18),
            size: 700,
          ),
        ),
        Positioned(
          bottom: 220,
          right: -220,
          child: _Blob(
            color: StatisticsShareCard._sAmber.withValues(alpha: 0.18),
            size: 580,
          ),
        ),
      ],
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({required this.color, required this.size});
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withValues(alpha: 0.0)],
          stops: const [0.0, 1.0],
        ),
      ),
    );
  }
}

/// Decorative confetti dots scattered around. Seeded `Random` so the
/// pattern is deterministic across renders — no flicker between
/// preview and capture.
class _Sparkles extends StatelessWidget {
  const _Sparkles();

  static const List<Color> _palette = [
    StatisticsShareCard._sTeal,
    StatisticsShareCard._sCoral,
    StatisticsShareCard._sPurple,
    StatisticsShareCard._sAmber,
    StatisticsShareCard._toothPink,
  ];

  @override
  Widget build(BuildContext context) {
    final rng = math.Random(7);
    final dots = <Widget>[];
    for (var i = 0; i < 28; i++) {
      final left = rng.nextDouble() * StatisticsShareCard.canvasWidth;
      final top = 60 + rng.nextDouble() * (StatisticsShareCard.canvasHeight - 200);
      final size = 6.0 + rng.nextDouble() * 10;
      final color = _palette[rng.nextInt(_palette.length)];
      final alpha = 0.16 + rng.nextDouble() * 0.18;
      dots.add(Positioned(
        left: left,
        top: top,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color.withValues(alpha: alpha),
            shape: BoxShape.circle,
          ),
        ),
      ));
    }
    return Stack(children: dots);
  }
}

// ─── Top smile row — real tooth SVGs, fanned in a smile arc ──────────────

class _SmileRow extends StatelessWidget {
  static const List<_Tooth> _teeth = [
    _Tooth(
      asset: 'assets/icons/case/teeth/canine.svg',
      color: StatisticsShareCard._toothTeal,
      size: 96,
      angleDeg: -12,
    ),
    _Tooth(
      asset: 'assets/icons/case/teeth/lateral_inc.svg',
      color: StatisticsShareCard._toothCoral,
      size: 108,
      angleDeg: -6,
    ),
    _Tooth(
      asset: 'assets/icons/case/teeth/central_inc.svg',
      color: StatisticsShareCard._toothPurple,
      size: 124,
      angleDeg: 0,
    ),
    _Tooth(
      asset: 'assets/icons/case/teeth/lateral_inc.svg',
      color: StatisticsShareCard._toothAmber,
      size: 108,
      angleDeg: 6,
    ),
    _Tooth(
      asset: 'assets/icons/case/teeth/canine.svg',
      color: StatisticsShareCard._toothPink,
      size: 96,
      angleDeg: 12,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (final t in _teeth)
            Transform.rotate(
              angle: t.angleDeg * math.pi / 180,
              child: _ShadowedSvg(
                asset: t.asset,
                color: t.color,
                size: t.size,
              ),
            ),
        ],
      ),
    );
  }
}

class _Tooth {
  const _Tooth({
    required this.asset,
    required this.color,
    required this.size,
    required this.angleDeg,
  });
  final String asset;
  final Color color;
  final double size;
  final double angleDeg;
}

/// SVG tinted with [color] and given a soft colored drop shadow — adds
/// the depth that a flat SVG normally lacks.
class _ShadowedSvg extends StatelessWidget {
  const _ShadowedSvg({
    required this.asset,
    required this.color,
    required this.size,
  });
  final String asset;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Drop-shadow pass: same SVG, blurred, in card color.
        Positioned(
          top: 8,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: SvgPicture.asset(
              asset,
              width: size,
              height: size,
              colorFilter: ColorFilter.mode(
                color.withValues(alpha: 0.45),
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        SvgPicture.asset(
          asset,
          width: size,
          height: size,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
      ],
    );
  }
}

// ─── Title ───────────────────────────────────────────────────────────────

class _Title extends StatelessWidget {
  const _Title({required this.clinicName, required this.period});
  final String clinicName;
  final StatisticsPeriod period;

  @override
  Widget build(BuildContext context) {
    final periodLabel = switch (period) {
      StatisticsPeriod.week => 'The week in smiles',
      StatisticsPeriod.month => 'The month in smiles',
      StatisticsPeriod.year => 'The year in smiles',
    };
    final name = clinicName.trim().isEmpty ? 'My Clinic' : clinicName.trim();

    return Column(
      children: [
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: FontFamily.geist,
            fontSize: 46,
            fontWeight: FontWeight.w800,
            color: StatisticsShareCard._ink,
            letterSpacing: -0.8,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            periodLabel,
            style: const TextStyle(
              fontFamily: FontFamily.geist,
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: StatisticsShareCard._ink,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ],
    );
  }
}

// ─── 2×2 colored stat grid ───────────────────────────────────────────────

class _StatGrid extends StatelessWidget {
  const _StatGrid({required this.snapshot});
  final StatisticsSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final o = snapshot.overview;
    final completed = snapshot.appointmentBreakdown.completed;
    final total = snapshot.appointmentBreakdown.total;
    final completionRatio =
        total == 0 ? 0.0 : (completed / total).clamp(0.0, 1.0);
    final completionPct = (completionRatio * 100).toStringAsFixed(0);

    final tiles = <_StatCardData>[
      _StatCardData(
        value: _fmt(o.totalPatients),
        label: 'Patients',
        gradient: StatisticsShareCard._gTeal,
        shadow: StatisticsShareCard._sTeal,
        icon: Icons.favorite_rounded,
      ),
      _StatCardData(
        value: _fmt(o.totalAppointments),
        label: 'Visits',
        gradient: StatisticsShareCard._gCoral,
        shadow: StatisticsShareCard._sCoral,
        icon: Icons.event_available_rounded,
      ),
      _StatCardData(
        value: _fmt(o.newPatients),
        label: 'New smiles',
        gradient: StatisticsShareCard._gPurple,
        shadow: StatisticsShareCard._sPurple,
        icon: Icons.sentiment_very_satisfied_rounded,
      ),
      _StatCardData(
        value: '$completionPct%',
        label: 'Completed',
        gradient: StatisticsShareCard._gAmber,
        shadow: StatisticsShareCard._sAmber,
        icon: Icons.check_circle_rounded,
        progress: completionRatio,
      ),
    ];

    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: _StatCard(data: tiles[0])),
              const SizedBox(width: 26),
              Expanded(child: _StatCard(data: tiles[1])),
            ],
          ),
        ),
        const SizedBox(height: 26),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: _StatCard(data: tiles[2])),
              const SizedBox(width: 26),
              Expanded(child: _StatCard(data: tiles[3])),
            ],
          ),
        ),
      ],
    );
  }

  static String _fmt(int n) {
    if (n < 1000) return '$n';
    final s = n.toString();
    final buf = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
      buf.write(s[i]);
    }
    return buf.toString();
  }
}

class _StatCardData {
  const _StatCardData({
    required this.value,
    required this.label,
    required this.gradient,
    required this.shadow,
    required this.icon,
    this.progress,
  });
  final String value;
  final String label;
  final LinearGradient gradient;
  final Color shadow;
  final IconData icon;
  /// 0..1. When non-null, the card renders a horizontal progress bar
  /// under the number — turns "84 %" from a static label into a
  /// data-feel visual.
  final double? progress;
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.data});
  final _StatCardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: data.gradient,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: data.shadow.withValues(alpha: 0.42),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Stack(
          children: [
            // Decorative oversize circle in the bottom-right corner —
            // adds depth without taking up real estate.
            Positioned(
              right: -50,
              bottom: -60,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.10),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              right: -10,
              top: -30,
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 28, 30, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.24),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                        width: 1.2,
                      ),
                    ),
                    child: Icon(data.icon, color: Colors.white, size: 30),
                  ),
                  const SizedBox(height: 26),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      data.value,
                      style: const TextStyle(
                        fontFamily: FontFamily.geist,
                        fontSize: 80,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        height: 1.0,
                        letterSpacing: -2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    data.label,
                    style: TextStyle(
                      fontFamily: FontFamily.geist,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withValues(alpha: 0.95),
                      letterSpacing: 0.2,
                    ),
                  ),
                  if (data.progress != null) ...[
                    const SizedBox(height: 18),
                    _ProgressBar(value: data.progress!),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Capsule "slider-feel" progress bar. The filled portion ends in a
/// taller, brighter dot that reads like a slider handle — gives the
/// completion card a tactile, interactive feel even though the
/// captured image is static.
///
/// Implementation note: this widget intentionally avoids [LayoutBuilder]
/// because the share card uses [IntrinsicHeight] in [_StatGrid], and
/// LayoutBuilder doesn't support intrinsic-dimension queries. The fill
/// and handle are positioned via [FractionallySizedBox] and [Align],
/// both of which forward intrinsic dimensions correctly.
class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.value});
  final double value;

  @override
  Widget build(BuildContext context) {
    final v = value.clamp(0.0, 1.0);
    return SizedBox(
      height: 18,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Track — full width, vertically centered, 10 px tall.
          Center(
            child: Container(
              height: 10,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          // Fill — left-aligned, width = v × track width.
          Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: v,
              child: Center(
                child: Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.5),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Slider-style handle. Alignment.x = 2v − 1 maps v=0 → left
          // edge, v=1 → right edge, child centered at that x.
          Align(
            alignment: Alignment(2 * v - 1, 0),
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.18),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Highlight pill (most-performed by procedure count) ──────────────────

class _Highlight extends StatelessWidget {
  const _Highlight({required this.snapshot});
  final StatisticsSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final slices = snapshot.treatmentDistribution;
    if (slices.isEmpty) return const SizedBox.shrink();
    final mostPerformed = slices.reduce(
      (a, b) => a.count >= b.count ? a : b,
    );

    return Container(
      padding: const EdgeInsets.fromLTRB(28, 18, 32, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              gradient: StatisticsShareCard._gAmber,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.star_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              'Most performed · ${mostPerformed.name}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: FontFamily.geist,
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: StatisticsShareCard._ink,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Brand footer ────────────────────────────────────────────────────────

class _BrandFooter extends StatelessWidget {
  const _BrandFooter({required this.brand, required this.tagline});
  final String brand;
  final String tagline;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 3,
          decoration: BoxDecoration(
            color: StatisticsShareCard._inkMuted.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const _BrandMonogram(),
            const SizedBox(width: 18),
            Text(
              brand,
              style: const TextStyle(
                fontFamily: FontFamily.geist,
                fontSize: 42,
                fontWeight: FontWeight.w800,
                color: StatisticsShareCard._ink,
                letterSpacing: -0.6,
                height: 1.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          tagline,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: FontFamily.geist,
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: StatisticsShareCard._inkMuted,
            letterSpacing: 0.6,
          ),
        ),
      ],
    );
  }
}

class _BrandMonogram extends StatelessWidget {
  const _BrandMonogram();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        gradient: StatisticsShareCard._gBrandMono,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7C3AED).withValues(alpha: 0.36),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Center(
        child: Text(
          'S',
          style: TextStyle(
            fontFamily: FontFamily.geist,
            fontSize: 46,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            height: 1.0,
            letterSpacing: -1.2,
          ),
        ),
      ),
    );
  }
}
