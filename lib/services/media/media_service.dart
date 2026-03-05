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

  Future<MediaUploadResponse> uploadFile(
    File file, {
    String? customFilename,
  }) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split(Platform.pathSeparator).last,
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
