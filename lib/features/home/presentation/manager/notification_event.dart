part of 'notification_bloc.dart';

@freezed
class NotificationEvent with _$NotificationEvent {
  const factory NotificationEvent.loadNotifications() = _LoadNotifications;
  const factory NotificationEvent.markAsRead(String id) = _MarkAsRead;
  const factory NotificationEvent.markAllAsRead() = _MarkAllAsRead;

  /// Fired internally when a foreground FCM push arrives while the bloc is
  /// alive. The payload is prepended to the current list so the screen
  /// updates without a network refetch.
  const factory NotificationEvent.pushReceived(
    NotificationEntity notification,
  ) = _PushReceived;
}
