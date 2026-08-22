part of 'notification_settings_bloc.dart';

@freezed
class NotificationSettingsEvent with _$NotificationSettingsEvent {
  const factory NotificationSettingsEvent.load() = _Load;

  /// [key] is the server-supplied `key`, never a label shown to the user.
  const factory NotificationSettingsEvent.toggle({
    required String key,
    required bool enabled,
  }) = _Toggle;
}
