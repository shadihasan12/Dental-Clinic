import 'dart:io';

import 'package:dental_clinic_app/services/file_picker/picked_file_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FilePickerService {
  /// Every one of these has a standard MIME mapping on Android.
  ///
  /// That matters more than it looks: file_picker turns [allowedExtensions]
  /// into an EXTRA_MIME_TYPES array, and an extension it cannot resolve
  /// degrades the whole filter to `*/*` - which is why the document picker
  /// was listing APKs. Anything added here needs a MIME type Android knows,
  /// or the filter silently stops filtering.
  static const _imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'webp', 'heic'];

  /// What a case attachment is allowed to be: documents plus images.
  ///
  /// Anything outside this list is refused. The backend rejects the rest
  /// anyway - an audio file used to pass the picker, fail the upload, and
  /// leave the user with no idea why - so the line is drawn here, where it
  /// can be explained.
  static const _documentExtensions = ['pdf', 'ppt', 'pptx', 'xls', 'xlsx'];

  /// What the media endpoint actually stores for a screenshot: JPEG and PNG
  /// and nothing else.
  ///
  /// Narrower than [_imageExtensions] on purpose - `heic` is what an iPhone
  /// hands over from the photo library, and the server rejects it, so it is
  /// kept out of the dialog rather than failing after the upload starts.
  static const screenshotExtensions = ['jpg', 'jpeg', 'png'];

  /// Server-side ceiling for one upload: 51200 KB.
  static const int maxUploadBytes = 51200 * 1024;

  /// Extensions offered by [pickDocument], images included.
  static List<String> get attachmentExtensions => [
    ..._documentExtensions,
    ..._imageExtensions,
  ];

  static bool isImageExtension(String ext) =>
      _imageExtensions.contains(ext.toLowerCase());

  static bool isAllowedAttachment(String? ext) =>
      ext != null && attachmentExtensions.contains(ext.toLowerCase());

  Future<PickedFileResult?> pickFile({FileType type = FileType.any}) async {
    final result = await FilePicker.platform.pickFiles(
      type: type,
      allowMultiple: false,
    );
    if (result == null || result.files.isEmpty) return null;
    return _toResult(result.files.first);
  }

  Future<List<PickedFileResult>> pickMultipleFiles({
    FileType type = FileType.any,
  }) async {
    final result = await FilePicker.platform.pickFiles(
      type: type,
      allowMultiple: true,
    );
    if (result == null || result.files.isEmpty) return [];
    return result.files.map(_toResult).whereType<PickedFileResult>().toList();
  }

  Future<PickedFileResult?> pickImage() async {
    return pickFile(type: FileType.image);
  }

  /// Picks case attachments, restricted to [attachmentExtensions].
  ///
  /// The native dialog is filtered, and the result is checked again on the way
  /// back. The second check is the one that actually holds: a file manager can
  /// offer "all files" regardless of what we asked for, and an extensionless
  /// file slips through any filter. So the returned outcome distinguishes
  /// "user cancelled" from "picked something we cannot accept", which is the
  /// difference between saying nothing and saying why.
  ///
  /// A mixed multi-selection keeps whatever is valid and reports the first
  /// thing it turned away, so one stray file does not throw out the other
  /// nine the user just chose.
  Future<DocumentPick> pickDocuments({bool allowMultiple = false}) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: attachmentExtensions,
      allowMultiple: allowMultiple,
    );
    if (result == null || result.files.isEmpty) {
      return const DocumentPick.cancelled();
    }

    final picked = result.files
        .map(_toResult)
        .whereType<PickedFileResult>()
        .toList();
    if (picked.isEmpty) return const DocumentPick.cancelled();

    final allowed = <PickedFileResult>[];
    String? rejected;
    for (final file in picked) {
      if (isAllowedAttachment(file.extension)) {
        allowed.add(file);
      } else {
        rejected ??= file.name;
      }
    }

    if (allowed.isEmpty) return DocumentPick.unsupported(rejected ?? '');
    return DocumentPick.picked(allowed, rejectedName: rejected);
  }

  /// Picks screenshots for a support report: JPEG or PNG, nothing else.
  ///
  /// The dialog is filtered and the result is checked again on the way back,
  /// for the same reason [pickDocuments] does it - a file manager can offer
  /// "all files" whatever we asked for.
  Future<DocumentPick> pickScreenshots({bool allowMultiple = true}) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: screenshotExtensions,
      allowMultiple: allowMultiple,
    );
    if (result == null || result.files.isEmpty) {
      return const DocumentPick.cancelled();
    }

    final picked = result.files
        .map(_toResult)
        .whereType<PickedFileResult>()
        .toList();
    if (picked.isEmpty) return const DocumentPick.cancelled();

    final allowed = <PickedFileResult>[];
    String? rejected;
    for (final file in picked) {
      final ext = file.extension?.toLowerCase();
      if (ext != null && screenshotExtensions.contains(ext)) {
        allowed.add(file);
      } else {
        rejected ??= file.name;
      }
    }

    if (allowed.isEmpty) return DocumentPick.unsupported(rejected ?? '');
    return DocumentPick.picked(allowed, rejectedName: rejected);
  }

  PickedFileResult? _toResult(PlatformFile platformFile) {
    if (platformFile.path == null) return null;
    final ext = platformFile.extension ?? '';
    return PickedFileResult(
      file: File(platformFile.path!),
      name: platformFile.name,
      extension: ext.isEmpty ? null : ext,
      isImage: isImageExtension(ext),
    );
  }
}

/// Why [FilePickerService.pickDocuments] came back without a file.
enum DocumentPickOutcome { picked, cancelled, unsupportedType }

class DocumentPick {
  const DocumentPick._(
    this.outcome, {
    this.files = const [],
    this.rejectedName,
  });

  const DocumentPick.cancelled() : this._(DocumentPickOutcome.cancelled);

  const DocumentPick.picked(
    List<PickedFileResult> files, {
    String? rejectedName,
  }) : this._(
         DocumentPickOutcome.picked,
         files: files,
         rejectedName: rejectedName,
       );

  const DocumentPick.unsupported(String name)
    : this._(DocumentPickOutcome.unsupportedType, rejectedName: name);

  final DocumentPickOutcome outcome;

  /// Everything accepted. Empty unless [outcome] is
  /// [DocumentPickOutcome.picked].
  final List<PickedFileResult> files;

  /// Name of a file we turned away. Set on [DocumentPickOutcome.unsupportedType],
  /// and also alongside a successful pick when part of a multi-selection was
  /// dropped - so the caller can take the good files and still say what went.
  final String? rejectedName;
}
