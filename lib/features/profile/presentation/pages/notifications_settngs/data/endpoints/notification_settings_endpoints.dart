/// Endpoints backing the notification-settings screen.
class NotificationSettingsEndpoints {
  NotificationSettingsEndpoints._();

  /// GET - the whole screen: keys, labels, descriptions, order, and the
  /// `audience` topic name for broadcast categories.
  static const String settings = '/notification-settings';

  /// PATCH - one switch. Body: `{"category": "<key>", "enabled": bool}`.
  /// Validation failures come back as 400, not 422.
  static const String updateSettings = '/notification-settings';
}
