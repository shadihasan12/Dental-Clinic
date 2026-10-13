import 'dart:io';

import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/services/media/media_upload_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';


@lazySingleton
class MediaService {
  final ApiConsumer _apiConsumer;

  MediaService(this._apiConsumer);

  static const String _uploadEndpoint = '/media-items';
  static String _updateFilenameEndpoint(String id) =>
      '/media-items/$id/update-filename';

  /// What each extension the app lets through is declared as.
  ///
  /// Dio labels every part `application/octet-stream` unless told otherwise,
  /// and a server that validates the declared type turns a perfectly good
  /// PNG away on that alone.
  static const Map<String, String> _mimeTypes = {
    'jpg': 'image/jpeg',
    'jpeg': 'image/jpeg',
    'png': 'image/png',
    'webp': 'image/webp',
    'heic': 'image/heic',
    'heif': 'image/heif',
    'tif': 'image/tiff',
    'tiff': 'image/tiff',
    'bmp': 'image/bmp',
    'mp4': 'video/mp4',
    'mov': 'video/quicktime',
    'webm': 'video/webm',
    'pdf': 'application/pdf',
    'doc': 'application/msword',
    'docx':
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    'xls': 'application/vnd.ms-excel',
    'xlsx': 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    'ppt': 'application/vnd.ms-powerpoint',
    'pptx':
        'application/vnd.openxmlformats-officedocument.presentationml.presentation',
    'dcm': 'application/dicom',
    'csv': 'text/csv',
    'txt': 'text/plain',
  };

  static DioMediaType? _mediaTypeOf(String filename) {
    final dot = filename.lastIndexOf('.');
    if (dot < 0) return null;
    final mime = _mimeTypes[filename.substring(dot + 1).toLowerCase()];
    return mime == null ? null : DioMediaType.parse(mime);
  }

  Future<MediaUploadResponse> uploadFile(
    File file, {
    String? customFilename,
  }) async {
    final filename = file.path.split(Platform.pathSeparator).last;
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: filename,
        contentType: _mediaTypeOf(filename),
      ),
      if (customFilename != null) 'custom_filename': customFilename,
    });

    final response = await _apiConsumer.post(
      _uploadEndpoint,
      formData: formData,
    );

    return MediaUploadResponse.fromJson(
      response['data'] as Map<String, dynamic>,
    );
  }

  Future<void> updateFilename(String mediaId, String newFileName) async {
    await _apiConsumer.put(
      _updateFilenameEndpoint(mediaId),
      body: {'new_file_name': newFileName},
    );
  }
}
