import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/home/domain/entities/notification_entity.dart';
import 'package:dental_clinic_app/features/home/domain/repositories/notification_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class MarkNotificationAsReadUseCase
    implements UseCase<NotificationEntity, String> {
  final NotificationRepository _repository;

  MarkNotificationAsReadUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, NotificationEntity>> call(String params) {
    return _repository.markAsRead(params);
  }
}
