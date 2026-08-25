import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/theme_manager.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/presentation/widgets/notification_settings_tile.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

/// The settings row carries on/off the way DENTA_STYLE carries status: a 3px
/// strip on the leading edge plus an icon tile in the same hue.
void main() {
  Widget host(Widget child, {Locale locale = const Locale('en')}) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, _) => MaterialApp(
        locale: locale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('ar')],
        theme: getApplicationThemeData(),
        home: Scaffold(body: child),
      ),
    );
  }

  Widget tile({required bool value, bool isPending = false}) =>
      NotificationSettingsTile(
        icon: Icons.calendar_month_outlined,
        iconColor: ColorManager.info,
        title: 'Appointment reminders',
        subtitle: 'Sent the day before a visit.',
        value: value,
        isPending: isPending,
        onChanged: (_) {},
      );

  AppCard card(WidgetTester tester) =>
      tester.widget<AppCard>(find.byType(AppCard));

  testWidgets('on: the card carries the category hue on its leading edge',
      (tester) async {
    await tester.pumpWidget(host(tile(value: true)));
    await tester.pumpAndSettle();
    expect(card(tester).statusTone, ColorManager.info);
  });

  testWidgets('off: no strip, and the icon tile drops to grey', (tester) async {
    await tester.pumpWidget(host(tile(value: false)));
    await tester.pumpAndSettle();

    expect(card(tester).statusTone, isNull);
    final iconTile = tester.widget<IconTile>(find.byType(IconTile));
    expect(iconTile.tone, isNot(ColorManager.info));
  });

  testWidgets('a toggle in flight cannot be tapped again', (tester) async {
    await tester.pumpWidget(host(tile(value: true, isPending: true)));
    await tester.pumpAndSettle();
    expect(tester.widget<Switch>(find.byType(Switch)).onChanged, isNull);
  });

  testWidgets('the strip sits on the trailing side of the screen in Arabic',
      (tester) async {
    await tester.pumpWidget(
      host(tile(value: true), locale: const Locale('ar')),
    );
    await tester.pumpAndSettle();

    // PositionedDirectional resolves against the ambient direction, so the
    // 3px strip has to land on the right edge of the card, not the left.
    final cardRect = tester.getRect(find.byType(AppCard));
    final strip = tester.getRect(
      find.descendant(
        of: find.byType(AppCard),
        matching: find.byType(ColoredBox),
      ),
    );
    expect(strip.right, closeTo(cardRect.right, 0.5));
  });

  testWidgets('the count pill states what it counts', (tester) async {
    await tester.pumpWidget(
      host(
        Builder(
          builder: (context) {
            final l10n = AppLocalizations.of(context)!;
            return CountPill.label(l10n.categoriesOnCount(3, 5));
          },
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('3 of 5 on'), findsOneWidget);
  });
}
