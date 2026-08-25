import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/data/endpoints/notification_settings_endpoints.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/data/models/notification_settings_model.dart';
import 'package:injectable/injectable.dart';

abstract class NotificationSettingsRemoteDataSource {
  Future<List<NotificationSettingModel>> getSettings();

  /// [category] must be a `key` the GET returned; anything else is a 400.
  Future<void> updateSetting({required String category, required bool enabled});
}

@Injectable(as: NotificationSettingsRemoteDataSource)
class NotificationSettingsRemoteDataSourceImpl
    implements NotificationSettingsRemoteDataSource {
  final ApiConsumer _apiConsumer;

  NotificationSettingsRemoteDataSourceImpl(this._apiConsumer);

  @override
  Future<List<NotificationSettingModel>> getSettings() async {
    final response = await _apiConsumer.get(
      NotificationSettingsEndpoints.settings,
    );

    final data = response is Map ? response['data'] : null;
    if (data is! List) return const [];

    // Rendered in the order received — the response defines the ordering, and
    // there are no sections.
    return data
        .whereType<Map>()
        .map(
          (e) =>
              NotificationSettingModel.fromJson(Map<String, dynamic>.from(e)),
        )
        .toList();
  }

  @override
  Future<void> updateSetting({
    required String category,
    required bool enabled,
  }) async {
    await _apiConsumer.patch(
      NotificationSettingsEndpoints.updateSettings,
      body: {'category': category, 'enabled': enabled},
    );
  }
}
