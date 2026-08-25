import 'package:dental_clinic_app/features/patients/presentation/widgets/patient_card.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_test/flutter_test.dart';

/// Covers the swipe pane on the patients list: the actions must be hidden
/// until the row is dragged, must fire the callbacks the list page wires
/// up, and must not appear at all when the caller withholds them.
void main() {
  Widget host(
    Widget child, {
    Locale locale = const Locale('en'),
  }) {
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
        home: Scaffold(
          body: SlidableAutoCloseBehavior(
            child: ListView(children: [child]),
          ),
        ),
      ),
    );
  }

  const patient = Patient(
    id: 'p1',
    name: 'Sara Khaled',
    age: 32,
    gender: 'female',
    phone: '+971500000000',
    balance: 0,
  );

  testWidgets('actions stay hidden until the row is swiped', (tester) async {
    await tester.pumpWidget(
      host(
        PatientCard(
          patient: patient,
          onTap: () {},
          onEdit: () {},
          onDelete: () {},
        ),
      ),
    );
    await tester.pumpAndSettle();

    // The pane exists in the tree but is collapsed to zero extent.
    expect(find.text('Sara Khaled'), findsOneWidget);
    expect(find.byIcon(Icons.edit_outlined), findsNothing);
    expect(find.byIcon(Icons.delete_outline), findsNothing);
  });

  testWidgets('swiping left reveals edit and delete', (tester) async {
    await tester.pumpWidget(
      host(
        PatientCard(
          patient: patient,
          onTap: () {},
          onEdit: () {},
          onDelete: () {},
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.drag(find.text('Sara Khaled'), const Offset(-250, 0));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.edit_outlined), findsOneWidget);
    expect(find.byIcon(Icons.delete_outline), findsOneWidget);
    expect(find.text('Edit'), findsOneWidget);
    expect(find.text('Delete'), findsOneWidget);
  });

  testWidgets('each action fires its callback', (tester) async {
    var edited = 0;
    var deleted = 0;
    var tapped = 0;

    Future<void> pumpCard() async {
      await tester.pumpWidget(
        host(
          PatientCard(
            patient: patient,
            onTap: () => tapped++,
            onEdit: () => edited++,
            onDelete: () => deleted++,
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    await pumpCard();
    await tester.drag(find.text('Sara Khaled'), const Offset(-250, 0));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.edit_outlined));
    await tester.pumpAndSettle();
    expect(edited, 1);
    // Pressing an action must not also register as a tap on the card.
    expect(tapped, 0);
    // …and the pane closes itself afterwards.
    expect(find.byIcon(Icons.edit_outlined), findsNothing);

    await tester.drag(find.text('Sara Khaled'), const Offset(-250, 0));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();
    expect(deleted, 1);
    expect(tapped, 0);
  });

  testWidgets('tapping the closed card still opens the patient',
      (tester) async {
    var tapped = 0;
    await tester.pumpWidget(
      host(
        PatientCard(
          patient: patient,
          onTap: () => tapped++,
          onEdit: () {},
          onDelete: () {},
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Sara Khaled'));
    await tester.pumpAndSettle();
    expect(tapped, 1);
  });

  testWidgets('no swipe pane when the caller supplies no actions',
      (tester) async {
    await tester.pumpWidget(
      host(PatientCard(patient: patient, onTap: () {})),
    );
    await tester.pumpAndSettle();

    expect(find.byType(Slidable), findsNothing);

    await tester.drag(find.text('Sara Khaled'), const Offset(-250, 0));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.edit_outlined), findsNothing);
  });

  testWidgets('Arabic opens from the leading edge', (tester) async {
    await tester.pumpWidget(
      host(
        PatientCard(
          patient: patient,
          onTap: () {},
          onEdit: () {},
          onDelete: () {},
        ),
        locale: const Locale('ar'),
      ),
    );
    await tester.pumpAndSettle();

    // RTL flips the trailing edge, so the same pane is reached by dragging
    // the opposite way.
    await tester.drag(find.text('Sara Khaled'), const Offset(250, 0));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.edit_outlined), findsOneWidget);
    expect(find.byIcon(Icons.delete_outline), findsOneWidget);
  });
}
