import 'package:dental_clinic_app/core/utils/account_rules.dart';
import 'package:flutter_test/flutter_test.dart';

/// The server's rules for a password being set and for a mobile number,
/// checked on the device first. These pin them to what the server does.
void main() {
  group('a password being set', () {
    test('needs 8 to 72 characters, a letter and a digit', () {
      expect(PasswordRules.isValid('abcdefg1'), isTrue);
      expect(PasswordRules.isValid('abc1'), isFalse);
      expect(PasswordRules.isValid('abcdefgh'), isFalse);
      expect(PasswordRules.isValid('12345678'), isFalse);
      expect(PasswordRules.isValid('a1' * 36), isTrue);
      expect(PasswordRules.isValid('${'a1' * 36}x'), isFalse);
    });

    test('Arabic letters and Arabic-Indic digits count', () {
      expect(PasswordRules.isValid('كلمةمرور١٢'), isTrue);
    });
  });

  group('a mobile number', () {
    test('is cleaned to what the server stores', () {
      expect(MobileNumber.clean('0935 315-978'), '0935315978');
      expect(MobileNumber.clean('+963 935 315 978'), '+963935315978');
      expect(MobileNumber.clean('٠٩٣٥٣١٥٩٧٨'), '0935315978');
      expect(MobileNumber.clean('۰۹۳۵۳۱۵۹۷۸'), '0935315978');
    });

    test('is an optional + and 7 to 19 digits', () {
      expect(MobileNumber.isValid('0935 315-978'), isTrue);
      expect(MobileNumber.isValid('+963935315978'), isTrue);
      expect(MobileNumber.isValid('1234567'), isTrue);
      expect(MobileNumber.isValid('123456'), isFalse);
      expect(MobileNumber.isValid('1' * 20), isFalse);
      expect(MobileNumber.isValid('(0935) 315.978'), isFalse);
      expect(MobileNumber.isValid('0935abc978'), isFalse);
    });
  });
}
