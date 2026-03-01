import 'package:dental_clinic_app/features/home/domain/entities/notification_entity.dart';

class NotificationModel {
  final String id;
  final String title;
  final String content;
  final String type;
  final String timestamp;
  final bool isRead;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.content,
    required this.type,
    required this.timestamp,
    this.isRead = false,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      type: json['type'] as String,
      timestamp: json['timestamp'] as String,
      isRead: json['is_read'] as bool? ?? false,
    );
  }

  factory NotificationModel.fromEntity(NotificationEntity entity) {
    return NotificationModel(
      id: entity.id,
      title: entity.title,
      content: entity.content,
      type: entity.type.name,
      timestamp: entity.timestamp.toIso8601String(),
      isRead: entity.isRead,
    );
  }

  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id,
      title: title,
      content: content,
      type: _parseType(type),
      timestamp: DateTime.parse(timestamp),
      isRead: isRead,
    );
  }

  NotificationModel copyWith({bool? isRead}) {
    return NotificationModel(
      id: id,
      title: title,
      content: content,
      type: type,
      timestamp: timestamp,
      isRead: isRead ?? this.isRead,
    );
  }

  static NotificationType _parseType(String type) {
    switch (type) {
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
