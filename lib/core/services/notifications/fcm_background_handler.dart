import 'package:dental_clinic_app/core/services/notifications/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

/// Top-level background message handler.
///
/// FCM spawns a separate Dart isolate for messages received while the app is
/// terminated or backgrounded, so this MUST be a top-level function and MUST
/// be annotated with @pragma('vm:entry-point') for release builds (otherwise
/// tree-shaking strips it).
///
/// Keep the work here minimal: Firebase needs to be re-initialised in the
/// background isolate, but anything heavier (drawing UI, hitting the DB) is
/// not appropriate. We rely on the FCM notification payload to be auto-shown
/// by the system; this handler exists so the message is acknowledged and so
/// `data`-only messages don't get silently dropped.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (kDebugMode) {
    debugPrint('[FCM-bg] ${message.messageId} data=${message.data}');
  }
}
