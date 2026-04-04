import 'package:dental_clinic_app/services/permissions/clinic_permissions_entity.dart';

class ClinicPermissionsModel {
  final Set<String> featureSlugs;

  ClinicPermissionsModel({required this.featureSlugs});

  /// Parses the API response where `data` is a list of groups,
  /// each containing a `feature_slugs` list. Flattens all slugs
  /// into a single set for fast lookups.
  factory ClinicPermissionsModel.fromList(List<dynamic> dataList) {
    final slugs = <String>{};
    for (final group in dataList) {
      final featureList = group['feature_slugs'] as List? ?? [];
      for (final slug in featureList) {
        slugs.add(slug.toString());
      }
    }
    return ClinicPermissionsModel(featureSlugs: slugs);
  }

  ClinicPermissionsEntity toEntity() {
    return ClinicPermissionsEntity(featureSlugs: featureSlugs);
  }
}
