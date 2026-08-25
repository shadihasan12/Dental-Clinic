import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/domain/repositories/notification_settings_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

class UpdateNotificationSettingParams extends Equatable {
  /// A `key` from the GET response - anything else is rejected with 400.
  final String category;
  final bool enabled;

  const UpdateNotificationSettingParams({
    required this.category,
    required this.enabled,
  });

  @override
  List<Object?> get props => [category, enabled];
}

@injectable
class UpdateNotificationSettingUseCase
    implements UseCase<Unit, UpdateNotificationSettingParams> {
  final NotificationSettingsRepository _repository;

  UpdateNotificationSettingUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, Unit>> call(
    UpdateNotificationSettingParams params,
  ) {
    return _repository.updateSetting(
      category: params.category,
      enabled: params.enabled,
    );
  }
}
