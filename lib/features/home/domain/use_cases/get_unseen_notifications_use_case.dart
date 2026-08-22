import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/home/domain/entities/notification_entity.dart';
import 'package:dental_clinic_app/features/home/domain/repositories/notification_repository.dart';
import 'package:injectable/injectable.dart';

/// **Windows only.** The only caller is NotificationPoller; FCM platforms
/// receive a real push and must never poll, or every notification raises a
/// second banner.
@injectable
class GetUnseenNotificationsUseCase
    implements UseCase<UnseenNotificationsEntity, NoParams> {
  final NotificationRepository _repository;

  GetUnseenNotificationsUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, UnseenNotificationsEntity>> call(
    NoParams params,
  ) {
    return _repository.getUnseen();
  }
}
