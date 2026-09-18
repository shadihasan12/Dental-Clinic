// Basic Flutter widget test for Dental Clinic App.
//
// Two things `main()` does that a test pumping the widget has to do as well,
// or the app cannot be built at all:
//
//   * Firebase, because the DI container registers `FirebaseMessaging.instance`
//     eagerly and that throws without a default app;
//   * `configureDependencies()`, because the root widget resolves
//     TokenStorage out of GetIt while it is still being constructed.
//
// Firebase is answered by the mock `firebase_core` ships for exactly this:
// the point of the test is that the widget tree builds, and reaching out to
// Google to prove it would make the suite depend on the network.

import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core_platform_interface/test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    // AppConfig reads dotenv while the API client is being registered, and
    // the getter throws if load() never ran. Loaded from a string rather than
    // the real .env so the suite does not depend on a file that is
    // deliberately environment-specific - and so no test can ever reach the
    // production API by accident.
    dotenv.testLoad(
      fileInput: 'BASE_URL=https://example.invalid/api\n'
          'API_TIMEOUT=30\n'
          'ENVIRONMENT=test',
    );

    setupFirebaseCoreMocks();
    await Firebase.initializeApp();

    // Storage-backed singletons resolve SharedPreferences during init; the
    // mock keeps that off the platform channel, and an empty map is a
    // first-launch device - signed out, no cached clinic.
    SharedPreferences.setMockInitialValues({});
    await getIt.reset();
    await configureDependencies();
  });

  tearDown(() => getIt.reset());

  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const DentalClinicApp());

    // Verify that app builds successfully
    expect(find.byType(DentalClinicApp), findsOneWidget);

    // The first screen schedules entrance animations. Let them fire, then
    // tear the tree down so their timers are cancelled in dispose - the test
    // binding fails the test for any timer still pending at the end.
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
