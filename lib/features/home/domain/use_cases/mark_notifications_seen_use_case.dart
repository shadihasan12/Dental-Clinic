import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/home/domain/repositories/notification_repository.dart';
import 'package:injectable/injectable.dart';

/// **Windows only.** Call this *after* the banners have actually been shown —
/// acknowledging first and then crashing loses those notifications forever.
@injectable
class MarkNotificationsSeenUseCase implements UseCase<int, List<String>> {
  final NotificationRepository _repository;

  MarkNotificationsSeenUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, int>> call(List<String> ids) {
    return _repository.markSeen(ids);
  }
}
