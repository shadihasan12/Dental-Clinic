import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdfx/pdfx.dart';
import 'package:url_launcher/url_launcher.dart';

/// What a case attachment turns out to be.
///
/// Decided from the bytes, not from the name: the API hands back a signed URL
/// with no extension and often no file name either, so the only thing that
/// actually knows what a file is is its first few bytes.
enum FileKind {
  image,
  pdf,

  /// Something we have no renderer for. It still opens in whatever app the
  /// device uses for it.
  other;

  /// Reads the magic number. Anything unrecognised is [other], including a
  /// truncated download - guessing from a name we may not have would only
  /// move the failure to the renderer.
  static FileKind ofBytes(Uint8List bytes) {
    if (bytes.length < 4) return other;

    // %PDF
    if (bytes[0] == 0x25 &&
        bytes[1] == 0x50 &&
        bytes[2] == 0x44 &&
        bytes[3] == 0x46) {
      return pdf;
    }
    // \x89PNG
    if (bytes[0] == 0x89 && bytes[1] == 0x50) return image;
    // JPEG
    if (bytes[0] == 0xFF && bytes[1] == 0xD8) return image;
    // GIF8
    if (bytes[0] == 0x47 && bytes[1] == 0x49) return image;
    // RIFF....WEBP
    if (bytes[0] == 0x52 && bytes[1] == 0x49) return image;
    // BM
    if (bytes[0] == 0x42 && bytes[1] == 0x4D) return image;

    return other;
  }

  /// The guess a file name allows, for the strip - which cannot download
  /// every file it draws a tile for. Null when the name says nothing.
  static FileKind? ofName(String? name) {
    if (name == null) return null;
    // Only the last path segment can carry an extension. Fed a signed URL
    // (`…runbit.tech/api/media-items/secure?data=…`) the whole string's last
    // dot is in the host, which classed every nameless attachment as
    // "other" - and the strip then stopped trying to preview real images.
    var file = name.split(RegExp(r'[?#]')).first;
    file = file.substring(file.lastIndexOf('/') + 1);
    final dot = file.lastIndexOf('.');
    if (dot <= 0 || dot == file.length - 1) return null;
    switch (file.substring(dot + 1).toLowerCase()) {
      case 'pdf':
        return pdf;
      case 'png':
      case 'jpg':
      case 'jpeg':
      case 'gif':
      case 'webp':
      case 'bmp':
      case 'heic':
        return image;
      default:
        return other;
    }
  }
}

/// Renders a PDF from a URL, full screen.
///
/// Downloads once into memory and hands the bytes to pdfx rather than letting
/// it fetch: the URL is a short-lived signed link, and the download is the
/// step that can fail in ways worth reporting - an expired link, no network -
/// which a renderer given a URL reports as a blank page.
///
/// Continuous vertical scroll with pinch zoom, so the gesture never fights
/// the horizontal pager that carries the viewer from one attachment to the
/// next.
class CasePdfView extends StatefulWidget {
  const CasePdfView({
    super.key,
    required this.url,
    this.bytes,
    this.onPageChanged,
  });

  final String url;

  /// Already-downloaded bytes, when the caller sniffed the type itself.
  /// Saves the second request.
  final Uint8List? bytes;

  /// Fired with 1-based page and page count once known, and on every turn.
  final void Function(int page, int pages)? onPageChanged;

  @override
  State<CasePdfView> createState() => _CasePdfViewState();
}

class _CasePdfViewState extends State<CasePdfView> {
  /// pdfx's pinch viewer is mobile/macOS only - on Windows it throws
  /// UnimplementedError the moment it builds. There the paged viewer is used
  /// instead: one page at a time, each zoomable, turned vertically so it
  /// still never fights the horizontal pager between attachments.
  static bool get _pinchSupported => switch (defaultTargetPlatform) {
    TargetPlatform.android ||
    TargetPlatform.iOS ||
    TargetPlatform.macOS => true,
    _ => false,
  };

  PdfControllerPinch? _pinch;
  PdfController? _paged;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _pinch?.dispose();
    _paged?.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final bytes = widget.bytes ?? await cachedFileBytes(widget.url);
      if (bytes == null) throw StateError('empty');
      if (!mounted) return;

      final document = PdfDocument.openData(bytes);
      setState(() {
        if (_pinchSupported) {
          _pinch = PdfControllerPinch(document: document);
        } else {
          _paged = PdfController(document: document);
        }
      });
    } catch (e) {
      if (mounted) setState(() => _error = e);
    }
  }

  void _onError(Object error) {
    if (mounted) setState(() => _error = error);
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return CaseFileFallback(url: widget.url, name: null);
    }

    // The viewer's own background. pdfx paints white behind a page by
    // default, which on a black screen reads as a flash between pages.
    const background = BoxDecoration(color: ColorManager.black);

    final paged = _paged;
    if (paged != null) {
      return PdfView(
        controller: paged,
        scrollDirection: Axis.vertical,
        backgroundDecoration: background,
        onDocumentLoaded: (document) =>
            widget.onPageChanged?.call(paged.page, document.pagesCount),
        onPageChanged: (page) =>
            widget.onPageChanged?.call(page, paged.pagesCount ?? 0),
        onDocumentError: _onError,
      );
    }

    final pinch = _pinch;
    if (pinch == null) {
      return const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: ColorManager.white,
        ),
      );
    }

    return PdfViewPinch(
      controller: pinch,
      onDocumentLoaded: (document) =>
          widget.onPageChanged?.call(pinch.page, document.pagesCount),
      onPageChanged: (page) =>
          widget.onPageChanged?.call(page, pinch.pagesCount ?? 0),
      backgroundDecoration: background,
      // A document that fails to parse after downloading cleanly - a PDF we
      // cannot render, or one that is not really a PDF - falls through to
      // the same way out as any other unrenderable file.
      onDocumentError: _onError,
    );
  }
}

/// What the viewer shows for a file it cannot render: the name, and the way
/// out to an app that can.
///
/// Never the media id. An id tells the user nothing, and it is what used to
/// be shown here whenever the payload arrived without a file name.
class CaseFileFallback extends StatelessWidget {
  const CaseFileFallback({
    super.key,
    required this.url,
    required this.name,
    this.kind = FileKind.other,
  });

  final String url;
  final String? name;
  final FileKind kind;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);
    final label = (name != null && name!.trim().isNotEmpty)
        ? name!.trim()
        : (kind == FileKind.pdf ? l10n.filePdfDocument : l10n.fileDocument);

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              kind == FileKind.pdf
                  ? Icons.picture_as_pdf_outlined
                  : Icons.description_outlined,
              size: 44.w,
              color: ColorManager.white.withValues(alpha: 0.7),
            ),
            SizedBox(height: 12.h),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.5.sp,
                height: 1.4,
                fontWeight: FontWeight.w600,
                fontFamily: family,
                color: ColorManager.white,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              l10n.filePreviewFailed,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.sp,
                height: 1.4,
                fontFamily: family,
                color: ColorManager.white.withValues(alpha: 0.65),
              ),
            ),
            SizedBox(height: 16.h),
            OutlinedButton.icon(
              onPressed: () => launchUrl(
                Uri.parse(url),
                mode: LaunchMode.externalApplication,
              ),
              icon: Icon(Icons.open_in_new_rounded, size: 16.w),
              label: Text(
                l10n.fileOpenExternally,
                style: TextStyle(fontFamily: family, fontSize: 12.5.sp),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: ColorManager.white,
                side: BorderSide(
                  color: ColorManager.white.withValues(alpha: 0.4),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 10.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Pulls a file into memory.
///
/// Its own Dio, deliberately: the attachment URL is a signed link to storage,
/// not an API route, and the app's configured client would attach a bearer
/// token and a clinic header that the storage host has no use for and may
/// reject.
Future<Uint8List?> downloadFileBytes(String url) async {
  final response = await Dio().get<List<int>>(
    url,
    options: Options(
      responseType: ResponseType.bytes,
      // A 404 on an expired link should reach the caller as a failure it can
      // report, not as an exception from deep inside Dio's validator.
      validateStatus: (status) => status != null && status < 500,
    ),
  );
  final data = response.data;
  if (response.statusCode != 200 || data == null || data.isEmpty) return null;
  return Uint8List.fromList(data);
}

/// Downloads already made, keyed by URL, so the strip's thumbnail and the
/// viewer share one request per file. Bounded: a case can carry many files
/// and a PDF can be megabytes, so only the most recent few are kept.
final Map<String, Future<Uint8List?>> _fileBytesCache = {};
const int _fileBytesCacheSize = 24;

/// [downloadFileBytes], at most once per URL while it stays cached. A failed
/// or empty download is dropped from the cache, so opening the file again
/// retries it.
Future<Uint8List?> cachedFileBytes(String url) {
  final cached = _fileBytesCache.remove(url);
  if (cached != null) {
    // Re-inserted to mark it most recently used.
    _fileBytesCache[url] = cached;
    return cached;
  }
  final request = downloadFileBytes(url).then(
    (bytes) {
      if (bytes == null) _fileBytesCache.remove(url);
      return bytes;
    },
    onError: (Object error, StackTrace stack) {
      _fileBytesCache.remove(url);
      Error.throwWithStackTrace(error, stack);
    },
  );
  _fileBytesCache[url] = request;
  while (_fileBytesCache.length > _fileBytesCacheSize) {
    _fileBytesCache.remove(_fileBytesCache.keys.first);
  }
  return request;
}

/// A remote attachment whose type nothing in the payload revealed.
///
/// Downloads it once, reads the magic number, and renders what it actually
/// is: a PDF in the pinch viewer, an image the server mislabelled in an image
/// view, and anything else as the fallback with a way out to another app.
/// One request either way - the bytes are handed straight to whichever
/// renderer wins, never fetched twice.
class CaseRemoteFile extends StatefulWidget {
  const CaseRemoteFile({
    super.key,
    required this.url,
    required this.name,
    this.probableKind,
    this.onPdfPages,
  });

  final String url;
  final String? name;

  /// What the file name suggested, used only for the icon while the download
  /// is in flight.
  final FileKind? probableKind;

  final void Function(int page, int pages)? onPdfPages;

  @override
  State<CaseRemoteFile> createState() => _CaseRemoteFileState();
}

class _CaseRemoteFileState extends State<CaseRemoteFile> {
  Uint8List? _bytes;
  FileKind? _kind;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      // Usually already fetched by the thumbnail that was tapped.
      final bytes = await cachedFileBytes(widget.url);
      if (!mounted) return;
      if (bytes == null) {
        setState(() => _failed = true);
        return;
      }
      setState(() {
        _bytes = bytes;
        _kind = FileKind.ofBytes(bytes);
      });
    } catch (_) {
      if (mounted) setState(() => _failed = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_failed) {
      return CaseFileFallback(
        url: widget.url,
        name: widget.name,
        kind: widget.probableKind ?? FileKind.other,
      );
    }

    final bytes = _bytes;
    if (bytes == null) {
      return const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: ColorManager.white,
        ),
      );
    }

    switch (_kind) {
      case FileKind.pdf:
        return CasePdfView(
          url: widget.url,
          bytes: bytes,
          onPageChanged: widget.onPdfPages,
        );
      case FileKind.image:
        // The server sent an image after all - a photo uploaded with no
        // extension, which is why this path exists at all.
        return InteractiveViewer(
          minScale: 1,
          maxScale: 4,
          child: Center(child: Image.memory(bytes)),
        );
      case FileKind.other:
      case null:
        return CaseFileFallback(
          url: widget.url,
          name: widget.name,
          kind: FileKind.other,
        );
    }
  }
}
