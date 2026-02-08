import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/specialty_entity.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/location_entity.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/plan_entity.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/register_response_entity.dart';

/// Parameters for registration request
class RegisterRequestParams {
  final String userName;
  final String userEmail;
  final String mobileNumber;
  final String password;
  final String passwordConfirmation;
  final String specialtyId;
  final String clinicName;
  final String locationId;
  final String detailedAddress;
  final String planVersionId;

  RegisterRequestParams({
    required this.userName,
    required this.userEmail,
    required this.mobileNumber,
    required this.password,
    required this.passwordConfirmation,
    required this.specialtyId,
    required this.clinicName,
    required this.locationId,
    required this.detailedAddress,
    required this.planVersionId,
  });

  /// Convert to JSON request body
  Map<String, dynamic> toJson() {
    return {
      'user': {
        'name': userName,
        'email': userEmail,
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

  /// Register a new user with clinic creation
  Future<Either<NetworkExceptions, RegisterResponseEntity>> register({
    required RegisterRequestParams params,
  });
}
