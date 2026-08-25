import 'package:dental_clinic_app/core/services/notifications/notification_routing.dart';
import 'package:dental_clinic_app/features/home/domain/entities/notification_entity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

/// Strongly-typed view over an inbound FCM message.
///
/// Server-side payload contract (see the integration guide, §9):
///
///   notification.title / notification.body   — system-shown text (Android/web)
///   apns.payload.aps.alert.title / .body     — the same, on iOS
///   data: {
///     "type":     "appointment_reminder|payment_reminder|clinic_invitation|announcement",
///     "category": same value as `type` — prefer `type`,
///     ...id keys that depend on the type (see NotificationRouting)
///   }
///
/// Every FCM `data` value arrives as a string; the list API sends the same
/// keys with real types. Nothing downstream may assume one or the other.
class PushPayload {
  final String? id;
  final String? title;
  final String? body;

  /// The raw `data` map — the single source for both the category and the
  /// deep link.
  final Map<String, dynamic> data;
  final DateTime receivedAt;

  const PushPayload({
    required this.id,
    required this.title,
    required this.body,
    required this.data,
    required this.receivedAt,
  });

  /// Server category, e.g. `announcement`. Empty when the push omits it.
  String get category => NotificationRouting.typeOf(data);

  factory PushPayload.fromRemoteMessage(RemoteMessage message) {
    final data = Map<String, dynamic>.from(message.data);
    final id = (data['id'] as String?)?.trim();
    return PushPayload(
      id: (id != null && id.isNotEmpty) ? id : message.messageId,
      title: message.notification?.title ?? data['title'] as String?,
      body: message.notification?.body ?? data['body'] as String?,
      data: data,
      receivedAt: message.sentTime ?? DateTime.now(),
    );
  }

  /// A provisional inbox row for a push that just arrived, so an open list can
  /// show it without a refetch. The server row remains authoritative.
  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id ?? receivedAt.microsecondsSinceEpoch.toString(),
      category: category,
      title: title ?? '',
      body: body,
      data: data,
      isSeen: true,
      isRead: false,
      sentAt: receivedAt,
    );
  }
}
