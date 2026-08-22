import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/home/domain/repositories/notification_repository.dart';
import 'package:injectable/injectable.dart';

/// Returns the fresh unread count, so the badge updates without a second call.
@injectable
class MarkNotificationAsReadUseCase implements UseCase<int, String> {
  final NotificationRepository _repository;

  MarkNotificationAsReadUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, int>> call(String id) {
    return _repository.markAsRead(id);
  }
}
