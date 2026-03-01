import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/features/patients/data/models/patient_model.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:injectable/injectable.dart';

abstract class PatientRemoteDataSource {
  Future<List<PatientModel>> getAllPatients();
  Future<PatientModel> getPatientDetails(String patientId);
  Future<DentalCase?> getActiveCase(String patientId);
  Future<List<DentalCase>> getCompletedCases(String patientId);
  Future<PatientModel> addPatient(PatientModel patient);
  Future<TreatmentItem> addTreatment({
    required String patientId,
    required TreatmentItem treatment,
  });
}

@LazySingleton(as: PatientRemoteDataSource)
class PatientRemoteDataSourceImpl implements PatientRemoteDataSource {
  // ignore: unused_field
  final ApiConsumer _apiConsumer;

  PatientRemoteDataSourceImpl(this._apiConsumer);

  List<PatientModel>? _cachedPatients;

  List<PatientModel> _getMockPatients() => [
        const PatientModel(
          id: '1',
          name: 'اسماعيل الشوفي',
          age: 32,
          gender: 'Male',
          phone: '(555) 123-4567',
          email: 'ismail@email.com',
          address: 'Damascus, Syria',
          dateOfBirth: '1992-05-15',
          nextVisit: '12/28/2024',
          balance: 0,
        ),
        const PatientModel(
          id: '2',
          name: 'وسام إلياس',
          age: 45,
          gender: 'Male',
          phone: '(555) 234-5678',
          email: 'wissam@email.com',
          address: 'Aleppo, Syria',
          dateOfBirth: '1979-03-22',
          nextVisit: '12/22/2024',
          balance: 250,
        ),
        const PatientModel(
          id: '3',
          name: 'سركيس شلهوب',
          age: 28,
          gender: 'Male',
          phone: '(555) 345-6789',
          email: 'sarkis@email.com',
          address: 'Latakia, Syria',
          dateOfBirth: '1996-11-08',
          balance: 0,
        ),
        const PatientModel(
          id: '4',
          name: 'شادي حسن',
          age: 56,
          gender: 'Male',
          phone: '(555) 456-7890',
          email: 'shadi@email.com',
          address: 'Homs, Syria',
          dateOfBirth: '1968-07-14',
          balance: 180,
        ),
        const PatientModel(
          id: '5',
          name: 'جميل عامر',
          age: 39,
          gender: 'Male',
          phone: '(555) 567-8901',
          email: 'jamil@email.com',
          address: 'Damascus, Syria',
          dateOfBirth: '1985-01-30',
          nextVisit: '01/05/2025',
          balance: 0,
        ),
        const PatientModel(
          id: '6',
          name: 'عمران المتني',
          age: 62,
          gender: 'Male',
          phone: '(555) 678-9012',
          email: 'omran@email.com',
          address: 'Tartus, Syria',
          dateOfBirth: '1962-09-03',
          nextVisit: '01/10/2025',
          balance: 320,
        ),
      ];

  @override
  Future<List<PatientModel>> getAllPatients() async {
    // TODO: Replace with real API call when backend is ready
    // final response = await _apiConsumer.get(PatientEndpoints.patients);
    // return (response as List)
    //     .map((e) => PatientModel.fromJson(e as Map<String, dynamic>))
    //     .toList();

    await Future.delayed(const Duration(milliseconds: 3000));
    _cachedPatients ??= _getMockPatients();
    return _cachedPatients!;
  }

  @override
  Future<PatientModel> addPatient(PatientModel patient) async {
    // TODO: Replace with real API call when backend is ready
    // final response = await _apiConsumer.post(
    //   PatientEndpoints.patients,
    //   body: patient.toJson(),
    // );
    // return PatientModel.fromJson(response as Map<String, dynamic>);

    await Future.delayed(const Duration(milliseconds: 800));
    final newPatient = PatientModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: patient.name,
      age: patient.age,
      gender: patient.gender,
      phone: patient.phone,
      email: patient.email,
      address: patient.address,
      dateOfBirth: patient.dateOfBirth,
      medicalHistory: patient.medicalHistory,
      allergies: patient.allergies,
      status: 'active',
    );
    _cachedPatients ??= _getMockPatients();
    _cachedPatients!.insert(0, newPatient);
    return newPatient;
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

  @override
  Future<TreatmentItem> addTreatment({
    required String patientId,
    required TreatmentItem treatment,
  }) async {
    // TODO: Replace with real API call when backend is ready
    // final response = await _apiConsumer.post(
    //   PatientEndpoints.addTreatment(patientId),
    //   body: treatment.toJson(),
    // );
    // return TreatmentItem.fromJson(response as Map<String, dynamic>);

    await Future.delayed(const Duration(milliseconds: 800));
    final newTreatment = treatment.copyWith(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    return newTreatment;
  }
}
