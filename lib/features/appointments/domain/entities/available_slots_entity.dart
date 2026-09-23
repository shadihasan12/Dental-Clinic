/// Which schedule a set of slots was cut from - `meta.hours_source` on
/// `GET /clinics/appointment-available-slots`.
enum SlotsHoursSource {
  /// The doctor's own rows, or an availability exception for that date.
  user,

  /// The doctor has no rows here; the clinic's schedule stood in. Also what
  /// a holiday or a closed day reports, with no slots.
  clinic,

  /// `is_vip` was set: hours were not consulted, only existing appointments.
  vip,
  unknown;

  static SlotsHoursSource fromApi(String? value) {
    switch (value) {
      case 'user':
        return SlotsHoursSource.user;
      case 'clinic':
        return SlotsHoursSource.clinic;
      case 'vip':
        return SlotsHoursSource.vip;
      default:
        return SlotsHoursSource.unknown;
    }
  }
}

class AvailableSlotsEntity {
  const AvailableSlotsEntity({
    required this.slots,
    this.hoursSource = SlotsHoursSource.unknown,
  });

  /// Start times, `HH:mm`.
  final List<String> slots;
  final SlotsHoursSource hoursSource;
}
