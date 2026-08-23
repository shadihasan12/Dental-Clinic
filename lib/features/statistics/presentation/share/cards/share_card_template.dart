import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';

import 'certificate_share_card.dart';
import 'editorial_share_card.dart';
import 'enamel_share_card.dart';
import 'share_card_common.dart';

/// The share-card designs a doctor can pick between.
///
/// Order is the order they appear in the picker. [id] is what gets
/// persisted, so renaming a value is fine but changing an id will silently
/// reset everyone's saved choice.
enum ShareCardTemplate {
  enamel(
    id: 'enamel',
    label: 'Enamel',
    previewBackground: Color(0xFFE6F1F7),
  ),
  editorial(
    id: 'editorial',
    label: 'Editorial',
    previewBackground: Color(0xFF061412),
  ),
  certificate(
    id: 'certificate',
    label: 'Certificate',
    previewBackground: Color(0xFF08132E),
  );

  const ShareCardTemplate({
    required this.id,
    required this.label,
    required this.previewBackground,
  });

  final String id;

  /// The design's name. Deliberately not localized: it names the artwork,
  /// which is English-only, so it reads the same in every locale.
  final String label;

  /// One-line description of the design's look. This one *is* localized —
  /// it describes the design rather than naming it.
  String blurb(AppLocalizations l10n) {
    switch (this) {
      case ShareCardTemplate.enamel:
        return l10n.shareCardEnamelBlurb;
      case ShareCardTemplate.editorial:
        return l10n.shareCardEditorialBlurb;
      case ShareCardTemplate.certificate:
        return l10n.shareCardCertificateBlurb;
    }
  }

  /// Painted behind the preview so there is never a flash of empty tile
  /// while the card warms up.
  final Color previewBackground;

  /// Builds the 1080x1920 card. Callers are responsible for sizing and for
  /// wrapping it in the `RepaintBoundary` that gets captured.
  Widget build(ShareCardData data) {
    switch (this) {
      case ShareCardTemplate.enamel:
        return EnamelShareCard(data: data);
      case ShareCardTemplate.editorial:
        return EditorialShareCard(data: data);
      case ShareCardTemplate.certificate:
        return CertificateShareCard(data: data);
    }
  }

  /// Resolves a persisted [id] back to a template, falling back to the
  /// first design when the stored value is missing or no longer known.
  static ShareCardTemplate fromId(String? id) {
    for (final t in ShareCardTemplate.values) {
      if (t.id == id) return t;
    }
    return ShareCardTemplate.enamel;
  }
}
