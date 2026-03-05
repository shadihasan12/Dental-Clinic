import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency_entity.freezed.dart';

@freezed
class CurrencyEntity with _$CurrencyEntity {
  const factory CurrencyEntity({
    required String id,
    required String currencyName,
    required String currencyCode,
  }) = _CurrencyEntity;
}
