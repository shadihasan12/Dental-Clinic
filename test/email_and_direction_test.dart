import 'package:dental_clinic_app/core/utils/account_rules.dart';
import 'package:dental_clinic_app/core/utils/input_direction.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('an email address', () {
    test('takes long endings, plus-addressing and subdomains', () {
      expect(EmailAddress.isValid('info@skew.digital'), isTrue);
      expect(EmailAddress.isValid('dr.sam+clinic@mail.example.co.uk'), isTrue);
      expect(EmailAddress.isValid('a_b-c@x-y.io'), isTrue);
    });

    test('refuses broken shapes', () {
      expect(EmailAddress.isValid('no-at.example.com'), isFalse);
      expect(EmailAddress.isValid('a@b'), isFalse);
      expect(EmailAddress.isValid('a..b@example.com'), isFalse);
      expect(EmailAddress.isValid('.a@example.com'), isFalse);
      expect(EmailAddress.isValid('a@-example.com'), isFalse);
      expect(EmailAddress.isValid('a@example.c0m'), isFalse);
    });

    test('names the character that does not belong', () {
      expect(EmailAddress.invalidCharacter('sam!@example.com'), '!');
      expect(EmailAddress.invalidCharacter('سام@example.com'), 'س');
      expect(EmailAddress.invalidCharacter('sam @example.com'), ' ');
      expect(EmailAddress.invalidCharacter('sam@example.com'), isNull);
    });
  });

  group('input direction', () {
    test('passwords and Latin-only keyboards are always left-to-right', () {
      expect(inputTextDirection(obscureText: true), TextDirection.ltr);
      expect(
        inputTextDirection(keyboardType: TextInputType.emailAddress),
        TextDirection.ltr,
      );
      expect(
        inputTextDirection(keyboardType: TextInputType.phone, text: 'مرحبا'),
        TextDirection.ltr,
      );
    });

    test('free text follows its first letter', () {
      expect(inputTextDirection(text: 'pass@123'), TextDirection.ltr);
      expect(inputTextDirection(text: '12 أسنان'), TextDirection.rtl);
      expect(inputTextDirection(text: '123 !'), isNull);
      expect(inputTextDirection(text: ''), isNull);
    });

    test('an explicit direction wins', () {
      expect(
        inputTextDirection(explicit: TextDirection.rtl, obscureText: true),
        TextDirection.rtl,
      );
    });
  });
}
