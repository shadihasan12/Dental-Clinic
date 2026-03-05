import 'dart:io';

import 'package:dental_clinic_app/services/file_picker/picked_file_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';


@lazySingleton
class FilePickerService {
  static const _imageExtensions = [
    'jpg',
    'jpeg',
    'png',
    'gif',
    'webp',
    'bmp',
    'heic',
  ];

  static bool isImageExtension(String ext) =>
      _imageExtensions.contains(ext.toLowerCase());

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
    return result.files
        .map(_toResult)
        .whereType<PickedFileResult>()
        .toList();
  }

  Future<PickedFileResult?> pickImage() async {
    return pickFile(type: FileType.image);
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
