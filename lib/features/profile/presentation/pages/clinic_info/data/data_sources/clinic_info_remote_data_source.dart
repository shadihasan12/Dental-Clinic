import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/features/auth/data/models/location_model.dart';
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
  });
  Future<List<LocationModel>> searchLocations(String query, String countryCode);
}

@Injectable(as: ClinicInfoRemoteDataSource)
class ClinicInfoRemoteDataSourceImpl implements ClinicInfoRemoteDataSource {
  final ApiConsumer _apiConsumer;
  final UserStorage _userStorage;

  ClinicInfoRemoteDataSourceImpl(this._apiConsumer, this._userStorage);

  @override
  Future<ClinicInfoModel> getClinicInfo() async {
    return ClinicInfoModel(
      id: '',
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
  }) async {
    await _apiConsumer.put(
      ClinicInfoEndpoints.updateClinic,
      body: {
        'name': name,
        'location_id': locationId,
        'detailed_address': detailedAddress,
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
      queryParameters: {
        'query': query,
        'country_code': countryCode,
      },
    );
    final data = response['data'] as List;
    return data
        .map((e) => LocationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
