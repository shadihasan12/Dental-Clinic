import 'dart:io';

import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/features/auth/data/endpoints/auth_endpoints.dart';
import 'package:injectable/injectable.dart';

abstract class FcmTokenRemoteDataSource {
  Future<void> register(String token);
}

@Injectable(as: FcmTokenRemoteDataSource)
class FcmTokenRemoteDataSourceImpl implements FcmTokenRemoteDataSource {
  final ApiConsumer _apiConsumer;

  FcmTokenRemoteDataSourceImpl(this._apiConsumer);

  /// The only two values the backend accepts for `platform`. Anything else
  /// (desktop, web) has no FCM device token worth registering — callers should
  /// check [isSupportedPlatform] first rather than let this throw.
  static String? get currentPlatform {
    if (Platform.isAndroid) return 'ANDROID';
    if (Platform.isIOS) return 'IOS';
    return null;
  }

  static bool get isSupportedPlatform => currentPlatform != null;

  @override
  Future<void> register(String token) async {
    final platform = currentPlatform;
    if (platform == null) {
      throw UnsupportedError(
        'Device token registration is only supported on Android and iOS.',
      );
    }

    await _apiConsumer.post(
      AuthEndpoints.deviceToken,
      body: {
        'token': token,
        'platform': platform,
      },
    );
  }
}
