import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/services/currency/currency_bloc.dart';
import 'package:dental_clinic_app/services/currency/currency_entity.dart';
import 'package:dental_clinic_app/services/currency/currency_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

/// Answers each call with the next queued result.
class _FakeService extends Fake implements CurrencyService {
  final results = <Either<NetworkExceptions, List<CurrencyEntity>>>[];
  int calls = 0;

  @override
  Future<Either<NetworkExceptions, List<CurrencyEntity>>> getCurrencies() async {
    calls++;
    return results.removeAt(0);
  }
}

class _FakeConnection extends Fake implements InternetConnectionChecker {
  final controller = StreamController<InternetConnectionStatus>.broadcast();

  @override
  Stream<InternetConnectionStatus> get onStatusChange => controller.stream;
}

const _offline = Left<NetworkExceptions, List<CurrencyEntity>>(
  NetworkExceptions.noInternetConnection(),
);

Future<void> _settle() => Future<void>.delayed(Duration.zero);

void main() {
  late _FakeService service;
  late _FakeConnection connection;
  late CurrencyBloc bloc;

  setUp(() {
    service = _FakeService();
    connection = _FakeConnection();
    bloc = CurrencyBloc(service, connection);
  });

  tearDown(() async {
    await bloc.close();
    await connection.controller.close();
  });

  bool isLoaded(CurrencyState s) =>
      s.maybeWhen(loaded: (_) => true, orElse: () => false);
  bool isError(CurrencyState s) =>
      s.maybeWhen(error: (_) => true, orElse: () => false);

  test('a load that failed offline retries once the connection is back',
      () async {
    service.results
      ..add(_offline)
      ..add(const Right([]));

    bloc.add(const CurrencyEvent.load());
    await _settle();
    expect(isError(bloc.state), isTrue);
    expect(connection.controller.hasListener, isTrue);

    connection.controller.add(InternetConnectionStatus.connected);
    await _settle();
    await _settle();

    expect(service.calls, 2);
    expect(isLoaded(bloc.state), isTrue);
    // The checker probes the network while listened to; it is let go.
    expect(connection.controller.hasListener, isFalse);
  });

  test('going offline again does not trigger a fetch', () async {
    service.results.add(_offline);
    bloc.add(const CurrencyEvent.load());
    await _settle();

    connection.controller.add(InternetConnectionStatus.disconnected);
    await _settle();
    expect(service.calls, 1);
  });

  test('ensureLoaded fetches after a failure but not once loaded', () async {
    service.results
      ..add(_offline)
      ..add(const Right([]));

    bloc.add(const CurrencyEvent.ensureLoaded());
    await _settle();
    expect(isError(bloc.state), isTrue);

    bloc.add(const CurrencyEvent.ensureLoaded());
    await _settle();
    expect(isLoaded(bloc.state), isTrue);

    bloc.add(const CurrencyEvent.ensureLoaded());
    await _settle();
    expect(service.calls, 2);
  });
}
