import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Locale-aware date and time formatting.
///
/// Every user-facing date or time goes through here so the app never mixes
/// languages: Arabic renders Arabic month and weekday names and the ص/م
/// markers, English renders the English ones.
///
/// Digits stay Western (0-9) in both languages. That is not a workaround —
/// intl's plain `ar` locale declares `ZERO_DIGIT: '0'`, so `DateFormat` with
/// the `ar` locale already emits ASCII digits. It also keeps dates consistent
/// with prices and counts elsewhere in the app, which are printed straight
/// from Dart and are therefore always Western.
///
/// Date symbols for the active locale are loaded by
/// `GlobalMaterialLocalizations.delegate` (registered in `main.dart`), so the
/// locale-tagged constructors below are safe without a separate
/// `initializeDateFormatting` call. Passing the locale explicitly also matters:
/// the no-argument constructors follow `Intl.defaultLocale`, which this app
/// never sets, so they silently render English even in Arabic.
///
/// Wire formats — anything sent to the API — must NOT come from here. Use
/// [apiDate] / [apiDateTime], which are locale-independent by construction.
class AppDate {
  const AppDate._();

  static String _locale(BuildContext context) =>
      Localizations.localeOf(context).toString();

  // ─── Dates ────────────────────────────────────────────────────────────────

  /// `Dec 28, 2024` · `28 ديسمبر 2024`
  static String medium(BuildContext context, DateTime date) =>
      mediumFormat(context).format(date);

  /// [medium] as a reusable `DateFormat`, for call sites that format several
  /// dates in a row or need to chain `add_*` onto it. The locale is baked in,
  /// so the chained result stays localised.
  static DateFormat mediumFormat(BuildContext context) =>
      DateFormat.yMMMd(_locale(context));

  /// `Dec 28` · `28 ديسمبر` — no year, for dates already scoped to one year.
  static String dayMonth(BuildContext context, DateTime date) =>
      DateFormat.MMMd(_locale(context)).format(date);

  /// `December 2024` · `ديسمبر 2024`
  static String monthYear(BuildContext context, DateTime date) =>
      DateFormat.yMMMM(_locale(context)).format(date);

  /// `Dec` · `ديسمبر`
  static String monthAbbr(BuildContext context, DateTime date) =>
      DateFormat.MMM(_locale(context)).format(date);

  /// `Mon` · `الاثنين`
  static String weekdayAbbr(BuildContext context, DateTime date) =>
      DateFormat.E(_locale(context)).format(date);

  // ─── Times ────────────────────────────────────────────────────────────────

  /// `09:00` — 24-hour, used by appointments and working hours.
  static String time24(BuildContext context, DateTime time) =>
      DateFormat.Hm(_locale(context)).format(time);

  /// `9:30 AM` · `9:30 ص` — 12-hour, used by the treatment log.
  static String time12(BuildContext context, DateTime time) =>
      DateFormat.jm(_locale(context)).format(time);

  /// [time24] for a [TimeOfDay], which carries no date of its own.
  static String time24Of(BuildContext context, TimeOfDay time) =>
      time24(context, _dateFor(time));

  /// [time12] for a [TimeOfDay].
  static String time12Of(BuildContext context, TimeOfDay time) =>
      time12(context, _dateFor(time));

  // ─── Combined ─────────────────────────────────────────────────────────────

  /// `Dec 28, 2024 • 9:30 AM` · `28 ديسمبر 2024 • 9:30 ص`
  static String mediumWithTime12(BuildContext context, DateTime date) =>
      '${medium(context, date)} • ${time12(context, date)}';

  /// `28 Dec 2024 · 09:30` · `28 ديسمبر 2024 · 09:30`
  static String mediumWithTime24(BuildContext context, DateTime date) =>
      '${medium(context, date)} · ${time24(context, date)}';

  // ─── Wire formats — deliberately locale-independent ───────────────────────

  /// `2024-12-28` for API payloads and query parameters. Never shown to users.
  static String apiDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

  /// `2024-12-28 09:30:00` for API payloads. Never shown to users.
  static String apiDateTime(DateTime date) =>
      DateFormat('yyyy-MM-dd HH:mm:ss').format(date);

  /// A [TimeOfDay] has no date, but `DateFormat` needs one. The date part is
  /// discarded by every time-only pattern above.
  static DateTime _dateFor(TimeOfDay time) =>
      DateTime(2000, 1, 1, time.hour, time.minute);
}
