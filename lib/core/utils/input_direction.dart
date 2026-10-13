import 'package:flutter/widgets.dart';

/// Which way a text field should run, so what is typed reads in the order it
/// was typed.
///
/// A field inherits the app's direction, and in Arabic that is right-to-left.
/// English typed into it is then laid out by the bidi algorithm: the words
/// stay readable, but the neutral characters between them - `@ . - _ !` and
/// digits next to them - are pulled to the other end, so `pass@123` shows up
/// as something the user never typed. The fix is to give the field the
/// direction of what is in it:
///
///  * [explicit] wins when the field asked for one.
///  * Passwords, emails, phone numbers, URLs and plain numbers are always
///    left-to-right - they are Latin by nature whatever the UI language.
///  * Anything else follows its first strong letter, the way a chat app does:
///    Arabic text runs right-to-left, English left-to-right, and an empty or
///    letterless field keeps the app's direction.
TextDirection? inputTextDirection({
  TextDirection? explicit,
  bool obscureText = false,
  TextInputType? keyboardType,
  String? text,
}) {
  if (explicit != null) return explicit;
  if (obscureText || _isLatinKeyboard(keyboardType)) return TextDirection.ltr;
  if (text == null || text.isEmpty) return null;
  return firstStrongDirection(text);
}

/// The direction of the first character in [text] that has one, or null
/// when there is none (only digits, spaces, punctuation).
TextDirection? firstStrongDirection(String text) {
  for (final rune in text.runes) {
    if (_isRtl(rune)) return TextDirection.rtl;
    if (_isLtrLetter(rune)) return TextDirection.ltr;
  }
  return null;
}

bool _isLatinKeyboard(TextInputType? type) {
  if (type == null) return false;
  return type.index == TextInputType.emailAddress.index ||
      type.index == TextInputType.phone.index ||
      type.index == TextInputType.url.index ||
      type.index == TextInputType.number.index ||
      type.index == TextInputType.visiblePassword.index;
}

/// Hebrew, Arabic, Syriac, Thaana, NKo and the Arabic presentation forms.
bool _isRtl(int c) =>
    (c >= 0x0590 && c <= 0x08FF) ||
    (c >= 0xFB1D && c <= 0xFDFF) ||
    (c >= 0xFE70 && c <= 0xFEFF);

/// Latin, Greek and Cyrillic letters - enough to tell "this is not Arabic".
bool _isLtrLetter(int c) =>
    (c >= 0x41 && c <= 0x5A) ||
    (c >= 0x61 && c <= 0x7A) ||
    (c >= 0xC0 && c <= 0x024F && c != 0xD7 && c != 0xF7) ||
    (c >= 0x0370 && c <= 0x04FF);
