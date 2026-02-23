import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/data/data_sources/notification_settings_remote_data_source.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/data/models/notification_settings_model.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/domain/entities/notification_settings_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/domain/repositories/notification_settings_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NotificationSettingsRepository)
class NotificationSettingsRepositoryImpl
    implements NotificationSettingsRepository {
  final NotificationSettingsRemoteDataSource _remoteDataSource;

  NotificationSettingsRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<NetworkExceptions, NotificationSettingsEntity>>
      getSettings() async {
    try {
      final model = await _remoteDataSource.getSettings();
      return Right(model.toEntity());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, NotificationSettingsEntity>> updateSettings(
    NotificationSettingsEntity settings,
  ) async {
    try {
      final model = await _remoteDataSource.updateSettings(
        NotificationSettingsModel.fromEntity(settings),
      );
      return Right(model.toEntity());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }
}
