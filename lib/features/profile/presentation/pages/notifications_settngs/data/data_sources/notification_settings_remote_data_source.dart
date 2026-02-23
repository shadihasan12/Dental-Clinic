import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/data/models/notification_settings_model.dart';
import 'package:injectable/injectable.dart';

abstract class NotificationSettingsRemoteDataSource {
  Future<NotificationSettingsModel> getSettings();
  Future<NotificationSettingsModel> updateSettings(
    NotificationSettingsModel settings,
  );
}

@Injectable(as: NotificationSettingsRemoteDataSource)
class NotificationSettingsRemoteDataSourceImpl
    implements NotificationSettingsRemoteDataSource {
  // ignore: unused_field
  final ApiConsumer _apiConsumer;

  NotificationSettingsRemoteDataSourceImpl(this._apiConsumer);

  NotificationSettingsModel? _cachedSettings;

  NotificationSettingsModel _getMockSettings() {
    if (_cachedSettings != null) return _cachedSettings!;

    _cachedSettings = const NotificationSettingsModel(
      appointmentReminders: true,
      paymentReminders: true,
      patientFollowUp: false,
      newsAndUpdates: true,
      newFeatures: true,
      promotionalOffers: false,
      statisticsUpdates: true,
      pushNotifications: true,
      emailNotifications: true,
    );
    return _cachedSettings!;
  }

  @override
  Future<NotificationSettingsModel> getSettings() async {
    // TODO: Replace with real API call when backend is ready
    // final response = await _apiConsumer.get(
    //   NotificationSettingsEndpoints.settings,
    // );
    // return NotificationSettingsModel.fromJson(
    //   response as Map<String, dynamic>,
    // );

    await Future.delayed(const Duration(milliseconds: 800));
    return _getMockSettings();
  }

  @override
  Future<NotificationSettingsModel> updateSettings(
    NotificationSettingsModel settings,
  ) async {
    // TODO: Replace with real API call when backend is ready
    // final response = await _apiConsumer.put(
    //   NotificationSettingsEndpoints.updateSettings,
    //   body: settings.toJson(),
    // );
    // return NotificationSettingsModel.fromJson(
    //   response as Map<String, dynamic>,
    // );

    await Future.delayed(const Duration(milliseconds: 300));
    _cachedSettings = settings;
    return settings;
  }
}
