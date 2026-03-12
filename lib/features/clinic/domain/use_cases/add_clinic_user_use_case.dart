import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_user_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/repositories/clinic_repository.dart';
import 'package:injectable/injectable.dart';

class AddClinicUserParams {
  final String clinicId;
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;
  final String password;
  final String passwordConfirmation;
  final List<String> roles;
  final String? specialtyId;

  const AddClinicUserParams({
    required this.clinicId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNumber,
    required this.password,
    required this.passwordConfirmation,
    required this.roles,
    this.specialtyId,
  });
}

@injectable
class AddClinicUserUseCase {
  final ClinicRepository _repository;
  AddClinicUserUseCase(this._repository);

  Future<Either<NetworkExceptions, ClinicUserEntity>> call(
      AddClinicUserParams params) {
    return _repository.addClinicUser(
      clinicId: params.clinicId,
      firstName: params.firstName,
      lastName: params.lastName,
      email: params.email,
      mobileNumber: params.mobileNumber,
      password: params.password,
      passwordConfirmation: params.passwordConfirmation,
      roles: params.roles,
      specialtyId: params.specialtyId,
    );
  }
}
