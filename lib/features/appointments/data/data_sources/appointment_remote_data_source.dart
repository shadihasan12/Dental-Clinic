import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/features/appointments/data/endpoints/appointment_endpoints.dart';
import 'package:dental_clinic_app/features/appointments/data/models/appointment_model.dart';
import 'package:dental_clinic_app/features/appointments/data/models/clinic_doctor_model.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/appointment_entity.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/create_appointment_params.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/get_appointments_params.dart';
import 'package:injectable/injectable.dart';

abstract class AppointmentRemoteDataSource {
  Future<List<AppointmentModel>> getAllAppointments(GetAppointmentsParams params);
  Future<List<String>> getAvailableSlots(
    DateTime date,
    int durationMinutes, {
    String? doctorId,
    bool isVip = false,
  });
  Future<AppointmentModel> createAppointment(CreateAppointmentParams params);
  Future<AppointmentModel> updateStatus(String id, AppointmentStatus status);
  Future<List<ClinicDoctorModel>> getClinicDoctors();
}

@Injectable(as: AppointmentRemoteDataSource)
class AppointmentRemoteDataSourceImpl implements AppointmentRemoteDataSource {
  final ApiConsumer _apiConsumer;

  AppointmentRemoteDataSourceImpl(this._apiConsumer);

  @override
  Future<List<AppointmentModel>> getAllAppointments(
    GetAppointmentsParams params,
  ) async {
    final response = await _apiConsumer.get(
      AppointmentEndpoints.appointments,
      queryParameters: params.isSingleDay
          ? {'filters[date][eq]': _formatDate(params.from)}
          : {
              'filters[date][gte]': _formatDate(params.from),
              'filters[date][lte]': _formatDate(params.to),
            },
    );

    final dataList = response['data'] as List;
    return dataList
        .map((e) => AppointmentModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<String>> getAvailableSlots(
    DateTime date,
    int durationMinutes, {
    String? doctorId,
    bool isVip = false,
  }) async {
    final response = await _apiConsumer.get(
      AppointmentEndpoints.availableSlots,
      queryParameters: {
        'date': _formatDate(date),
        'duration': durationMinutes,
        if (doctorId != null && doctorId.isNotEmpty) 'doctor_id': doctorId,
        if (isVip) 'is_vip': true,
      },
    );

    final dataList = response['data'] as List;
    return dataList.map((e) {
      if (e is String) return e;
      final map = e as Map<String, dynamic>;
      return (map['start_time'] ?? map['start'] ?? map['time']).toString();
    }).toList();
  }

  @override
  Future<AppointmentModel> createAppointment(
    CreateAppointmentParams params,
  ) async {
    final response = await _apiConsumer.post(
      AppointmentEndpoints.appointments,
      body: {
        'patient_id': params.patientId,
        'doctor_id': params.doctorId,
        'start_time': _formatDateTime(params.startTime),
        'end_time': _formatDateTime(params.endTime),
        'core_treatment_ids': params.coreTreatmentIds,
        if (params.notes != null && params.notes!.isNotEmpty)
          'notes': params.notes,
        'notify_patient': params.notifyPatient,
      },
    );

    final data = response['data'] as Map<String, dynamic>;
    return AppointmentModel.fromJson(data);
  }

  @override
  Future<List<ClinicDoctorModel>> getClinicDoctors() async {
    final response = await _apiConsumer.get(
      AppointmentEndpoints.clinicDoctors,
    );
    final data = response['data'] as List;
    return data
        .map((e) => ClinicDoctorModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<AppointmentModel> updateStatus(
    String id,
    AppointmentStatus status,
  ) async {
    final response = await _apiConsumer.patch(
      AppointmentEndpoints.appointmentStatus(id),
      body: {'status': AppointmentModel.apiValue(status)},
    );
    final data = response['data'] as Map<String, dynamic>;
    return AppointmentModel.fromJson(data);
  }

  String _formatDate(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';

  String _formatDateTime(DateTime d) =>
      '${_formatDate(d)} '
      '${d.hour.toString().padLeft(2, '0')}:'
      '${d.minute.toString().padLeft(2, '0')}:'
      '${d.second.toString().padLeft(2, '0')}';
}
