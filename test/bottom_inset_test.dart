import 'package:dental_clinic_app/core/resources/theme_manager.dart';
import 'package:dental_clinic_app/core/utils/system_insets.dart';
import 'package:dental_clinic_app/custom_widgets/denta_form.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

/// The app runs edge-to-edge, so every docked surface reserves the system
/// navigation bar itself. Two different rules apply and mixing them up is
/// what put the Save button under the navigation buttons:
///
///  * a modal sheet is never lifted for the keyboard, so it reserves
///    max(keyboard, navigation bar);
///  * a Scaffold-docked bar *is* lifted, so once the keyboard is up there is
///    nothing left to reserve.
///
/// These cases drive both from a MediaQuery whose values match a phone with
/// on-screen navigation buttons.
void main() {
  const navBar = 48.0;
  const keyboard = 300.0;

  /// A phone with a 48dp navigation bar. `padding` is derived the way
  /// Flutter derives it — viewPadding minus viewInsets — so an open keyboard
  /// collapses it to zero exactly as it does on a device.
  MediaQueryData phone({double keyboardHeight = 0}) {
    return MediaQueryData(
      size: const Size(400, 800),
      viewPadding: const EdgeInsets.only(bottom: navBar),
      viewInsets: EdgeInsets.only(bottom: keyboardHeight),
      padding: EdgeInsets.only(
        bottom: (navBar - keyboardHeight).clamp(0.0, navBar),
      ),
    );
  }

  Widget host(Widget child, {double keyboardHeight = 0}) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, _) => MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('ar')],
        theme: getApplicationThemeData(),
        home: MediaQuery(
          data: phone(keyboardHeight: keyboardHeight),
          child: child,
        ),
      ),
    );
  }

  group('inset helpers', () {
    testWidgets('a sheet keeps its reservation when the keyboard opens',
        (tester) async {
      late double closed;
      late double open;
      await tester.pumpWidget(
        host(Builder(builder: (c) {
          closed = systemBottomInset(c);
          return const SizedBox();
        })),
      );
      await tester.pumpWidget(
        host(
          Builder(builder: (c) {
            open = systemBottomInset(c);
            return const SizedBox();
          }),
          keyboardHeight: keyboard,
        ),
      );

      // The regression: SafeArea reads `padding`, which is zero here, so the
      // bar it wraps lands under the navigation buttons.
      expect(closed, navBar);
      expect(open, navBar);
    });

    testWidgets('a Scaffold bar hands its reservation to the keyboard',
        (tester) async {
      late double closed;
      late double open;
      await tester.pumpWidget(
        host(Builder(builder: (c) {
          closed = scaffoldBottomInset(c);
          return const SizedBox();
        })),
      );
      await tester.pumpWidget(
        host(
          Builder(builder: (c) {
            open = scaffoldBottomInset(c);
            return const SizedBox();
          }),
          keyboardHeight: keyboard,
        ),
      );

      // The Scaffold has already lifted the bar above the keyboard, so
      // reserving the navigation bar on top would just be a gap.
      expect(closed, navBar);
      expect(open, 0);
    });
  });

  group('FormSheetShell', () {
    Widget shell() => Align(
          alignment: Alignment.bottomCenter,
          child: FormSheetShell(
            title: 'Add expense',
            footer: const _Footer(),
            children: [SizedBox(height: 120.h)],
          ),
        );

    testWidgets('clears the navigation bar with the keyboard down',
        (tester) async {
      await tester.pumpWidget(host(shell()));
      await tester.pumpAndSettle();

      final sheet = tester.getRect(find.byType(FormSheetShell));
      final footer = tester.getRect(find.byType(_Footer));
      expect(sheet.bottom - footer.bottom, greaterThanOrEqualTo(navBar));
    });

    testWidgets('clears the keyboard with it up, and does not stack both',
        (tester) async {
      await tester.pumpWidget(host(shell(), keyboardHeight: keyboard));
      await tester.pumpAndSettle();

      final sheet = tester.getRect(find.byType(FormSheetShell));
      final footer = tester.getRect(find.byType(_Footer));
      final gap = sheet.bottom - footer.bottom;

      // At least the keyboard — the footer used to sit behind it.
      expect(gap, greaterThanOrEqualTo(keyboard));
      // An open keyboard already covers the navigation bar, so reserving
      // both would leave a dead 48dp band above it.
      expect(gap, lessThan(keyboard + navBar));
    });
  });
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) => const SizedBox(height: 44, width: 200);
}
