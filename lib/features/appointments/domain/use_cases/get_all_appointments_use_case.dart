import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/appointment_entity.dart';
import 'package:dental_clinic_app/features/appointments/domain/repositories/appointment_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllAppointmentsUseCase
    implements UseCase<List<AppointmentEntity>, NoParams> {
  final AppointmentRepository _repository;

  GetAllAppointmentsUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, List<AppointmentEntity>>> call(
    NoParams params,
  ) {
    return _repository.getAllAppointments();
  }
}
