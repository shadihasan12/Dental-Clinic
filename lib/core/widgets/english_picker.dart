import 'package:flutter/widgets.dart';

/// Keeps a picker wheel in English, whatever language the app is in.
///
/// `CupertinoDatePicker` formats its own columns through `CupertinoLocalizations`,
/// so under Arabic it renders Arabic-Indic digits (١٤ instead of 14) and
/// Levantine month names. Dates in this app are read back as Latin digits
/// everywhere else - the API speaks them, the forms show them, and a clinic
/// reads a birth date or an appointment slot as 14/03 either way - so a wheel
/// that switches numbering systems is the odd one out, not the rule.
///
/// The locale override applies to this subtree only, and carries the
/// direction with it: the column order the English strings expect is
/// left-to-right, so an RTL page would otherwise lay out month and day
/// mirrored from the words describing them.
class EnglishPicker extends StatelessWidget {
  const EnglishPicker({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      locale: const Locale('en'),
      child: Directionality(textDirection: TextDirection.ltr, child: child),
    );
  }
}
