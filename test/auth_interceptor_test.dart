import 'dart:async';
import 'dart:io';

import 'package:dental_clinic_app/core/api/interceptors/auth_interceptor.dart';
import 'package:dental_clinic_app/core/localization/language_service.dart';
import 'package:dental_clinic_app/core/session/session_manager.dart';
import 'package:dental_clinic_app/core/storage/token_storage.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/services/clinic_access/clinic_access_guard.dart';
import 'package:dental_clinic_app/services/subscription_guard/subscription_guard.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// What the interceptor does with the answers that decide whether the user
/// stays signed in. Run against a real HTTP server on the loopback, because
/// the thing worth proving is the order the calls go out in - one renewal,
/// the others waiting for it - and that nothing but a refused renewal ends
/// the session.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  // The test binding answers every request with a bare 400 unless the
  // override is lifted, and these cases turn on what really goes over the
  // wire - how many renewals, and in which order.
  HttpOverrides.global = null;

  late HttpServer server;
  late TokenStorage tokens;
  late Dio client;
  late ClinicAccessGuard clinicGuard;

  /// Answers, by path, in the order they were registered.
  late Map<String, void Function(HttpRequest)> routes;

  /// How often each path was asked for.
  late Map<String, int> hits;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    tokens = TokenStorage(prefs);
    await tokens.saveToken('old-token');

    hits = {};
    routes = {};
    server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    server.listen((request) {
      final path = request.uri.path;
      hits[path] = (hits[path] ?? 0) + 1;
      final route = routes[path];
      if (route == null) {
        request.response.statusCode = 404;
        request.response.close();
        return;
      }
      route(request);
    });

    // The interceptor builds its own client for the renewal, from the
    // configured base URL - so the test points that at this server.
    dotenv.testLoad(
      mergeWith: {'BASE_URL': 'http://127.0.0.1:${server.port}/'},
    );

    final guard = SubscriptionGuard();
    clinicGuard = ClinicAccessGuard();
    client = Dio(BaseOptions(baseUrl: 'http://127.0.0.1:${server.port}/'))
      ..interceptors.add(
        AuthInterceptor(
          tokens,
          LanguageService(prefs),
          SessionManager(tokens, UserStorage(prefs), guard, clinicGuard),
          guard,
          clinicGuard,
        ),
      );
  });

  tearDown(() => server.close(force: true));

  void json(HttpRequest request, int status, {Map<String, String>? headers}) {
    request.response.statusCode = status;
    headers?.forEach(request.response.headers.set);
    request.response.headers.contentType = ContentType.json;
    request.response.write('{"message":"ok","error_list":[],"code":$status}');
    request.response.close();
  }

  /// A call that is refused until the token has been renewed.
  void serveUntilRenewed(String path) {
    routes[path] = (request) {
      final sent = request.headers.value('authorization');
      json(request, sent == 'Bearer new-token' ? 200 : 401);
    };
  }

  group('renewing the token', () {
    test('several calls refused at once renew it once between them', () async {
      serveUntilRenewed('/data');
      routes['/auth/refresh'] = (request) => json(
        request,
        200,
        headers: {'Authorization': 'new-token'},
      );

      final answers = await Future.wait([
        client.get('/data'),
        client.get('/data'),
        client.get('/data'),
      ]);

      expect(answers.map((r) => r.statusCode), everyElement(200));
      // One renewal for the three, and the new token kept for what follows.
      expect(hits['/auth/refresh'], 1);
      expect(tokens.getToken(), 'new-token');
    });

    test('a renewal refused with 401 ends the session', () async {
      routes['/data'] = (request) => json(request, 401);
      routes['/auth/refresh'] = (request) => json(request, 401);

      await expectLater(client.get('/data'), throwsA(isA<DioException>()));

      expect(tokens.getToken(), isNull);
    });

    test('a renewal that is rate-limited does not', () async {
      routes['/data'] = (request) => json(request, 401);
      routes['/auth/refresh'] = (request) =>
          json(request, 429, headers: {'Retry-After': '60'});

      final error = await client
          .get('/data')
          .then<DioException?>((_) => null, onError: (Object e) => e as DioException);

      // The session says nothing about being over: the user stays signed in
      // and the caller is handed the 429 to show.
      expect(tokens.getToken(), 'old-token');
      expect(error?.response?.statusCode, 429);
    });
  });

  group('being told to slow down', () {
    test('a 429 is neither a renewal nor a logout', () async {
      routes['/limited'] = (request) =>
          json(request, 429, headers: {'Retry-After': '60'});

      final error = await client
          .get('/limited')
          .then<DioException?>((_) => null, onError: (Object e) => e as DioException);

      expect(error?.response?.statusCode, 429);
      expect(hits['/auth/refresh'], isNull);
      expect(tokens.getToken(), 'old-token');
    });

    test('the same call is answered without going out again', () async {
      routes['/limited'] = (request) =>
          json(request, 429, headers: {'Retry-After': '60'});

      for (var i = 0; i < 3; i++) {
        final error = await client
            .get('/limited')
            .then<DioException?>((_) => null, onError: (Object e) => e as DioException);
        expect(error?.response?.statusCode, 429);
      }

      // Only the first one reached the server; every retry inside the wait
      // would have counted against the limit.
      expect(hits['/limited'], 1);
    });

    test('another call on the same route still goes out', () async {
      routes['/limited'] = (request) {
        final held = request.uri.queryParameters['q'] == 'a';
        json(
          request,
          held ? 429 : 200,
          headers: held ? {'Retry-After': '60'} : null,
        );
      };

      await client.get('/limited', queryParameters: {'q': 'a'}).then<void>(
        (_) {},
        onError: (_) {},
      );
      final other = await client.get('/limited', queryParameters: {'q': 'b'});

      expect(other.statusCode, 200);
      expect(hits['/limited'], 2);
    });
  });

  group('a clinic that is no longer the user’s', () {
    void forbidden(HttpRequest request, {String? reason}) {
      request.response.statusCode = 403;
      request.response.headers.contentType = ContentType.json;
      final meta = reason == null
          ? '{"correlation_id":"x"}'
          : '{"correlation_id":"x","reason":"$reason"}';
      request.response.write(
        '{"result":"error","message":"m","data":null,"error_list":[],'
        '"code":403,"meta":$meta}',
      );
      request.response.close();
    }

    test('a not_clinic_member refusal is reported once, for its clinic',
        () async {
      await tokens.saveClinicId('clinic-a');
      routes['/patients'] =
          (request) => forbidden(request, reason: 'not_clinic_member');
      final reported = <String>[];
      final sub = clinicGuard.losses.listen((n) => reported.add(n.clinicId));

      // A screen loading several lists together: all refused at once.
      await Future.wait([
        for (var i = 0; i < 3; i++)
          client.get('/patients').then((_) {}, onError: (_) {}),
      ]);
      await Future<void>.delayed(Duration.zero);

      expect(reported, ['clinic-a']);
      await sub.cancel();
    });

    test('a role refusal (no reason) leaves the clinic alone', () async {
      await tokens.saveClinicId('clinic-a');
      routes['/staff'] = (request) => forbidden(request);
      var reported = 0;
      final sub = clinicGuard.losses.listen((_) => reported++);

      await expectLater(client.get('/staff'), throwsA(isA<DioException>()));
      await Future<void>.delayed(Duration.zero);

      expect(reported, 0);
      await sub.cancel();
    });

    test('the clinic named is the one the request was sent with', () async {
      await tokens.saveClinicId('clinic-a');
      final answer = Completer<void>();
      routes['/slow'] = (request) async {
        await answer.future;
        forbidden(request, reason: 'not_clinic_member');
      };
      final reported = <String>[];
      final sub = clinicGuard.losses.listen((n) => reported.add(n.clinicId));

      final call = client.get('/slow').then((_) {}, onError: (_) {});
      // The user switched clinics while the request was out.
      await Future<void>.delayed(const Duration(milliseconds: 50));
      await tokens.saveClinicId('clinic-b');
      answer.complete();
      await call;
      await Future<void>.delayed(Duration.zero);

      expect(reported, ['clinic-a']);
      await sub.cancel();
    });
  });
}
