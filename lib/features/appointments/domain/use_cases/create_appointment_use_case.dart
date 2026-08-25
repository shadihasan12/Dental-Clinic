import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/appointment_entity.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/create_appointment_params.dart';
import 'package:dental_clinic_app/features/appointments/domain/repositories/appointment_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateAppointmentUseCase
    implements UseCase<AppointmentEntity, CreateAppointmentParams> {
  final AppointmentRepository _repository;

  CreateAppointmentUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, AppointmentEntity>> call(
    CreateAppointmentParams params,
  ) {
    return _repository.createAppointment(params);
  }
}
