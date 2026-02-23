import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_entity.freezed.dart';

enum NotificationType {
  appointment,
  payment,
  patient,
  report,
  treatment,
  cancellation,
}

@freezed
class NotificationEntity with _$NotificationEntity {
  const factory NotificationEntity({
    required String id,
    required String title,
    required String content,
    required NotificationType type,
    required DateTime timestamp,
    @Default(false) bool isRead,
  }) = _NotificationEntity;
}
