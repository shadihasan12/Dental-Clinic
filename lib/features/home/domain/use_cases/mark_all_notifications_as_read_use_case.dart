import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/home/domain/repositories/notification_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class MarkAllNotificationsAsReadUseCase implements UseCase<int, NoParams> {
  final NotificationRepository _repository;

  MarkAllNotificationsAsReadUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, int>> call(NoParams params) {
    return _repository.markAllAsRead();
  }
}
