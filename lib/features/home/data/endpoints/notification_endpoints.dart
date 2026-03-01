class NotificationEndpoints {
  NotificationEndpoints._();

  static const String notifications = '/notifications';
  static String markAsRead(String id) => '/notifications/$id/read';
  static const String markAllAsRead = '/notifications/read-all';
}
