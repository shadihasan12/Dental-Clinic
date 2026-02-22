import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/patients/data/data_sources/patient_remote_data_source.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:dental_clinic_app/features/patients/domain/entities/patient_entity.dart';
import 'package:dental_clinic_app/features/patients/domain/repositories/patient_repository.dart';

class PatientRepositoryImpl implements PatientRepository {
  final PatientRemoteDataSource _remoteDataSource;

  PatientRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<NetworkExceptions, PatientEntity>> getPatientDetails(
    String patientId,
  ) async {
    try {
      final model = await _remoteDataSource.getPatientDetails(patientId);
      return Right(model.toEntity());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, DentalCase?>> getActiveCase(
    String patientId,
  ) async {
    try {
      final dentalCase = await _remoteDataSource.getActiveCase(patientId);
      return Right(dentalCase);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, List<DentalCase>>> getCompletedCases(
    String patientId,
  ) async {
    try {
      final cases = await _remoteDataSource.getCompletedCases(patientId);
      return Right(cases);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }
}
