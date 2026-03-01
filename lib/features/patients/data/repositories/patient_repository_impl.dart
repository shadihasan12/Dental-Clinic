import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/patients/data/data_sources/patient_remote_data_source.dart';
import 'package:dental_clinic_app/features/patients/data/models/patient_model.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:dental_clinic_app/features/patients/domain/entities/patient_entity.dart';
import 'package:dental_clinic_app/features/patients/domain/repositories/patient_repository.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/add_treatment_use_case.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PatientRepository)
class PatientRepositoryImpl implements PatientRepository {
  final PatientRemoteDataSource _remoteDataSource;

  PatientRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<NetworkExceptions, List<PatientEntity>>> getAllPatients() async {
    try {
      final models = await _remoteDataSource.getAllPatients();
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

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

  @override
  Future<Either<NetworkExceptions, PatientEntity>> addPatient(
    PatientEntity patient,
  ) async {
    try {
      final model = PatientModel.fromEntity(patient);
      final result = await _remoteDataSource.addPatient(model);
      return Right(result.toEntity());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, TreatmentItem>> addTreatment(
    AddTreatmentParams params,
  ) async {
    try {
      final treatment = TreatmentItem(
        id: '',
        description: params.summary,
        treatmentTypes: params.treatmentTypes,
        selectedTeeth: params.selectedTeeth,
        attachments: params.attachments,
        createdAt: params.visitDate,
        isDone: false,
      );
      final result = await _remoteDataSource.addTreatment(
        patientId: params.patientId,
        treatment: treatment,
      );
      return Right(result);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }
}
