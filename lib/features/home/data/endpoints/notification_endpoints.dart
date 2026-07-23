class NotificationEndpoints {
  NotificationEndpoints._();

  static const String notifications = '/notifications';
  static String markAsRead(String id) => '/notifications/$id/read';
  static const String markAllAsRead = '/notifications/read-all';

  /// POST { token, platform } — backend stores the FCM device token against
  /// the authenticated user. Server should dedupe per-user-per-device and
  /// invalidate on logout/uninstall.
  static const String fcmToken = '/users/me/fcm-token';
}
