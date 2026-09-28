import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';

/// "Upper Right First Molar" for FDI code `16`, in the user's language.
///
/// Empty for anything that is not a two-digit FDI code, so a caller can
/// simply skip the line rather than show a half-built name.
String toothDisplayName(AppLocalizations l10n, String code) {
  if (code.length != 2 || int.tryParse(code) == null) return '';

  final quadrant = switch (code[0]) {
    '1' => l10n.toothQuadrantUpperRight,
    '2' => l10n.toothQuadrantUpperLeft,
    '3' => l10n.toothQuadrantLowerLeft,
    '4' => l10n.toothQuadrantLowerRight,
    _ => null,
  };
  final tooth = switch (code[1]) {
    '1' => l10n.toothCentralIncisor,
    '2' => l10n.toothLateralIncisor,
    '3' => l10n.toothCanine,
    '4' => l10n.toothFirstPremolar,
    '5' => l10n.toothSecondPremolar,
    '6' => l10n.toothFirstMolar,
    '7' => l10n.toothSecondMolar,
    '8' => l10n.toothWisdom,
    _ => null,
  };
  if (quadrant == null || tooth == null) return '';

  return l10n.toothFullName(quadrant, tooth);
}
