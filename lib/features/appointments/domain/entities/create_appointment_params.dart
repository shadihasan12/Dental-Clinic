class CreateAppointmentParams {
  final String patientId;
  final String doctorId;
  final DateTime startTime;
  final DateTime endTime;
  final String? notes;
  final bool notifyPatient;

  const CreateAppointmentParams({
    required this.patientId,
    required this.doctorId,
    required this.startTime,
    required this.endTime,
    this.notes,
    this.notifyPatient = true,
  });
}
