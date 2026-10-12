import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';

/// The rules the server holds a password to wherever one is *set* - sign-up,
/// reset, adding a member. Checked here first so the form says it as the
/// user types instead of after a round trip; the server's check stays the
/// last word.
///
/// The password in use - at login, or typed to confirm a change - is only
/// ever compared, never judged: an account set up before these rules still
/// signs in with what it has. Do not run it through here.
class PasswordRules {
  PasswordRules._();

  static const int minLength = 8;
  static const int maxLength = 72;

  // Any alphabet and any digits: Arabic letters and Arabic-Indic digits
  // count, as they do on the server.
  static final RegExp _letter = RegExp(r'\p{L}', unicode: true);
  static final RegExp _digit = RegExp(r'\p{N}', unicode: true);

  static bool isValid(String password) => _problems(password).isEmpty;

  /// Every rule [password] fails, in the user's language, joined the way the
  /// server joins them - or null when it passes.
  static String? problem(AppLocalizations l10n, String password) {
    final problems = _problems(password);
    if (problems.isEmpty) return null;
    return problems
        .map(
          (p) => switch (p) {
            _PasswordProblem.tooShort => l10n.passwordTooShort,
            _PasswordProblem.tooLong => l10n.passwordTooLong,
            _PasswordProblem.noLetter => l10n.passwordNeedsLetter,
            _PasswordProblem.noDigit => l10n.passwordNeedsDigit,
          },
        )
        .join(', ');
  }

  static List<_PasswordProblem> _problems(String password) {
    // Characters, not UTF-16 units: an emoji is one.
    final length = password.runes.length;
    return [
      if (length < minLength) _PasswordProblem.tooShort,
      if (length > maxLength) _PasswordProblem.tooLong,
      if (!_letter.hasMatch(password)) _PasswordProblem.noLetter,
      if (!_digit.hasMatch(password)) _PasswordProblem.noDigit,
    ];
  }
}

enum _PasswordProblem { tooShort, tooLong, noLetter, noDigit }

/// A mobile number the way the server stores it: an optional `+` and 7 to 19
/// digits `0-9`, with nothing in between.
///
/// The server drops spaces and dashes itself but refuses Arabic-Indic digits,
/// and an Arabic keyboard types exactly those - so [clean] converts them, and
/// what is sent is always what will be stored.
class MobileNumber {
  MobileNumber._();

  static final RegExp _pattern = RegExp(r'^\+?[0-9]{7,19}$');
  static final RegExp _spacesAndDashes = RegExp(r'[\s\-]', unicode: true);

  /// [input] with Arabic-Indic and Persian digits as `0-9`, and without
  /// spaces - of any kind - or dashes.
  static String clean(String input) {
    final buffer = StringBuffer();
    for (final rune in input.runes) {
      if (rune >= 0x0660 && rune <= 0x0669) {
        buffer.writeCharCode(0x30 + rune - 0x0660);
      } else if (rune >= 0x06F0 && rune <= 0x06F9) {
        buffer.writeCharCode(0x30 + rune - 0x06F0);
      } else {
        buffer.writeCharCode(rune);
      }
    }
    return buffer.toString().replaceAll(_spacesAndDashes, '');
  }

  /// Whether [input], once cleaned, is a number the server takes.
  static bool isValid(String input) => _pattern.hasMatch(clean(input));
}
