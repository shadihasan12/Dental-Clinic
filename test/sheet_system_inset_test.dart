import 'package:dental_clinic_app/custom_widgets/adaptive_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Three-button navigation: a 48 dp bar the app draws behind (edge to edge).
const _navBar = 48.0;

Widget _host({required Widget child, double keyboard = 0}) => MediaQuery(
      data: const MediaQueryData(
        size: Size(400, 800),
        viewPadding: EdgeInsets.only(bottom: _navBar),
        padding: EdgeInsets.only(bottom: _navBar),
      ).copyWith(viewInsets: EdgeInsets.only(bottom: keyboard)),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Align(alignment: Alignment.bottomCenter, child: child),
      ),
    );

void main() {
  setUp(() {
    final view = TestWidgetsFlutterBinding.instance.platformDispatcher.views.first;
    view.physicalSize = const Size(400, 800);
    view.devicePixelRatio = 1;
  });
  tearDown(() {
    final view = TestWidgetsFlutterBinding.instance.platformDispatcher.views.first;
    view.resetPhysicalSize();
    view.resetDevicePixelRatio();
  });

  testWidgets('lifts the sheet above the navigation bar, once', (tester) async {
    double? seenInset;
    await tester.pumpWidget(_host(
      child: SheetSystemInset(
        color: Colors.white,
        child: Builder(builder: (context) {
          // What a sheet reserving the inset itself would add.
          seenInset = MediaQuery.viewPaddingOf(context).bottom;
          return const SizedBox(key: Key('sheet'), height: 200);
        }),
      ),
    ));

    final sheet = tester.getRect(find.byKey(const Key('sheet')));
    expect(sheet.bottom, 800 - _navBar);
    // Already reserved here, so the sheet must not reserve it again.
    expect(seenInset, 0);
  });

  testWidgets('steps aside while the keyboard is up', (tester) async {
    await tester.pumpWidget(_host(
      keyboard: 300,
      child: const SheetSystemInset(
        color: Colors.white,
        child: SizedBox(key: Key('sheet'), height: 200),
      ),
    ));

    expect(tester.getRect(find.byKey(const Key('sheet'))).bottom, 800);
  });
}
