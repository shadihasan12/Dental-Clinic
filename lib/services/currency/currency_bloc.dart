import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:dental_clinic_app/services/currency/currency_entity.dart';
import 'package:dental_clinic_app/services/currency/currency_service.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';

part 'currency_bloc.freezed.dart';

@freezed
class CurrencyEvent with _$CurrencyEvent {
  /// Fetches the list, whatever is held now.
  const factory CurrencyEvent.load() = _Load;

  /// Fetches the list only when it is not already held or on its way - what
  /// a screen that needs currencies sends when it opens. Cheap to send
  /// every time, which is the point: no screen has to remember whether the
  /// first attempt worked.
  const factory CurrencyEvent.ensureLoaded() = _EnsureLoaded;
}

@freezed
class CurrencyState with _$CurrencyState {
  const factory CurrencyState.initial() = _Initial;
  const factory CurrencyState.loading() = _Loading;
  const factory CurrencyState.loaded(List<CurrencyEntity> currencies) = _Loaded;
  const factory CurrencyState.error(String message) = _Error;
}

/// The currency list the whole app shares, fetched once at startup.
///
/// A start without internet used to leave it failed for the rest of the
/// session: nothing asked again, and a screen that only read the state (the
/// expense sheet) showed no currencies until the app was restarted. Now a
/// failed load watches the connection and retries the moment it is back,
/// and screens send [CurrencyEvent.ensureLoaded] when they open.
@lazySingleton
class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final CurrencyService _currencyService;
  final InternetConnectionChecker _connection;

  /// Only held while the last load failed. The checker probes the network
  /// for as long as anyone listens, so it is not left running once the list
  /// is in.
  StreamSubscription<InternetConnectionStatus>? _reconnect;

  CurrencyBloc(this._currencyService, this._connection)
      : super(const CurrencyState.initial()) {
    on<_Load>(_onLoad);
    on<_EnsureLoaded>(_onEnsureLoaded);
  }

  Future<void> _onEnsureLoaded(
    _EnsureLoaded event,
    Emitter<CurrencyState> emit,
  ) async {
    final settled = state.maybeWhen(
      loaded: (_) => true,
      loading: () => true,
      orElse: () => false,
    );
    if (settled) return;
    await _fetch(emit);
  }

  Future<void> _onLoad(_Load event, Emitter<CurrencyState> emit) =>
      _fetch(emit);

  Future<void> _fetch(Emitter<CurrencyState> emit) async {
    emit(const CurrencyState.loading());

    final result = await _currencyService.getCurrencies();

    result.fold(
      (error) {
        emit(CurrencyState.error(NetworkExceptions.getErrorMessage(error)));
        _retryWhenOnline();
      },
      (currencies) {
        _stopWatching();
        emit(CurrencyState.loaded(currencies));
      },
    );
  }

  void _retryWhenOnline() {
    _reconnect ??= _connection.onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.connected && !isClosed) {
        add(const CurrencyEvent.ensureLoaded());
      }
    });
  }

  void _stopWatching() {
    _reconnect?.cancel();
    _reconnect = null;
  }

  @override
  Future<void> close() {
    _stopWatching();
    return super.close();
  }
}
