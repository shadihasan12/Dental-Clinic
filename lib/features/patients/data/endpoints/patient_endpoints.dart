class PatientEndpoints {
  PatientEndpoints._();

  static String patientDetails(String patientId) => '/patients/$patientId';

  static String activeCase(String patientId) =>
      '/patients/$patientId/cases/active';

  static String completedCases(String patientId) =>
      '/patients/$patientId/cases/completed';
}
