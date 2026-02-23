import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/domain/entities/notification_settings_entity.dart';

abstract class NotificationSettingsRepository {
  Future<Either<NetworkExceptions, NotificationSettingsEntity>> getSettings();
  Future<Either<NetworkExceptions, NotificationSettingsEntity>> updateSettings(
    NotificationSettingsEntity settings,
  );
}
