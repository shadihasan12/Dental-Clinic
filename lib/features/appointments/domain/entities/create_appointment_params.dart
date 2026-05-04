class CreateAppointmentParams {
  final String patientId;
  final DateTime startTime;
  final DateTime endTime;
  final List<String> coreTreatmentIds;
  final String? notes;
  final bool notifyPatient;

  const CreateAppointmentParams({
    required this.patientId,
    required this.startTime,
    required this.endTime,
    required this.coreTreatmentIds,
    this.notes,
    this.notifyPatient = true,
  });
}
