import 'package:dental_clinic_app/features/appointments/domain/appointment_rules.dart';
import 'package:flutter_test/flutter_test.dart';

/// The server refuses an appointment that ends on another day than it
/// starts; a late slot with a long duration is how the form could build one.
void main() {
  final day = DateTime(2026, 10, 12);

  test('ending at 23:59 is the latest that goes', () {
    final start = day.add(const Duration(hours: 23, minutes: 29));
    expect(endsOnStartDay(start, start.add(const Duration(minutes: 30))), isTrue);
  });

  test('ending at midnight is the next day', () {
    final start = day.add(const Duration(hours: 23, minutes: 30));
    expect(endsOnStartDay(start, start.add(const Duration(minutes: 30))), isFalse);
  });

  test('a late slot with a long duration runs past midnight', () {
    final start = day.add(const Duration(hours: 23));
    expect(endsOnStartDay(start, start.add(const Duration(hours: 2))), isFalse);
  });
}
