import '../../domain/entities/home_card.dart';

/// Parses `data.cards` from `GET /clinics/statistics/home-cards`.
///
/// Every field of a card is a string and none of them is optional except
/// `unit`, so the parse is a straight read. It is still defensive about the
/// envelope itself: a card that is not an object, or is missing a field the
/// contract promises, is skipped rather than thrown on. Losing one card is a
/// smaller failure than a carousel that renders nothing because one entry was
/// malformed.
class HomeCardModel {
  HomeCardModel._();

  static HomeCard? fromJson(Map<String, dynamic> json) {
    final key = _string(json['key']);
    final title = _string(json['title']);
    final subtitle = _string(json['subtitle']);
    final value = _string(json['value']);
    if (key == null || title == null || value == null) return null;

    return HomeCard(
      key: key,
      title: title,
      subtitle: subtitle ?? '',
      value: value,
      // Read through the same helper so a server that ever sends an empty
      // string instead of null lands on "no unit" rather than a blank chip.
      unit: _string(json['unit']),
    );
  }

  static List<HomeCard> listFrom(Object? raw) {
    if (raw is! List) return const [];
    final cards = <HomeCard>[];
    for (final entry in raw) {
      if (entry is! Map<String, dynamic>) continue;
      final card = fromJson(entry);
      if (card != null) cards.add(card);
    }
    return cards;
  }

  /// Null for anything that is not text with something in it - including the
  /// JSON null the contract puts on `unit`.
  static String? _string(Object? raw) {
    if (raw == null) return null;
    final text = raw.toString().trim();
    return text.isEmpty ? null : text;
  }
}
