class AppointmentEndpoints {
  AppointmentEndpoints._();

  static const String appointments = '/clinics/appointments';
  static const String availableSlots = '/clinics/appointment-available-slots';
  static const String clinicDoctors = '/clinics/clinic-doctors';

  static String appointmentStatus(String id) =>
      '/clinics/appointments/$id/status';
}
