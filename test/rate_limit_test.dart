import 'package:dental_clinic_app/core/api/interceptors/rate_limit_hold.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

/// A 429 is neither a refresh nor a logout: the app shows the server's
/// sentence and waits as long as it was told to. These pin the two halves of
/// that - reading the wait off the answer, and not sending the same call
/// again before it is over.
void main() {
  const tooMany =
      '{"result":"error","message":"طلبات كثيرة جداً","data":null,'
      '"error_list":[],"code":429,"meta":{"correlation_id":"x"}}';

  Response response429(
    RequestOptions options, {
    String body = tooMany,
    String? retryAfter,
  }) {
    return Response(
      requestOptions: options,
      statusCode: 429,
      data: body,
      headers: Headers.fromMap({
        if (retryAfter != null) 'retry-after': [retryAfter],
      }),
    );
  }

  DioException error429(RequestOptions options, {String? retryAfter}) {
    return DioException(
      requestOptions: options,
      type: DioExceptionType.badResponse,
      response: response429(options, retryAfter: retryAfter),
    );
  }

  RequestOptions login(String email) => RequestOptions(
    path: '/auth/login',
    method: 'POST',
    data: {'email_or_mobile_number': email, 'password': 'secret'},
  );

  group('reading a 429', () {
    test('a rate limit carries Retry-After and the server sentence', () {
      final exception = NetworkExceptions.handleResponse(
        response429(login('a@x.com'), retryAfter: '60'),
      );

      expect(
        exception,
        const NetworkExceptions.tooManyRequests(
          'طلبات كثيرة جداً',
          retryAfterSeconds: 60,
        ),
      );
      expect(NetworkExceptions.waitSecondsOf(exception), 60);
    });

    test('the wait between two codes carries seconds_remaining instead', () {
      final exception = NetworkExceptions.handleResponse(
        response429(
          RequestOptions(path: '/auth/register/request-otp'),
          body:
              '{"result":"error","message":"يرجى إعادة المحاولة بعد 299 ثانية",'
              '"error_list":[],"code":429,"meta":{"seconds_remaining":299}}',
        ),
      );

      expect(
        exception,
        const NetworkExceptions.tooManyRequests(
          'يرجى إعادة المحاولة بعد 299 ثانية',
          secondsRemaining: 299,
        ),
      );
      expect(NetworkExceptions.waitSecondsOf(exception), 299);
    });

    test('a 503 keeps the sentence the server sent', () {
      final exception = NetworkExceptions.handleResponse(
        Response(
          requestOptions: RequestOptions(path: '/auth/verify-email/request-otp'),
          statusCode: 503,
          data: '{"message":"تعذّر إرسال الرمز حالياً.","error_list":[]}',
        ),
      );

      expect(
        exception,
        const NetworkExceptions.serviceUnavailable('تعذّر إرسال الرمز حالياً.'),
      );
    });
  });

  group('holding a call back', () {
    late DateTime clock;
    late RateLimitHold hold;

    setUp(() {
      clock = DateTime(2026, 10, 11, 12);
      hold = RateLimitHold(now: () => clock);
    });

    test('the same call is answered here until the wait is over', () {
      hold.report(error429(login('a@x.com'), retryAfter: '60'));

      clock = clock.add(const Duration(seconds: 20));
      final held = hold.check(login('a@x.com'));

      expect(held?.response?.statusCode, 429);
      expect(NetworkExceptions.retryAfterOf(held?.response), 40);
      expect(
        NetworkExceptions.handleResponse(held?.response),
        const NetworkExceptions.tooManyRequests(
          'طلبات كثيرة جداً',
          retryAfterSeconds: 40,
        ),
      );

      clock = clock.add(const Duration(seconds: 40));
      expect(hold.check(login('a@x.com')), isNull);
    });

    test('another address on the same route is let through', () {
      hold.report(error429(login('a@x.com'), retryAfter: '60'));

      expect(hold.check(login('b@x.com')), isNull);
    });

    test('a held answer does not push its own hold further out', () {
      hold.report(error429(login('a@x.com'), retryAfter: '60'));

      // 65 seconds of tapping twice a second.
      for (var i = 0; i < 130; i++) {
        clock = clock.add(const Duration(milliseconds: 500));
        final held = hold.check(login('a@x.com'));
        if (held != null) hold.report(held);
      }

      expect(hold.check(login('a@x.com')), isNull);
    });

    test('the wait between two codes is not held', () {
      // No Retry-After: that wait ends early, when its code is used up.
      hold.report(error429(login('a@x.com')));

      expect(hold.check(login('a@x.com')), isNull);
    });
  });
}
