
import 'dart:io';

class PickedFileResult {
  final File file;
  final String name;
  final String? extension;
  final bool isImage;

  const PickedFileResult({
    required this.file,
    required this.name,
    this.extension,
    required this.isImage,
  });
}
