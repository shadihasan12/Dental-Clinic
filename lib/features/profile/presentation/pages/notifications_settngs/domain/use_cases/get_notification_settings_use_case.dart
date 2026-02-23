import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/domain/entities/notification_settings_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/domain/repositories/notification_settings_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetNotificationSettingsUseCase
    extends UseCase<NotificationSettingsEntity, NoParams> {
  final NotificationSettingsRepository _repository;

  GetNotificationSettingsUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, NotificationSettingsEntity>> call(
    NoParams params,
  ) {
    return _repository.getSettings();
  }
}
