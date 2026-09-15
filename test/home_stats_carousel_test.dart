import 'package:dental_clinic_app/features/home/domain/entities/home_summary.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/home_stats_carousel.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

/// The Home carousel is the one place on the screen where a design reference
/// supplied example data - seven bars at fixed heights. These cases pin the
/// line between drawing the clinic's numbers and drawing the designer's, and
/// the rule that the card count is the server's rather than a hard-coded
/// three.
void main() {
  /// A phone, not the 800x600 default. ScreenUtil scales against 375x812, so
  /// the default test surface stretches every `.w` by 2.1 and squashes every
  /// `.h` - proportions no device has, and the card is laid out in both.
  void useHandsetSurface(WidgetTester tester) {
    tester.view.physicalSize = const Size(375 * 3, 812 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
  }

  Widget host(HomeSummary? summary, {Locale locale = const Locale('en')}) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, _) => MaterialApp(
        locale: locale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('ar')],
        home: Scaffold(body: HomeStatsCarousel(summary: summary)),
      ),
    );
  }

  HomeSummary oneRevenue({
    double value = 0,
    String? currencyCode,
    List<double> recentDaily = const [],
  }) => HomeSummary(
    stats: [
      HomeStat(
        kind: HomeStatKind.revenue,
        value: value,
        currencyCode: currencyCode,
        recentDaily: recentDaily,
      ),
    ],
  );

  List<double> barHeights(WidgetTester tester) => [
    for (var i = 0; i < 7; i++)
      tester.getSize(find.byKey(HomeStatCard.barKey(i))).height,
  ];

  testWidgets('with no series the bars stay flat, not the reference shape', (
    tester,
  ) async {
    useHandsetSurface(tester);
    await tester.pumpWidget(host(oneRevenue()));
    await tester.pumpAndSettle();

    final heights = barHeights(tester);
    expect(heights, everyElement(greaterThan(0)));
    // All equal: the card draws no shape it was not given.
    expect(heights.toSet().length, 1);
  });

  testWidgets('a series drives the heights, tallest last when today is', (
    tester,
  ) async {
    useHandsetSurface(tester);
    await tester.pumpWidget(
      host(
        oneRevenue(value: 700, recentDaily: const [10, 20, 30, 40, 50, 60, 70]),
      ),
    );
    await tester.pumpAndSettle();

    final heights = barHeights(tester);
    for (var i = 1; i < heights.length; i++) {
      expect(heights[i], greaterThan(heights[i - 1]));
    }
  });

  testWidgets('a short series is padded at the front, today still last', (
    tester,
  ) async {
    useHandsetSurface(tester);
    await tester.pumpWidget(
      host(oneRevenue(value: 90, recentDaily: const [30, 90])),
    );
    await tester.pumpAndSettle();

    final heights = barHeights(tester);
    // Five empty days, then the two we have - the newest in the last slot.
    expect(heights.take(5).toSet().length, 1);
    expect(heights[6], greaterThan(heights[5]));
  });

  testWidgets('an empty month reads as zero rather than vanishing', (
    tester,
  ) async {
    useHandsetSurface(tester);
    await tester.pumpWidget(host(oneRevenue()));
    await tester.pumpAndSettle();

    expect(find.text('0'), findsOneWidget);
    expect(find.text('TOTAL REVENUE'), findsOneWidget);
  });

  testWidgets('no figures at all draws nothing', (tester) async {
    useHandsetSurface(tester);
    await tester.pumpWidget(host(null));
    await tester.pumpAndSettle();
    expect(tester.getSize(find.byType(HomeStatsCarousel)), Size.zero);

    await tester.pumpWidget(host(const HomeSummary.empty()));
    await tester.pumpAndSettle();
    expect(tester.getSize(find.byType(HomeStatsCarousel)), Size.zero);
  });

  testWidgets('the currency is shown only when the server sent one', (
    tester,
  ) async {
    useHandsetSurface(tester);
    await tester.pumpWidget(host(oneRevenue(value: 1200, currencyCode: 'USD')));
    await tester.pumpAndSettle();
    expect(find.text('USD · This month'), findsOneWidget);

    await tester.pumpWidget(host(oneRevenue(value: 1200)));
    await tester.pumpAndSettle();
    expect(find.text('This month'), findsOneWidget);
  });

  testWidgets('a lone figure gets no dots to advertise a second card', (
    tester,
  ) async {
    useHandsetSurface(tester);
    await tester.pumpWidget(host(oneRevenue(value: 1200)));
    await tester.pumpAndSettle();

    expect(find.byType(PageView), findsNothing);
  });

  testWidgets('the server decides how many cards there are', (tester) async {
    useHandsetSurface(tester);
    const summary = HomeSummary(
      stats: [
        HomeStat(kind: HomeStatKind.patients, value: 248, newInPeriod: 12),
        HomeStat(kind: HomeStatKind.revenue, value: 4180, currencyCode: 'USD'),
        HomeStat(
          kind: HomeStatKind.revenue,
          value: 12500000,
          currencyCode: 'SYP',
        ),
      ],
    );

    await tester.pumpWidget(host(summary));
    await tester.pumpAndSettle();

    // Patients first, and its intake line rather than a currency.
    expect(find.text('TOTAL PATIENTS'), findsOneWidget);
    expect(find.text('248'), findsOneWidget);
    expect(find.text('12 new this month'), findsOneWidget);

    // The two currencies are separate cards and are never added together.
    await tester.drag(find.byType(PageView), const Offset(-400, 0));
    await tester.pumpAndSettle();
    expect(find.text('USD · This month'), findsOneWidget);

    await tester.drag(find.byType(PageView), const Offset(-400, 0));
    await tester.pumpAndSettle();
    expect(find.text('SYP · This month'), findsOneWidget);
    expect(find.text('12,500,000'), findsOneWidget);
  });
}
