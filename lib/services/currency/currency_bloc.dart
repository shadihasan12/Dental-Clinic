import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_clinic_app/services/currency/currency_entity.dart';
import 'package:dental_clinic_app/services/currency/currency_service.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';

part 'currency_bloc.freezed.dart';

@freezed
class CurrencyEvent with _$CurrencyEvent {
  const factory CurrencyEvent.load() = _Load;
}

@freezed
class CurrencyState with _$CurrencyState {
  const factory CurrencyState.initial() = _Initial;
  const factory CurrencyState.loading() = _Loading;
  const factory CurrencyState.loaded(List<CurrencyEntity> currencies) = _Loaded;
  const factory CurrencyState.error(String message) = _Error;
}

@lazySingleton
class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final CurrencyService _currencyService;

  CurrencyBloc(this._currencyService) : super(const CurrencyState.initial()) {
    on<_Load>(_onLoad);
  }

  Future<void> _onLoad(_Load event, Emitter<CurrencyState> emit) async {
    emit(const CurrencyState.loading());

    final result = await _currencyService.getCurrencies();

    result.fold(
      (error) => emit(
        CurrencyState.error(NetworkExceptions.getErrorMessage(error)),
      ),
      (currencies) => emit(CurrencyState.loaded(currencies)),
    );
  }
}
