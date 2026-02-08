import 'package:freezed_annotation/freezed_annotation.dart';

part 'specialty_entity.freezed.dart';

/// Domain entity representing a dental specialty
@freezed
class SpecialtyEntity with _$SpecialtyEntity {
  const factory SpecialtyEntity({
    required String id,
    required String name,
  }) = _SpecialtyEntity;
}
