import 'package:dental_clinic_app/core/widgets/directional_chevron.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

/// The drill-in chevron has to end up pointing at the row's text in both
/// languages. Which way the glyph faces is only half of that — the other
/// half is which edge the layout put it on — so these cases assert the
/// mirror, not the appearance.
void main() {
  Widget host(Widget child, {required Locale locale}) {
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
        home: Scaffold(body: child),
      ),
    );
  }

  /// True when the glyph was flipped about its own centre.
  bool mirrored(WidgetTester tester) {
    final transforms = tester.widgetList<Transform>(
      find.ancestor(
        of: find.byIcon(Icons.chevron_right),
        matching: find.byType(Transform),
      ),
    );
    return transforms.any((t) => t.transform.entry(0, 0) < 0);
  }

  testWidgets('English: drawn as-is, trailing the text', (tester) async {
    await tester.pumpWidget(
      host(const DirectionalChevron(), locale: const Locale('en')),
    );
    await tester.pumpAndSettle();
    expect(mirrored(tester), isFalse);
  });

  testWidgets('Arabic, normal row: not mirrored — the layout already moved '
      'it to the other edge, so it points back at the text', (tester) async {
    await tester.pumpWidget(
      host(const DirectionalChevron(), locale: const Locale('ar')),
    );
    await tester.pumpAndSettle();
    expect(mirrored(tester), isFalse);
  });

  testWidgets('Arabic, LTR-pinned row: mirrored — the chevron stayed on the '
      'right, so the glyph has to turn around', (tester) async {
    await tester.pumpWidget(
      host(
        DirectionalChevron.pinLtr(child: const DirectionalChevron()),
        locale: const Locale('ar'),
      ),
    );
    await tester.pumpAndSettle();
    expect(mirrored(tester), isTrue);
  });

  testWidgets('English, LTR-pinned row: unchanged', (tester) async {
    await tester.pumpWidget(
      host(
        DirectionalChevron.pinLtr(child: const DirectionalChevron()),
        locale: const Locale('en'),
      ),
    );
    await tester.pumpAndSettle();
    expect(mirrored(tester), isFalse);
  });
}
