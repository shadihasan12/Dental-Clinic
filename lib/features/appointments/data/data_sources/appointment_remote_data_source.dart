import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/features/appointments/data/models/appointment_model.dart';
import 'package:injectable/injectable.dart';

abstract class AppointmentRemoteDataSource {
  Future<List<AppointmentModel>> getAllAppointments();
  Future<AppointmentModel> createAppointment(AppointmentModel appointment);
}

@Injectable(as: AppointmentRemoteDataSource)
class AppointmentRemoteDataSourceImpl implements AppointmentRemoteDataSource {
  // ignore: unused_field
  final ApiConsumer _apiConsumer;

  AppointmentRemoteDataSourceImpl(this._apiConsumer);

  @override
  Future<List<AppointmentModel>> getAllAppointments() async {
    // TODO: Replace with real API call when backend is ready
    // final response = await _apiConsumer.get(AppointmentEndpoints.appointments);
    // return (response as List)
    //     .map((e) => AppointmentModel.fromJson(e as Map<String, dynamic>))
    //     .toList();

    await Future.delayed(const Duration(milliseconds: 800));

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return [
      AppointmentModel(
        id: '1',
        patientId: '1',
        patientName: 'اسماعيل الشوفي',
        doctorId: 'd1',
        doctorName: 'د. سارة جونسون',
        dateTime: today.add(const Duration(hours: 9)),
        durationMinutes: 30,
        treatmentType: 'Checkup',
        status: 'confirmed',
      ),
      AppointmentModel(
        id: '2',
        patientId: '2',
        patientName: 'وسام إلياس',
        doctorId: 'd1',
        doctorName: 'د. سارة جونسون',
        dateTime: today.add(const Duration(hours: 10)),
        durationMinutes: 60,
        treatmentType: 'Cleaning',
        status: 'confirmed',
      ),
      AppointmentModel(
        id: '3',
        patientId: '3',
        patientName: 'سركيس شلهوب',
        doctorId: 'd1',
        doctorName: 'د. سارة جونسون',
        dateTime: today.add(const Duration(hours: 11, minutes: 30)),
        durationMinutes: 45,
        treatmentType: 'Filling',
        status: 'pending',
      ),
      AppointmentModel(
        id: '4',
        patientId: '4',
        patientName: 'شادي حسن',
        doctorId: 'd1',
        doctorName: 'د. سارة جونسون',
        dateTime: today.add(const Duration(hours: 14)),
        durationMinutes: 90,
        treatmentType: 'Root Canal',
        status: 'confirmed',
      ),
      AppointmentModel(
        id: '5',
        patientId: '5',
        patientName: 'جميل عامر',
        doctorId: 'd1',
        doctorName: 'د. سارة جونسون',
        dateTime: today.add(const Duration(hours: 16)),
        durationMinutes: 30,
        treatmentType: 'Consultation',
        status: 'completed',
      ),
    ];
  }

  @override
  Future<AppointmentModel> createAppointment(
    AppointmentModel appointment,
  ) async {
    // TODO: Replace with real API call when backend is ready
    // final response = await _apiConsumer.post(
    //   AppointmentEndpoints.appointments,
    //   body: appointment.toJson(),
    // );
    // return AppointmentModel.fromJson(response as Map<String, dynamic>);

    await Future.delayed(const Duration(seconds: 1));
    return AppointmentModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      patientId: appointment.patientId,
      patientName: appointment.patientName,
      doctorId: appointment.doctorId,
      doctorName: appointment.doctorName,
      dateTime: appointment.dateTime,
      durationMinutes: appointment.durationMinutes,
      treatmentType: appointment.treatmentType,
      status: 'pending',
      notes: appointment.notes,
      clinicId: appointment.clinicId,
    );
  }
}
