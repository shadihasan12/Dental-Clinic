import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_user_entity.dart';

abstract class ClinicRepository {
  Future<Either<NetworkExceptions, List<ClinicMembershipEntity>>> getMyClinics();

  Future<Either<NetworkExceptions, List<ClinicUserEntity>>> getClinicUsers(
      String clinicId);

  Future<Either<NetworkExceptions, ClinicUserEntity>> addClinicUser({
    required String clinicId,
    required String firstName,
    required String lastName,
    required String email,
    required String mobileNumber,
    required String password,
    required String passwordConfirmation,
    required List<String> roles,
    String? specialtyId,
  });

  Future<Either<NetworkExceptions, void>> updateUserRoles({
    required String clinicId,
    required String userId,
    required List<String> roles,
  });

  Future<Either<NetworkExceptions, void>> removeClinicUser({
    required String clinicId,
    required String userId,
  });
}
