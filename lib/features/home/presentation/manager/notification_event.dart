part of 'notification_bloc.dart';

@freezed
class NotificationEvent with _$NotificationEvent {
  const factory NotificationEvent.loadNotifications() = _LoadNotifications;
  const factory NotificationEvent.markAsRead(String id) = _MarkAsRead;
  const factory NotificationEvent.markAllAsRead() = _MarkAllAsRead;
}
