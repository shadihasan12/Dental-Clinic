/// Endpoints for the notification inbox.
///
/// Contract reference: "Notifications — Client Integration Guide" §11.
/// Every one of these requires the Authorization header.
class NotificationEndpoints {
  NotificationEndpoints._();

  /// GET — the inbox. Cursor-paged with `?limit=&before=`.
  static const String notifications = '/notifications';

  /// GET — **Windows only.** Notifications never announced to the user.
  static const String unseen = '/notifications/unseen';

  /// POST — **Windows only.** Acknowledge the ones we actually showed.
  /// Body: `{"ids": [...]}` (1–200 uuids).
  static const String seen = '/notifications/seen';

  /// GET — just the badge number.
  static const String unreadCount = '/notifications/unread-count';

  /// POST — no body. Marks read (and implicitly seen).
  static String markAsRead(String id) => '/notifications/$id/read';

  /// POST — no body. Marks unread again; stays seen.
  static String markAsUnread(String id) => '/notifications/$id/unread';

  /// POST — no body.
  static const String readAll = '/notifications/read-all';

  // The device-token endpoint lives on the auth API - see
  // AuthEndpoints.deviceToken.
}
