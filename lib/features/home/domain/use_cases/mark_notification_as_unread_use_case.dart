import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/home/domain/repositories/notification_repository.dart';
import 'package:injectable/injectable.dart';

/// The notification stays *seen* — it was already announced once and must not
/// be announced again.
@injectable
class MarkNotificationAsUnreadUseCase implements UseCase<int, String> {
  final NotificationRepository _repository;

  MarkNotificationAsUnreadUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, int>> call(String id) {
    return _repository.markAsUnread(id);
  }
}
