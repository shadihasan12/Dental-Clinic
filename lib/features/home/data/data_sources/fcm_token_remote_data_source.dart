import 'dart:io';

import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/features/home/data/endpoints/notification_endpoints.dart';
import 'package:injectable/injectable.dart';

abstract class FcmTokenRemoteDataSource {
  Future<void> register(String token);
}

@Injectable(as: FcmTokenRemoteDataSource)
class FcmTokenRemoteDataSourceImpl implements FcmTokenRemoteDataSource {
  final ApiConsumer _apiConsumer;

  FcmTokenRemoteDataSourceImpl(this._apiConsumer);

  @override
  Future<void> register(String token) async {
    await _apiConsumer.post(
      NotificationEndpoints.fcmToken,
      body: {
        'token': token,
        'platform': _platform(),
      },
    );
  }

  String _platform() {
    if (Platform.isAndroid) return 'android';
    if (Platform.isIOS) return 'ios';
    return 'unknown';
  }
}
