import 'package:injectable/injectable.dart';
import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/core/storage/token_storage.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/features/auth/data/endpoints/auth_endpoints.dart';
import 'package:dental_clinic_app/features/auth/data/models/specialty_model.dart';
import 'package:dental_clinic_app/features/auth/data/models/location_model.dart';
import 'package:dental_clinic_app/features/auth/data/models/plan_model.dart';
import 'package:dental_clinic_app/features/auth/data/models/login_response_model.dart';
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

  /// Login with email or mobile number
  Future<LoginResponseModel> login(Map<String, dynamic> body);

  /// Request OTP for email verification (requires auth token)
  Future<OtpResponse> requestOtpForVerifyEmail();

  /// Verify email with OTP (requires auth token)
  Future<void> verifyEmailWithOtp(String otp);

  /// Request OTP for password reset
  Future<OtpResponse> requestOtpForResetPassword(Map<String, dynamic> body);

  /// Reset password with session ID
  Future<void> resetPassword(Map<String, dynamic> body);
}

/// Implementation of auth remote data source using API consumer
@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiConsumer _apiConsumer;
  final TokenStorage _tokenStorage;
  final UserStorage _userStorage;

  AuthRemoteDataSourceImpl(this._apiConsumer, this._tokenStorage, this._userStorage);

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

    // Token is extracted from Authorization response header by AuthInterceptor

    // Extract data object from response
    final data = response['data'] as Map<String, dynamic>?;
    if (data == null) {
      throw Exception('Registration failed: Invalid response data');
    }

    // Save refresh token if present in response body
    await _saveRefreshTokenFromResponse(response, data);

    // Save user ID for later use
    final userId = data['id'] as String?;
    if (userId != null && userId.isNotEmpty) {
      await _tokenStorage.saveUserId(userId);
    }

    // Cache user data
    await _cacheUserData(data);

    // Save first clinic ID for X-Selected-Clinic-id header
    final clinics = data['clinics'] as List?;
    if (clinics != null && clinics.isNotEmpty) {
      final clinic = clinics[0]['clinic'] as Map<String, dynamic>?;
      final clinicId = clinic?['id'] as String?;
      if (clinicId != null && clinicId.isNotEmpty) {
        await _tokenStorage.saveClinicId(clinicId);
      }
    }

    // Map JSON to RegisterResponseModel
    return RegisterResponseModel.fromJson(data);
  }

  @override
  Future<LoginResponseModel> login(Map<String, dynamic> body) async {
    final response = await _apiConsumer.post(
      AuthEndpoints.login,
      body: body,
    );

    // Token is extracted from Authorization response header by AuthInterceptor

    // Extract data object from response
    final data = response['data'] as Map<String, dynamic>?;
    if (data == null) {
      throw Exception('Login failed: Invalid response data');
    }

    // Save refresh token if present in response body
    await _saveRefreshTokenFromResponse(response, data);

    // Save user ID for later use
    final userId = data['id'] as String?;
    if (userId != null && userId.isNotEmpty) {
      await _tokenStorage.saveUserId(userId);
    }

    // Cache user data
    await _cacheUserData(data);

    // Save first clinic ID for X-Selected-Clinic-id header
    final clinics = data['clinics'] as List?;
    if (clinics != null && clinics.isNotEmpty) {
      final clinic = clinics[0]['clinic'] as Map<String, dynamic>?;
      final clinicId = clinic?['id'] as String?;
      if (clinicId != null && clinicId.isNotEmpty) {
        await _tokenStorage.saveClinicId(clinicId);
      }
    }

    return LoginResponseModel.fromJson(data);
  }

  Future<void> _saveRefreshTokenFromResponse(
      dynamic response, Map<String, dynamic> data) async {
    final refreshToken = (response is Map ? response['refresh_token'] : null)
            as String? ??
        data['refresh_token'] as String?;
    if (refreshToken != null && refreshToken.isNotEmpty) {
      await _tokenStorage.saveRefreshToken(refreshToken);
    }
  }

  Future<void> _cacheUserData(Map<String, dynamic> data) async {
    final firstName = data['first_name'] as String? ?? '';
    final lastName = data['last_name'] as String? ?? '';
    if (firstName.isNotEmpty) {
      await _userStorage.saveFirstName(firstName);
    }
    if (lastName.isNotEmpty) {
      await _userStorage.saveLastName(lastName);
    }
    final userName = '$firstName $lastName'.trim();
    if (userName.isNotEmpty) {
      await _userStorage.saveUserName(userName);
    }
    final email = data['email'] as String?;
    if (email != null && email.isNotEmpty) {
      await _userStorage.saveUserEmail(email);
    }
    final clinics = data['clinics'] as List?;
    if (clinics != null && clinics.isNotEmpty) {
      final clinic = clinics[0]['clinic'] as Map<String, dynamic>?;
      if (clinic != null) {
        final clinicName = clinic['name'] as String?;
        if (clinicName != null && clinicName.isNotEmpty) {
          await _userStorage.saveClinicName(clinicName);
        }
        final detailedAddress = clinic['detailed_address'] as String?;
        if (detailedAddress != null) {
          await _userStorage.saveDetailedAddress(detailedAddress);
        }
        final location = clinic['location'] as Map<String, dynamic>?;
        if (location != null) {
          final locationId = location['id'] as String?;
          if (locationId != null && locationId.isNotEmpty) {
            await _userStorage.saveLocationId(locationId);
          }
          final locationName = location['name'] as String?;
          if (locationName != null && locationName.isNotEmpty) {
            await _userStorage.saveLocationName(locationName);
          }
          final locationFullName = location['full_name'] as String?;
          if (locationFullName != null && locationFullName.isNotEmpty) {
            await _userStorage.saveLocationFullName(locationFullName);
          }
        }
      }
    }
  }

  @override
  Future<void> verifyEmailWithOtp(String otp) async {
    await _apiConsumer.post(
      AuthEndpoints.verifyEmail,
      body: {'otp': otp},
    );
  }

  @override
  Future<OtpResponse> requestOtpForVerifyEmail() async {
    final response = await _apiConsumer.post(
      AuthEndpoints.verifyEmailRequestOtp,
      body: {},
    );
    return OtpResponse.fromJson(response);
  }

  @override
  Future<OtpResponse> requestOtpForResetPassword(Map<String, dynamic> body) async {
    final response = await _apiConsumer.post(
      AuthEndpoints.requestOtpForResetPassword,
      body: body,
    );
    return OtpResponse.fromJson(response);
  }

  @override
  Future<void> resetPassword(Map<String, dynamic> body) async {
    await _apiConsumer.post(
      AuthEndpoints.resetPassword,
      body: body,
    );
  }
}
