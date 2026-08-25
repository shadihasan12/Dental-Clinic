import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/home/domain/entities/notification_entity.dart';
import 'package:dental_clinic_app/features/home/domain/repositories/notification_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

class GetNotificationsParams extends Equatable {
  /// Server caps this at 100.
  final int limit;

  /// The previous page's `nextCursor`. `null` fetches the newest page.
  final String? before;

  const GetNotificationsParams({this.limit = 30, this.before});

  @override
  List<Object?> get props => [limit, before];
}

@injectable
class GetNotificationsUseCase
    implements UseCase<NotificationPageEntity, GetNotificationsParams> {
  final NotificationRepository _repository;

  GetNotificationsUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, NotificationPageEntity>> call(
    GetNotificationsParams params,
  ) {
    return _repository.getNotifications(
      limit: params.limit,
      before: params.before,
    );
  }
}
