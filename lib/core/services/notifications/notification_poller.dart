import 'dart:async';

import 'package:dental_clinic_app/core/services/notifications/notification_service.dart';
import 'package:dental_clinic_app/core/storage/token_storage.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/home/domain/entities/notification_entity.dart';
import 'package:dental_clinic_app/features/home/domain/use_cases/get_unseen_notifications_use_case.dart';
import 'package:dental_clinic_app/features/home/domain/use_cases/mark_notifications_seen_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

/// Windows-only delivery path.
///
/// Firebase Cloud Messaging has no Windows implementation, so there is no push
/// channel to the desktop app at all. Windows asks the server on a timer and
/// raises its own banner for anything that has never been announced.
///
/// **Every other platform receives a real push and must not run this.** A poll
/// on Android/iOS/Web would raise a second banner for a notification Firebase
/// has already delivered. [start] enforces that itself, so callers can invoke
/// it unconditionally.
///
/// The loop is:
///
///   GET  /notifications/unseen   -> what has never been announced
///        ...raise a banner for each...
///   POST /notifications/seen     -> acknowledge the ones actually shown
///        ...wait meta.poll_after seconds...
@lazySingleton
class NotificationPoller {
  NotificationPoller({
    required GetUnseenNotificationsUseCase getUnseen,
    required MarkNotificationsSeenUseCase markSeen,
    required NotificationService notificationService,
    required TokenStorage tokenStorage,
  })  : _getUnseen = getUnseen,
        _markSeen = markSeen,
        _notificationService = notificationService,
        _tokenStorage = tokenStorage;

  final GetUnseenNotificationsUseCase _getUnseen;
  final MarkNotificationsSeenUseCase _markSeen;
  final NotificationService _notificationService;
  final TokenStorage _tokenStorage;

  /// Only used when the server's `poll_after` is missing or unusable — the
  /// server owns the interval so it can be raised under load without shipping
  /// a new build.
  static const Duration _fallbackInterval = Duration(seconds: 30);

  /// After a failed request. Long enough not to hammer a server that is down,
  /// short enough that a passing blip doesn't stall delivery for minutes.
  static const Duration _errorBackoff = Duration(seconds: 60);

  Timer? _timer;
  bool _running = false;
  bool _polling = false;

  /// Localised copy for the "N more notifications" summary banner. Set by the
  /// app once localisations are available; falls back to English otherwise,
  /// since the poller has no BuildContext of its own.
  String Function(int remaining)? summaryBodyBuilder;
  String? summaryTitle;

  bool get isRunning => _running;

  /// Starts the loop. No-op on every platform that receives real pushes, and
  /// no-op while signed out — `/unseen` is authenticated.
  void start() {
    if (!NotificationService.usesPolling) return;
    if (_running) return;
    if (!_tokenStorage.hasToken()) return;

    _running = true;
    if (kDebugMode) debugPrint('[poller] started');
    // Poll immediately: anything that arrived while the app was closed should
    // surface at launch, not one interval later.
    unawaited(_poll());
  }

  /// Stops the loop and drops any pending timer. Called on logout.
  void stop() {
    if (!_running) return;
    _running = false;
    _timer?.cancel();
    _timer = null;
    if (kDebugMode) debugPrint('[poller] stopped');
  }

  Future<void> _poll() async {
    if (!_running) return;
    // A timer could fire while a slow request is still in flight; one poll at
    // a time keeps us from announcing the same rows twice.
    if (_polling) return;
    _polling = true;

    var nextDelay = _fallbackInterval;
    try {
      // Signing out between two ticks: stop rather than 401 in a loop.
      if (!_tokenStorage.hasToken()) {
        stop();
        return;
      }

      final result = await _getUnseen(NoParams());

      await result.fold(
        (error) async {
          if (kDebugMode) debugPrint('[poller] unseen failed: $error');
          nextDelay = _errorBackoff;
        },
        (unseen) async {
          nextDelay = Duration(
            seconds: unseen.pollAfter > 0
                ? unseen.pollAfter
                : _fallbackInterval.inSeconds,
          );
          await _announce(unseen);
        },
      );
    } catch (e) {
      if (kDebugMode) debugPrint('[poller] poll threw: $e');
      nextDelay = _errorBackoff;
    } finally {
      _polling = false;
      _scheduleNext(nextDelay);
    }
  }

  Future<void> _announce(UnseenNotificationsEntity unseen) async {
    if (unseen.notifications.isEmpty && unseen.remaining == 0) return;

    // Show first, acknowledge second. If we acknowledged first and the app
    // then died, those notifications would be marked announced and never
    // shown again. Showing one twice is recoverable; losing it is not.
    final shown = <String>[];
    for (final notification in unseen.notifications) {
      try {
        await _notificationService.showNotification(notification);
        shown.add(notification.id);
      } catch (e) {
        // Leave it unacknowledged so the next poll retries it.
        if (kDebugMode) debugPrint('[poller] show failed: $e');
      }
    }

    // The endpoint caps each response at 10; `remaining` is how many it held
    // back. One summary banner, not that many banners.
    if (unseen.remaining > 0) {
      await _notificationService.showSummaryNotification(
        title: summaryTitle ?? 'New notifications',
        body: summaryBodyBuilder?.call(unseen.remaining) ??
            '${unseen.remaining} more notifications',
      );
    }

    if (shown.isEmpty) return;
    final seenResult = await _markSeen(shown);
    seenResult.fold(
      (error) {
        // Not fatal: the rows stay unseen and get re-announced next poll.
        if (kDebugMode) debugPrint('[poller] seen failed: $error');
      },
      (marked) {
        if (kDebugMode) debugPrint('[poller] marked $marked seen');
      },
    );
  }

  void _scheduleNext(Duration delay) {
    if (!_running) return;
    _timer?.cancel();
    _timer = Timer(delay, _poll);
  }

  void dispose() => stop();
}
