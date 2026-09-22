// End-to-end check of in-app account deletion against the real backend.
//
// DESTRUCTIVE: the account named below is permanently deleted on success.
// Point it at a throwaway account only:
//
//   flutter test integration_test/delete_account_flow_test.dart -d <device> \
//     --dart-define=DELETE_TEST_EMAIL=... --dart-define=DELETE_TEST_PASSWORD=...
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/routes_manager.dart';
import 'package:dental_clinic_app/core/storage/token_storage.dart';
import 'package:dental_clinic_app/custom_widgets/denta_form.dart';
import 'package:dental_clinic_app/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:dental_clinic_app/features/auth/data/endpoints/auth_endpoints.dart';
import 'package:dental_clinic_app/features/auth/presentation/pages/login_page.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/delete_account_page.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/main.dart' as app;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:integration_test/integration_test.dart';

const _email = String.fromEnvironment('DELETE_TEST_EMAIL');
const _password = String.fromEnvironment('DELETE_TEST_PASSWORD');

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('delete account calls the API and lands on login', (
    tester,
  ) async {
    expect(_email, isNotEmpty, reason: 'pass --dart-define=DELETE_TEST_EMAIL');
    expect(_password, isNotEmpty, reason: 'pass --dart-define=DELETE_TEST_PASSWORD');

    await app.main();
    await _pumpFor(tester, const Duration(seconds: 3));

    // Sign in through the app's own data source, so the session is stored
    // exactly the way a real login stores it.
    await getIt<AuthRemoteDataSource>().login({
      'email_or_mobile_number': _email,
      'password': _password,
    });
    expect(getIt<TokenStorage>().hasToken(), isTrue);

    // Record every delete call and what the server answered.
    final deleteCalls = <int?>[];
    getIt<Dio>().interceptors.add(
      InterceptorsWrapper(
        onResponse: (r, h) {
          if (r.requestOptions.path == AuthEndpoints.deleteAccount) {
            deleteCalls.add(r.statusCode);
          }
          h.next(r);
        },
        onError: (e, h) {
          if (e.requestOptions.path == AuthEndpoints.deleteAccount) {
            deleteCalls.add(e.response?.statusCode);
          }
          h.next(e);
        },
      ),
    );

    final router = GoRouter.of(rootNavigatorKey.currentContext!);
    router.go('/');
    await _pumpFor(tester, const Duration(seconds: 3));
    router.pushNamed(AppRoutesNames.deleteAccount);

    // The preview is fetched from the server when the page opens.
    await _pumpUntil(tester, find.byType(FormActionBar), const Duration(seconds: 20));
    expect(find.byType(DeleteAccountPage), findsOneWidget);

    // First reason in the picker.
    final picker = find.byWidgetPredicate(
      (w) => w.runtimeType.toString() == '_ReasonPicker',
    );
    await tester.ensureVisible(picker);
    await tester.tap(
      find.descendant(of: picker, matching: find.byType(InkWell)).first,
    );
    await tester.pump();

    // The password field is the last text field on the page.
    final passwordField = find.descendant(
      of: find.byType(DeleteAccountPage),
      matching: find.byType(EditableText),
    ).last;
    await tester.ensureVisible(passwordField);
    // No keyboard "done": the field submits the form on it, and the test
    // should press the button the way a user does.
    await tester.enterText(passwordField, _password);
    await tester.pump();

    final cta = find.descendant(
      of: find.byType(FormActionBar),
      matching: find.byType(ElevatedButton),
    );
    expect(tester.widget<ElevatedButton>(cta).onPressed, isNotNull,
        reason: 'delete button should be enabled once reason + password set');
    // ignore: avoid_print
    print('[delete-test] tapping delete');
    await tester.tap(cta);

    await _pumpUntil(tester, find.byType(LoginPage), const Duration(seconds: 30));
    // Let the page transition finish: the outgoing delete page is still in
    // the tree for the length of the animation.
    await _pumpFor(tester, const Duration(seconds: 2));

    // ignore: avoid_print
    print('[delete-test] delete calls: $deleteCalls');
    // ignore: avoid_print
    print('[delete-test] location: '
        '${router.routerDelegate.currentConfiguration.uri}');

    expect(deleteCalls, [200], reason: 'exactly one delete call, answered 200');
    expect(find.byType(LoginPage), findsOneWidget);
    expect(find.byType(DeleteAccountPage), findsNothing);
    expect(getIt<TokenStorage>().hasToken(), isFalse);
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
