import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/features/patients/data/models/patient_model.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';

abstract class PatientRemoteDataSource {
  Future<PatientModel> getPatientDetails(String patientId);
  Future<DentalCase?> getActiveCase(String patientId);
  Future<List<DentalCase>> getCompletedCases(String patientId);
}

class PatientRemoteDataSourceImpl implements PatientRemoteDataSource {
  // ignore: unused_field
  final ApiConsumer _apiConsumer;

  PatientRemoteDataSourceImpl(this._apiConsumer);

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
          treatmentTypes: [TreatmentType.rootCanal, TreatmentType.crown],
          selectedTeeth: const [14],
          attachments: const [],
          createdAt: DateTime(2024, 11, 15),
          isDone: false,
        ),
      ],
    );
  }

  @override
  Future<List<DentalCase>> getCompletedCases(String patientId) async {
    // TODO: Replace with real API call when backend is ready
    // final response = await _apiConsumer.get(
    //   PatientEndpoints.completedCases(patientId),
    // );
    // return (response as List)
    //     .map((e) => DentalCase.fromJson(e as Map<String, dynamic>))
    //     .toList();

    await Future.delayed(const Duration(milliseconds: 400));
    return [
      DentalCase(
        id: '2',
        patientId: patientId,
        patientName: 'Sarah Johnson',
        title: 'Teeth Cleaning',
        startDate: DateTime(2024, 8, 15),
        endDate: DateTime(2024, 8, 15),
        status: 'Completed',
        totalCost: 200,
        paidAmount: 200,
        treatmentItems: [
          TreatmentItem(
            id: '10',
            description: 'Full teeth cleaning and polishing',
            treatmentTypes: const [TreatmentType.cleaning],
            selectedTeeth: const [],
            attachments: const [],
            createdAt: DateTime(2024, 8, 15),
            completedAt: DateTime(2024, 8, 15),
            isDone: true,
          ),
        ],
      ),
      DentalCase(
        id: '3',
        patientId: patientId,
        patientName: 'Sarah Johnson',
        title: 'Cavity Filling',
        startDate: DateTime(2024, 6, 10),
        endDate: DateTime(2024, 6, 20),
        status: 'Completed',
        totalCost: 350,
        paidAmount: 350,
        treatmentItems: [
          TreatmentItem(
            id: '20',
            description: 'Initial examination',
            treatmentTypes: const [TreatmentType.consultation],
            selectedTeeth: const [18, 19],
            attachments: const [],
            createdAt: DateTime(2024, 6, 10),
            completedAt: DateTime(2024, 6, 10),
            isDone: true,
          ),
          TreatmentItem(
            id: '21',
            description: 'Filling procedure',
            treatmentTypes: const [TreatmentType.filling],
            selectedTeeth: const [18, 19],
            attachments: const [],
            createdAt: DateTime(2024, 6, 20),
            completedAt: DateTime(2024, 6, 20),
            isDone: true,
          ),
        ],
      ),
    ];
  }
}
