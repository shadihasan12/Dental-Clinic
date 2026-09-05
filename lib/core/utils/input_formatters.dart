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

/// [emailInputFormatters] when the field declares itself an email field, null
/// otherwise.
///
/// The shared field widgets call this so the keyboard type is the only thing
/// a page has to get right: declaring `TextInputType.emailAddress` is what
/// buys the whitespace guard, and a new email field cannot forget it.
List<TextInputFormatter>? formattersForKeyboard(TextInputType? keyboardType) =>
    keyboardType == TextInputType.emailAddress ? emailInputFormatters : null;
