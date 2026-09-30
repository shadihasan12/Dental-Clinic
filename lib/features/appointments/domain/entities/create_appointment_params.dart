class CreateAppointmentParams {
  final String patientId;
  final String doctorId;
  final DateTime startTime;
  final DateTime endTime;
  final String? notes;
  final bool notifyPatient;

  /// Booked outside the doctor's hours on purpose. Without it the server
  /// checks the schedule and refuses a slot only a VIP lookup offered.
  final bool isVip;

  const CreateAppointmentParams({
    required this.patientId,
    required this.doctorId,
    required this.startTime,
    required this.endTime,
    this.notes,
    this.notifyPatient = true,
    this.isVip = false,
  });
}
