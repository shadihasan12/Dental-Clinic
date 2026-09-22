// Smoke tour of the app against the real backend: signs in through the login
// screen, opens every major screen, screenshots each one, and reports any
// framework error or failed API call it saw along the way.
//
//   flutter test integration_test/app_tour_test.dart -d <simulator> \
//     --dart-define=TOUR_EMAIL=... --dart-define=TOUR_PASSWORD=...
//
// Each screen prints `[tour] READY <name>` and holds for 2.5s; capture it
// with `xcrun simctl io <simulator> screenshot <name>.png`.
import 'package:dental_clinic_app/core/resources/routes_manager.dart';
import 'package:dental_clinic_app/core/storage/token_storage.dart';
import 'package:dental_clinic_app/custom_widgets/denta_nav_bar.dart';
import 'package:dental_clinic_app/features/auth/presentation/pages/login_page.dart';
import 'package:dental_clinic_app/features/root/presentation/pages/root_page.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/main.dart' as app;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:integration_test/integration_test.dart';

const _email = String.fromEnvironment('TOUR_EMAIL');
const _password = String.fromEnvironment('TOUR_PASSWORD');
const _patientId = String.fromEnvironment('TOUR_PATIENT_ID');
const _patientName = String.fromEnvironment('TOUR_PATIENT_NAME');

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  // Present every frame: the default policy leaves the simulator's screen
  // showing a stale frame for several screens at a time, so an outside
  // screenshot captured the wrong page.
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  testWidgets('app tour', (tester) async {
    final problems = <String>[];
    var screen = 'boot';

    await app.main();
    await _pumpFor(tester, const Duration(seconds: 3));

    final originalOnError = FlutterError.onError;
    FlutterError.onError = (details) {
      final msg = details.exceptionAsString().split('\n').first;
      problems.add('[$screen] FLUTTER: $msg');
      // ignore: avoid_print
      print('[tour] FLUTTER ERROR on $screen: ${details.exceptionAsString()}\n${details.stack.toString().split('\n').take(8).join('\n')}');
    };
    // First in the chain, so it sees the raw error before ErrorInterceptor
    // folds every transport failure into "no internet connection".
    getIt<Dio>().interceptors.insert(
      0,
      InterceptorsWrapper(
        onError: (e, h) {
          if (e.response == null) {
            final raw = '[$screen] RAW ${e.requestOptions.path} '
                '${e.type} ${e.error.runtimeType}: ${e.error}';
            problems.add(raw);
            // ignore: avoid_print
            print('[tour] $raw');
          }
          h.next(e);
        },
      ),
    );
    getIt<Dio>().interceptors.add(
      InterceptorsWrapper(
        onError: (e, h) {
          final code = e.response?.statusCode;
          final body = e.response?.data?.toString() ?? '';
          problems.add('[$screen] API $code ${e.requestOptions.method} '
              '${e.requestOptions.path} ${body.length > 200 ? body.substring(0, 200) : body}');
          h.next(e);
        },
      ),
    );

    // Screenshots are taken from outside, by the simulator (`simctl io
    // screenshot`) when this marker appears - binding.takeScreenshot proved
    // flaky on iOS and returned the launch screen for a whole run.
    Future<void> shot(String name, {int seconds = 3}) async {
      screen = name;
      await _pumpFor(tester, Duration(seconds: seconds));
      // ignore: avoid_print
      print('[tour] READY $name');
      await _pumpFor(tester, const Duration(milliseconds: 2500));
    }

    final router = GoRouter.of(rootNavigatorKey.currentContext!);

    // ── Login through the real screen ──
    if (getIt<TokenStorage>().hasToken()) {
      problems.add('note: started already signed in');
    } else {
      router.go('/login');
      await _pumpUntil(tester, find.byType(LoginPage), const Duration(seconds: 10));
      await shot('01_login', seconds: 1);
      final fields = find.descendant(
        of: find.byType(LoginPage),
        matching: find.byType(EditableText),
      );
      await tester.enterText(fields.at(0), _email);
      await tester.enterText(fields.at(1), _password);
      await tester.pump();
      FocusManager.instance.primaryFocus?.unfocus();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.tap(find.text('Sign In').last);
    }
    await _pumpUntil(tester, find.byType(RootPage), const Duration(seconds: 25));
    expect(find.byType(RootPage), findsOneWidget, reason: 'login should land on the root page');
    await shot('02_home', seconds: 5);

    // ── Root tabs (icons only when unselected, so tapped by position) ──
    Future<void> tab(int index, String name) async {
      final items = find.descendant(
        of: find.byType(DentaNavBar),
        matching: find.byType(InkWell),
      );
      if (items.evaluate().length <= index) {
        problems.add('[$name] nav item $index not found');
        return;
      }
      await tester.tap(items.at(index));
      await shot(name, seconds: 4);
    }

    Future<void> scrollShots(String name, int pages) async {
      for (var i = 1; i <= pages; i++) {
        final scrollables = find.byType(Scrollable);
        if (scrollables.evaluate().isEmpty) return;
        await tester.drag(scrollables.first, const Offset(0, -520));
        await shot('${name}_scroll$i', seconds: 2);
      }
    }

    await tab(1, '03_patients');
    // Patient details, opened straight from its route: the list is lazy, so
    // a patient further down is not in the tree to tap.
    if (_patientId.isNotEmpty) {
      router.push('/patients-details', extra: {
        'patientId': _patientId,
        'patientName': _patientName,
      });
      await shot('04_patient_details', seconds: 6);
      await scrollShots('04_patient_details', 3);
      router.pop();
      await _pumpFor(tester, const Duration(seconds: 1));
    }
    await tab(2, '05_appointments');
    await tab(3, '06_expenses');
    await scrollShots('06_expenses', 1);
    await tab(0, '02b_home_again');

    // ── Pushed screens ──
    Future<void> open(String path, String name) async {
      screen = name;
      router.push(path);
      await shot(name, seconds: 4);
      if (router.canPop()) router.pop();
      await _pumpFor(tester, const Duration(seconds: 1));
    }

    await open('/patients/add', '07_add_patient');
    await open('/new-appointment', '08_new_appointment');
    router.push('/statistics');
    await shot('09_statistics', seconds: 6);
    await scrollShots('09_statistics', 7);
    router.pop();
    await _pumpFor(tester, const Duration(seconds: 1));
    await open('/more', '10_more');
    await open('/clinic-info', '11_clinic_info');
    await open('/working-days', '12_working_days');
    await open('/clinic-users', '13_clinic_users');
    await open('/my-clinics', '14_my_clinics');
    await open('/notifications', '15_notifications');
    await open('/notifications-settigns', '16_notification_settings');
    await open('/edit-profile', '17_edit_profile');
    await open('/billing', '18_billing');
    await open('/pricing', '19_pricing');
    await open('/report-issue', '20_report_issue');
    await open('/delete-account', '21_delete_account');

    FlutterError.onError = originalOnError;
    // ignore: avoid_print
    print('[tour] ===== PROBLEMS (${problems.length}) =====');
    for (final p in problems) {
      // ignore: avoid_print
      print('[tour] $p');
    }
    // ignore: avoid_print
    print('[tour] ===== END =====');
  });
}

Future<void> _pumpFor(WidgetTester tester, Duration d) async {
  final end = DateTime.now().add(d);
  while (DateTime.now().isBefore(end)) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

Future<void> _pumpUntil(WidgetTester tester, Finder f, Duration timeout) async {
  final end = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(end)) {
    await tester.pump(const Duration(milliseconds: 100));
    if (f.evaluate().isNotEmpty) return;
  }
}
