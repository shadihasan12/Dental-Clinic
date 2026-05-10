import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/appointments/data/data_sources/appointment_remote_data_source.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/appointment_entity.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/clinic_doctor_entity.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/create_appointment_params.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/get_appointments_params.dart';
import 'package:dental_clinic_app/features/appointments/domain/repositories/appointment_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AppointmentRepository)
class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentRemoteDataSource _remoteDataSource;

  AppointmentRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<NetworkExceptions, List<AppointmentEntity>>>
      getAllAppointments(GetAppointmentsParams params) async {
    try {
      final models = await _remoteDataSource.getAllAppointments(params);
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, List<String>>> getAvailableSlots(
    DateTime date,
    int durationMinutes, {
    String? doctorId,
    bool isVip = false,
  }) async {
    try {
      final slots = await _remoteDataSource.getAvailableSlots(
        date,
        durationMinutes,
        doctorId: doctorId,
        isVip: isVip,
      );
      return Right(slots);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, List<ClinicDoctorEntity>>>
      getClinicDoctors() async {
    try {
      final models = await _remoteDataSource.getClinicDoctors();
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, AppointmentEntity>> createAppointment(
    CreateAppointmentParams params,
  ) async {
    try {
      final model = await _remoteDataSource.createAppointment(params);
      return Right(model.toEntity());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, AppointmentEntity>> updateAppointmentStatus(
    String id,
    AppointmentStatus status,
  ) async {
    try {
      final model = await _remoteDataSource.updateStatus(id, status);
      return Right(model.toEntity());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }
}
