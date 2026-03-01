import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/domain/entities/notification_settings_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/domain/repositories/notification_settings_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateNotificationSettingsUseCase
    extends UseCase<NotificationSettingsEntity, NotificationSettingsEntity> {
  final NotificationSettingsRepository _repository;

  UpdateNotificationSettingsUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, NotificationSettingsEntity>> call(
    NotificationSettingsEntity params,
  ) {
    return _repository.updateSettings(params);
  }
}
