import 'package:dental_clinic_app/features/home/domain/entities/notification_entity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

/// Strongly-typed view over an inbound FCM message.
///
/// Server-side payload contract — keep in sync with the backend:
///
///   notification.title / notification.body  — system-shown text
///   data: {
///     "id":        "<uuid>",                 // server-side notification row
///     "type":      "appointment|payment|patient|report|treatment|cancellation",
///     "deep_link": "/notifications" (optional, defaults to /notifications),
///   }
///
/// When `data.id` is present we treat the push as authoritative and surface it
/// through the in-app stream so the bloc can append without a network refetch.
class PushPayload {
  final String? id;
  final String? title;
  final String? body;
  final NotificationType type;
  final String deepLink;
  final DateTime receivedAt;
  final Map<String, dynamic> raw;

  const PushPayload({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.deepLink,
    required this.receivedAt,
    required this.raw,
  });

  factory PushPayload.fromRemoteMessage(RemoteMessage message) {
    final data = message.data;
    return PushPayload(
      id: (data['id'] as String?)?.trim().isNotEmpty == true
          ? data['id'] as String
          : message.messageId,
      title: message.notification?.title ?? data['title'] as String?,
      body: message.notification?.body ?? data['body'] as String?,
      type: _parseType(data['type'] as String?),
      deepLink: (data['deep_link'] as String?) ?? '/notifications',
      receivedAt: message.sentTime ?? DateTime.now(),
      raw: Map<String, dynamic>.from(data),
    );
  }

  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id ?? receivedAt.microsecondsSinceEpoch.toString(),
      title: title ?? '',
      content: body ?? '',
      type: type,
      timestamp: receivedAt,
      isRead: false,
    );
  }

  static NotificationType _parseType(String? raw) {
    switch (raw) {
      case 'appointment':
        return NotificationType.appointment;
      case 'payment':
        return NotificationType.payment;
      case 'patient':
        return NotificationType.patient;
      case 'report':
        return NotificationType.report;
      case 'treatment':
        return NotificationType.treatment;
      case 'cancellation':
        return NotificationType.cancellation;
      default:
        return NotificationType.appointment;
    }
  }
}
