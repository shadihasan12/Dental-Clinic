import 'dart:async';

import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/services/notifications/notification_service.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/home/domain/entities/notification_entity.dart';
import 'package:dental_clinic_app/features/home/domain/use_cases/get_notifications_use_case.dart';
import 'package:dental_clinic_app/features/home/domain/use_cases/mark_all_notifications_as_read_use_case.dart';
import 'package:dental_clinic_app/features/home/domain/use_cases/mark_notification_as_read_use_case.dart';
import 'package:dental_clinic_app/features/home/domain/use_cases/mark_notification_as_unread_use_case.dart';
import 'package:dental_clinic_app/features/home/presentation/manager/unread_count_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'notification_bloc.freezed.dart';
part 'notification_event.dart';
part 'notification_state.dart';

@injectable
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotificationsUseCase _getNotifications;
  final MarkNotificationAsReadUseCase _markAsRead;
  final MarkNotificationAsUnreadUseCase _markAsUnread;
  final MarkAllNotificationsAsReadUseCase _markAllAsRead;
  final NotificationService _notificationService;
  final UnreadCountCubit _unreadCount;

  StreamSubscription<NotificationEntity>? _arrivalSubscription;

  /// Server caps `limit` at 100; 30 is its own default and a comfortable
  /// screenful on every form factor.
  static const int _pageSize = 30;

  NotificationBloc({
    required GetNotificationsUseCase getNotifications,
    required MarkNotificationAsReadUseCase markAsRead,
    required MarkNotificationAsUnreadUseCase markAsUnread,
    required MarkAllNotificationsAsReadUseCase markAllAsRead,
    required NotificationService notificationService,
    required UnreadCountCubit unreadCount,
  })  : _getNotifications = getNotifications,
        _markAsRead = markAsRead,
        _markAsUnread = markAsUnread,
        _markAllAsRead = markAllAsRead,
        _notificationService = notificationService,
        _unreadCount = unreadCount,
        super(const NotificationState()) {
    on<_Load>(_onLoad);
    on<_Refresh>(_onRefresh);
    on<_LoadMore>(_onLoadMore);
    on<_MarkAsRead>(_onMarkAsRead);
    on<_MarkAsUnread>(_onMarkAsUnread);
    on<_MarkAllAsRead>(_onMarkAllAsRead);
    on<_PushReceived>(_onPushReceived);

    // Forward arrivals into the bloc's event stream so the screen updates live
    // while it is mounted. Deliberately the delivery-agnostic stream, not
    // onPushReceived: on Windows there is no push, and a polled row has to
    // land in an open list exactly the way a push does on mobile.
    _arrivalSubscription = _notificationService.onNotificationReceived.listen(
      (notification) => add(NotificationEvent.pushReceived(notification)),
    );
  }

  @override
  Future<void> close() async {
    await _arrivalSubscription?.cancel();
    return super.close();
  }

  Future<void> _onLoad(_Load event, Emitter<NotificationState> emit) async {
    emit(state.copyWith(status: NotificationStatus.loading, errorMessage: null));
    await _fetchFirstPage(emit);
  }

  Future<void> _onRefresh(
    _Refresh event,
    Emitter<NotificationState> emit,
  ) async {
    // No loading state: pull-to-refresh already has its own spinner, and
    // blanking the list under the user's finger looks broken.
    await _fetchFirstPage(emit);
  }

  Future<void> _fetchFirstPage(Emitter<NotificationState> emit) async {
    final result = await _getNotifications(
      const GetNotificationsParams(limit: _pageSize),
    );

    result.fold(
      (error) {
        final message = NetworkExceptions.getErrorMessage(error);
        // A failed pull-to-refresh should leave the rows the user is looking
        // at alone; only an empty screen has room for the error state.
        emit(state.copyWith(
          status: state.notifications.isEmpty
              ? NotificationStatus.failure
              : state.status,
          errorMessage: message,
        ));
      },
      (page) {
        _unreadCount.set(page.unreadCount);
        emit(state.copyWith(
          status: NotificationStatus.success,
          notifications: page.notifications,
          nextCursor: page.nextCursor,
          unreadCount: page.unreadCount,
          errorMessage: null,
        ));
      },
    );
  }

  Future<void> _onLoadMore(
    _LoadMore event,
    Emitter<NotificationState> emit,
  ) async {
    // `nextCursor == null` means the server has no more pages — not an error.
    if (state.nextCursor == null || state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));

    final result = await _getNotifications(
      GetNotificationsParams(limit: _pageSize, before: state.nextCursor),
    );

    result.fold(
      // Keep the rows already on screen; the user can scroll to retry.
      (_) => emit(state.copyWith(isLoadingMore: false)),
      (page) {
        _unreadCount.set(page.unreadCount);
        // Cursor paging is stable, but a push may already have prepended a row
        // the server also returns — drop any id we are holding.
        final existing = state.notifications.map((n) => n.id).toSet();
        emit(state.copyWith(
          isLoadingMore: false,
          notifications: [
            ...state.notifications,
            ...page.notifications.where((n) => !existing.contains(n.id)),
          ],
          nextCursor: page.nextCursor,
          unreadCount: page.unreadCount,
        ));
      },
    );
  }

  Future<void> _onMarkAsRead(
    _MarkAsRead event,
    Emitter<NotificationState> emit,
  ) async {
    final target = _find(event.id);
    if (target == null || target.isRead) return;

    // Optimistic — the row should stop looking unread the instant it's tapped.
    emit(state.copyWith(
      notifications: _replace(event.id, (n) => n.copyWith(
            isRead: true,
            isSeen: true,
            readAt: DateTime.now(),
          )),
    ));

    final result = await _markAsRead(event.id);
    result.fold(
      // Roll back so the dot doesn't lie about server state.
      (_) => emit(state.copyWith(
        notifications: _replace(
          event.id,
          (n) => n.copyWith(isRead: false, readAt: null),
        ),
      )),
      (count) => _applyUnreadCount(emit, count),
    );
  }

  Future<void> _onMarkAsUnread(
    _MarkAsUnread event,
    Emitter<NotificationState> emit,
  ) async {
    final target = _find(event.id);
    if (target == null || !target.isRead) return;

    // The row stays seen — it was already announced once and must not be
    // announced again.
    emit(state.copyWith(
      notifications: _replace(
        event.id,
        (n) => n.copyWith(isRead: false, readAt: null),
      ),
    ));

    final result = await _markAsUnread(event.id);
    result.fold(
      (_) => emit(state.copyWith(
        notifications: _replace(
          event.id,
          (n) => n.copyWith(isRead: true, readAt: target.readAt),
        ),
      )),
      (count) => _applyUnreadCount(emit, count),
    );
  }

  Future<void> _onMarkAllAsRead(
    _MarkAllAsRead event,
    Emitter<NotificationState> emit,
  ) async {
    final previous = state.notifications;
    final previousCount = state.unreadCount;
    final now = DateTime.now();

    emit(state.copyWith(
      notifications: previous
          .map((n) => n.isRead
              ? n
              : n.copyWith(isRead: true, isSeen: true, readAt: now))
          .toList(),
      unreadCount: 0,
    ));
    _unreadCount.set(0);

    final result = await _markAllAsRead(NoParams());
    result.fold(
      (_) {
        emit(state.copyWith(
          notifications: previous,
          unreadCount: previousCount,
        ));
        _unreadCount.set(previousCount);
      },
      (count) => _applyUnreadCount(emit, count),
    );
  }

  void _onPushReceived(_PushReceived event, Emitter<NotificationState> emit) {
    // The server row is authoritative: if we already hold this id, leave it
    // alone rather than clobber fields the push payload doesn't carry.
    if (state.notifications.any((n) => n.id == event.notification.id)) return;

    // The badge is not touched here: UnreadCountCubit subscribes to the same
    // push stream and increments itself, so doing it from both would
    // double-count.
    emit(state.copyWith(
      notifications: [event.notification, ...state.notifications],
      unreadCount: state.unreadCount + 1,
    ));
  }

  // ── helpers ───────────────────────────────────────────────────────────

  /// Every read/unread/read-all response carries the fresh `unread_count`, so
  /// the badge never needs a follow-up request.
  void _applyUnreadCount(Emitter<NotificationState> emit, int count) {
    _unreadCount.set(count);
    emit(state.copyWith(unreadCount: count));
  }

  NotificationEntity? _find(String id) {
    for (final n in state.notifications) {
      if (n.id == id) return n;
    }
    return null;
  }

  List<NotificationEntity> _replace(
    String id,
    NotificationEntity Function(NotificationEntity) update,
  ) {
    return state.notifications
        .map((n) => n.id == id ? update(n) : n)
        .toList();
  }
}
