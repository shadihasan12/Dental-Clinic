import 'package:dental_clinic_app/services/currency/currency_entity.dart';

class CurrencyModel {
  final String id;
  final String currencyName;
  final String currencyCode;

  const CurrencyModel({
    required this.id,
    required this.currencyName,
    required this.currencyCode,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      id: json['id'] as String,
      currencyName: json['currency_name'] as String? ?? '',
      currencyCode: json['currency_code'] as String? ?? '',
    );
  }

  CurrencyEntity toEntity() {
    return CurrencyEntity(
      id: id,
      currencyName: currencyName,
      currencyCode: currencyCode,
    );
  }
}
