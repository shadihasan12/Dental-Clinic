import 'package:dental_clinic_app/core/utils/input_formatters.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// A case cost, and a lab fee, have to stay inside what the server takes:
/// 99,999,999.99. The field refuses anything longer instead of letting it
/// reach the API, or quietly turning it into a different number.
void main() {
  String type(String text, {String from = ''}) {
    final formatter = moneyInputFormatters().single;
    return formatter
        .formatEditUpdate(
          TextEditingValue(
            text: from,
            selection: TextSelection.collapsed(offset: from.length),
          ),
          TextEditingValue(
            text: text,
            selection: TextSelection.collapsed(offset: text.length),
          ),
        )
        .text;
  }

  test('up to eight digits and two decimals go in', () {
    expect(type('99999999.99'), '99999999.99');
    expect(type('0.01'), '0.01');
    expect(type(''), '');
  });

  test('a ninth digit is refused, not swallowed', () {
    // The old filter pattern let this through: `allow` keeps every run its
    // pattern matches, so the ninth digit came back as a second match.
    expect(type('123456789', from: '12345678'), '12345678');
  });

  test('a third decimal is refused', () {
    expect(type('1.234', from: '1.23'), '1.23');
  });

  test('a pasted figure that is too long leaves the field as it was', () {
    expect(type('12345678901234', from: '5'), '5');
  });

  test('letters and separators are refused', () {
    expect(type('12a', from: '12'), '12');
    expect(type('1,200', from: '1'), '1');
  });
}
