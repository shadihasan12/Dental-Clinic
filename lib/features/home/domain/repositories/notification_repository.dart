import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/home/domain/entities/notification_entity.dart';

abstract class NotificationRepository {
  /// One cursor-paged slice of the inbox. Pass the previous page's
  /// `nextCursor` as [before]; ids sort by time, newest first.
  Future<Either<NetworkExceptions, NotificationPageEntity>> getNotifications({
    int limit,
    String? before,
  });

  /// **Windows only.** What has never been announced to the user.
  Future<Either<NetworkExceptions, UnseenNotificationsEntity>> getUnseen();

  /// **Windows only.** Acknowledge the banners we actually raised.
  /// Returns how many rows changed.
  Future<Either<NetworkExceptions, int>> markSeen(List<String> ids);

  /// Each of these returns the fresh `unread_count`, so the badge never needs
  /// a follow-up request.
  Future<Either<NetworkExceptions, int>> markAsRead(String id);
  Future<Either<NetworkExceptions, int>> markAsUnread(String id);
  Future<Either<NetworkExceptions, int>> markAllAsRead();
  Future<Either<NetworkExceptions, int>> getUnreadCount();
}
