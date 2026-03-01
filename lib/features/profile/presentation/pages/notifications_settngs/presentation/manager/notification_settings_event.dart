part of 'notification_settings_bloc.dart';

@freezed
class NotificationSettingsEvent with _$NotificationSettingsEvent {
  const factory NotificationSettingsEvent.loadSettings() = _LoadSettings;
  const factory NotificationSettingsEvent.updateSettings(
    NotificationSettingsEntity settings,
  ) = _UpdateSettings;
}
