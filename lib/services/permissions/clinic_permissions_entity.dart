import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinic_permissions_entity.freezed.dart';

@freezed
class ClinicPermissionsEntity with _$ClinicPermissionsEntity {
  const factory ClinicPermissionsEntity({
    required Set<String> featureSlugs,
  }) = _ClinicPermissionsEntity;

  const ClinicPermissionsEntity._();

  bool hasFeature(String slug) => featureSlugs.contains(slug);
}
