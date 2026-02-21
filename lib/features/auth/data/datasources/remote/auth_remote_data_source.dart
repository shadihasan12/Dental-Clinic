import 'package:injectable/injectable.dart';
import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/core/storage/token_storage.dart';
import 'package:dental_clinic_app/features/auth/data/endpoints/auth_endpoints.dart';
import 'package:dental_clinic_app/features/auth/data/models/specialty_model.dart';
import 'package:dental_clinic_app/features/auth/data/models/location_model.dart';
import 'package:dental_clinic_app/features/auth/data/models/plan_model.dart';
import 'package:dental_clinic_app/features/auth/data/models/register_response_model.dart';
import 'package:dental_clinic_app/features/auth/domain/repositories/auth_repository.dart';

/// Abstract interface for auth remote data source
abstract class AuthRemoteDataSource {
  /// Fetch list of specialties from API
  Future<List<SpecialtyModel>> getSpecialties();

  /// Search locations by query and country code
  Future<List<LocationModel>> searchLocations(String query, String countryCode);

  /// Fetch list of subscription plans
  Future<List<PlanModel>> getPlans();

  /// Request OTP for registration
  Future<OtpResponse> requestOtpForRegister(Map<String, dynamic> body);

  /// Verify OTP and get session token
  Future<VerifyOtpResponse> verifyOtp(Map<String, dynamic> body);

  /// Resend OTP
  Future<OtpResponse> resendOtp(Map<String, dynamic> body);

  /// Register new user with clinic
  Future<RegisterResponseModel> register(Map<String, dynamic> body);
}

/// Implementation of auth remote data source using API consumer
@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiConsumer _apiConsumer;
  final TokenStorage _tokenStorage;

  AuthRemoteDataSourceImpl(this._apiConsumer, this._tokenStorage);

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
  Future<OtpResponse> requestOtpForRegister(Map<String, dynamic> body) async {
    final response = await _apiConsumer.post(
      AuthEndpoints.requestOtpForRegister,
      body: body,
    );

    // Return OTP response with seconds remaining
    return OtpResponse.fromJson(response);
  }

  @override
  Future<VerifyOtpResponse> verifyOtp(Map<String, dynamic> body) async {
    final response = await _apiConsumer.post(
      AuthEndpoints.verifyOtp,
      body: body,
    );

    // Return verify OTP response with session token
    return VerifyOtpResponse.fromJson(response);
  }

  @override
  Future<OtpResponse> resendOtp(Map<String, dynamic> body) async {
    // Resend uses the same endpoint as request OTP
    final response = await _apiConsumer.post(
      AuthEndpoints.requestOtpForRegister,
      body: body,
    );

    // Return OTP response with seconds remaining
    return OtpResponse.fromJson(response);
  }

  @override
  Future<RegisterResponseModel> register(Map<String, dynamic> body) async {
    final response = await _apiConsumer.post(
      AuthEndpoints.register,
      body: body,
    );

    // Extract and save token from response root level
    final token = response['token'] as String?;
    if (token != null && token.isNotEmpty) {
      await _tokenStorage.saveToken(token);
    }

    // Extract data object from response
    final data = response['data'] as Map<String, dynamic>?;
    if (data == null) {
      throw Exception('Registration failed: Invalid response data');
    }

    // Save user ID for later use
    final userId = data['id'] as String?;
    if (userId != null && userId.isNotEmpty) {
      await _tokenStorage.saveUserId(userId);
    }

    // Map JSON to RegisterResponseModel
    return RegisterResponseModel.fromJson(data);
  }
}
