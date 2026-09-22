import 'package:dental_clinic_app/features/statistics/presentation/widgets/charts/chart_support.dart';
import 'package:flutter_test/flutter_test.dart';

// Payloads copied from GET /clinics/statistics/fetch. Every one of these
// used to render "No data for this period" because the parser only knew the
// `{labels, values}` shape.
void main() {
  test('labels/values map (appointment status breakdown)', () {
    final s = LabelledSeries.tryParse({
      'labels': ['COMPLETED', 'UPCOMING'],
      'values': [6, 14],
    })!;
    expect(s.labels, ['COMPLETED', 'UPCOMING']);
    expect(s.values, [6, 14]);
  });

  test('name/count rows (top requested treatments)', () {
    final s = LabelledSeries.tryParse([
      {'id': 'a', 'name': 'Sealant', 'count': 1},
      {'id': 'b', 'name': 'Root Canal', 'count': 3},
    ])!;
    expect(s.labels, ['Sealant', 'Root Canal']);
    expect(s.values, [1, 3]);
  });

  test('status/count rows (medical cases status ratio)', () {
    final s = LabelledSeries.tryParse([
      {'status': 'ACTIVE', 'count': 7},
      {'status': 'COMPLETED', 'count': 1},
    ])!;
    expect(s.labels, ['ACTIVE', 'COMPLETED']);
    expect(s.values, [7, 1]);
  });

  test('period/count rows (patient acquisition)', () {
    final s = LabelledSeries.tryParse([
      {'period': '2026-09-22', 'count': 10},
    ])!;
    expect(s.labels, ['2026-09-22']);
    expect(s.values, [10]);
  });

  test('doctor rows with count (appointments per doctor)', () {
    final s = LabelledSeries.tryParse([
      {'doctor_id': 'x', 'doctor_name': 'Sami Haddad', 'count': 21},
    ])!;
    expect(s.labels, ['Sami Haddad']);
    expect(s.values, [21]);
  });

  test('per-currency money sums only the main currency', () {
    final s = LabelledSeries.tryParse([
      {
        'doctor_name': 'Sami Haddad',
        'revenues': [
          {'currency': 'USD', 'amount': 3920},
          {'currency': 'SYP', 'amount': 500000},
        ],
      },
      {
        'name': 'Clinic Rent',
        'currencies': [
          {'currency': 'USD', 'amount': '450.00'},
        ],
      },
    ])!;
    expect(s.labels, ['Sami Haddad', 'Clinic Rent']);
    expect(s.values, [3920, 450]);
  });

  test('empty list is an empty series, not a parse failure', () {
    expect(LabelledSeries.tryParse(<dynamic>[])!.isEmpty, isTrue);
  });

  test('unrecognised rows are rejected', () {
    expect(LabelledSeries.tryParse([
      {'foo': 1},
    ]), isNull);
  });
}
