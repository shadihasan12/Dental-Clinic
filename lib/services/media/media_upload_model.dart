class MediaUploadResponse {
  final String id;
  final String filename;
  final String formattedFilename;
  final String extension;
  final String mimeType;
  final int size;
  final String url;

  const MediaUploadResponse({
    required this.id,
    required this.filename,
    required this.formattedFilename,
    required this.extension,
    required this.mimeType,
    required this.size,
    required this.url,
  });

  /// Lenient on everything but the id: a stored upload whose size arrived as
  /// a string or a decimal must not read as a failed one.
  factory MediaUploadResponse.fromJson(Map<String, dynamic> json) {
    final size = json['size'];
    return MediaUploadResponse(
      id: json['id'].toString(),
      filename: json['filename']?.toString() ?? '',
      formattedFilename: json['formatted_filename']?.toString() ?? '',
      extension: json['extension']?.toString() ?? '',
      mimeType: json['mime_type']?.toString() ?? '',
      size: size is num ? size.toInt() : int.tryParse('$size') ?? 0,
      url: json['url']?.toString() ?? '',
    );
  }
}