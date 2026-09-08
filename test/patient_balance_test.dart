import 'package:dental_clinic_app/features/patients/data/models/patient_model.dart';
import 'package:flutter_test/flutter_test.dart';

/// The list screen showed "$0 owed" on patients the details screen showed as
/// owing money, because the API sends `outstanding_balance: 0` for everyone
/// while the patient's own case reports a real `pending_amount`. These cover
/// the derivation that closes that gap - and the currency that comes with it,
/// which must never fall back to dollars on a clinic billing in SYP.
Map<String, dynamic> patientJson({
  num? outstanding,
  Map<String, dynamic>? openedCase,
  List<Map<String, dynamic>> otherCases = const [],
}) => {
  'id': 'p1',
  'first_name': 'Sara',
  'last_name': 'Deeb',
  'date_of_birth': '2000-02-07',
  'gender': 'FEMALE',
  'phone_number': '0991000124',
  if (outstanding != null) 'outstanding_balance': outstanding,
  'opened_case': openedCase,
  'other_cases': otherCases,
};

Map<String, dynamic> caseJson(num pending, {String? code}) => {
  'id': 'c1',
  'pending_amount': pending,
  if (code != null)
    'total_cost_currency': {'currency_code': code, 'currency_name': code},
};

void main() {
  test('derives the balance from the open case when the server sends 0', () {
    final model = PatientModel.fromJson(
      patientJson(outstanding: 0, openedCase: caseJson(100, code: 'USD')),
    );

    expect(model.balance, 100);
    expect(model.balanceCurrencyCode, 'USD');
  });

  test('a real outstanding_balance still wins', () {
    // So this heals itself the day the backend aggregates the field.
    final model = PatientModel.fromJson(
      patientJson(outstanding: 250, openedCase: caseJson(100, code: 'USD')),
    );

    expect(model.balance, 250);
  });

  test('sums pending across every case', () {
    final model = PatientModel.fromJson(
      patientJson(
        outstanding: 0,
        openedCase: caseJson(100, code: 'USD'),
        otherCases: [caseJson(40), caseJson(10)],
      ),
    );

    expect(model.balance, 150);
  });

  test('a settled patient still reads as zero', () {
    final model = PatientModel.fromJson(
      patientJson(outstanding: 0, openedCase: caseJson(0, code: 'USD')),
    );

    expect(model.balance, 0);
  });

  test('carries a non-dollar currency rather than assuming USD', () {
    final model = PatientModel.fromJson(
      patientJson(outstanding: 0, openedCase: caseJson(977777, code: 'SYP')),
    );

    expect(model.balance, 977777);
    expect(model.balanceCurrencyCode, 'SYP');
  });

  test('no currency is null, not a guess', () {
    // The card renders the amount bare in this case - a wrong symbol on a
    // money figure is worse than no symbol.
    final model = PatientModel.fromJson(
      patientJson(outstanding: 0, openedCase: caseJson(100)),
    );

    expect(model.balanceCurrencyCode, isNull);
  });

  test('a patient with no case at all is handled', () {
    final model = PatientModel.fromJson(patientJson(outstanding: 0));

    expect(model.balance, 0);
    expect(model.balanceCurrencyCode, isNull);
  });
}
