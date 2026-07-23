import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/services/notifications/notification_service.dart';
import 'package:dental_clinic_app/core/services/notifications/push_payload.dart';
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
  final NotificationService _notificationService;

  StreamSubscription<PushPayload>? _pushSubscription;

  NotificationBloc({
    required GetAllNotificationsUseCase getAllNotifications,
    required MarkNotificationAsReadUseCase markNotificationAsRead,
    required MarkAllNotificationsAsReadUseCase markAllNotificationsAsRead,
    required NotificationService notificationService,
  })  : _getAllNotifications = getAllNotifications,
        _markNotificationAsRead = markNotificationAsRead,
        _markAllNotificationsAsRead = markAllNotificationsAsRead,
        _notificationService = notificationService,
        super(const NotificationState.initial()) {
    on<_LoadNotifications>(_onLoadNotifications);
    on<_MarkAsRead>(_onMarkAsRead);
    on<_MarkAllAsRead>(_onMarkAllAsRead);
    on<_PushReceived>(_onPushReceived);

    // Forward foreground pushes into the bloc's event stream so the screen
    // updates live while the bloc is mounted.
    _pushSubscription = _notificationService.onPushReceived.listen(
      (payload) => add(NotificationEvent.pushReceived(payload.toEntity())),
    );
  }

  @override
  Future<void> close() async {
    await _pushSubscription?.cancel();
    return super.close();
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

  void _onPushReceived(
    _PushReceived event,
    Emitter<NotificationState> emit,
  ) {
    // If we're not yet loaded (page just opened, request still in flight),
    // skip — the upcoming load will include this notification from the server.
    final currentState = state;
    if (currentState is! _Loaded) return;

    // Server-authoritative: if a notification with the same id already exists,
    // prefer the existing one so we don't clobber server-side fields the push
    // payload doesn't carry. Otherwise prepend.
    final exists = currentState.notifications.any(
      (n) => n.id == event.notification.id,
    );
    if (exists) return;
    emit(NotificationState.loaded([event.notification, ...currentState.notifications]));
  }
}
