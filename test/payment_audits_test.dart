import 'package:dental_clinic_app/features/patients/data/models/payment.dart';
import 'package:flutter_test/flutter_test.dart';

/// Every case payment carries its history. This is the answer the server
/// gives to an edit: 100,000 SYP recorded as $10, then changed to 120,000
/// SYP, $12, with a new note.
void main() {
  final edited = <String, dynamic>{
    'id': '01a0fca7-9f31-710d-857a-448a4889bd9d',
    'amount': 120000,
    'currency': {
      'id': 'syp',
      'currency_name': 'الليرة السورية',
      'currency_code': 'SYP',
    },
    'amount_in_case_currency': '12.00',
    'case_currency': {
      'id': 'usd',
      'currency_name': 'الدولار الأمريكي',
      'currency_code': 'USD',
    },
    'exchange_rate': '10000.000000',
    'notes': 'دفعة أولى، نقداً',
    'case_id': '01a0fca7-9f04-7242-a310-f6bb443bdcda',
    'created_at': '2026-10-02T15:47:18+03:00',
    'audits': [
      {
        'id': 'a1',
        'event': 'CREATE',
        'user_id': 'u1',
        'user_fullname': 'سامي الخطيب',
        'old_values': null,
        'new_values': {
          'amount': 100000,
          'currency_id': 'syp',
          'amount_in_case_currency': 10,
          'case_currency_id': 'usd',
          'exchange_rate': 10000,
          'notes': 'دفعة أولى',
        },
        'created_at': '2026-10-02T15:47:18+03:00',
      },
      {
        'id': 'a2',
        'event': 'UPDATE',
        'user_id': 'u1',
        'user_fullname': ' ',
        'old_values': {
          'amount': '100000.00',
          'notes': 'دفعة أولى',
          'amount_in_case_currency': '10.00',
        },
        'new_values': {
          'amount': 120000,
          'notes': 'دفعة أولى، نقداً',
          'amount_in_case_currency': 12,
        },
        'created_at': '2026-10-02T15:49:00+03:00',
      },
    ],
  };

  test('the payment keeps the currency it was taken in', () {
    final payment = Payment.fromJson(edited);

    // `case_currency` names the case's currency; the payment's own is
    // `currency`.
    expect(payment.currencyCode, 'SYP');
    expect(payment.amountInCaseCurrency, 12.0);
    expect(payment.exchangeRate, 10000.0);
  });

  test('the history is read oldest first, with who and when', () {
    final audits = Payment.fromJson(edited).audits;

    expect(audits, hasLength(2));
    expect(audits.first.isCreate, isTrue);
    expect(audits.first.userFullname, 'سامي الخطيب');
    expect(audits.first.createdAt, isNotNull);
    expect(audits.last.isUpdate, isTrue);
    // A single space where the name was: the account has been deleted.
    expect(audits.last.isDeletedUser, isTrue);
  });

  test('an edit lists only what it changed, a first recording nothing', () {
    final audits = Payment.fromJson(edited).audits;

    expect(Payment.changesIn(audits.first), isEmpty);

    final changes = Payment.changesIn(audits.last);
    expect(changes.map((c) => c.field), [
      'amount',
      'amount_in_case_currency',
      'notes',
    ]);
    // A number when it was sent, a string when it was read back.
    expect(Payment.auditFigure(changes.first.before), 100000.0);
    expect(Payment.auditFigure(changes.first.after), 120000.0);
    expect(changes.last.after, 'دفعة أولى، نقداً');
  });

  test('a payment from before the history has none', () {
    final old = Map<String, dynamic>.from(edited)..remove('audits');
    expect(Payment.fromJson(old).audits, isEmpty);

    final empty = Map<String, dynamic>.from(edited)..['audits'] = [];
    expect(Payment.fromJson(empty).audits, isEmpty);
  });
}
