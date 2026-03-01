import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/home/domain/entities/notification_entity.dart';
import 'package:dental_clinic_app/features/home/domain/use_cases/get_all_notifications_use_case.dart';
import 'package:dental_clinic_app/features/home/domain/use_cases/mark_notification_as_read_use_case.dart';
import 'package:dental_clinic_app/features/home/domain/use_cases/mark_all_notifications_as_read_use_case.dart';
import 'package:injectable/injectable.dart';

part 'notification_bloc.freezed.dart';
part 'notification_event.dart';
part 'notification_state.dart';

@injectable
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetAllNotificationsUseCase _getAllNotifications;
  final MarkNotificationAsReadUseCase _markNotificationAsRead;
  final MarkAllNotificationsAsReadUseCase _markAllNotificationsAsRead;

  NotificationBloc({
    required GetAllNotificationsUseCase getAllNotifications,
    required MarkNotificationAsReadUseCase markNotificationAsRead,
    required MarkAllNotificationsAsReadUseCase markAllNotificationsAsRead,
  })  : _getAllNotifications = getAllNotifications,
        _markNotificationAsRead = markNotificationAsRead,
        _markAllNotificationsAsRead = markAllNotificationsAsRead,
        super(const NotificationState.initial()) {
    on<_LoadNotifications>(_onLoadNotifications);
    on<_MarkAsRead>(_onMarkAsRead);
    on<_MarkAllAsRead>(_onMarkAllAsRead);
  }

  Future<void> _onLoadNotifications(
    _LoadNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    emit(const NotificationState.loading());

    final result = await _getAllNotifications(NoParams());

    result.fold(
      (error) => emit(
        NotificationState.error(NetworkExceptions.getErrorMessage(error)),
      ),
      (notifications) => emit(NotificationState.loaded(notifications)),
    );
  }

  Future<void> _onMarkAsRead(
    _MarkAsRead event,
    Emitter<NotificationState> emit,
  ) async {
    final currentState = state;
    if (currentState is! _Loaded) return;

    final result = await _markNotificationAsRead(event.id);

    result.fold(
      (_) {},
      (updatedNotification) {
        final updatedList = currentState.notifications.map((n) {
          return n.id == updatedNotification.id ? updatedNotification : n;
        }).toList();
        emit(NotificationState.loaded(updatedList));
      },
    );
  }

  Future<void> _onMarkAllAsRead(
    _MarkAllAsRead event,
    Emitter<NotificationState> emit,
  ) async {
    final currentState = state;
    if (currentState is! _Loaded) return;

    final result = await _markAllNotificationsAsRead(NoParams());

    result.fold(
      (_) {},
      (notifications) => emit(NotificationState.loaded(notifications)),
    );
  }
}
