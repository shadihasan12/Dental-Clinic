import 'package:dental_clinic_app/features/home/domain/entities/home_card.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/home_stats_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

/// The carousel's whole job is to render what the server sent, unchanged and
/// in order. These cases pin the four ways that could quietly stop being true:
/// a hard-coded card count, a client-side sort, a reformatted figure, and a
/// null unit leaking onto the card as text.
void main() {
  /// A phone, not the 800x600 default. ScreenUtil scales against 375x812, so
  /// the default test surface stretches every `.w` by 2.1 and squashes every
  /// `.h` - proportions no device has, and the card is laid out in both.
  void useHandsetSurface(WidgetTester tester) {
    tester.view.physicalSize = const Size(375 * 3, 812 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
  }

  Widget host(List<HomeCard> cards) => ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, _) => MaterialApp(
          home: Scaffold(body: HomeStatsCarousel(cards: cards)),
        ),
      );

  HomeCard card({
    String key = 'total_revenue_usd',
    String title = 'Total revenue',
    String subtitle = 'This month',
    String value = '17,060.00',
    String? unit = 'USD',
  }) =>
      HomeCard(
        key: key,
        title: title,
        subtitle: subtitle,
        value: value,
        unit: unit,
      );

  testWidgets('renders the figure exactly as the server formatted it', (
    tester,
  ) async {
    useHandsetSurface(tester);
    await tester.pumpWidget(host([card(value: '4,000,000.00')]));

    // Grouped, two decimals, Western digits - all the server's decisions.
    expect(find.text('4,000,000.00'), findsOneWidget);
    expect(find.text('USD'), findsOneWidget);
  });

  testWidgets('a null unit draws nothing, not the word null', (tester) async {
    useHandsetSurface(tester);
    await tester.pumpWidget(
      host([card(key: 'total_cases', title: 'Cases', value: '42', unit: null)]),
    );

    expect(find.text('42'), findsOneWidget);
    expect(find.text('null'), findsNothing);
  });

  testWidgets('a lone card gets no dots to swipe towards', (tester) async {
    useHandsetSurface(tester);
    await tester.pumpWidget(host([card()]));

    expect(find.byType(PageView), findsNothing);
    expect(find.byType(AnimatedContainer), findsNothing);
  });

  testWidgets('the card count is the response, not a constant', (tester) async {
    useHandsetSurface(tester);
    await tester.pumpWidget(
      host([
        card(key: 'total_revenue_syp', value: '4,000,000.00', unit: 'SYP'),
        card(key: 'total_revenue_usd', value: '17,060.00', unit: 'USD'),
        card(key: 'total_revenue_try', value: '900.00', unit: 'TRY'),
        card(key: 'total_cases', title: 'Cases', value: '42', unit: null),
      ]),
    );

    // One dot per card, however many arrive - a fourth currency must not need
    // an app release.
    expect(find.byType(AnimatedContainer), findsNWidgets(4));
  });

  testWidgets('the first card is the first one sent', (tester) async {
    useHandsetSurface(tester);
    await tester.pumpWidget(
      host([
        card(key: 'total_revenue_syp', value: '4,000,000.00', unit: 'SYP'),
        card(key: 'total_revenue_usd', value: '17,060.00', unit: 'USD'),
      ]),
    );

    // The server orders these - largest first - so a client-side sort by
    // currency code or by the numeric value would reorder them wrongly.
    expect(find.text('4,000,000.00'), findsOneWidget);
  });

  testWidgets('an empty list hides the carousel entirely', (tester) async {
    useHandsetSurface(tester);
    await tester.pumpWidget(host(const []));

    // A secretary gets `"cards": []` and is not meant to see these figures -
    // no placeholder, no zero, no empty band.
    expect(find.byType(PageView), findsNothing);
    expect(find.byType(HomeStatCard), findsNothing);
  });

  testWidgets('the loading state reserves the height it will occupy', (
    tester,
  ) async {
    useHandsetSurface(tester);
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, _) => const MaterialApp(
          home: Scaffold(
            body: HomeStatsCarousel(cards: [], isLoading: true),
          ),
        ),
      ),
    );

    // Same box as the loaded carousel, so the page below does not jump when
    // the figures land.
    expect(
      tester.getSize(find.byType(HomeStatsCarousel)).height,
      HomeStatsCarousel.totalHeight,
    );
  });
}
