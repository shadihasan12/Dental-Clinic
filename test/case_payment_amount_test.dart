import 'package:dental_clinic_app/features/patients/domain/case_payment_amount.dart';
import 'package:flutter_test/flutter_test.dart';

/// The amount in the case's currency is computed, never typed, and has to
/// agree with the rate the way the server checks it.
void main() {
  test('pounds at 10,000 to the dollar, the rate either way round', () {
    // 1 USD = 10,000 SYP: divide.
    expect(
      CasePaymentAmount.inCaseCurrency(
        amount: 120000,
        rate: 10000,
        rateIsPerPaymentUnit: false,
      ),
      12.0,
    );
    // 1 SYP = 0.0001 USD: multiply.
    expect(
      CasePaymentAmount.inCaseCurrency(
        amount: 120000,
        rate: 0.0001,
        rateIsPerPaymentUnit: true,
      ),
      12.0,
    );
  });

  test('the result is rounded to the cent', () {
    expect(
      CasePaymentAmount.inCaseCurrency(
        amount: 100,
        rate: 3,
        rateIsPerPaymentUnit: false,
      ),
      33.33,
    );
    expect(
      CasePaymentAmount.inCaseCurrency(
        amount: 200,
        rate: 3,
        rateIsPerPaymentUnit: false,
      ),
      66.67,
    );
  });

  test('in the case\'s own currency the two amounts are one amount', () {
    expect(
      CasePaymentAmount.inCaseCurrency(
        amount: 59.97,
        rate: 1,
        rateIsPerPaymentUnit: true,
      ),
      59.97,
    );
  });

  test('a pound at 10,000 is under a cent, which the server refuses', () {
    final converted = CasePaymentAmount.inCaseCurrency(
      amount: 1,
      rate: 10000,
      rateIsPerPaymentUnit: false,
    );
    expect(CasePaymentAmount.isAmountInRange(converted), isFalse);
  });

  test('the bounds are the server\'s', () {
    expect(CasePaymentAmount.isAmountInRange(0.01), isTrue);
    expect(CasePaymentAmount.isAmountInRange(99999999.99), isTrue);
    expect(CasePaymentAmount.isAmountInRange(100000000), isFalse);
    expect(CasePaymentAmount.isRateInRange(0.000001), isTrue);
    expect(CasePaymentAmount.isRateInRange(0.0000001), isFalse);
    expect(CasePaymentAmount.isRateInRange(1000000000), isFalse);
  });
}
