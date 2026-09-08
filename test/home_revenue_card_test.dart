import 'package:dental_clinic_app/features/home/presentation/widgets/home_revenue_card.dart';
import 'package:dental_clinic_app/features/statistics/domain/entities/revenue_summary.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

/// The revenue card is the one place on Home where a design reference
/// supplied example data - seven bars at fixed heights. These cases pin the
/// line between drawing the clinic's numbers and drawing the designer's.
void main() {
  Widget host(RevenueSummary? summary, {Locale locale = const Locale('en')}) {
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
        home: Scaffold(body: HomeRevenueCard(summary: summary)),
      ),
    );
  }

  List<double> barHeights(WidgetTester tester) => [
    for (var i = 0; i < 7; i++)
      tester.getSize(find.byKey(HomeRevenueCard.barKey(i))).height,
  ];

  testWidgets('with no series the bars stay flat, not the reference shape', (
    tester,
  ) async {
    await tester.pumpWidget(host(const RevenueSummary.empty()));
    await tester.pumpAndSettle();

    final heights = barHeights(tester);
    expect(heights, everyElement(greaterThan(0)));
    // All equal: the card draws no shape it was not given.
    expect(heights.toSet().length, 1);
  });

  testWidgets('a series drives the heights, tallest last when today is', (
    tester,
  ) async {
    await tester.pumpWidget(
      host(
        const RevenueSummary(
          value: 700,
          recentDaily: [10, 20, 30, 40, 50, 60, 70],
        ),
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
    await tester.pumpWidget(
      host(const RevenueSummary(value: 90, recentDaily: [30, 90])),
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
    await tester.pumpWidget(host(const RevenueSummary.empty()));
    await tester.pumpAndSettle();

    expect(find.text('0'), findsOneWidget);
    expect(find.text('TOTAL REVENUE'), findsOneWidget);
  });

  testWidgets('no revenue metric at all draws nothing', (tester) async {
    await tester.pumpWidget(host(null));
    await tester.pumpAndSettle();

    expect(tester.getSize(find.byType(HomeRevenueCard)), Size.zero);
  });

  testWidgets('the currency is shown only when the server sent one', (
    tester,
  ) async {
    await tester.pumpWidget(
      host(const RevenueSummary(value: 1200, currencyCode: 'USD')),
    );
    await tester.pumpAndSettle();
    expect(find.text('USD · This month'), findsOneWidget);

    await tester.pumpWidget(host(const RevenueSummary(value: 1200)));
    await tester.pumpAndSettle();
    expect(find.text('This month'), findsOneWidget);
  });
}
