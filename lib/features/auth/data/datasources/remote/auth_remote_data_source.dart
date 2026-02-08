import 'package:injectable/injectable.dart';
import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/features/auth/data/endpoints/auth_endpoints.dart';
import 'package:dental_clinic_app/features/auth/data/models/specialty_model.dart';
import 'package:dental_clinic_app/features/auth/data/models/location_model.dart';
import 'package:dental_clinic_app/features/auth/data/models/plan_model.dart';
import 'package:dental_clinic_app/features/auth/data/models/register_response_model.dart';

/// Abstract interface for auth remote data source
abstract class AuthRemoteDataSource {
  /// Fetch list of specialties from API
  Future<List<SpecialtyModel>> getSpecialties();

  /// Search locations by query and country code
  Future<List<LocationModel>> searchLocations(String query, String countryCode);

  /// Fetch list of subscription plans
  Future<List<PlanModel>> getPlans();

  /// Register new user with clinic
  Future<RegisterResponseModel> register(Map<String, dynamic> body);
}

/// Implementation of auth remote data source using API consumer
@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiConsumer _apiConsumer;

  AuthRemoteDataSourceImpl(this._apiConsumer);

  @override
  Future<List<SpecialtyModel>> getSpecialties() async {
    final response = await _apiConsumer.get(AuthEndpoints.specialties);

    // Extract data array from response
    final data = response['data'] as List;

    // Map each JSON object to SpecialtyModel
    return data
        .map((json) => SpecialtyModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<LocationModel>> searchLocations(
    String query,
    String countryCode,
  ) async {
    final response = await _apiConsumer.get(
      AuthEndpoints.locationSearch,
      queryParameters: {
        'query': query,
        'country_code': countryCode,
      },
    );

    // Extract data array from response
    final data = response['data'] as List;

    // Map each JSON object to LocationModel
    return data
        .map((json) => LocationModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<PlanModel>> getPlans() async {
    final response = await _apiConsumer.get(AuthEndpoints.plans);

    // Extract data array from response
    final data = response['data'] as List;

    // Map each JSON object to PlanModel
    return data
        .map((json) => PlanModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<RegisterResponseModel> register(Map<String, dynamic> body) async {
    final response = await _apiConsumer.post(
      AuthEndpoints.register,
      body: body,
    );

    // Extract data object from response
    final data = response['data'] as Map<String, dynamic>;

    // Map JSON to RegisterResponseModel
    return RegisterResponseModel.fromJson(data);
  }
}
