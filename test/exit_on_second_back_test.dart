import 'package:dental_clinic_app/core/utils/exit_on_second_back.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late int exits;

  setUp(() {
    exits = 0;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, (call) async {
      if (call.method == 'SystemNavigator.pop') exits++;
      return null;
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, null);
  });

  Future<BuildContext> host(WidgetTester tester) async {
    late BuildContext context;
    await tester.pumpWidget(ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, _) => MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(builder: (c) {
          context = c;
          return const SizedBox();
        }),
      ),
    ));
    return context;
  }

  testWidgets('one back only says how to leave', (tester) async {
    final context = await host(tester);
    ExitOnSecondBack().onBack(context);
    await tester.pump();

    expect(exits, 0);
    expect(find.text('Press back again to exit'), findsOneWidget);
    // Let the toast's timer run out before the test ends.
    await tester.pump(const Duration(seconds: 5));
  });

  testWidgets('a second back in time leaves the app', (tester) async {
    final context = await host(tester);
    final exit = ExitOnSecondBack();
    exit.onBack(context);
    await tester.pump();
    exit.onBack(context);
    await tester.pump();

    expect(exits, 1);
    await tester.pump(const Duration(seconds: 5));
  });
}
