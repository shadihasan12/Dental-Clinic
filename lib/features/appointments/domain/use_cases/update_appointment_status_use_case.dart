import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/appointment_entity.dart';
import 'package:dental_clinic_app/features/appointments/domain/repositories/appointment_repository.dart';
import 'package:injectable/injectable.dart';

class UpdateAppointmentStatusParams {
  final String id;
  final AppointmentStatus status;

  const UpdateAppointmentStatusParams({
    required this.id,
    required this.status,
  });
}

@injectable
class UpdateAppointmentStatusUseCase
    implements
        UseCase<AppointmentEntity, UpdateAppointmentStatusParams> {
  final AppointmentRepository _repository;

  UpdateAppointmentStatusUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, AppointmentEntity>> call(
    UpdateAppointmentStatusParams params,
  ) {
    return _repository.updateAppointmentStatus(params.id, params.status);
  }
}
