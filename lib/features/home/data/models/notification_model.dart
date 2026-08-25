import 'package:dental_clinic_app/features/home/domain/entities/notification_entity.dart';

/// Wire model for one row of `GET /notifications` (and `/notifications/unseen`,
/// which returns the identical shape).
class NotificationModel {
  final String id;
  final String category;
  final String title;
  final String? body;
  final Map<String, dynamic> data;
  final bool isSeen;
  final bool isRead;
  final String? readAt;
  final String sentAt;

  const NotificationModel({
    required this.id,
    required this.category,
    required this.title,
    this.body,
    this.data = const <String, dynamic>{},
    this.isSeen = false,
    this.isRead = false,
    this.readAt,
    required this.sentAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      category: json['category'] as String? ?? '',
      title: json['title'] as String? ?? '',
      // Documented as nullable — announcements may carry a title only.
      body: json['body'] as String?,
      data: json['data'] is Map
          ? Map<String, dynamic>.from(json['data'] as Map)
          : const <String, dynamic>{},
      isSeen: json['is_seen'] as bool? ?? false,
      isRead: json['is_read'] as bool? ?? false,
      readAt: json['read_at'] as String?,
      sentAt: json['sent_at'] as String? ?? '',
    );
  }

  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id,
      category: category,
      title: title,
      body: body,
      data: data,
      isSeen: isSeen,
      isRead: isRead,
      readAt: readAt == null ? null : DateTime.tryParse(readAt!),
      // sent_at is ISO 8601 with an offset; fall back to "now" rather than
      // throwing if the server ever sends something unparseable.
      sentAt: DateTime.tryParse(sentAt)?.toLocal() ?? DateTime.now(),
    );
  }
}
