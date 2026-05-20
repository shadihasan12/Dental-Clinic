import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/custom_widgets/app_snackbar.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'share_statistics.dart';
import 'statistics_share_card.dart';

/// Opens the bottom sheet that previews the share card and lets the
/// user share it as an image (the same way Instagram/Spotify Wrapped
/// shares work — the host app picks Instagram Stories, WhatsApp, etc).
Future<void> showStatisticsShareSheet({
  required BuildContext context,
  required ShareStatistics stats,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.55),
    builder: (_) => _StatisticsShareSheet(stats: stats),
  );
}

class _StatisticsShareSheet extends StatefulWidget {
  const _StatisticsShareSheet({required this.stats});
  final ShareStatistics stats;

  @override
  State<_StatisticsShareSheet> createState() => _StatisticsShareSheetState();
}

class _StatisticsShareSheetState extends State<_StatisticsShareSheet> {
  final GlobalKey _boundaryKey = GlobalKey();
  bool _sharing = false;

  /// Builds the doctor's display name from cached profile data. Falls
  /// back through first+last → username → a locale-specific generic
  /// so the card never shows an empty title. Prefix is locale-aware:
  /// "Dr." in English, "د." in Arabic.
  static String _composeDoctorName(UserStorage s, {required bool isArabic}) {
    final prefix = isArabic ? 'د. ' : 'Dr. ';
    final fallbackName = isArabic ? 'طبيب' : 'Doctor';

    final first = (s.getFirstName() ?? '').trim();
    final last = (s.getLastName() ?? '').trim();
    final full = [first, last].where((p) => p.isNotEmpty).join(' ');
    final fallback = (s.getUserName() ?? '').trim();
    final base = full.isNotEmpty ? full : fallback;
    if (base.isEmpty) return fallbackName;
    // Already prefixed (in either language)? leave as-is.
    final lower = base.toLowerCase();
    if (lower.startsWith('dr') || base.startsWith('د.') || base.startsWith('د ')) {
      return base;
    }
    return '$prefix$base';
  }

  /// Precache the avatar so it's rasterized before [_capture] runs.
  /// Network images decode async; without this the first share-press
  /// can snapshot the card while the avatar is still a placeholder.
  Future<void> _precacheAvatar(String? url) async {
    if (url == null || url.isEmpty) return;
    try {
      await precacheImage(NetworkImage(url), context);
    } catch (_) {
      // The card has an [errorBuilder] that renders initials — a
      // failed precache just means the captured image will use that
      // fallback, which is fine.
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final storage = getIt<UserStorage>();
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final clinicName = storage.getClinicName() ?? '';
    final doctorName = _composeDoctorName(storage, isArabic: isArabic);
    final avatarUrl = storage.getProfileImageUrl();
    final fontFamily = FontHelper.fontFamily(context);
    // Synchronous reads — both values were seeded in UserStorage on
    // login. clinicCount defaults to 1 for legacy installs that
    // logged in before the count was cached.
    final clinicCount = storage.getClinicCount() ?? 1;
    final firstSeen = storage.getFirstSeenAt() ?? DateTime.now();
    final daysOnPlatform =
        DateTime.now().difference(firstSeen).inDays.clamp(1, 100000);

    // Pick a 9:16 preview size that fits the screen with room to spare
    // for the header and buttons. Deterministic — no Flexible needed,
    // and the surrounding Column shrinks to fit naturally.
    final mq = MediaQuery.of(context);
    final maxPreviewW = mq.size.width - 80.w;
    final maxPreviewH = mq.size.height * 0.58;
    final double previewWidth;
    final double previewHeight;
    if (maxPreviewW * 16 / 9 <= maxPreviewH) {
      previewWidth = maxPreviewW;
      previewHeight = maxPreviewW * 16 / 9;
    } else {
      previewHeight = maxPreviewH;
      previewWidth = maxPreviewH * 9 / 16;
    }
    // Floor to safe minimums in case the screen is unusually small.
    final pw = math.max(previewWidth, 180.0);
    final ph = math.max(previewHeight, pw * 16 / 9);

    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: c.surfaceBg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _Grabber(color: c.borderLight),
            SizedBox(height: 16.h),
            _Header(),
            SizedBox(height: 20.h),
            _Preview(
              boundaryKey: _boundaryKey,
              stats: widget.stats,
              doctorName: doctorName,
              clinicName: clinicName,
              avatarUrl: avatarUrl,
              fontFamily: fontFamily,
              clinicCount: clinicCount,
              daysOnPlatform: daysOnPlatform,
              width: pw,
              height: ph,
            ),
            SizedBox(height: 20.h),
            _ShareButton(
              loading: _sharing,
              onPressed: _sharing ? null : () => _onShare(avatarUrl),
            ),
            SizedBox(height: 8.h),
            _CancelButton(onPressed: () => Navigator.of(context).pop()),
          ],
        ),
      ),
    );
  }

  Future<void> _onShare(String? avatarUrl) async {
    // Grab the anchor rect *before* any async gaps. iPad needs this for
    // UIActivityViewController; on phones it's harmless to pass.
    final box = context.findRenderObject() as RenderBox?;
    final origin = box == null
        ? null
        : box.localToGlobal(Offset.zero) & box.size;

    setState(() => _sharing = true);
    try {
      // Make sure the avatar is decoded before we snapshot — otherwise
      // the captured PNG can show the initials fallback on first share.
      await _precacheAvatar(avatarUrl);
      final bytes = await _capture();
      final file = await _writeToTemp(bytes);
      await Share.shareXFiles(
        [XFile(file.path, mimeType: 'image/png')],
        text: 'My clinic statistics',
        sharePositionOrigin: origin,
      );
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.showError(
        context,
        title: 'Share failed',
        message: e.toString(),
      );
    } finally {
      if (mounted) setState(() => _sharing = false);
    }
  }

  Future<Uint8List> _capture() async {
    final boundary = _boundaryKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary;
    // flutter_svg decodes asynchronously on first use, so a single
    // endOfFrame wait isn't always enough. Wait two frames + a small
    // tail so every tooth SVG is rasterized before we snapshot.
    await WidgetsBinding.instance.endOfFrame;
    await WidgetsBinding.instance.endOfFrame;
    await Future<void>.delayed(const Duration(milliseconds: 120));
    final image = await boundary.toImage(pixelRatio: 1.0);
    final byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) {
      throw StateError('Failed to encode share image');
    }
    return byteData.buffer.asUint8List();
  }

  Future<File> _writeToTemp(Uint8List bytes) async {
    final dir = await getTemporaryDirectory();
    final filename =
        'statistics_${DateTime.now().millisecondsSinceEpoch}.png';
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }
}

// ─── Pieces ──────────────────────────────────────────────────────────────

class _Grabber extends StatelessWidget {
  const _Grabber({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 4.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2.r),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Column(
      children: [
        Text(
          'Share your stats',
          style: TextStyle(
            fontFamily: FontHelper.fontFamily(context),
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: c.textPrimary,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'Post to your story or send to a friend',
          style: TextStyle(
            fontFamily: FontHelper.fontFamily(context),
            fontSize: 13.sp,
            color: c.textTertiary,
          ),
        ),
      ],
    );
  }
}

/// Preview: a scaled-down render of the 1080×1920 card.
///
/// One [StatisticsShareCard] is mounted at its native 1080×1920 size
/// inside a [RepaintBoundary] — so [RepaintBoundary.toImage] captures
/// at full resolution and the exported PNG stays crisp.
///
/// The card is rendered visibly via a [Transform.scale]: layout stays
/// at 1080×1920 (capture-friendly), paint is scaled down (display-
/// friendly). [OverflowBox] lets the giant child render inside the
/// smaller visible box without constraint errors; [ClipRRect] crops
/// the scaled paint to the rounded preview frame.
class _Preview extends StatelessWidget {
  const _Preview({
    required this.boundaryKey,
    required this.stats,
    required this.doctorName,
    required this.clinicName,
    required this.avatarUrl,
    required this.fontFamily,
    required this.clinicCount,
    required this.daysOnPlatform,
    required this.width,
    required this.height,
  });

  final GlobalKey boundaryKey;
  final ShareStatistics stats;
  final String doctorName;
  final String clinicName;
  final String? avatarUrl;
  final String fontFamily;
  final int clinicCount;
  final int daysOnPlatform;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final scale = width / StatisticsShareCard.canvasWidth;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        // Solid fallback color so the preview is never just void if the
        // child somehow fails to paint — matches the card's teal-black
        // bg so there's no color flash while it warms up.
        color: const Color(0xFF0B2424),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: c.borderLight, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: OverflowBox(
        alignment: Alignment.topLeft,
        minWidth: 0,
        maxWidth: double.infinity,
        minHeight: 0,
        maxHeight: double.infinity,
        child: Transform.scale(
          scale: scale,
          alignment: Alignment.topLeft,
          child: RepaintBoundary(
            key: boundaryKey,
            child: SizedBox(
              width: StatisticsShareCard.canvasWidth,
              height: StatisticsShareCard.canvasHeight,
              child: StatisticsShareCard(
                stats: stats,
                doctorName: doctorName,
                clinicName: clinicName,
                doctorAvatarUrl: avatarUrl,
                fontFamily: fontFamily,
                clinicCount: clinicCount,
                daysOnPlatform: daysOnPlatform,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ShareButton extends StatelessWidget {
  const _ShareButton({required this.loading, required this.onPressed});
  final bool loading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: ColorManager.primary,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
        icon: loading
            ? SizedBox(
                width: 18.w,
                height: 18.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Icon(Icons.ios_share_rounded, size: 20.w),
        label: Text(
          loading ? 'Preparing…' : 'Share',
          style: TextStyle(
            fontFamily: FontHelper.fontFamily(context),
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _CancelButton extends StatelessWidget {
  const _CancelButton({required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
        child: Text(
          'Cancel',
          style: TextStyle(
            fontFamily: FontHelper.fontFamily(context),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: c.textSecondary,
          ),
        ),
      ),
    );
  }
}
