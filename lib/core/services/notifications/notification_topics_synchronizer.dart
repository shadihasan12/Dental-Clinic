import 'package:dental_clinic_app/core/services/notifications/notification_service.dart';
import 'package:dental_clinic_app/core/storage/token_storage.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/domain/entities/notification_settings_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/domain/use_cases/get_notification_settings_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

/// Keeps this install's Firebase topic subscriptions in step with the server.
///
/// The rule the whole system hangs on: **every topic the app subscribes to
/// comes from the server.** The only source of topic names is the `audience`
/// field of `GET /notification-settings` — never a constant in the app, never
/// string concatenation. A client-built name drifts out of step the moment the
/// server renames one, and the resulting subscription receives nothing,
/// forever, with nothing to notice it by.
///
/// Call [sync]:
///   * on every launch of an authenticated session (`subscribeToTopic` is
///     idempotent, and re-asserting repairs a subscription that failed
///     silently earlier),
///   * right after sign-in,
///   * after a language change — the audience for the same category becomes a
///     different string (`announcement_ar` -> `announcement_en`), and
///     [NotificationService.syncTopics] unsubscribes the one that dropped off.
///
/// Windows subscribes to nothing: topics are a push concept and it polls.
@lazySingleton
class NotificationTopicsSynchronizer {
  NotificationTopicsSynchronizer({
    required GetNotificationSettingsUseCase getSettings,
    required NotificationService notificationService,
    required TokenStorage tokenStorage,
  })  : _getSettings = getSettings,
        _notificationService = notificationService,
        _tokenStorage = tokenStorage;

  final GetNotificationSettingsUseCase _getSettings;
  final NotificationService _notificationService;
  final TokenStorage _tokenStorage;

  /// Fetches the settings and applies whatever topics they name.
  ///
  /// Deliberately quiet: a failure here must never surface to the user or
  /// block whatever triggered it. The next launch re-asserts.
  Future<void> sync() async {
    if (!NotificationService.supportsPush) return;
    // The settings endpoint is authenticated.
    if (!_tokenStorage.hasToken()) return;

    final result = await _getSettings(NoParams());
    await result.fold(
      (error) async {
        if (kDebugMode) {
          debugPrint('[topics] settings fetch failed, keeping current: $error');
        }
      },
      (settings) => applyFrom(settings),
    );
  }

  /// Applies topics from settings the caller already has in hand — the
  /// settings screen calls this after a toggle instead of re-fetching.
  Future<void> applyFrom(List<NotificationSettingEntity> settings) {
    return _notificationService.syncTopics(
      settings
          .where((s) => s.isBroadcast)
          .map((s) => TopicSubscription(name: s.audience!, enabled: s.enabled))
          .toList(),
    );
  }
}
