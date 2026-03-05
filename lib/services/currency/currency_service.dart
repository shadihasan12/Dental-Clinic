import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/services/currency/currency_entity.dart';
import 'package:dental_clinic_app/services/currency/currency_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CurrencyService {
  final ApiConsumer _apiConsumer;

  CurrencyService(this._apiConsumer);

  static const String _endpoint = '/currencies';

  Future<Either<NetworkExceptions, List<CurrencyEntity>>>
      getCurrencies() async {
    try {
      final response = await _apiConsumer.get(_endpoint);
      final dataList = response['data'] as List;
      final currencies = dataList
          .map((e) =>
              CurrencyModel.fromJson(e as Map<String, dynamic>).toEntity())
          .toList();
      return Right(currencies);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }
}
