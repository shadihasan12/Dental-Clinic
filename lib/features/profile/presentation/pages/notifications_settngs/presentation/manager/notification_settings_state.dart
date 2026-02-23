part of 'notification_settings_bloc.dart';

@freezed
class NotificationSettingsState with _$NotificationSettingsState {
  const factory NotificationSettingsState.initial() = _Initial;
  const factory NotificationSettingsState.loading() = _Loading;
  const factory NotificationSettingsState.loaded(
    NotificationSettingsEntity settings,
  ) = _Loaded;
  const factory NotificationSettingsState.error(String message) = _Error;
}
