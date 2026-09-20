/// One card of the Home carousel, exactly as the server built it.
///
/// Every field is a string the app prints. The backend words, translates,
/// formats, orders and filters these; nothing here is interpreted. That is
/// deliberate: a clinic that starts billing in a third currency, or a card
/// type the product adds later, arrives as another entry in the same list and
/// needs no app release.
///
/// So: never branch on [key], never sort, never parse [value].
class HomeCard {
  const HomeCard({
    required this.key,
    required this.title,
    required this.subtitle,
    required this.value,
    this.unit,
  });

  /// Stable id within the response - `total_revenue_usd`, `total_cases`, and
  /// whatever comes next. Opaque: it keys the widget and nothing else.
  final String key;

  /// The headline, already in the requested language.
  final String title;

  /// The period wording, already in the requested language.
  final String subtitle;

  /// The figure as rendered text: grouped, rounded, two decimals on money and
  /// none on counts. Printed as-is - reformatting it can only lose something
  /// the server decided on purpose.
  final String value;

  /// Currency code on money cards, null on counts. Null renders nothing at
  /// all, never the word "null".
  final String? unit;
}
