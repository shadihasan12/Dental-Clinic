import 'package:dental_clinic_app/features/billing/domain/repositories/billing_repository.dart';
import 'package:dental_clinic_app/features/billing/presentation/widgets/billing_ui.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';

/// What `POST /clinic-payments` is sent. The server refuses a report that
/// does not name the account the money went to, and an amount over its
/// ceiling; these pin the body and the on-device check to that.
void main() {
  ReportPaymentParams params({
    String method = 'SHAM_CASH',
    String? bankName,
    String? notes,
    DateTime? paidAt,
    List<String> receipts = const [],
  }) => ReportPaymentParams(
    method: method,
    paymentAccountId: 'account-1',
    amountOriginal: '719640',
    currencyOriginal: 'SYP',
    referenceNumber: 'TX-900001',
    bankName: bankName,
    notes: notes,
    paidAt: paidAt,
    mediaItemIds: receipts,
  );

  group('the body of a reported transfer', () {
    test('always names the account, beside the method it is listed under', () {
      expect(params().toJson(), {
        'method': 'SHAM_CASH',
        'payment_account_id': 'account-1',
        'amount_original': '719640',
        'currency_original': 'SYP',
        'reference_number': 'TX-900001',
      });
    });

    test('sends a method it has never seen back as it came', () {
      expect(params(method: 'NEW_WALLET').toJson()['method'], 'NEW_WALLET');
    });

    test('carries what else was filled in, and nothing that was not', () {
      final body = params(
        bankName: 'Bank of Syria',
        notes: '',
        receipts: ['receipt-1'],
      ).toJson();

      expect(body['bank_name'], 'Bank of Syria');
      expect(body['media_item_ids'], ['receipt-1']);
      expect(body.containsKey('notes'), isFalse);
      expect(body.containsKey('paid_at'), isFalse);
    });
  });

  group('the amount sent', () {
    test('is read with its thousands separators dropped', () {
      expect(ReportPaymentParams.parseAmount(' 719,640.50 '), 719640.5);
      expect(ReportPaymentParams.parseAmount('59.97'), 59.97);
    });

    test('is nothing when it is not a number', () {
      expect(ReportPaymentParams.parseAmount(''), isNull);
      expect(ReportPaymentParams.parseAmount('abc'), isNull);
      expect(ReportPaymentParams.parseAmount('NaN'), isNull);
    });

    test('has the ceiling the server holds it to', () {
      const max = ReportPaymentParams.maxAmount;

      expect(ReportPaymentParams.parseAmount('999,999,999,999.99')! > max, isFalse);
      expect(ReportPaymentParams.parseAmount('1,000,000,000,000')! > max, isTrue);
      expect(ReportPaymentParams.parseAmount('1000000000000.00')! > max, isTrue);
    });
  });

  group('the name of a way of paying', () {
    final l10n = AppLocalizationsEn();

    test('is the server\'s, for a method the app has never seen', () {
      expect(
        paymentMethodLabel(l10n, 'NEW_WALLET', {'NEW_WALLET': 'محفظة جديدة'}),
        'محفظة جديدة',
      );
    });

    test('falls back to a readable form of the code', () {
      expect(paymentMethodLabel(l10n, 'NEW_WALLET', const {}), 'New Wallet');
      expect(paymentMethodLabel(l10n, 'CASH', const {}), 'Cash');
    });
  });
}
