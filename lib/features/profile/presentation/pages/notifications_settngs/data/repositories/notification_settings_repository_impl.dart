import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/data/data_sources/notification_settings_remote_data_source.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/domain/entities/notification_settings_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/domain/repositories/notification_settings_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NotificationSettingsRepository)
class NotificationSettingsRepositoryImpl
    implements NotificationSettingsRepository {
  final NotificationSettingsRemoteDataSource _remoteDataSource;

  NotificationSettingsRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<NetworkExceptions, List<NotificationSettingEntity>>>
      getSettings() async {
    try {
      final models = await _remoteDataSource.getSettings();
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, Unit>> updateSetting({
    required String category,
    required bool enabled,
  }) async {
    try {
      await _remoteDataSource.updateSetting(
        category: category,
        enabled: enabled,
      );
      return const Right(unit);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }
}
