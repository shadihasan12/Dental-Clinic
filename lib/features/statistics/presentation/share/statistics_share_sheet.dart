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

import 'cards/share_card_common.dart';
import 'cards/share_card_template.dart';
import 'share_statistics.dart';

/// Opens the bottom sheet that previews the share cards and lets the user
/// swipe between designs before sharing one as an image (the same way
/// Instagram/Spotify Wrapped shares work — the host app picks Instagram
/// Stories, WhatsApp, etc).
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
  /// One capture boundary per design — the picker keeps neighbours mounted
  /// so a swipe reveals a warm card, and sharing snapshots whichever key
  /// belongs to the page on screen.
  late final Map<ShareCardTemplate, GlobalKey> _boundaryKeys = {
    for (final t in ShareCardTemplate.values) t: GlobalKey(),
  };

  late final PageController _pageController;
  late ShareCardTemplate _selected;
  bool _sharing = false;

  @override
  void initState() {
    super.initState();
    _selected = ShareCardTemplate.fromId(
      getIt<UserStorage>().getShareCardTemplate(),
    );
    _pageController = PageController(
      initialPage: ShareCardTemplate.values.indexOf(_selected),
      viewportFraction: 0.78,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// Builds the doctor's display name from cached profile data. Falls back
  /// through first+last → username → a generic so the card never shows an
  /// empty title. The cards are English-only, so the prefix is always "Dr.".
  static String _composeDoctorName(UserStorage s) {
    final first = (s.getFirstName() ?? '').trim();
    final last = (s.getLastName() ?? '').trim();
    final full = [first, last].where((p) => p.isNotEmpty).join(' ');
    final fallback = (s.getUserName() ?? '').trim();
    final base = full.isNotEmpty ? full : fallback;
    if (base.isEmpty) return 'Doctor';
    final lower = base.toLowerCase();
    if (lower.startsWith('dr') || base.startsWith('د.') || base.startsWith('د ')) {
      return base;
    }
    return 'Dr. $base';
  }

  ShareCardData _buildData() {
    final storage = getIt<UserStorage>();
    final firstSeen = storage.getFirstSeenAt() ?? DateTime.now();
    return ShareCardData(
      stats: widget.stats,
      doctorName: _composeDoctorName(storage),
      clinicName: storage.getClinicName() ?? '',
      doctorAvatarUrl: storage.getProfileImageUrl(),
      // Both values were seeded in UserStorage on login. clinicCount
      // defaults to 1 for legacy installs that logged in before the count
      // was cached.
      clinicCount: storage.getClinicCount() ?? 1,
      daysOnPlatform:
          DateTime.now().difference(firstSeen).inDays.clamp(1, 100000),
    );
  }

  /// Precache the avatar so it's decoded before [_capture] runs. Network
  /// images decode async; without this the first share-press can snapshot
  /// the card while the avatar is still a placeholder.
  Future<void> _precacheAvatar(String? url) async {
    if (url == null || url.isEmpty) return;
    try {
      await precacheImage(NetworkImage(url), context);
    } catch (_) {
      // The cards fall back to initials — a failed precache just means the
      // exported PNG uses that fallback, which is fine.
    }
  }

  /// Same reasoning for the two texture assets: an un-decoded asset
  /// snapshots as an empty tile.
  Future<void> _precacheTextures() async {
    for (final asset in const [
      ShareCardCanvas.grainAsset,
      ShareCardCanvas.editorialContoursAsset,
    ]) {
      try {
        if (!mounted) return;
        await precacheImage(AssetImage(asset), context);
      } catch (_) {
        // Non-fatal — worst case that layer captures blank.
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final data = _buildData();

    // Pick a 9:16 preview size that fits the screen with room to spare for
    // the header, picker chrome and buttons.
    final mq = MediaQuery.of(context);
    final maxPreviewW = (mq.size.width - 80.w) * 0.86;
    final maxPreviewH = mq.size.height * 0.50;
    final double previewWidth;
    final double previewHeight;
    if (maxPreviewW * 16 / 9 <= maxPreviewH) {
      previewWidth = maxPreviewW;
      previewHeight = maxPreviewW * 16 / 9;
    } else {
      previewHeight = maxPreviewH;
      previewWidth = maxPreviewH * 9 / 16;
    }
    final pw = math.max(previewWidth, 180.0);
    final ph = math.max(previewHeight, pw * 16 / 9);

    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: c.surfaceBg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.fromLTRB(0, 12.h, 0, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _Grabber(color: c.borderLight),
            SizedBox(height: 16.h),
            const _Header(),
            SizedBox(height: 16.h),
            SizedBox(
              height: ph,
              child: PageView.builder(
                controller: _pageController,
                itemCount: ShareCardTemplate.values.length,
                // Keeps the off-screen neighbours built so swiping never
                // lands on a blank card mid-decode.
                allowImplicitScrolling: true,
                onPageChanged: (i) {
                  final next = ShareCardTemplate.values[i];
                  setState(() => _selected = next);
                  getIt<UserStorage>().saveShareCardTemplate(next.id);
                },
                itemBuilder: (context, i) {
                  final template = ShareCardTemplate.values[i];
                  return Center(
                    child: _TemplatePreview(
                      key: ValueKey(template),
                      boundaryKey: _boundaryKeys[template]!,
                      template: template,
                      data: data,
                      width: pw,
                      height: ph,
                      selected: template == _selected,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 14.h),
            _TemplateLabel(template: _selected),
            SizedBox(height: 10.h),
            _PageDots(
              count: ShareCardTemplate.values.length,
              index: ShareCardTemplate.values.indexOf(_selected),
            ),
            SizedBox(height: 18.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  _ShareButton(
                    loading: _sharing,
                    onPressed: _sharing
                        ? null
                        : () => _onShare(data.doctorAvatarUrl),
                  ),
                  SizedBox(height: 8.h),
                  _CancelButton(onPressed: () => Navigator.of(context).pop()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onShare(String? avatarUrl) async {
    // Grab the anchor rect *before* any async gaps. iPad needs this for
    // UIActivityViewController; on phones it's harmless to pass.
    final box = context.findRenderObject() as RenderBox?;
    final origin =
        box == null ? null : box.localToGlobal(Offset.zero) & box.size;

    setState(() => _sharing = true);
    try {
      await _precacheAvatar(avatarUrl);
      await _precacheTextures();
      final bytes = await _capture(_selected);
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

  Future<Uint8List> _capture(ShareCardTemplate template) async {
    final ctx = _boundaryKeys[template]!.currentContext;
    if (ctx == null) {
      throw StateError('Share card is not on screen yet');
    }
    final boundary = ctx.findRenderObject() as RenderRepaintBoundary;
    // flutter_svg decodes asynchronously on first use, so a single
    // endOfFrame wait isn't always enough. Wait two frames plus a small
    // tail so every vector layer is rasterized before we snapshot.
    await WidgetsBinding.instance.endOfFrame;
    await WidgetsBinding.instance.endOfFrame;
    await Future<void>.delayed(const Duration(milliseconds: 120));
    final image = await boundary.toImage(pixelRatio: 1.0);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
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
  const _Header();

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
          'Swipe to choose a design',
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

/// Preview: a scaled-down render of one 1080x1920 design.
///
/// The card is mounted at its native size inside a [RepaintBoundary] — so
/// [RepaintBoundary.toImage] captures at full resolution and the exported
/// PNG stays crisp — and displayed through a [Transform.scale]: layout
/// stays at 1080x1920 (capture-friendly), paint is scaled down (display-
/// friendly). [OverflowBox] lets the giant child render inside the smaller
/// visible box without constraint errors.
class _TemplatePreview extends StatelessWidget {
  const _TemplatePreview({
    super.key,
    required this.boundaryKey,
    required this.template,
    required this.data,
    required this.width,
    required this.height,
    required this.selected,
  });

  final GlobalKey boundaryKey;
  final ShareCardTemplate template;
  final ShareCardData data;
  final double width;
  final double height;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final scale = width / ShareCardCanvas.width;

    return AnimatedScale(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      scale: selected ? 1.0 : 0.93,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 180),
        opacity: selected ? 1.0 : 0.62,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            // Solid fallback so the preview is never void if the child
            // somehow fails to paint, and so there's no colour flash while
            // it warms up.
            color: template.previewBackground,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: selected ? ColorManager.primary : c.borderLight,
              width: selected ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: selected ? 0.16 : 0.08),
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
                  width: ShareCardCanvas.width,
                  height: ShareCardCanvas.height,
                  child: template.build(data),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TemplateLabel extends StatelessWidget {
  const _TemplateLabel({required this.template});
  final ShareCardTemplate template;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Column(
      children: [
        Text(
          template.label,
          style: TextStyle(
            fontFamily: FontHelper.fontFamily(context),
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: c.textPrimary,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          template.blurb,
          style: TextStyle(
            fontFamily: FontHelper.fontFamily(context),
            fontSize: 12.sp,
            color: c.textTertiary,
          ),
        ),
      ],
    );
  }
}

class _PageDots extends StatelessWidget {
  const _PageDots({required this.count, required this.index});
  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            margin: EdgeInsets.symmetric(horizontal: 3.w),
            width: i == index ? 18.w : 6.w,
            height: 6.w,
            decoration: BoxDecoration(
              color: i == index ? ColorManager.primary : c.borderLight,
              borderRadius: BorderRadius.circular(3.r),
            ),
          ),
      ],
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
            : Icon(Icons.ios_share_rounded, size: 18.w),
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
