import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_entity.freezed.dart';

/// The categories the backend ships today.
///
/// Deliberately open-ended: `category` is kept as the raw server string on the
/// entity and only mapped to an icon/colour at render time, because new
/// categories are added server-side and will reach an app that has never heard
/// of them. Nothing here may throw on an unknown value.
class NotificationCategories {
  NotificationCategories._();

  static const String appointmentReminder = 'appointment_reminder';
  static const String paymentReminder = 'payment_reminder';
  static const String clinicInvitation = 'clinic_invitation';
  static const String announcement = 'announcement';
}

@freezed
class NotificationEntity with _$NotificationEntity {
  const factory NotificationEntity({
    required String id,

    /// Server-defined kind — drives the icon and colour. May be a value this
    /// build has never seen; render a neutral fallback rather than throwing.
    required String category,

    /// Already rendered in the caller's language. Show as-is.
    required String title,

    /// Already rendered in the caller's language. May legitimately be null —
    /// announcements are often title-only.
    String? body,

    /// Deep-link payload. `data['type']` is always present and names the
    /// destination screen. See [NotificationRouting].
    @Default(<String, dynamic>{}) Map<String, dynamic> data,

    /// Whether a banner was ever raised for it. Windows-relevant only.
    @Default(false) bool isSeen,

    /// Whether the user opened it. Drives the unread dot and the badge.
    @Default(false) bool isRead,
    DateTime? readAt,
    required DateTime sentAt,
  }) = _NotificationEntity;
}

/// One cursor-paged slice of the inbox, plus the badge count the same
/// response carried.
@freezed
class NotificationPageEntity with _$NotificationPageEntity {
  const factory NotificationPageEntity({
    required List<NotificationEntity> notifications,

    /// Pass as `before` for the next page. `null` means no more pages.
    String? nextCursor,
    @Default(0) int unreadCount,
  }) = _NotificationPageEntity;
}

/// The `/unseen` payload — Windows polling only.
@freezed
class UnseenNotificationsEntity with _$UnseenNotificationsEntity {
  const factory UnseenNotificationsEntity({
    required List<NotificationEntity> notifications,

    /// How many unseen notifications were withheld past the server's cap.
    /// Surface as a single summary banner, never as that many banners.
    @Default(0) int remaining,
    @Default(0) int unreadCount,

    /// Seconds until the next poll. Server-controlled — never hardcode it.
    @Default(30) int pollAfter,
  }) = _UnseenNotificationsEntity;
}
