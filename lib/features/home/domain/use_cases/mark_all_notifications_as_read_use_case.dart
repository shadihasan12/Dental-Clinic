import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/home/domain/entities/notification_entity.dart';
import 'package:dental_clinic_app/features/home/domain/repositories/notification_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class MarkAllNotificationsAsReadUseCase
    implements UseCase<List<NotificationEntity>, NoParams> {
  final NotificationRepository _repository;

  MarkAllNotificationsAsReadUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, List<NotificationEntity>>> call(
    NoParams params,
  ) {
    return _repository.markAllAsRead();
  }
}
