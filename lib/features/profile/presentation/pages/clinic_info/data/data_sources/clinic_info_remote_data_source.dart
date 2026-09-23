import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/features/auth/data/models/location_model.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_type.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/data/endpoints/clinic_info_endpoints.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/data/models/clinic_info_model.dart';
import 'package:injectable/injectable.dart';

abstract class ClinicInfoRemoteDataSource {
  Future<ClinicInfoModel> getClinicInfo();
  Future<void> updateClinicInfo({
    required String name,
    required String locationId,
    required String locationName,
    required String locationFullName,
    required String detailedAddress,
    ClinicType? type,
  });
  Future<List<LocationModel>> searchLocations(String query, String countryCode);
}

@Injectable(as: ClinicInfoRemoteDataSource)
class ClinicInfoRemoteDataSourceImpl implements ClinicInfoRemoteDataSource {
  final ApiConsumer _apiConsumer;
  final UserStorage _userStorage;

  ClinicInfoRemoteDataSourceImpl(this._apiConsumer, this._userStorage);

  /// The cached name and location, plus the clinic's type from
  /// `GET /clinics`. The cache is what this page has always shown; the type
  /// only lives on the server, and a failure to read it leaves it unset
  /// rather than failing the whole page.
  @override
  Future<ClinicInfoModel> getClinicInfo() async {
    ClinicType? type;
    String id = '';
    try {
      final response = await _apiConsumer.get(ClinicInfoEndpoints.clinic);
      final data = response['data'];
      if (data is Map) {
        type = ClinicType.fromApi(data['type'] as String?);
        id = (data['id'] ?? '').toString();
      }
    } catch (_) {}

    return ClinicInfoModel(
      id: id,
      type: type,
      name: _userStorage.getClinicName() ?? '',
      locationId: _userStorage.getLocationId() ?? '',
      locationName: _userStorage.getLocationName() ?? '',
      locationFullName: _userStorage.getLocationFullName() ?? '',
      address: _userStorage.getDetailedAddress() ?? '',
      workingDays: const [],
      holidays: const [],
    );
  }

  @override
  Future<void> updateClinicInfo({
    required String name,
    required String locationId,
    required String locationName,
    required String locationFullName,
    required String detailedAddress,
    ClinicType? type,
  }) async {
    await _apiConsumer.put(
      ClinicInfoEndpoints.clinic,
      body: {
        'name': name,
        'location_id': locationId,
        'detailed_address': detailedAddress,
        // Optional on update: left out, it stays as it was.
        if (type != null) 'type': type.apiValue,
      },
    );

    // Update cache after successful save
    await _userStorage.saveClinicName(name);
    await _userStorage.saveLocationId(locationId);
    await _userStorage.saveLocationName(locationName);
    await _userStorage.saveLocationFullName(locationFullName);
    await _userStorage.saveDetailedAddress(detailedAddress);
  }

  @override
  Future<List<LocationModel>> searchLocations(
    String query,
    String countryCode,
  ) async {
    final response = await _apiConsumer.get(
      '/locations/search',
      queryParameters: {'query': query, 'country_code': countryCode},
    );
    final data = response['data'] as List;
    return data
        .map((e) => LocationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
