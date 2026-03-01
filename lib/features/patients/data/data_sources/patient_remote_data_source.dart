import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/core/models/paginated_response.dart';
import 'package:dental_clinic_app/features/patients/data/endpoints/patient_endpoints.dart';
import 'package:dental_clinic_app/features/patients/data/models/patient_model.dart';
import 'package:dental_clinic_app/features/patients/data/models/core_treatment.dart';
import 'package:dental_clinic_app/features/patients/data/models/tooth.dart';
import 'package:dental_clinic_app/features/patients/data/models/payment.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/add_treatment_use_case.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

class PatientFullDetailsResponse {
  final PatientModel patient;
  final DentalCase? activeCase;
  final List<DentalCase> completedCases;

  const PatientFullDetailsResponse({
    required this.patient,
    this.activeCase,
    required this.completedCases,
  });
}

abstract class PatientRemoteDataSource {
  Future<PaginatedResponse<PatientModel>> getAllPatients({int page = 1});
  Future<PatientFullDetailsResponse> getPatientFullDetails(String patientId);
  Future<PatientModel> getPatientDetails(String patientId);
  Future<DentalCase?> getActiveCase(String patientId);
  Future<List<DentalCase>> getCompletedCases(String patientId);
  Future<PatientModel> addPatient(PatientModel patient);
  Future<TreatmentItem> addTreatment(AddTreatmentParams params);
  Future<List<Tooth>> getAllTeeth();
  Future<List<CoreTreatment>> getAllCoreTreatments();
  Future<List<TreatmentItem>> getTreatmentPlanItems(
    String patientId,
    String caseId,
  );
  Future<void> markCaseAsFinished(
    String patientId,
    String caseId, {
    String? title,
  });
  Future<List<Payment>> getPayments(String patientId, String caseId);
  Future<void> addPayment(
    String patientId,
    String caseId,
    double amount, {
    String? notes,
  });
}

@LazySingleton(as: PatientRemoteDataSource)
class PatientRemoteDataSourceImpl implements PatientRemoteDataSource {
  final ApiConsumer _apiConsumer;

  PatientRemoteDataSourceImpl(this._apiConsumer);

  @override
  Future<PaginatedResponse<PatientModel>> getAllPatients({
    int page = 1,
  }) async {
    final response = await _apiConsumer.get(
      PatientEndpoints.patients,
      queryParameters: {'page': page},
    );

    final dataList = response['data'] as List;
    final patients = dataList
        .map((e) => PatientModel.fromJson(e as Map<String, dynamic>))
        .toList();

    final pagination =
        response['meta']['pagination'] as Map<String, dynamic>;

    return PaginatedResponse(
      data: patients,
      currentPage: pagination['page'] as int,
      lastPage: pagination['last_page'] as int,
    );
  }

  @override
  Future<PatientFullDetailsResponse> getPatientFullDetails(
    String patientId,
  ) async {
    final response = await _apiConsumer.get(
      PatientEndpoints.patientDetails(patientId),
    );

    final data = response['data'] as Map<String, dynamic>;
    final patient = PatientModel.fromJson(data);
    final patientName = patient.name;

    DentalCase? activeCase;
    if (data['opened_case'] != null) {
      activeCase = DentalCase.fromJson(
        data['opened_case'] as Map<String, dynamic>,
        patientName: patientName,
      );
      final items = await getTreatmentPlanItems(patientId, activeCase.id);
      activeCase = activeCase.copyWith(treatmentItems: items);
    }

    final rawCompletedCases = await getCompletedCases(patientId);
    final completedCases = <DentalCase>[];
    for (final c in rawCompletedCases) {
      final items = await getTreatmentPlanItems(patientId, c.id);
      completedCases.add(
        c.copyWith(patientName: patientName, treatmentItems: items),
      );
    }

    return PatientFullDetailsResponse(
      patient: patient,
      activeCase: activeCase,
      completedCases: completedCases,
    );
  }

  @override
  Future<PatientModel> addPatient(PatientModel patient) async {
    final nameParts = patient.name.split(' ');
    final firstName = nameParts.first;
    final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    final formData = FormData.fromMap({
      'first_name': firstName,
      'last_name': lastName,
      'date_of_birth': patient.dateOfBirth,
      'phone_number': patient.phone,
      'gender': patient.gender,
      if (patient.medicalHistory != null)
        'medical_history_notes': patient.medicalHistory,
      if (patient.allergies != null) 'allergy_notes': patient.allergies,
    });

    final response = await _apiConsumer.post(
      PatientEndpoints.patients,
      formData: formData,
    );

    final data = response['data'] as Map<String, dynamic>;
    return PatientModel.fromJson(data);
  }

  @override
  Future<PatientModel> getPatientDetails(String patientId) async {
    // TODO: Replace with real API call when backend is ready
    // final response = await _apiConsumer.get(
    //   PatientEndpoints.patientDetails(patientId),
    // );
    // return PatientModel.fromJson(response as Map<String, dynamic>);

    await Future.delayed(const Duration(milliseconds: 600));
    return const PatientModel(
      id: '1',
      name: 'Sarah Johnson',
      age: 32,
      gender: 'Female',
      phone: '+963988026431',
      email: 'sarah.j@email.com',
      address: '123 Main St, New York, NY 10001',
      dateOfBirth: '1992-05-15',
      medicalHistory:
          'No known allergies. Previous dental work includes 2 fillings.',
      insuranceProvider: 'Delta Dental',
      insuranceNumber: 'DD-123456789',
      emergencyContact: 'John Johnson - (555) 987-6543',
      status: 'active',
    );
  }

  @override
  Future<DentalCase?> getActiveCase(String patientId) async {
    // TODO: Replace with real API call when backend is ready
    // final response = await _apiConsumer.get(
    //   PatientEndpoints.activeCase(patientId),
    // );
    // if (response == null) return null;
    // return DentalCase.fromJson(response as Map<String, dynamic>);

    await Future.delayed(const Duration(milliseconds: 400));
    return DentalCase(
      id: '1',
      patientId: patientId,
      patientName: 'Sarah Johnson',
      title: 'Root Canal Treatment',
      startDate: DateTime(2024, 11, 1),
      status: 'In Progress',
      totalCost: 1500,
      paidAmount: 1000,
      treatmentItems: [
        TreatmentItem(
          id: '3',
          description: 'Root canal completion and temporary crown',
          treatmentTypes: const [],
          selectedTeeth: const [],
          attachments: const [],
          createdAt: DateTime(2024, 11, 15),
          isDone: false,
        ),
      ],
    );
  }

  @override
  Future<List<DentalCase>> getCompletedCases(String patientId) async {
    final response = await _apiConsumer.get(
      PatientEndpoints.cases(patientId),
      queryParameters: {'filters[status][eq]': 'COMPLETED'},
    );

    final dataList = response['data'] as List;
    return dataList
        .map((e) => DentalCase.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<TreatmentItem> addTreatment(AddTreatmentParams params) async {
    final treatmentPlanItem = {
      'description': params.summary,
      'core_treatment_ids': params.treatmentTypes,
      'tooth_ids': params.selectedTeeth,
    };

    if (params.isInitial) {
      // Create a new case with the first treatment
      final body = {
        'patient_id': params.patientId,
        'total_cost': params.totalCost,
        'lab_fees': params.labFees,
        'treatment_plan_item': treatmentPlanItem,
      };

      final response = await _apiConsumer.post(
        PatientEndpoints.createCase(params.patientId),
        body: body,
      );

      final data = response['data'] as Map<String, dynamic>;
      return TreatmentItem(
        id: data['id'] as String? ?? '',
        description: params.summary,
        treatmentTypes: params.treatmentTypes,
        selectedTeeth: params.selectedTeeth,
        attachments: params.attachments,
        createdAt: DateTime.now(),
      );
    } else {
      // Add treatment to existing case
      final response = await _apiConsumer.post(
        PatientEndpoints.addTreatmentPlanItem(
          params.patientId,
          params.caseId!,
        ),
        body: treatmentPlanItem,
      );

      final data = response['data'] as Map<String, dynamic>;
      return TreatmentItem(
        id: data['id'] as String? ?? '',
        description: params.summary,
        treatmentTypes: params.treatmentTypes,
        selectedTeeth: params.selectedTeeth,
        attachments: params.attachments,
        createdAt: DateTime.now(),
      );
    }
  }

  @override
  Future<List<Tooth>> getAllTeeth() async {
    final response = await _apiConsumer.get(PatientEndpoints.teeth);
    final dataList = response['data'] as List;
    return dataList
        .map((e) => Tooth.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<CoreTreatment>> getAllCoreTreatments() async {
    final response = await _apiConsumer.get(PatientEndpoints.coreTreatments);
    final dataList = response['data'] as List;
    return dataList
        .map((e) => CoreTreatment.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<TreatmentItem>> getTreatmentPlanItems(
    String patientId,
    String caseId,
  ) async {
    final response = await _apiConsumer.get(
      PatientEndpoints.addTreatmentPlanItem(patientId, caseId),
    );

    final dataList = response['data'] as List;
    return dataList.map((e) {
      final item = e as Map<String, dynamic>;
      final coreTreatments = item['core_treatments'] as List? ?? [];
      final teeth = item['teeth'] as List? ?? [];

      return TreatmentItem(
        id: item['id'] as String,
        description: item['description'] as String? ?? '',
        treatmentTypes: coreTreatments
            .map((t) => (t as Map<String, dynamic>)['id'] as String)
            .toList(),
        selectedTeeth: teeth
            .map((t) => (t as Map<String, dynamic>)['id'] as String)
            .toList(),
        createdAt: DateTime.parse(item['created_at'] as String),
      );
    }).toList();
  }

  @override
  Future<void> markCaseAsFinished(
    String patientId,
    String caseId, {
    String? title,
  }) async {
    await _apiConsumer.patch(
      PatientEndpoints.completeCase(patientId, caseId),
      body: {
        if (title != null && title.isNotEmpty) 'title': title,
      },
    );
  }

  @override
  Future<List<Payment>> getPayments(
    String patientId,
    String caseId,
  ) async {
    final response = await _apiConsumer.get(
      PatientEndpoints.payments(patientId, caseId),
    );

    final dataList = response['data'] as List;
    return dataList
        .map((e) => Payment.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> addPayment(
    String patientId,
    String caseId,
    double amount, {
    String? notes,
  }) async {
    await _apiConsumer.post(
      PatientEndpoints.payments(patientId, caseId),
      body: {
        'amount': amount,
        if (notes != null && notes.isNotEmpty) 'notes': notes,
      },
    );
  }
}
