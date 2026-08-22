import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/domain/entities/notification_settings_entity.dart';

abstract class NotificationSettingsRepository {
  /// The complete screen definition. Render it as a flat list in the order
  /// received.
  Future<Either<NetworkExceptions, List<NotificationSettingEntity>>>
      getSettings();

  /// Toggles one category. [category] must be a `key` the GET returned.
  Future<Either<NetworkExceptions, Unit>> updateSetting({
    required String category,
    required bool enabled,
  });
}
