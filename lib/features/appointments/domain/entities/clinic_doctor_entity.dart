/// A doctor who can be assigned to appointments in the current clinic.
class ClinicDoctorEntity {
  final String id;
  final String name;
  final String? specialty;
  final String? avatarUrl;

  const ClinicDoctorEntity({
    required this.id,
    required this.name,
    this.specialty,
    this.avatarUrl,
  });
}
