import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:dental_clinic_app/features/patients/domain/entities/patient_entity.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/add_treatment_use_case.dart';

abstract class PatientRepository {
  Future<Either<NetworkExceptions, List<PatientEntity>>> getAllPatients();

  Future<Either<NetworkExceptions, PatientEntity>> getPatientDetails(
    String patientId,
  );

  Future<Either<NetworkExceptions, DentalCase?>> getActiveCase(
    String patientId,
  );

  Future<Either<NetworkExceptions, List<DentalCase>>> getCompletedCases(
    String patientId,
  );

  Future<Either<NetworkExceptions, PatientEntity>> addPatient(
    PatientEntity patient,
  );

  Future<Either<NetworkExceptions, TreatmentItem>> addTreatment(
    AddTreatmentParams params,
  );
}
