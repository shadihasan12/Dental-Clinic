import 'dart:async';
import 'dart:io';

import 'package:dental_clinic_app/core/services/notifications/push_payload.dart';
import 'package:dental_clinic_app/core/storage/token_storage.dart';
import 'package:dental_clinic_app/features/home/domain/entities/notification_entity.dart';
import 'package:dental_clinic_app/features/home/domain/use_cases/register_fcm_token_use_case.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Color;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';

/// Single source of truth for everything FCM-shaped in the app.
///
/// Lifecycle (called once from `main.dart` after Firebase.initializeApp):
///
///   1. [initialize] — asks the OS for notification permission, wires the
///      local-notifications plugin, registers FCM listeners.
///   2. The service then quietly listens for token refreshes and forwards any
///      foreground push to the in-app stream so an active NotificationBloc can
///      react without an extra network round-trip.
///   3. Taps on push notifications (foreground, background, or terminated)
///      surface through [onNotificationTap] so the app's router can navigate.
///
/// The service is auth-state-agnostic: it grabs a token whenever Firebase has
/// one and tries to POST it. If the request fails (no auth token yet, offline,
/// etc.) the local store is left "unsynced" and [syncTokenIfNeeded] retries on
/// the next opportunity — typically right after sign-in.
@lazySingleton
class NotificationService {
  NotificationService({
    required FirebaseMessaging messaging,
    required FlutterLocalNotificationsPlugin localNotifications,
    required RegisterFcmTokenUseCase registerFcmToken,
    required TokenStorage tokenStorage,
  })  : _messaging = messaging,
        _localNotifications = localNotifications,
        _registerFcmToken = registerFcmToken,
        _tokenStorage = tokenStorage;

  final FirebaseMessaging _messaging;
  final FlutterLocalNotificationsPlugin _localNotifications;
  final RegisterFcmTokenUseCase _registerFcmToken;
  final TokenStorage _tokenStorage;

  // Android needs an explicit channel created up front; sending to a missing
  // channel on API 26+ silently drops the notification. Keep this ID in sync
  // with the AndroidManifest meta-data (com.google.firebase.messaging.default_
  // notification_channel_id) so server-sent FCM "notification" messages land
  // in the right channel too.
  static const String _androidChannelId = 'dental_clinic_default';
  static const String _androidChannelName = 'General notifications';
  static const String _androidChannelDescription =
      'Appointments, payments, patient updates, and other clinic alerts.';

  /// Topic every install subscribes to so the backend can fan out global
  /// announcements without enumerating device tokens.
  ///
  /// Agreed contract with the backend - it publishes global notifications to
  /// this exact topic name. Changing it here breaks global pushes unless the
  /// backend is changed in lockstep.
  static const String globalTopic = 'all_en';

  /// Whether FCM exists on this platform at all.
  ///
  /// firebase_messaging ships implementations for android/ios/macos/web only -
  /// there is no Windows or Linux plugin, so every FCM call there throws
  /// MissingPluginException. Desktop builds skip the subsystem entirely and
  /// get their notifications over a different transport.
  static bool get supportsPush => Platform.isAndroid || Platform.isIOS;

  final _onPushReceivedController = StreamController<PushPayload>.broadcast();
  final _onNotificationTapController = StreamController<PushPayload>.broadcast();

  /// Foreground pushes — emitted right before we show the local banner.
  Stream<PushPayload> get onPushReceived => _onPushReceivedController.stream;

  /// User taps from foreground/background/terminated states.
  /// The router subscribes to this and navigates to the deep link.
  Stream<PushPayload> get onNotificationTap => _onNotificationTapController.stream;

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
    if (!supportsPush) return;
    _initialized = true;

    await _requestPermission();
    await _setupLocalNotifications();
    await _setupAndroidChannel();
    await _wireFcmListeners();
    await _bootstrapInitialToken();
    await subscribeToGlobalTopics();
    await _handleInitialMessage();
  }

  Future<void> _requestPermission() async {
    // On iOS this triggers the OS prompt. On Android 13+ (API 33) the same
    // call requests POST_NOTIFICATIONS via the plugin shim. On older Android
    // it's a no-op that resolves to authorized.
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    if (kDebugMode) {
      debugPrint('[FCM] permission=${settings.authorizationStatus}');
    }
  }

  Future<void> _setupLocalNotifications() async {
    // Default small icon for any notification that does not name one. Must be
    // the silhouette, not the launcher icon - Android masks small icons to
    // their alpha channel.
    const android =
        AndroidInitializationSettings('@drawable/ic_stat_notification');
    const darwin = DarwinInitializationSettings(
      // We already requested via FirebaseMessaging; don't double-prompt.
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    await _localNotifications.initialize(
      settings: const InitializationSettings(android: android, iOS: darwin),
      onDidReceiveNotificationResponse: _onLocalNotificationTapped,
    );
  }

  Future<void> _setupAndroidChannel() async {
    if (!Platform.isAndroid) return;
    const channel = AndroidNotificationChannel(
      _androidChannelId,
      _androidChannelName,
      description: _androidChannelDescription,
      importance: Importance.high,
    );
    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<void> _wireFcmListeners() async {
    FirebaseMessaging.onMessage.listen(_onForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedFromBackground);
    _messaging.onTokenRefresh.listen(_onTokenRefreshed);
  }

  Future<void> _bootstrapInitialToken() async {
    // iOS needs the APNs token before FCM will hand out a registration token.
    // FirebaseMessaging waits for it internally; we just call getToken.
    try {
      final token = await _messaging.getToken();
      if (token != null) {
        await _onTokenRefreshed(token);
      }
    } catch (e, st) {
      if (kDebugMode) {
        debugPrint('[FCM] getToken failed: $e\n$st');
      }
    }
  }

  Future<void> _handleInitialMessage() async {
    // Cold-start path: user tapped a push from a fully-terminated state.
    final initial = await _messaging.getInitialMessage();
    if (initial != null) {
      _onNotificationTapController.add(PushPayload.fromRemoteMessage(initial));
    }
  }

  // ── FCM event handlers ────────────────────────────────────────────────

  Future<void> _onForegroundMessage(RemoteMessage message) async {
    final payload = PushPayload.fromRemoteMessage(message);
    _onPushReceivedController.add(payload);
    await _showLocalNotification(message, payload);
  }

  void _onMessageOpenedFromBackground(RemoteMessage message) {
    _onNotificationTapController.add(PushPayload.fromRemoteMessage(message));
  }

  Future<void> _onTokenRefreshed(String token) async {
    if (kDebugMode) {
      debugPrint('[FCM] token: $token');
    }
    await _tokenStorage.saveFcmToken(token);
    await _syncToken(token);
  }

  void _onLocalNotificationTapped(NotificationResponse response) {
    // The local notification was scheduled with the deep-link string in
    // `payload`. We don't reconstruct the original RemoteMessage here — the
    // router only needs to know where to go.
    final deepLink = response.payload ?? '/notifications';
    _onNotificationTapController.add(
      PushPayload(
        id: null,
        title: null,
        body: null,
        type: NotificationType.appointment,
        deepLink: deepLink,
        receivedAt: DateTime.now(),
        raw: const {},
      ),
    );
  }

  // ── Public API ────────────────────────────────────────────────────────

  /// Call this right after the user signs in. If we already have a token but
  /// failed to sync (e.g. user wasn't authenticated yet at cold start), this
  /// retries the POST. Cheap when already synced — early-exits on the marker.
  Future<void> syncTokenIfNeeded() async {
    if (!supportsPush) return;
    // The endpoint is authenticated - nothing to do until we have a session.
    if (!_tokenStorage.hasToken()) return;

    final token = _tokenStorage.getFcmToken();
    if (token == null) {
      // No token cached yet (fresh install, or cleared on the last logout).
      // Ask Firebase for one and persist it on the way through.
      try {
        final fresh = await _messaging.getToken();
        if (fresh != null) await _onTokenRefreshed(fresh);
      } catch (e) {
        if (kDebugMode) debugPrint('[FCM] getToken during sync failed: $e');
      }
      return;
    }
    if (_tokenStorage.isFcmTokenSynced(token)) return;
    await _syncToken(token);
  }

  /// Subscribes this install to the broadcast topic(s) the backend uses for
  /// global announcements. Topic subscriptions are stored by FCM itself, so
  /// this is idempotent and needs no auth token.
  Future<void> subscribeToGlobalTopics() async {
    if (!supportsPush) return;
    try {
      await _messaging.subscribeToTopic(globalTopic);
      if (kDebugMode) debugPrint('[FCM] subscribed to topic "$globalTopic"');
    } catch (e) {
      if (kDebugMode) debugPrint('[FCM] topic subscribe failed: $e');
    }
  }

  Future<void> unsubscribeFromGlobalTopics() async {
    if (!supportsPush) return;
    try {
      await _messaging.unsubscribeFromTopic(globalTopic);
    } catch (e) {
      if (kDebugMode) debugPrint('[FCM] topic unsubscribe failed: $e');
    }
  }

  /// Call from the logout flow. Nothing here is authenticated, so it can run
  /// before or after the auth token is cleared.
  ///
  /// Deleting the FCM token is what actually stops pushes for the signed-out
  /// user: the backend maps token -> user and there is no DELETE endpoint to
  /// unregister with. Firebase mints a fresh token on the next getToken(),
  /// which the next sign-in registers against the new user.
  Future<void> onLogout() async {
    await unsubscribeFromGlobalTopics();
    await deleteToken();
  }

  /// Wipes the FCM token from this device, so a subsequent user sign-in on the
  /// same device starts fresh.
  Future<void> deleteToken() async {
    try {
      await _messaging.deleteToken();
    } catch (_) {/* ignore - best-effort */}
    // Drop our cached copy too, otherwise the next syncTokenIfNeeded would
    // happily re-POST the token we just invalidated.
    await _tokenStorage.clearFcmToken();
  }

  // ── internals ─────────────────────────────────────────────────────────

  Future<void> _syncToken(String token) async {
    // /auth/device-token requires the Authorization header. POSTing before
    // sign-in just yields a 401 (and makes the auth interceptor burn a refresh
    // attempt). Leave the token marked unsynced - the post-login call to
    // syncTokenIfNeeded picks it up.
    if (!_tokenStorage.hasToken()) {
      if (kDebugMode) {
        debugPrint('[FCM] not signed in yet - deferring device-token sync');
      }
      return;
    }

    final result = await _registerFcmToken(token);
    result.fold(
      (err) {
        if (kDebugMode) debugPrint('[FCM] token sync failed: $err');
      },
      (_) => _tokenStorage.setFcmTokenSynced(token),
    );
  }

  Future<void> _showLocalNotification(
    RemoteMessage message,
    PushPayload payload,
  ) async {
    // If the FCM message carries a `notification` block, Android already shows
    // it when the app is backgrounded — but in the foreground we MUST show it
    // ourselves; FCM does not auto-display in the foreground on any platform.
    final notification = message.notification;
    if (notification == null && payload.title == null && payload.body == null) {
      // data-only push — nothing user-visible to show.
      return;
    }

    await _localNotifications.show(
      id: _notificationIdFrom(payload),
      title: payload.title,
      body: payload.body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          _androidChannelId,
          _androidChannelName,
          channelDescription: _androidChannelDescription,
          importance: Importance.high,
          priority: Priority.high,
          // White-on-transparent silhouette. Android masks the small icon to
          // its alpha channel, so the full-colour launcher icon rendered as a
          // featureless blob in the status bar.
          icon: '@drawable/ic_stat_notification',
          // Matches the manifest's default_notification_color so foreground
          // banners look identical to server-sent ones.
          color: const Color(0xFF199ED9),
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: payload.deepLink,
    );
  }

  /// Stable-ish 32-bit id for the local notification. Using the FCM message
  /// id (or our payload id) hashed lets a follow-up "same notification"
  /// update overwrite the existing banner instead of stacking.
  int _notificationIdFrom(PushPayload payload) {
    final key = payload.id ?? payload.raw.toString();
    return key.hashCode & 0x7fffffff;
  }

  Future<void> dispose() async {
    await _onPushReceivedController.close();
    await _onNotificationTapController.close();
  }
}
