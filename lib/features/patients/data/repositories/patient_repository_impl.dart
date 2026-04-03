import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/models/paginated_response.dart';
import 'package:dental_clinic_app/features/patients/data/data_sources/patient_remote_data_source.dart';
import 'package:dental_clinic_app/features/patients/data/models/patient_model.dart';
import 'package:dental_clinic_app/features/patients/data/models/core_treatment.dart';
import 'package:dental_clinic_app/features/patients/data/models/payment.dart';
import 'package:dental_clinic_app/features/patients/data/models/tooth.dart';
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
  Future<Either<NetworkExceptions, PaginatedResponse<PatientEntity>>>
      getAllPatients({int page = 1}) async {
    try {
      final result = await _remoteDataSource.getAllPatients(page: page);
      return Right(PaginatedResponse(
        data: result.data.map((m) => m.toEntity()).toList(),
        currentPage: result.currentPage,
        lastPage: result.lastPage,
      ));
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, PatientFullDetailsResult>>
      getPatientFullDetails(String patientId) async {
    try {
      final result =
          await _remoteDataSource.getPatientFullDetails(patientId);
      return Right(PatientFullDetailsResult(
        patient: result.patient.toEntity(),
        activeCase: result.activeCase,
        completedCases: result.completedCases,
      ));
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
      final result = await _remoteDataSource.addTreatment(params);
      return Right(result);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, List<Tooth>>> getAllTeeth() async {
    try {
      final teeth = await _remoteDataSource.getAllTeeth();
      return Right(teeth);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, List<CoreTreatment>>>
      getAllCoreTreatments() async {
    try {
      final treatments = await _remoteDataSource.getAllCoreTreatments();
      return Right(treatments);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, void>> markCaseAsFinished(
    String patientId,
    String caseId, {
    String? title,
  }) async {
    try {
      await _remoteDataSource.markCaseAsFinished(
        patientId,
        caseId,
        title: title,
      );
      return const Right(null);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, void>> updateTreatmentPlanItem({
    required String patientId,
    required String caseId,
    required String itemId,
    String? description,
    required List<Map<String, String>> notes,
  }) async {
    try {
      await _remoteDataSource.updateTreatmentPlanItem(
        patientId: patientId,
        caseId: caseId,
        itemId: itemId,
        description: description,
        notes: notes,
      );
      return const Right(null);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, void>> deleteTreatmentPlanItem({
    required String patientId,
    required String caseId,
    required String itemId,
  }) async {
    try {
      await _remoteDataSource.deleteTreatmentPlanItem(
        patientId: patientId,
        caseId: caseId,
        itemId: itemId,
      );
      return const Right(null);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, void>> toggleTreatmentPlanItemStatus({
    required String patientId,
    required String caseId,
    required String itemId,
  }) async {
    try {
      await _remoteDataSource.toggleTreatmentPlanItemStatus(
        patientId: patientId,
        caseId: caseId,
        itemId: itemId,
      );
      return const Right(null);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, List<Payment>>> getPayments(
    String patientId,
    String caseId,
  ) async {
    try {
      final payments =
          await _remoteDataSource.getPayments(patientId, caseId);
      return Right(payments);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, void>> addPayment(
    String patientId,
    String caseId,
    double amount, {
    required String currencyId,
    required String caseCurrencyId,
    required double amountInCaseCurrency,
    required double exchangeRate,
    String? notes,
  }) async {
    try {
      await _remoteDataSource.addPayment(
        patientId,
        caseId,
        amount,
        currencyId: currencyId,
        caseCurrencyId: caseCurrencyId,
        amountInCaseCurrency: amountInCaseCurrency,
        exchangeRate: exchangeRate,
        notes: notes,
      );
      return const Right(null);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, void>> updateCaseCosts({
    required String patientId,
    required String caseId,
    required double totalCost,
    String? totalCostCurrencyId,
    required double labFees,
    String? labFeesCurrencyId,
  }) async {
    try {
      await _remoteDataSource.updateCaseCosts(
        patientId: patientId,
        caseId: caseId,
        totalCost: totalCost,
        totalCostCurrencyId: totalCostCurrencyId,
        labFees: labFees,
        labFeesCurrencyId: labFeesCurrencyId,
      );
      return const Right(null);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, void>> updateCaseTitle({
    required String patientId,
    required String caseId,
    required String? title,
  }) async {
    try {
      await _remoteDataSource.updateCaseTitle(
        patientId: patientId,
        caseId: caseId,
        title: title,
      );
      return const Right(null);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, void>> reactivateCase({
    required String patientId,
    required String caseId,
  }) async {
    try {
      await _remoteDataSource.reactivateCase(
        patientId: patientId,
        caseId: caseId,
      );
      return const Right(null);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }
}
