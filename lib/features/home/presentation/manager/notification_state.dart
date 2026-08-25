part of 'notification_bloc.dart';

enum NotificationStatus { initial, loading, success, failure }

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState({
    @Default(NotificationStatus.initial) NotificationStatus status,
    @Default(<NotificationEntity>[]) List<NotificationEntity> notifications,

    /// Pass as `before` for the next page. `null` means there are no more —
    /// this is a cursor, never a page number: new notifications arrive at the
    /// top constantly, so an offset-based page 2 would repeat or skip rows.
    String? nextCursor,
    @Default(0) int unreadCount,
    @Default(false) bool isLoadingMore,
    String? errorMessage,
  }) = _NotificationState;

  const NotificationState._();

  bool get hasMore => nextCursor != null;
  bool get hasUnread => unreadCount > 0 || notifications.any((n) => !n.isRead);
  bool get isEmpty =>
      status == NotificationStatus.success && notifications.isEmpty;
}
