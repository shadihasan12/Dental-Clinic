import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/appointment_entity.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/clinic_doctor_entity.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/create_appointment_params.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/get_appointments_params.dart';

abstract class AppointmentRepository {
  Future<Either<NetworkExceptions, List<AppointmentEntity>>>
      getAllAppointments(GetAppointmentsParams params);

  Future<Either<NetworkExceptions, List<String>>> getAvailableSlots(
    DateTime date,
    int durationMinutes, {
    String? doctorId,
    bool isVip,
  });

  Future<Either<NetworkExceptions, AppointmentEntity>> createAppointment(
    CreateAppointmentParams params,
  );

  Future<Either<NetworkExceptions, AppointmentEntity>> updateAppointmentStatus(
    String id,
    AppointmentStatus status,
  );

  Future<Either<NetworkExceptions, List<ClinicDoctorEntity>>>
      getClinicDoctors();
}
