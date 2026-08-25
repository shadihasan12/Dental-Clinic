import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/home/data/data_sources/notification_remote_data_source.dart';
import 'package:dental_clinic_app/features/home/domain/entities/notification_entity.dart';
import 'package:dental_clinic_app/features/home/domain/repositories/notification_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource _remoteDataSource;

  NotificationRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<NetworkExceptions, NotificationPageEntity>> getNotifications({
    int limit = NotificationRemoteDataSourceImpl.defaultLimit,
    String? before,
  }) async {
    try {
      final page = await _remoteDataSource.getNotifications(
        limit: limit,
        before: before,
      );
      return Right(
        NotificationPageEntity(
          notifications: page.notifications.map((m) => m.toEntity()).toList(),
          nextCursor: page.nextCursor,
          unreadCount: page.unreadCount,
        ),
      );
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, UnseenNotificationsEntity>>
      getUnseen() async {
    try {
      final response = await _remoteDataSource.getUnseen();
      return Right(
        UnseenNotificationsEntity(
          notifications:
              response.notifications.map((m) => m.toEntity()).toList(),
          remaining: response.remaining,
          unreadCount: response.unreadCount,
          pollAfter: response.pollAfter,
        ),
      );
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, int>> markSeen(List<String> ids) async {
    try {
      return Right(await _remoteDataSource.markSeen(ids));
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, int>> markAsRead(String id) async {
    try {
      return Right(await _remoteDataSource.markAsRead(id));
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, int>> markAsUnread(String id) async {
    try {
      return Right(await _remoteDataSource.markAsUnread(id));
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, int>> markAllAsRead() async {
    try {
      return Right(await _remoteDataSource.markAllAsRead());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, int>> getUnreadCount() async {
    try {
      return Right(await _remoteDataSource.getUnreadCount());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }
}
