import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/clinic_doctor_entity.dart';
import 'package:dental_clinic_app/features/appointments/domain/repositories/appointment_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetClinicDoctorsUseCase
    implements UseCase<List<ClinicDoctorEntity>, NoParams> {
  final AppointmentRepository _repository;

  GetClinicDoctorsUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, List<ClinicDoctorEntity>>> call(
    NoParams params,
  ) {
    return _repository.getClinicDoctors();
  }
}
