import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/appointment_entity.dart';

abstract class AppointmentRepository {
  Future<Either<NetworkExceptions, List<AppointmentEntity>>>
      getAllAppointments();

  Future<Either<NetworkExceptions, AppointmentEntity>> createAppointment(
    AppointmentEntity appointment,
  );
}
