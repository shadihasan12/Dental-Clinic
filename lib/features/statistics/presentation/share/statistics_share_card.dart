import 'dart:math' as math;

import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'share_statistics.dart';

/// Pixel-perfect 9:16 (1080×1920) shareable card.
///
/// Hero-number layout (Spotify-Wrapped style): one enormous metric
/// owns the visual center; doctor identity reads as a compact bar
/// at the top with a meta-line (clinic count + days on platform);
/// supporting stats and a featured top-treatment panel sit below;
/// the bottom houses a tier/ranking badge and the QR brand block.
///
/// All sizes are absolute px — the card renders at native resolution
/// inside a `RepaintBoundary` captured at `pixelRatio: 1.0`. Do not
/// add `flutter_screenutil` `.w/.h/.sp` calls in here or the capture
/// will be distorted.
///
/// The font family is injected (not hardcoded) because the share
/// sheet is responsible for picking Geist (LTR) vs Cairo (Arabic) —
/// the card itself is locale-agnostic.
class StatisticsShareCard extends StatelessWidget {
  const StatisticsShareCard({
    super.key,
    required this.stats,
    required this.doctorName,
    required this.clinicName,
    required this.fontFamily,
    required this.clinicCount,
    required this.daysOnPlatform,
    this.doctorAvatarUrl,
  });

  static const double canvasWidth = 1080;
  static const double canvasHeight = 1920;

  /// Landing page the QR points to. Swap this single constant when
  /// the real smartlink is ready.
  static const String appUrl = 'https://denta.pro';

  static const String _brandName = 'Denta';

  /// Brand mark drawn into the share image. Must be precached before the
  /// RepaintBoundary snapshot or it captures as an empty tile - see
  /// StatisticsShareSheet._precacheBrandMark.
  static const String brandMarkAsset = 'assets/images/logo/denta_mark.png';
  static const String _brandTagline = 'Scan to install';

  // ─ Palette (kept deliberately small, all derived from brand) ──────
  static const Color _bgTop = Color(0xFF0B2424);
  static const Color _bgBottom = Color(0xFF040E0E);
  static const Color _teal = ColorManager.primary;
  static const Color _tealLight = ColorManager.primaryLighter;
  static const Color _ink = Color(0xFFF5FAFA);
  static const Color _inkMuted = Color(0xFFB6CACA);

  final ShareStatistics stats;
  final String doctorName;
  final String clinicName;
  final String? doctorAvatarUrl;
  final String fontFamily;
  final int clinicCount;
  final int daysOnPlatform;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: canvasWidth,
      height: canvasHeight,
      child: Stack(
        children: [
          const _Background(),
          const _Aurora(),
          const _Starfield(),
          Padding(
            padding: const EdgeInsets.fromLTRB(72, 96, 72, 84),
            child: Column(
              children: [
                _IdentityBar(
                  doctorName: doctorName,
                  clinicName: clinicName,
                  avatarUrl: doctorAvatarUrl,
                  clinicCount: clinicCount,
                  daysOnPlatform: daysOnPlatform,
                  fontFamily: fontFamily,
                ),
                const SizedBox(height: 40),
                _Hero(stats: stats, fontFamily: fontFamily),
                const SizedBox(height: 32),
                _SupportingStats(
                  stats: stats,
                  fontFamily: fontFamily,
                ),
                const Spacer(),
                _FeaturedTreatment(
                  stats: stats,
                  fontFamily: fontFamily,
                ),
                const SizedBox(height: 24),
                _BrandFooter(
                  brand: _brandName,
                  tagline: _brandTagline,
                  url: appUrl,
                  fontFamily: fontFamily,
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

class _Aurora extends StatelessWidget {
  const _Aurora();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -260,
          left: -200,
          child: _Glow(
            color: StatisticsShareCard._teal.withValues(alpha: 0.22),
            size: 880,
          ),
        ),
        Positioned(
          bottom: -260,
          right: -220,
          child: _Glow(
            color: StatisticsShareCard._tealLight.withValues(alpha: 0.14),
            size: 820,
          ),
        ),
        Positioned(
          top: 720,
          right: -240,
          child: _Glow(
            color: StatisticsShareCard._teal.withValues(alpha: 0.12),
            size: 640,
          ),
        ),
      ],
    );
  }
}

class _Glow extends StatelessWidget {
  const _Glow({required this.color, required this.size});
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color, color.withValues(alpha: 0.0)],
            stops: const [0.0, 1.0],
          ),
        ),
      ),
    );
  }
}

class _Starfield extends StatelessWidget {
  const _Starfield();

  @override
  Widget build(BuildContext context) {
    final rng = math.Random(11);
    final stars = <Widget>[];
    for (var i = 0; i < 36; i++) {
      final left = rng.nextDouble() * StatisticsShareCard.canvasWidth;
      final top = rng.nextDouble() * StatisticsShareCard.canvasHeight;
      final size = 2.0 + rng.nextDouble() * 4.0;
      final alpha = 0.12 + rng.nextDouble() * 0.28;
      stars.add(Positioned(
        left: left,
        top: top,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: alpha),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.white.withValues(alpha: alpha * 0.6),
                blurRadius: size * 2,
              ),
            ],
          ),
        ),
      ));
    }
    return Stack(children: stars);
  }
}

// ─── Identity bar ────────────────────────────────────────────────────────

class _IdentityBar extends StatelessWidget {
  const _IdentityBar({
    required this.doctorName,
    required this.clinicName,
    required this.avatarUrl,
    required this.clinicCount,
    required this.daysOnPlatform,
    required this.fontFamily,
  });

  final String doctorName;
  final String clinicName;
  final String? avatarUrl;
  final int clinicCount;
  final int daysOnPlatform;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final name = doctorName.trim().isEmpty ? 'Doctor' : doctorName.trim();
    final clinic =
        clinicName.trim().isEmpty ? 'Smile Center' : clinicName.trim();
    final hasAvatar = avatarUrl != null && avatarUrl!.isNotEmpty;

    final clinicLabel = clinicCount == 1 ? 'clinic' : 'clinics';
    final daysLabel = daysOnPlatform == 1 ? 'day caring' : 'days caring';
    final meta = '$clinicCount $clinicLabel  ·  $daysOnPlatform $daysLabel';

    final nameAndClinic = Column(
      crossAxisAlignment:
          hasAvatar ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: hasAvatar ? TextAlign.start : TextAlign.center,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 54,
            fontWeight: FontWeight.w800,
            color: StatisticsShareCard._ink,
            letterSpacing: -1.2,
            height: 1.05,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          clinic,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: hasAvatar ? TextAlign.start : TextAlign.center,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 28,
            fontWeight: FontWeight.w500,
            color: StatisticsShareCard._teal,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          meta,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: hasAvatar ? TextAlign.start : TextAlign.center,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: StatisticsShareCard._inkMuted,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );

    if (!hasAvatar) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: nameAndClinic,
      );
    }

    return Row(
      children: [
        _AvatarBadge(url: avatarUrl!),
        const SizedBox(width: 22),
        Expanded(child: nameAndClinic),
      ],
    );
  }
}

class _AvatarBadge extends StatelessWidget {
  const _AvatarBadge({required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    const double diameter = 130;
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: StatisticsShareCard._teal.withValues(alpha: 0.45),
            blurRadius: 24,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              StatisticsShareCard._tealLight,
              StatisticsShareCard._teal,
            ],
          ),
        ),
        child: ClipOval(
          child: Image.network(
            url,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => Container(
              color: StatisticsShareCard._bgTop,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Hero number ─────────────────────────────────────────────────────────

class _Hero extends StatelessWidget {
  const _Hero({required this.stats, required this.fontFamily});
  final ShareStatistics stats;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final value = stats.visits;
    final dateLabel = _formatRange(stats.startDate, stats.endDate);

    return Column(
      children: [
        _MetaLabel(
          text: 'SMILE REPORT  ·  $dateLabel',
          fontFamily: fontFamily,
        ),
        const SizedBox(height: 22),
        // ShaderMask gives the number a teal→cyan gradient fill;
        // FittedBox guards 4-digit values against pushing past the
        // 1080-px canvas.
        FittedBox(
          fit: BoxFit.scaleDown,
          child: ShaderMask(
            shaderCallback: (rect) => const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                StatisticsShareCard._tealLight,
                StatisticsShareCard._teal,
              ],
            ).createShader(rect),
            blendMode: BlendMode.srcIn,
            child: Text(
              value == null ? '—' : _fmt(value),
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 340,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                height: 0.95,
                letterSpacing: -12,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'VISITS',
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: StatisticsShareCard._ink,
            letterSpacing: 4,
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

  /// Compact date-range label, e.g. "MAR 15 – 21, 2026" within a month,
  /// "MAR 28 – APR 14, 2026" across months, with year on cross-year.
  static String _formatRange(DateTime start, DateTime end) {
    final mon = DateFormat.MMM().format(start).toUpperCase();
    final monEnd = DateFormat.MMM().format(end).toUpperCase();
    if (start.year != end.year) {
      return '$mon ${start.day}, ${start.year} – $monEnd ${end.day}, ${end.year}';
    }
    if (start.month == end.month) {
      return '$mon ${start.day} – ${end.day}, ${end.year}';
    }
    return '$mon ${start.day} – $monEnd ${end.day}, ${end.year}';
  }
}

class _MetaLabel extends StatelessWidget {
  const _MetaLabel({required this.text, required this.fontFamily});
  final String text;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: StatisticsShareCard._teal.withValues(alpha: 0.45),
          width: 1.2,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: StatisticsShareCard._tealLight,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: StatisticsShareCard._tealLight.withValues(alpha: 0.7),
                  blurRadius: 10,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: StatisticsShareCard._inkMuted,
              letterSpacing: 2.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Supporting stats (3 chips) ──────────────────────────────────────────

class _SupportingStats extends StatelessWidget {
  const _SupportingStats({required this.stats, required this.fontFamily});
  final ShareStatistics stats;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final newPatients = stats.newPatients;
    final completionRate = stats.completionRate;
    final completedCases = stats.completedCases;

    final items = <_SupportItem>[
      _SupportItem(
        icon: Icons.sentiment_very_satisfied_rounded,
        value: newPatients == null ? '—' : '+${_fmt(newPatients)}',
        label: 'new smiles',
      ),
      _SupportItem(
        icon: Icons.check_circle_rounded,
        value: completionRate == null
            ? '—'
            : '${(completionRate * 100).round()}%',
        label: 'completed',
      ),
      _SupportItem(
        icon: Icons.folder_special_rounded,
        value: completedCases == null ? '—' : _fmt(completedCases),
        label: 'cases done',
      ),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (final i in items)
          Expanded(
            child: Center(child: _SupportPill(item: i, fontFamily: fontFamily)),
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

class _SupportItem {
  const _SupportItem({
    required this.icon,
    required this.value,
    required this.label,
  });
  final IconData icon;
  final String value;
  final String label;
}

class _SupportPill extends StatelessWidget {
  const _SupportPill({required this.item, required this.fontFamily});
  final _SupportItem item;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 78,
          height: 78,
          decoration: BoxDecoration(
            color: StatisticsShareCard._teal.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: StatisticsShareCard._teal.withValues(alpha: 0.45),
              width: 1.2,
            ),
          ),
          child: Icon(
            item.icon,
            color: StatisticsShareCard._tealLight,
            size: 40,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          item.value,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 54,
            fontWeight: FontWeight.w800,
            color: StatisticsShareCard._ink,
            letterSpacing: -1.2,
            height: 1.0,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          item.label,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: StatisticsShareCard._inkMuted,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}

// ─── Featured top treatment (big visual block) ──────────────────────────

class _FeaturedTreatment extends StatelessWidget {
  const _FeaturedTreatment({
    required this.stats,
    required this.fontFamily,
  });
  final ShareStatistics stats;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final name = stats.topTreatmentName;
    // Nothing to feature — collapse the block entirely.
    if (name == null || name.isEmpty) return const SizedBox.shrink();

    final count = stats.topTreatmentCount;
    final sub = count == null ? 'Most requested' : '$count procedures';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(32, 28, 32, 30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.10),
            Colors.white.withValues(alpha: 0.03),
          ],
        ),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: StatisticsShareCard._teal.withValues(alpha: 0.36),
          width: 1.4,
        ),
        boxShadow: [
          BoxShadow(
            color: StatisticsShareCard._teal.withValues(alpha: 0.18),
            blurRadius: 26,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      StatisticsShareCard._tealLight,
                      StatisticsShareCard._teal,
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.emoji_events_rounded,
                  color: StatisticsShareCard._bgTop,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Text(
                'TOP TREATMENT',
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: StatisticsShareCard._inkMuted,
                  letterSpacing: 2.8,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          // Treatment name — large, teal→cyan gradient, fitted to
          // width so long names (e.g. "Root canal therapy") still
          // read on one line.
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: ShaderMask(
              shaderCallback: (rect) => const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  StatisticsShareCard._tealLight,
                  StatisticsShareCard._teal,
                ],
              ).createShader(rect),
              blendMode: BlendMode.srcIn,
              child: Text(
                name,
                maxLines: 1,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 84,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -1.4,
                  height: 1.0,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            sub,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: StatisticsShareCard._inkMuted,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Brand footer (QR + brand) ───────────────────────────────────────────

class _BrandFooter extends StatelessWidget {
  const _BrandFooter({
    required this.brand,
    required this.tagline,
    required this.url,
    required this.fontFamily,
  });
  final String brand;
  final String tagline;
  final String url;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 20, 28, 20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.10),
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          _QrTile(url: url),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    _BrandMonogram(fontFamily: fontFamily),
                    const SizedBox(width: 12),
                    Flexible(
                      child: Text(
                        brand,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 34,
                          fontWeight: FontWeight.w800,
                          color: StatisticsShareCard._ink,
                          letterSpacing: -0.4,
                          height: 1.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  tagline,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: StatisticsShareCard._inkMuted,
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QrTile extends StatelessWidget {
  const _QrTile({required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: StatisticsShareCard._tealLight.withValues(alpha: 0.30),
            blurRadius: 22,
            spreadRadius: 1,
          ),
        ],
      ),
      child: QrImageView(
        data: url,
        version: QrVersions.auto,
        size: 140,
        gapless: true,
        eyeStyle: const QrEyeStyle(
          eyeShape: QrEyeShape.square,
          color: StatisticsShareCard._bgTop,
        ),
        dataModuleStyle: const QrDataModuleStyle(
          dataModuleShape: QrDataModuleShape.square,
          color: StatisticsShareCard._bgTop,
        ),
      ),
    );
  }
}

class _BrandMonogram extends StatelessWidget {
  const _BrandMonogram({required this.fontFamily});

  /// Kept on the signature so the footer's call site is unchanged; the mark
  /// is artwork now, so nothing here is typeset.
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Image.asset(
        StatisticsShareCard.brandMarkAsset,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}
