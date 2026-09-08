import 'package:dental_clinic_app/features/appointments/domain/entities/appointment_entity.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/today_hero_card.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

/// The hero card is derived state - every number on it is computed from the
/// appointment list and the clock. These cases pin the derivations that are
/// easy to get subtly wrong: which appointment counts as "next", and which
/// ones belong in the ring at all.
void main() {
  AppointmentEntity appointment({
    required String name,
    required DateTime at,
    required AppointmentStatus status,
    int minutes = 30,
  }) {
    return AppointmentEntity(
      id: name,
      patientId: 'p-$name',
      patientName: name,
      doctorId: 'd1',
      doctorName: 'Dr. Smith',
      dateTime: at,
      durationMinutes: minutes,
      treatmentType: 'Cleaning',
      status: status,
    );
  }

  Widget host(List<AppointmentEntity> appointments) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, _) => MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('ar')],
        home: Scaffold(body: TodayHeroCard(appointments: appointments)),
      ),
    );
  }

  /// The card runs a periodic ticker, so every case has to take it off the
  /// tree before finishing or the test ends with a pending timer.
  Future<void> teardown(WidgetTester tester) =>
      tester.pumpWidget(const SizedBox.shrink());

  testWidgets('names the next appointment and counts down to it', (
    tester,
  ) async {
    final now = DateTime.now();
    await tester.pumpWidget(
      host([
        appointment(
          name: 'Omar',
          at: now.subtract(const Duration(hours: 1)),
          status: AppointmentStatus.completed,
        ),
        appointment(
          name: 'Sara',
          at: now.add(const Duration(minutes: 25, seconds: 5)),
          status: AppointmentStatus.confirmed,
        ),
      ]),
    );
    await tester.pumpAndSettle();

    expect(find.text('Sara'), findsOneWidget);
    expect(find.text('in 25 min'), findsOneWidget);
    expect(find.text('1 of 2 done'), findsOneWidget);

    await teardown(tester);
  });

  testWidgets('an appointment already under way is the one shown, as Now', (
    tester,
  ) async {
    final now = DateTime.now();
    await tester.pumpWidget(
      host([
        appointment(
          name: 'Layla',
          at: now.subtract(const Duration(minutes: 10)),
          status: AppointmentStatus.confirmed,
        ),
        appointment(
          name: 'Sara',
          at: now.add(const Duration(hours: 1)),
          status: AppointmentStatus.scheduled,
        ),
      ]),
    );
    await tester.pumpAndSettle();

    expect(find.text('Layla'), findsOneWidget);
    expect(find.text('Now'), findsOneWidget);

    await teardown(tester);
  });

  testWidgets('a settled day reads as complete, with the ring full', (
    tester,
  ) async {
    final now = DateTime.now();
    await tester.pumpWidget(
      host([
        appointment(
          name: 'Omar',
          at: now.subtract(const Duration(hours: 2)),
          status: AppointmentStatus.completed,
        ),
        appointment(
          name: 'Sara',
          at: now.subtract(const Duration(hours: 1)),
          status: AppointmentStatus.noShow,
        ),
      ]),
    );
    await tester.pumpAndSettle();

    expect(find.text('Day complete'), findsOneWidget);
    // A no-show is settled, not outstanding - the ring reaches full.
    expect(find.text('2 of 2 done'), findsOneWidget);

    await teardown(tester);
  });

  testWidgets('cancellations are left out of the count entirely', (
    tester,
  ) async {
    final now = DateTime.now();
    await tester.pumpWidget(
      host([
        appointment(
          name: 'Omar',
          at: now.subtract(const Duration(hours: 1)),
          status: AppointmentStatus.completed,
        ),
        appointment(
          name: 'Sara',
          at: now.add(const Duration(minutes: 30)),
          status: AppointmentStatus.cancelledByPatient,
        ),
      ]),
    );
    await tester.pumpAndSettle();

    // One live appointment, and it is done: the ring is full rather than
    // stuck at half by a slot nobody can ever complete.
    expect(find.text('1 of 1 done'), findsOneWidget);
    expect(find.text('Sara'), findsNothing);

    await teardown(tester);
  });

  testWidgets('a day with nothing live takes up no space', (tester) async {
    final now = DateTime.now();
    await tester.pumpWidget(
      host([
        appointment(
          name: 'Sara',
          at: now.add(const Duration(minutes: 30)),
          status: AppointmentStatus.cancelledByClinic,
        ),
      ]),
    );
    await tester.pumpAndSettle();

    expect(tester.getSize(find.byType(TodayHeroCard)), Size.zero);

    await teardown(tester);
  });
}
