import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/home/domain/entities/notification_entity.dart';

abstract class NotificationRepository {
  Future<Either<NetworkExceptions, List<NotificationEntity>>>
      getAllNotifications();
  Future<Either<NetworkExceptions, NotificationEntity>> markAsRead(String id);
  Future<Either<NetworkExceptions, List<NotificationEntity>>> markAllAsRead();
}
