import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dental_clinic_app/core/services/notifications/push_payload.dart';
import 'package:dental_clinic_app/core/storage/token_storage.dart';
import 'package:dental_clinic_app/features/home/domain/entities/notification_entity.dart';
import 'package:dental_clinic_app/features/home/domain/use_cases/logout_device_use_case.dart';
import 'package:dental_clinic_app/features/home/domain/use_cases/register_fcm_token_use_case.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Color;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';

/// One broadcast topic the server told us about.
///
/// [name] is always a string the server handed back in the `audience` field of
/// `GET /notification-settings`. The app never builds a topic name — a
/// client-side name drifts out of step the moment the server renames one, and
/// a topic the server never publishes to receives nothing, forever.
class TopicSubscription {
  final String name;

  /// Subscribe only while the owning category is enabled.
  final bool enabled;

  const TopicSubscription({required this.name, required this.enabled});
}

/// Single source of truth for everything FCM-shaped in the app.
///
/// Lifecycle (called once from `main.dart` after Firebase.initializeApp):
///
///   1. [initialize] — wires the local-notifications plugin on every platform,
///      then (only where FCM exists) asks the OS for notification permission
///      and registers the FCM listeners.
///   2. The service quietly listens for token refreshes and forwards any
///      foreground push to the in-app stream so an active NotificationBloc can
///      react without an extra network round-trip.
///   3. Taps on notifications (foreground, background, or terminated) surface
///      through [onNotificationTap] so the app's router can navigate.
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
    required LogoutDeviceUseCase logoutDevice,
    required TokenStorage tokenStorage,
  })  : _messaging = messaging,
        _localNotifications = localNotifications,
        _registerFcmToken = registerFcmToken,
        _logoutDevice = logoutDevice,
        _tokenStorage = tokenStorage;

  final FirebaseMessaging _messaging;
  final FlutterLocalNotificationsPlugin _localNotifications;
  final RegisterFcmTokenUseCase _registerFcmToken;
  final LogoutDeviceUseCase _logoutDevice;
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

  /// Whether FCM exists on this platform at all.
  ///
  /// firebase_messaging ships implementations for android/ios/macos/web only -
  /// there is no Windows or Linux plugin, so every FCM call there throws
  /// MissingPluginException. Desktop builds skip the subsystem entirely and
  /// get their notifications by polling instead (see NotificationPoller).
  static bool get supportsPush =>
      kIsWeb || Platform.isAndroid || Platform.isIOS;

  /// Windows has no push channel at all, so it is the one platform that polls.
  /// Every other platform receives a real push and must NOT poll, or each
  /// notification raises a second banner on top of the one FCM delivered.
  static bool get usesPolling => !kIsWeb && Platform.isWindows;

  final _onPushReceivedController = StreamController<PushPayload>.broadcast();
  final _onNotificationReceivedController =
      StreamController<NotificationEntity>.broadcast();
  final _onNotificationTapController =
      StreamController<Map<String, dynamic>>.broadcast();

  /// Foreground **pushes**. FCM platforms only — nothing arrives here on
  /// Windows, which has no push channel. Use [onNotificationReceived] for
  /// anything that has to work on every platform.
  Stream<PushPayload> get onPushReceived => _onPushReceivedController.stream;

  /// A notification just arrived and was announced to the user, however it got
  /// here: an FCM push on mobile, or a polled `/unseen` row on Windows.
  ///
  /// This is the stream an open inbox listens to, because it is the only one
  /// that fires on both delivery paths.
  Stream<NotificationEntity> get onNotificationReceived =>
      _onNotificationReceivedController.stream;

  /// User taps from foreground/background/terminated states, carrying the
  /// notification's `data` map. The router subscribes to this and navigates
  /// via `NotificationRouting`.
  Stream<Map<String, dynamic>> get onNotificationTap =>
      _onNotificationTapController.stream;

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;

    // Local notifications work everywhere, including Windows — the poller
    // needs them there, so this must not sit behind the FCM check.
    await _setupLocalNotifications();
    await _setupAndroidChannel();

    if (!supportsPush) {
      // No FCM here, so getInitialMessage() will never fire. A toast the user
      // clicked while the app was closed reaches us through the local
      // plugin's launch details instead - without this, a cold-start tap on
      // Windows opens the app and then goes nowhere.
      await _handleNotificationLaunch();
      return;
    }

    await _requestPermission();
    await _wireFcmListeners();
    await _bootstrapInitialToken();
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
    // Windows toasts are addressed by an AppUserModelID; the GUID identifies
    // the COM activation callback that delivers taps back to us.
    final windows = WindowsInitializationSettings(
      appName: 'Denta',
      appUserModelId: 'Skew.Denta.DentalClinic',
      guid: '9a3f1f6c-6b2e-4f0e-9c1b-2f7a7d3c6f21',
      // Names the app in the toast's header row. Without it Windows falls back
      // to a generic placeholder and the banner reads as coming from nowhere.
      iconPath: _windowsAssetPath(_appIconAsset),
    );
    await _localNotifications.initialize(
      settings: InitializationSettings(
        android: android,
        iOS: darwin,
        windows: windows,
      ),
      onDidReceiveNotificationResponse: _onLocalNotificationTapped,
    );
  }

  Future<void> _setupAndroidChannel() async {
    if (kIsWeb || !Platform.isAndroid) return;
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
    // Tokens rotate after an app update, a data wipe, or a restore. Without
    // this listener push silently stops weeks later and the server never
    // learns why.
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
        debugPrint('[FCM] getToken failed: $e / $st');
      }
    }
  }

  Future<void> _handleNotificationLaunch() async {
    try {
      final launch = await _localNotifications.getNotificationAppLaunchDetails();
      if (launch?.didNotificationLaunchApp ?? false) {
        _onNotificationTapController
            .add(_decodePayload(launch!.notificationResponse?.payload));
      }
    } catch (e) {
      if (kDebugMode) debugPrint('[notifications] launch details failed: $e');
    }
  }

  Future<void> _handleInitialMessage() async {
    // Cold-start path: user tapped a push from a fully-terminated state.
    final initial = await _messaging.getInitialMessage();
    if (initial != null) {
      _onNotificationTapController
          .add(PushPayload.fromRemoteMessage(initial).data);
    }
  }

  // ── FCM event handlers ────────────────────────────────────────────────

  Future<void> _onForegroundMessage(RemoteMessage message) async {
    final payload = PushPayload.fromRemoteMessage(message);
    _onPushReceivedController.add(payload);
    _onNotificationReceivedController.add(payload.toEntity());
    await _showLocalNotification(
      id: _stableId(payload.id ?? payload.data.toString()),
      title: payload.title,
      body: payload.body,
      data: payload.data,
    );
  }

  void _onMessageOpenedFromBackground(RemoteMessage message) {
    _onNotificationTapController
        .add(PushPayload.fromRemoteMessage(message).data);
  }

  Future<void> _onTokenRefreshed(String token) async {
    if (kDebugMode) {
      debugPrint('[FCM] token: $token');
    }
    await _tokenStorage.saveFcmToken(token);
    await _syncToken(token);
  }

  void _onLocalNotificationTapped(NotificationResponse response) {
    // The banner was scheduled with the notification's `data` map encoded as
    // JSON, so the router gets the same payload a real push tap would carry.
    _onNotificationTapController.add(_decodePayload(response.payload));
  }

  Map<String, dynamic> _decodePayload(String? payload) {
    if (payload == null || payload.isEmpty) return const {};
    try {
      final decoded = jsonDecode(payload);
      return decoded is Map ? Map<String, dynamic>.from(decoded) : const {};
    } catch (_) {
      return const {};
    }
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

  /// Brings this install's topic subscriptions in line with what the server
  /// just told us, and forgets any topic that is no longer named.
  ///
  /// [topics] must come straight from the `audience` fields of
  /// `GET /notification-settings`. Re-running it on every launch is deliberate:
  /// `subscribeToTopic` is idempotent, and re-asserting repairs a subscription
  /// that failed silently earlier.
  ///
  /// A name that has dropped off the list — which is what a language change
  /// looks like, `announcement_ar` giving way to `announcement_en` — is
  /// unsubscribed, so a stale subscription can't linger receiving nothing.
  ///
  /// Windows subscribes to nothing: topics are a push concept and it polls.
  Future<void> syncTopics(List<TopicSubscription> topics) async {
    if (!supportsPush) return;

    final wanted = topics.where((t) => t.enabled).map((t) => t.name).toSet();
    final named = topics.map((t) => t.name).toSet();
    final remembered = _tokenStorage.getSubscribedTopics().toSet();

    // Anything we hold a subscription for that the server no longer wants:
    // either explicitly disabled now, or gone from the response entirely
    // (which is what a language change looks like). Plus disabled-but-named
    // topics we never recorded, e.g. the toggle was flipped on another device.
    final toUnsubscribe = {
      ...remembered.difference(wanted),
      ...named.difference(wanted),
    };

    for (final topic in toUnsubscribe) {
      try {
        await _messaging.unsubscribeFromTopic(topic);
        if (kDebugMode) debugPrint('[FCM] unsubscribed from "$topic"');
      } catch (e) {
        if (kDebugMode) debugPrint('[FCM] unsubscribe "$topic" failed: $e');
      }
    }

    final confirmed = <String>{};
    for (final topic in wanted) {
      try {
        await _messaging.subscribeToTopic(topic);
        confirmed.add(topic);
        if (kDebugMode) debugPrint('[FCM] subscribed to "$topic"');
      } catch (e) {
        // Leave it out of the remembered set so the next launch retries.
        if (kDebugMode) debugPrint('[FCM] subscribe "$topic" failed: $e');
      }
    }

    await _tokenStorage.setSubscribedTopics(confirmed);
  }

  /// Drops every topic this install ever subscribed to. Used on logout — the
  /// next user's settings response re-establishes whatever they should get.
  Future<void> unsubscribeFromAllTopics() async {
    if (!supportsPush) return;
    for (final topic in _tokenStorage.getSubscribedTopics()) {
      try {
        await _messaging.unsubscribeFromTopic(topic);
      } catch (e) {
        if (kDebugMode) debugPrint('[FCM] unsubscribe "$topic" failed: $e');
      }
    }
    await _tokenStorage.clearSubscribedTopics();
  }

  /// First half of the logout flow, run *before* the auth token is cleared —
  /// `POST /auth/logout` is authenticated.
  ///
  /// Sending the FCM token is what stops this device receiving notifications
  /// for an account that signed out. Failures are swallowed: a user tapping
  /// "log out" must end up signed out regardless, and [onLogout] deletes the
  /// token locally as a backstop.
  Future<void> notifyServerOfLogout() async {
    if (!_tokenStorage.hasToken()) return;
    final result = await _logoutDevice(_tokenStorage.getFcmToken());
    result.fold(
      (error) {
        if (kDebugMode) debugPrint('[FCM] logout call failed: $error');
      },
      (_) {},
    );
  }

  /// Second half of the logout flow, run *after* the auth token has been
  /// cleared.
  ///
  /// Deleting the FCM token is what stops pushes for the signed-out user on
  /// devices where `POST /auth/logout` never reached the server. Firebase
  /// mints a fresh token on the next getToken(), which the next sign-in
  /// registers against the new user.
  Future<void> onLogout() async {
    await unsubscribeFromAllTopics();
    await deleteToken();
  }

  /// Wipes the FCM token from this device, so a subsequent user sign-in on the
  /// same device starts fresh.
  Future<void> deleteToken() async {
    if (!supportsPush) return;
    try {
      await _messaging.deleteToken();
    } catch (_) {/* ignore - best-effort */}
    // Drop our cached copy too, otherwise the next syncTokenIfNeeded would
    // happily re-POST the token we just invalidated.
    await _tokenStorage.clearFcmToken();
  }

  /// Raises a banner for an inbox row. The Windows poller's only way to
  /// announce anything — there is no push channel to the desktop app.
  ///
  /// Also publishes it on [onNotificationReceived], so an inbox that is open
  /// in front of the user gains the row without waiting for a refresh — the
  /// same thing a foreground push does on mobile.
  Future<void> showNotification(NotificationEntity notification) async {
    await _showLocalNotification(
      id: _stableId(notification.id),
      title: notification.title,
      body: notification.body,
      data: notification.data,
    );
    _onNotificationReceivedController.add(notification);
  }

  /// A single summary banner standing in for notifications the server withheld
  /// past its per-poll cap. Firing one banner per withheld row would mean
  /// hundreds in a burst for a user who has been offline a while.
  Future<void> showSummaryNotification({
    required String title,
    required String body,
  }) {
    return _showLocalNotification(
      id: _stableId('unseen-summary'),
      title: title,
      body: body,
      data: const <String, dynamic>{'type': 'announcement'},
    );
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

  Future<void> _showLocalNotification({
    required int id,
    required String? title,
    required String? body,
    required Map<String, dynamic> data,
  }) async {
    // FCM never auto-displays in the foreground on any platform, so we show
    // the banner ourselves there. A data-only push, and a row with neither a
    // title nor a body, have nothing user-visible to show.
    if (title == null && body == null) return;

    await _localNotifications.show(
      id: id,
      title: title,
      body: body,
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
        windows: WindowsNotificationDetails(images: _windowsLogo()),
      ),
      // Carry the routing payload through the tap round-trip.
      payload: jsonEncode(data),
    );
  }

  /// The brand mark, padded into a transparent square so it sits *inside* the
  /// toast's logo slot rather than filling it edge to edge.
  ///
  /// Windows gives no size control over `appLogoOverride` — the slot is a
  /// fixed box in the toast template — so the only way to make the logo read
  /// smaller is to leave margin in the image itself. `denta_mark.png` fills
  /// ~95% of its own canvas and looked oversized here; this variant sits at
  /// 62%. The wordmark is not an option at this size, and the slot is
  /// circle-cropped besides.
  static const String _logoAsset = 'assets/images/logo/denta_mark_toast.png';

  /// The unpadded mark, for the toast header's app icon. That slot is already
  /// tiny, so it wants the tighter crop rather than this one's margin.
  static const String _appIconAsset = 'assets/images/logo/denta_mark.png';

  /// The Denta mark in the toast's app-logo slot, so a banner is recognisably
  /// ours at a glance rather than a bare block of text.
  ///
  /// Empty on every other platform: resolving the URI touches dart:io paths
  /// that only make sense for a Windows build, and nothing else reads this.
  List<WindowsImage> _windowsLogo() {
    if (!usesPolling) return const [];
    final uri = _windowsAssetUri(_logoAsset);
    if (uri == null) return const [];
    return [
      WindowsImage(
        uri,
        altText: 'Denta',
        placement: WindowsImagePlacement.appLogoOverride,
        crop: WindowsImageCrop.circle,
      ),
    ];
  }

  /// Asset paths differ between a debug run, a plain release build, and an
  /// MSIX package; the plugin's helper knows all three. It throws on anything
  /// but Windows, so every caller is guarded and a failure degrades to a
  /// logo-less toast rather than losing the notification.
  static Uri? _windowsAssetUri(String asset) {
    try {
      return WindowsImage.getAssetUri(asset);
    } catch (e) {
      if (kDebugMode) debugPrint('[notifications] asset uri failed: $e');
      return null;
    }
  }

  static String? _windowsAssetPath(String asset) {
    if (!usesPolling) return null;
    return _windowsAssetUri(asset)?.toFilePath(windows: true);
  }

  /// Stable-ish 32-bit id for the local notification. Deriving it from the
  /// server-side notification id lets a repeat of the same notification
  /// overwrite the existing banner instead of stacking a duplicate.
  int _stableId(String key) => key.hashCode & 0x7fffffff;

  Future<void> dispose() async {
    await _onPushReceivedController.close();
    await _onNotificationReceivedController.close();
    await _onNotificationTapController.close();
  }
}
