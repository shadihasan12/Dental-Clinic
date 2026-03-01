import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/models/paginated_response.dart';
import 'package:dental_clinic_app/features/patients/data/models/core_treatment.dart';
import 'package:dental_clinic_app/features/patients/data/models/payment.dart';
import 'package:dental_clinic_app/features/patients/data/models/tooth.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:dental_clinic_app/features/patients/domain/entities/patient_entity.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/add_treatment_use_case.dart';

class PatientFullDetailsResult {
  final PatientEntity patient;
  final DentalCase? activeCase;
  final List<DentalCase> completedCases;

  const PatientFullDetailsResult({
    required this.patient,
    this.activeCase,
    required this.completedCases,
  });
}

abstract class PatientRepository {
  Future<Either<NetworkExceptions, PaginatedResponse<PatientEntity>>>
      getAllPatients({int page = 1});

  Future<Either<NetworkExceptions, PatientFullDetailsResult>>
      getPatientFullDetails(String patientId);

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

  Future<Either<NetworkExceptions, List<Tooth>>> getAllTeeth();

  Future<Either<NetworkExceptions, List<CoreTreatment>>> getAllCoreTreatments();

  Future<Either<NetworkExceptions, void>> markCaseAsFinished(
    String patientId,
    String caseId, {
    String? title,
  });

  Future<Either<NetworkExceptions, List<Payment>>> getPayments(
    String patientId,
    String caseId,
  );

  Future<Either<NetworkExceptions, void>> addPayment(
    String patientId,
    String caseId,
    double amount, {
    String? notes,
  });
}
