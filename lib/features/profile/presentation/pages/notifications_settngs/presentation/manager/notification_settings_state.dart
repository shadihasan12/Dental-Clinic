part of 'notification_settings_bloc.dart';

enum NotificationSettingsStatus { initial, loading, success, failure }

@freezed
class NotificationSettingsState with _$NotificationSettingsState {
  const factory NotificationSettingsState({
    @Default(NotificationSettingsStatus.initial)
    NotificationSettingsStatus status,

    /// Rendered as a flat list in exactly this order. There are no sections,
    /// and nothing here is hardcoded client-side.
    @Default(<NotificationSettingEntity>[])
    List<NotificationSettingEntity> settings,

    /// Keys whose PATCH is still in flight - their switch is disabled so a
    /// second tap can't race the first.
    @Default(<String>{}) Set<String> pendingKeys,

    /// Set when a toggle was rejected and rolled back; shown once, then
    /// cleared by the next successful action.
    String? errorMessage,
  }) = _NotificationSettingsState;

  const NotificationSettingsState._();

  bool isPending(String key) => pendingKeys.contains(key);
}
