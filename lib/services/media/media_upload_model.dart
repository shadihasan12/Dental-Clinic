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

  factory MediaUploadResponse.fromJson(Map<String, dynamic> json) {
    return MediaUploadResponse(
      id: json['id'] as String,
      filename: json['filename'] as String? ?? '',
      formattedFilename: json['formatted_filename'] as String? ?? '',
      extension: json['extension'] as String? ?? '',
      mimeType: json['mime_type'] as String? ?? '',
      size: json['size'] as int? ?? 0,
      url: json['url'] as String? ?? '',
    );
  }
}