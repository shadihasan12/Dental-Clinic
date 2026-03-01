import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/specialty_entity.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/location_entity.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/plan_entity.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/register_response_entity.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/user_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';

/// Parameters for requesting OTP
class RequestOtpParams {
  final String email;

  RequestOtpParams({required this.email});

  Map<String, dynamic> toJson() => {'email': email};
}

/// Response from OTP request
class OtpResponse {
  final bool sent;
  final int secondsRemaining;

  OtpResponse({
    required this.sent,
    required this.secondsRemaining,
  });

  factory OtpResponse.fromJson(Map<String, dynamic> json) {
    return OtpResponse(
      sent: json['sent'] ?? true,
      secondsRemaining: json['meta']?['seconds_remaining'] ?? 0,
    );
  }
}

/// Parameters for verifying OTP
class VerifyOtpParams {
  final String email;
  final String otp;

  VerifyOtpParams({
    required this.email,
    required this.otp,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'otp': otp,
      };
}

/// Response from OTP verification
class VerifyOtpResponse {
  final String sessionId;

  VerifyOtpResponse({required this.sessionId});

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponse(
      sessionId: json['meta']?['session'] ?? '',
    );
  }
}

/// Parameters for login request
class LoginParams {
  final String emailOrMobileNumber;
  final String password;

  LoginParams({
    required this.emailOrMobileNumber,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'email_or_mobile_number': emailOrMobileNumber,
        'password': password,
      };
}

/// Result from a successful login
class LoginResult {
  final UserEntity user;
  final List<ClinicMembershipEntity> memberships;

  LoginResult({
    required this.user,
    required this.memberships,
  });
}

/// Parameters for registration request
class RegisterRequestParams {
  final String userName;
  final String mobileNumber;
  final String password;
  final String passwordConfirmation;
  final String specialtyId;
  final String clinicName;
  final String locationId;
  final String detailedAddress;
  final String planVersionId;
  final String sessionId;

  RegisterRequestParams({
    required this.userName,
    required this.mobileNumber,
    required this.password,
    required this.passwordConfirmation,
    required this.specialtyId,
    required this.clinicName,
    required this.locationId,
    required this.detailedAddress,
    required this.planVersionId,
    required this.sessionId,
  });

  /// Convert to JSON request body
  Map<String, dynamic> toJson() {
    return {
      'user': {
        'name': userName,
        'mobile_number': mobileNumber,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'specialty_id': specialtyId,
      },
      'clinic': {
        'name': clinicName,
        'location_id': locationId,
        'detailed_address': detailedAddress,
      },
      'plan_version_id': planVersionId,
      'session_id': sessionId,
    };
  }
}

/// Abstract repository interface for authentication operations
abstract class AuthRepository {
  /// Fetch list of available dental specialties
  Future<Either<NetworkExceptions, List<SpecialtyEntity>>> getSpecialties();

  /// Search for locations by query and country code
  Future<Either<NetworkExceptions, List<LocationEntity>>> searchLocations({
    required String query,
    required String countryCode,
  });

  /// Fetch list of available subscription plans
  Future<Either<NetworkExceptions, List<PlanEntity>>> getPlans();

  /// Request OTP for registration
  Future<Either<NetworkExceptions, OtpResponse>> requestOtpForRegister({
    required RequestOtpParams params,
  });

  /// Verify OTP and get session token
  Future<Either<NetworkExceptions, VerifyOtpResponse>> verifyOtp({
    required VerifyOtpParams params,
  });

  /// Resend OTP (same as request OTP but for resend flow)
  Future<Either<NetworkExceptions, OtpResponse>> resendOtp({
    required RequestOtpParams params,
  });

  /// Register a new user with clinic creation
  Future<Either<NetworkExceptions, RegisterResponseEntity>> register({
    required RegisterRequestParams params,
  });

  /// Login with email or mobile number
  Future<Either<NetworkExceptions, LoginResult>> login({
    required LoginParams params,
  });
}
