/// What a clinic calls itself. A label and nothing else: it decides no
/// price, no plan, no seat count and no working hours, so nothing in the app
/// may branch on it.
enum ClinicType {
  individual('INDIVIDUAL'),
  center('CENTER');

  const ClinicType(this.apiValue);

  final String apiValue;

  static ClinicType? fromApi(String? value) {
    for (final t in ClinicType.values) {
      if (t.apiValue == value?.toUpperCase()) return t;
    }
    return null;
  }
}
