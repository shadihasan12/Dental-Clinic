import 'package:flutter/services.dart';

/// Formatters every email input gets.
///
/// Platform autofill commits its suggestion with a trailing space. That space
/// then fails the address validator, and wherever a call site forgets to trim
/// it reaches the API still attached. No address contains whitespace, so this
/// denies it outright - which fixes the suggestion, a paste with a stray
/// space, and a typed one alike, in the field rather than at every submit.
final List<TextInputFormatter> emailInputFormatters = <TextInputFormatter>[
  FilteringTextInputFormatter.deny(RegExp(r'\s')),
];

/// Keeps a money field inside what the server takes: at most
/// [integerDigits] digits before the point, and two after it.
///
/// Refuses the edit rather than trimming it. A filter pattern cannot do this
/// job - `FilteringTextInputFormatter.allow` keeps every run of the text its
/// pattern matches, so a ninth digit comes back as a second match and slips
/// through - and silently cutting a pasted figure down would send a
/// different number from the one on screen.
List<TextInputFormatter> moneyInputFormatters({int integerDigits = 8}) {
  final shape = RegExp('^\\d{0,$integerDigits}(\\.\\d{0,2})?\$');
  return <TextInputFormatter>[
    TextInputFormatter.withFunction(
      (oldValue, newValue) =>
          shape.hasMatch(newValue.text) ? newValue : oldValue,
    ),
  ];
}

/// [emailInputFormatters] when the field declares itself an email field, null
/// otherwise.
///
/// The shared field widgets call this so the keyboard type is the only thing
/// a page has to get right: declaring `TextInputType.emailAddress` is what
/// buys the whitespace guard, and a new email field cannot forget it.
List<TextInputFormatter>? formattersForKeyboard(TextInputType? keyboardType) =>
    keyboardType == TextInputType.emailAddress ? emailInputFormatters : null;
