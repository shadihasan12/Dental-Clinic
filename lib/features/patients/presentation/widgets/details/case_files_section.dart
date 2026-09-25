import 'package:dental_clinic_app/core/utils/system_insets.dart';
import 'dart:io';

import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/case_file_preview.dart';
import 'package:dental_clinic_app/custom_widgets/app_snackbar.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/patient_detail_states.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/services/file_picker/file_picker_service.dart';
import 'package:dental_clinic_app/services/media/media_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

/// One attachment as the UI needs it. The API stores bare media ids, so a
/// freshly picked file lives here with a local path until its upload lands.
class CaseAttachment {
  CaseAttachment({
    required this.id,
    this.remoteId,
    this.url,
    this.downloadUrl,
    this.name,
    this.localFile,
    this.uploading = false,
    this.failed = false,
  });

  /// Media id. For a file still uploading this is a throwaway local key.
  final String id;

  /// Row id on the case-attachments sub-resource, which is what DELETE takes.
  /// Null while an upload is in flight, so the delete action stays hidden.
  final String? remoteId;
  final String? url;

  /// Signed URL that saves the file rather than rendering it. Present only
  /// where the API hands one back; drives the viewer's download action.
  final String? downloadUrl;
  final String? name;
  final File? localFile;
  final bool uploading;
  final bool failed;

  /// Known to be an image from its filename. Only reliable for a local pick;
  /// the server hands back signed URLs with no extension.
  bool get isImage {
    final probe = (name ?? url ?? id).toLowerCase();
    return FilePickerService.isImageExtension(
      probe.contains('.') ? probe.split('.').last : '',
    );
  }

  /// What the file name says this is, when it says anything.
  ///
  /// A guess, and the only one available in the strip: the strip draws a tile
  /// per file and cannot download every one of them to read its bytes. The
  /// viewer, which handles one file at a time, sniffs instead.
  FileKind? get probableKind => FileKind.ofName(name) ?? FileKind.ofName(url);

  /// What to call this file on screen. Never the id - an id names nothing,
  /// and it is what the viewer used to fall back to.
  String displayName(AppLocalizations l10n) {
    final n = name?.trim();
    if (n != null && n.isNotEmpty) return n;
    return probableKind == FileKind.pdf
        ? l10n.filePdfDocument
        : l10n.fileDocument;
  }

  /// Whether it is worth *attempting* an image render.
  ///
  /// A remote attachment arrives as `media_item.view` - a signed URL with no
  /// extension and no mime type anywhere in the payload - so the type cannot
  /// be known ahead of time. Try to decode it and let the error builder fall
  /// back to the file glyph, rather than showing a glyph for every photo.
  bool get canPreview => localFile != null ? isImage : url != null;

  CaseAttachment copyWith({
    bool? uploading,
    bool? failed,
    String? id,
    String? remoteId,
  }) =>
      CaseAttachment(
        id: id ?? this.id,
        remoteId: remoteId ?? this.remoteId,
        url: url,
        downloadUrl: downloadUrl,
        name: name,
        localFile: localFile,
        uploading: uploading ?? this.uploading,
        failed: failed ?? this.failed,
      );
}

/// Case-level attachments: X-rays, intra-oral photos, lab reports.
///
/// Kept case-level rather than per-treatment on purpose - one upload surface,
/// and a file can still be opened from the viewer to see which tooth it
/// belongs to.
class CaseFilesSection extends StatelessWidget {
  const CaseFilesSection({
    super.key,
    required this.attachments,
    required this.onOpen,
    this.onAdd,
    this.onRetry,
  });

  final List<CaseAttachment> attachments;
  final void Function(int index) onOpen;

  /// Null on a case nobody may add to any more - a finished one. The Add
  /// text button, the trailing add tile and the empty state's action all
  /// disappear with it, leaving the files themselves openable.
  final VoidCallback? onAdd;

  /// Retrying an upload only makes sense where uploading does.
  final ValueChanged<CaseAttachment>? onRetry;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              l10n.filesTitle,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                fontFamily: family,
                color: c.textPrimary,
              ),
            ),
            if (attachments.isNotEmpty) ...[
              SizedBox(width: 6.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: c.cardBgSecondary,
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: Text(
                  '${attachments.length}',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: family,
                    color: c.textSecondary,
                  ),
                ),
              ),
            ],
            const Spacer(),
            if (onAdd != null)
              TextButton(
                onPressed: onAdd,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  l10n.add,
                  style: TextStyle(
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: family,
                    color: ColorManager.primaryDarker,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 10.h),
        if (attachments.isEmpty)
          PatientDetailPlaceholder(
            icon: Icons.attach_file_rounded,
            title: l10n.noFilesYet,
            // Nothing to invite on a closed case: it is a statement of what
            // the case holds, not an empty slot waiting to be filled.
            message: onAdd == null ? null : l10n.noFilesHint,
            primaryLabel: onAdd == null ? null : l10n.add,
            onPrimary: onAdd,
          )
        else
          SizedBox(
            height: 92.w,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: attachments.length + (onAdd == null ? 0 : 1),
              separatorBuilder: (_, _) => SizedBox(width: 8.w),
              itemBuilder: (_, i) {
                if (i == attachments.length) {
                  return _AddTile(onTap: onAdd!);
                }
                return _Thumb(
                  attachment: attachments[i],
                  onTap: () => onOpen(i),
                  onRetry: () => onRetry?.call(attachments[i]),
                );
              },
            ),
          ),
      ],
    );
  }
}

class _Thumb extends StatelessWidget {
  const _Thumb({
    required this.attachment,
    required this.onTap,
    required this.onRetry,
  });

  final CaseAttachment attachment;
  final VoidCallback onTap;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final a = attachment;

    Widget body;
    if (a.localFile != null && a.isImage) {
      body = Image.file(a.localFile!, fit: BoxFit.cover);
    } else if (a.localFile == null && a.url != null) {
      body = Image.network(
        a.url!,
        fit: BoxFit.cover,
        // A PDF or lab report lands here too and simply fails to decode.
        errorBuilder: (_, _, _) => _fileCard(context, c, l10n),
        loadingBuilder: (_, child, progress) => progress == null
            ? child
            : Center(
                child: SizedBox(
                  width: 18.w,
                  height: 18.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: c.textTertiary,
                  ),
                ),
              ),
      );
    } else {
      body = _fileCard(context, c, l10n);
    }

    return GestureDetector(
      onTap: a.failed ? onRetry : onTap,
      child: SizedBox(
        width: 92.w,
        height: 92.w,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Container(color: c.cardBgSecondary, child: body),
            ),
            // Elevation is the border, here as everywhere. An image fills its
            // tile edge to edge, so without this the strip had no edges at
            // all against a pale page.
            IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: c.borderLight),
                ),
              ),
            ),
            if (a.uploading)
              DecoratedBox(
                decoration: BoxDecoration(
                  color: ColorManager.black.withValues(alpha: 0.45),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: ColorManager.white,
                    ),
                  ),
                ),
              ),
            if (a.failed)
              DecoratedBox(
                decoration: BoxDecoration(
                  color: ColorManager.error.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.refresh_rounded,
                        size: 18.w,
                        color: ColorManager.white,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        l10n.tryAgain,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: FontHelper.fontFamily(context),
                          color: ColorManager.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// A document tile, rather than a grey glyph on a grey square.
  ///
  /// The type's own hue in a tinted icon tile - red for a PDF, the way every
  /// file list marks one - and the file's name under it, so a case carrying
  /// three lab reports does not show three identical squares.
  Widget _fileCard(BuildContext context, AppColors c, AppLocalizations l10n) {
    final isPdf = attachment.probableKind == FileKind.pdf;
    final tone = isPdf ? ColorManager.error : ColorManager.info;
    final label = attachment.displayName(l10n);

    return Container(
      color: c.cardBg,
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconTile(
            icon: isPdf
                ? Icons.picture_as_pdf_outlined
                : Icons.description_outlined,
            tone: tone,
            size: 34.w,
          ),
          SizedBox(height: 6.h),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 9.5.sp,
              height: 1.25,
              fontWeight: FontWeight.w500,
              fontFamily: FontHelper.fontFamily(context),
              color: c.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _AddTile extends StatelessWidget {
  const _AddTile({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: 92.w,
        height: 92.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: c.border, style: BorderStyle.solid),
          color: c.cardBg,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_rounded, size: 22.w, color: ColorManager.primary),
            SizedBox(height: 2.h),
            Text(
              AppLocalizations.of(context)!.add,
              style: TextStyle(
                fontSize: 11.sp,
                fontFamily: FontHelper.fontFamily(context),
                color: c.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Offline note palette. Deliberately amber rather than the app's `warning`
// orange: this is an advisory, not an error, and brown-on-yellow reads that
// way. Fixed values because a notice keeps the same meaning in either theme.
const Color _noteBg = Color(0xFFFEF3C7);
const Color _noteBorder = Color(0xFFFCD34D);
const Color _noteText = Color(0xFF854D0E);

/// Bottom sheet offering the three ways a file gets into a case.
///
/// Camera and gallery go through image_picker; documents go through
/// file_picker, which is the only one of the two that can hand back a PDF.
class AddFileSheet extends StatelessWidget {
  const AddFileSheet._();

  /// Returns the picked files, or null if dismissed. A list because both the
  /// gallery and the desktop file dialog allow a multi-select.
  ///
  /// Desktop never sees the sheet. Two of its three rows are mobile-only -
  /// there is no camera, and "gallery" there is just a file dialog filtered to
  /// images, which the attachment picker already covers - so a sheet would be
  /// one real row and two dead ends. The file dialog opens directly instead.
  static Future<List<File>?> show(BuildContext context) async {
    if (!_hasMobileSources) return _pickAttachments(context);

    final c = ColorManager.of(context);
    return showModalBottomSheet<List<File>>(
      context: context,
      backgroundColor: c.cardBg,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
      ),
      builder: (_) => const AddFileSheet._(),
    );
  }

  /// Camera and photo-library pickers only exist on the phone platforms.
  static bool get _hasMobileSources =>
      !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  /// The one path desktop uses: documents and images in a single dialog,
  /// multi-select allowed.
  static Future<List<File>?> _pickAttachments(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final pick = await getIt<FilePickerService>().pickDocuments(
      allowMultiple: true,
    );
    if (!context.mounted) return null;

    if (pick.rejectedName != null) {
      AppSnackbar.showError(
        context,
        title: l10n.unsupportedFileTitle,
        message: l10n.unsupportedFileMessage,
      );
    }
    return pick.files.isEmpty ? null : pick.files.map((f) => f.file).toList();
  }

  Future<void> _pickDocument(BuildContext context) async {
    final files = await _pickAttachments(context);
    // Nothing usable: the sheet stays open rather than closing on a file that
    // would only fail at upload, so the user can pick again.
    if (files == null || !context.mounted) return;
    Navigator.pop(context, files);
  }

  /// Straight to the system photo picker - images only, and no browsing
  /// through folders to reach them.
  Future<void> _pickFromGallery(BuildContext context) async {
    final shots = await ImagePicker().pickMultiImage(
      imageQuality: 85,
      // iOS only: skips the full-metadata fetch, which is what makes the
      // system ask for full photo-library access before showing anything.
      requestFullMetadata: false,
    );
    if (shots.isEmpty) return;
    if (context.mounted) {
      Navigator.pop(context, shots.map((x) => File(x.path)).toList());
    }
  }

  Future<void> _takePhoto(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      final shot = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );
      if (shot == null) return;
      if (context.mounted) Navigator.pop(context, [File(shot.path)]);
    } catch (_) {
      // A device with no usable camera, or a denied permission the plugin
      // surfaces as a throw. Either way, say so instead of dying.
      if (context.mounted) {
        AppSnackbar.showError(context, title: l10n.cameraUnavailable);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);

    return Padding(
      padding: EdgeInsets.only(
        bottom: systemBottomInset(context),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(top: 10.h, bottom: 14.h),
              decoration: BoxDecoration(
                color: c.border,
                borderRadius: BorderRadius.circular(999.r),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              l10n.addFileTitle,
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
                fontFamily: family,
                color: c.textPrimary,
              ),
            ),
          ),
          SizedBox(height: 18.h),
          // The whole sheet only renders where these two sources exist, so
          // there is no per-row platform check to make here.
          _Option(
            icon: Icons.photo_camera_outlined,
            title: l10n.takePhotoAction,
            subtitle: l10n.takePhotoSub,
            onTap: () => _takePhoto(context),
          ),
          SizedBox(height: 12.h),
          _Option(
            icon: Icons.photo_library_outlined,
            title: l10n.chooseFromGalleryAction,
            subtitle: l10n.chooseFromGallerySub,
            onTap: () => _pickFromGallery(context),
          ),
          SizedBox(height: 12.h),
          _Option(
            icon: Icons.description_outlined,
            title: l10n.attachDocumentAction,
            subtitle: l10n.attachDocumentSub,
            onTap: () => _pickDocument(context),
          ),
          SizedBox(height: 18.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
              decoration: BoxDecoration(
                color: _noteBg,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: _noteBorder),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.cloud_off_rounded, size: 16.w, color: _noteText),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      l10n.offlineQueuedNote,
                      style: TextStyle(
                        fontSize: 11.5.sp,
                        height: 1.4,
                        fontFamily: family,
                        color: _noteText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}

class _Option extends StatelessWidget {
  const _Option({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Material(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(14.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: c.border),
            ),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorManager.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child:
                      Icon(icon, size: 20.w, color: ColorManager.primaryDarker),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.5.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: family,
                          color: c.textPrimary,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: family,
                          color: c.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 20.w,
                  color: c.textTertiary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Full-screen viewer with pinch-zoom for images and a graceful fallback for
/// anything that is not one.
class CaseFileViewer extends StatefulWidget {
  const CaseFileViewer({
    super.key,
    required this.attachments,
    required this.initialIndex,
    this.onDelete,
  });

  final List<CaseAttachment> attachments;
  final int initialIndex;

  /// Detaches the file from the case. Omitted for a read-only case.
  final ValueChanged<CaseAttachment>? onDelete;

  static Future<void> open(
    BuildContext context, {
    required List<CaseAttachment> attachments,
    required int initialIndex,
    ValueChanged<CaseAttachment>? onDelete,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => CaseFileViewer(
          attachments: attachments,
          initialIndex: initialIndex,
          onDelete: onDelete,
        ),
      ),
    );
  }

  @override
  State<CaseFileViewer> createState() => _CaseFileViewerState();
}

class _CaseFileViewerState extends State<CaseFileViewer> {
  late final PageController _controller =
      PageController(initialPage: widget.initialIndex);
  late int _index = widget.initialIndex;

  /// Pages in the PDF on screen, once it has loaded. Zero for anything that
  /// is not one, which is what keeps the counter out of an image's way.
  int _pdfPages = 0;

  /// "2 of 7" for a PDF, "3 / 5" for a strip of files, and both when a
  /// multi-page document sits inside a multi-file case.
  String _subtitle(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final parts = <String>[
      if (_pdfPages > 1) l10n.filePageOf(_pdfPage, _pdfPages),
      if (widget.attachments.length > 1)
        '${_index + 1} / ${widget.attachments.length}',
    ];
    return parts.join('  ·  ');
  }

  int _pdfPage = 1;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Hands the signed URL to the platform, which downloads or opens it in
  /// whatever the user already uses for that file type.
  Future<void> _download(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _confirmDelete(CaseAttachment item) async {
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          l10n.removeFileTitle,
          style: TextStyle(fontSize: 16.sp, fontFamily: family),
        ),
        content: Text(
          l10n.removeFileBody,
          style: TextStyle(fontSize: 13.sp, height: 1.45, fontFamily: family),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancel, style: TextStyle(fontFamily: family)),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(
              backgroundColor: ColorManager.destructive,
            ),
            // "Delete", not "Remove": the file is gone for good, there is
            // no media library it falls back into.
            child: Text(
              l10n.delete,
              style: TextStyle(
                fontFamily: family,
                color: ColorManager.white,
              ),
            ),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    widget.onDelete!(item);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final a = widget.attachments;
    final current = _index < a.length ? a[_index] : null;
    final canDelete = widget.onDelete != null &&
        current != null &&
        current.remoteId != null &&
        !current.uploading;

    return Scaffold(
      backgroundColor: ColorManager.black,
      appBar: AppBar(
        backgroundColor: ColorManager.black,
        foregroundColor: ColorManager.white,
        elevation: 0,
        // Set explicitly, because the app's AppBarTheme names an iconTheme
        // and an explicit iconTheme wins over foregroundColor: the close
        // button was inheriting near-black ink and disappearing into this
        // bar. The status bar needs telling too - a black bar under dark
        // system icons hides those the same way.
        iconTheme: const IconThemeData(color: ColorManager.white),
        actionsIconTheme: const IconThemeData(color: ColorManager.white),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: IconButton(
          tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
          onPressed: () => Navigator.of(context).maybePop(),
          icon: Icon(
            Icons.close_rounded,
            size: 22.w,
            color: ColorManager.white,
          ),
        ),
        // The file's own name, with the position under it. The name is what
        // the user is looking for; "3 / 7" was all the bar used to say.
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              current?.displayName(AppLocalizations.of(context)!) ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13.sp,
                height: 1.2,
                fontWeight: FontWeight.w600,
                fontFamily: FontHelper.fontFamily(context),
                color: ColorManager.white,
              ),
            ),
            if (a.length > 1 || _pdfPages > 1)
              Text(
                _subtitle(context),
                maxLines: 1,
                style: TextStyle(
                  fontSize: 10.5.sp,
                  height: 1.3,
                  fontFamily: FontHelper.fontFamily(context),
                  color: ColorManager.white.withValues(alpha: 0.6),
                ),
              ),
          ],
        ),
        actions: [
          if (current?.downloadUrl != null)
            IconButton(
              tooltip: AppLocalizations.of(context)!.download,
              onPressed: () => _download(current!.downloadUrl!),
              icon: Icon(
                Icons.file_download_outlined,
                size: 22.w,
                color: ColorManager.white,
              ),
            ),
          if (canDelete)
            IconButton(
              tooltip: AppLocalizations.of(context)!.delete,
              onPressed: () => _confirmDelete(current),
              icon: Icon(
                Icons.delete_outline_rounded,
                size: 22.w,
                color: ColorManager.white,
              ),
            ),
        ],
      ),
      body: PageView.builder(
        controller: _controller,
        itemCount: a.length,
        onPageChanged: (i) => setState(() {
          _index = i;
          // The next file owns the page counter; carrying the last one's
          // over would label an image "page 2 of 7".
          _pdfPages = 0;
          _pdfPage = 1;
        }),
        itemBuilder: (_, i) {
          final item = a[i];
          final url = item.url;

          // Anything remote that is not an image goes through the type
          // probe: a PDF renders, everything else offers the way out.
          if (url != null && item.localFile == null && !item.isImage) {
            return CaseRemoteFile(
              key: ValueKey('remote-${item.id}'),
              url: url,
              name: item.name,
              probableKind: item.probableKind,
              onPdfPages: (page, pages) {
                if (i != _index) return;
                if (pages == _pdfPages && page == _pdfPage) return;
                setState(() {
                  _pdfPages = pages;
                  _pdfPage = page;
                });
              },
            );
          }

          if (!item.canPreview) {
            return CaseFileFallback(
              url: url ?? '',
              name: item.name,
              kind: item.probableKind ?? FileKind.other,
            );
          }
          return InteractiveViewer(
            minScale: 1,
            maxScale: 4,
            child: Center(
              child: item.localFile != null
                  ? Image.file(item.localFile!)
                  : Image.network(
                      item.url ?? '',
                      // Not an image after all - a document opened from the
                      // strip lands here.
                      errorBuilder: (_, _, _) => CaseFileFallback(
                        url: item.url ?? '',
                        name: item.name,
                        kind: item.probableKind ?? FileKind.other,
                      ),
                      loadingBuilder: (_, child, progress) => progress == null
                          ? child
                          : const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: ColorManager.white,
                              ),
                            ),
                    ),
            ),
          );
        },
      ),
    );
  }
}

/// Uploads a picked file and returns its media id, or null on failure.
Future<String?> uploadCaseFile(File file) async {
  try {
    final res = await getIt<MediaService>().uploadFile(file);
    return res.id;
  } catch (_) {
    return null;
  }
}
