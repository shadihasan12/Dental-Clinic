import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';

/// Remembers the calls the server answered 429 to, and until when.
///
/// Every route has a limit on how often it is called, and a call over the
/// limit still counts. So once the server has said "wait N seconds" for a
/// call, sending the very same call again inside that time is pointless: it
/// is answered here, with the server's own sentence and the seconds left,
/// and never leaves the device.
///
/// "The same call" is the method, the path, the query and the body together.
/// The limits are counted by different things - the account, the address
/// typed at login, the address a code is for - so a different email on the
/// same route is a different call, and is let through.
///
/// Only a 429 with a `Retry-After` header is held. The wait between two
/// one-time codes (`meta.seconds_remaining`, no header) is not: it ends
/// early, the moment the code it guards is used up.
class RateLimitHold {
  RateLimitHold({DateTime Function()? now}) : _now = now ?? DateTime.now;

  final DateTime Function() _now;
  final Map<String, _Held> _held = {};

  /// A hold never outlives the longest window the server uses.
  static const int _maxSeconds = 3600;

  static const String _heldMark = 'rate_limit_held';

  /// Notes the `Retry-After` of a 429 against the call that received it.
  void report(DioException error) {
    final response = error.response;
    if (response?.statusCode != 429) return;
    // One of our own answers: the hold it came from already stands.
    if (response?.extra[_heldMark] == true) return;
    final seconds = NetworkExceptions.retryAfterOf(response);
    final key = _keyOf(error.requestOptions);
    if (seconds == null || key == null) return;

    _held[key] = _Held(
      until: _now().add(
        Duration(seconds: seconds > _maxSeconds ? _maxSeconds : seconds),
      ),
      body: response?.data,
    );
  }

  /// The 429 to answer [options] with while its hold lasts, or null when the
  /// call may go out.
  DioException? check(RequestOptions options) {
    final key = _keyOf(options);
    final held = key == null ? null : _held[key];
    if (held == null) return null;

    final left = held.until.difference(_now());
    if (left <= Duration.zero) {
      _held.remove(key);
      return null;
    }

    return DioException(
      requestOptions: options,
      type: DioExceptionType.badResponse,
      response: Response(
        requestOptions: options,
        statusCode: 429,
        data: held.body,
        extra: const {_heldMark: true},
        headers: Headers.fromMap({
          'retry-after': ['${(left.inMilliseconds / 1000).ceil()}'],
        }),
      ),
    );
  }

  void clear() => _held.clear();

  /// Null for a call that cannot be told from another - an upload, whose
  /// body is a stream.
  String? _keyOf(RequestOptions options) {
    final data = options.data;
    if (data is FormData) return null;
    String body;
    try {
      body = data == null ? '' : (data is String ? data : jsonEncode(data));
    } catch (_) {
      return null;
    }
    final query = options.queryParameters.isEmpty
        ? ''
        : jsonEncode(
            options.queryParameters.map((k, v) => MapEntry(k, '$v')),
          );
    return '${options.method.toUpperCase()} ${options.path}?$query#$body';
  }
}

class _Held {
  const _Held({required this.until, required this.body});

  final DateTime until;

  /// The 429's own body, so the held answer says what the server said.
  final Object? body;
}
