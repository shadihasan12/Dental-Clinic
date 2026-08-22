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
    blurb: 'Light, pearlescent',
    previewBackground: Color(0xFFE6F1F7),
  ),
  editorial(
    id: 'editorial',
    label: 'Editorial',
    blurb: 'Dark, off-axis',
    previewBackground: Color(0xFF061412),
  ),
  certificate(
    id: 'certificate',
    label: 'Certificate',
    blurb: 'Navy and gold foil',
    previewBackground: Color(0xFF08132E),
  );

  const ShareCardTemplate({
    required this.id,
    required this.label,
    required this.blurb,
    required this.previewBackground,
  });

  final String id;
  final String label;
  final String blurb;

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
