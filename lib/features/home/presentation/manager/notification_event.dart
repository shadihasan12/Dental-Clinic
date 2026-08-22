part of 'notification_bloc.dart';

@freezed
class NotificationEvent with _$NotificationEvent {
  /// First page, with the full-screen skeleton.
  const factory NotificationEvent.load() = _Load;

  /// First page again, without blanking what is already on screen.
  const factory NotificationEvent.refresh() = _Refresh;

  /// Next page, using the cursor the last response handed back.
  const factory NotificationEvent.loadMore() = _LoadMore;

  const factory NotificationEvent.markAsRead(String id) = _MarkAsRead;
  const factory NotificationEvent.markAsUnread(String id) = _MarkAsUnread;
  const factory NotificationEvent.markAllAsRead() = _MarkAllAsRead;

  /// Fired internally when a foreground FCM push arrives while the bloc is
  /// alive. The payload is prepended to the current list so the screen
  /// updates without a network refetch.
  const factory NotificationEvent.pushReceived(
    NotificationEntity notification,
  ) = _PushReceived;
}
