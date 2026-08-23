import 'package:dental_clinic_app/features/profile/presentation/pages/issues/domain/entities/issue_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/presentation/widgets/issue_card.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/presentation/widgets/issues_list_states.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/presentation/widgets/new_issue_form.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/theme_manager.dart';
import 'package:flutter_test/flutter_test.dart';

/// Covers the Report an Issue surface: the compose form's required-field
/// rules, the status rendering on a filed report, and the list's empty
/// state — in English and Arabic.
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
        home: Scaffold(body: SingleChildScrollView(child: child)),
      ),
    );
  }

  group('NewIssueForm', () {
    testWidgets('send stays disabled until title and description are filled',
        (tester) async {
      await tester.pumpWidget(
        host(
          NewIssueForm(
            isSubmitting: false,
            errorMessage: null,
            onSubmit: (_, _) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      FilledButton button() =>
          tester.widget<FilledButton>(find.byType(FilledButton));

      expect(button().onPressed, isNull, reason: 'both fields empty');

      await tester.enterText(find.byType(TextFormField).first, 'Cannot log in');
      await tester.pumpAndSettle();
      expect(button().onPressed, isNull, reason: 'description still empty');

      await tester.enterText(
        find.byType(TextFormField).last,
        'It returns invalid credentials every time.',
      );
      await tester.pumpAndSettle();
      expect(button().onPressed, isNotNull, reason: 'both fields filled');
    });

    testWidgets('whitespace-only input never reaches submit', (tester) async {
      var submissions = 0;
      await tester.pumpWidget(
        host(
          NewIssueForm(
            isSubmitting: false,
            errorMessage: null,
            onSubmit: (_, _) => submissions++,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).first, '   ');
      await tester.enterText(find.byType(TextFormField).last, '   ');
      await tester.pumpAndSettle();

      // The enabled-check trims too, so blanks are caught before the
      // validators ever run — the button simply stays dead.
      expect(
        tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNull,
      );

      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();
      expect(submissions, 0);
    });

    testWidgets('submits the trimmed values', (tester) async {
      String? gotTitle;
      String? gotDescription;
      await tester.pumpWidget(
        host(
          NewIssueForm(
            isSubmitting: false,
            errorMessage: null,
            onSubmit: (t, d) {
              gotTitle = t;
              gotDescription = d;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).first, '  Crash  ');
      await tester.enterText(
        find.byType(TextFormField).last,
        '  Happens on save.  ',
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      expect(gotTitle, 'Crash');
      expect(gotDescription, 'Happens on save.');
    });

    testWidgets('shows a spinner and blocks input while submitting',
        (tester) async {
      await tester.pumpWidget(
        host(
          NewIssueForm(
            isSubmitting: true,
            errorMessage: null,
            onSubmit: (_, _) {},
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(
        tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNull,
      );
    });

    testWidgets('the send label is actually visible', (tester) async {
      await tester.pumpWidget(
        host(
          NewIssueForm(
            isSubmitting: false,
            errorMessage: null,
            onSubmit: (_, _) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Regression: the label used to be squeezed to zero height when an
      // outer SizedBox fought the theme's button padding, leaving a blank
      // button. Finding the text is not enough — assert it has size.
      final label = find.text('Send report');
      expect(label, findsOneWidget);
      expect(tester.getSize(label).height, greaterThan(0));
      expect(tester.getSize(label).width, greaterThan(0));
    });

    testWidgets('renders a rejected create against the form', (tester) async {
      await tester.pumpWidget(
        host(
          NewIssueForm(
            isSubmitting: false,
            errorMessage: 'Server refused the report',
            onSubmit: (_, _) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Server refused the report'), findsOneWidget);
    });
  });

  group('IssueCard', () {
    IssueEntity issue(IssueStatus status) => IssueEntity(
          id: '1',
          title: 'Appointment reminders not arriving',
          description: 'No push since Tuesday on two devices.',
          status: status,
          createdAt: DateTime(2026, 8, 22, 14, 3),
        );

    testWidgets('labels each status in English', (tester) async {
      for (final entry in {
        IssueStatus.pending: 'Pending',
        IssueStatus.inProgress: 'In progress',
        IssueStatus.done: 'Done',
      }.entries) {
        await tester.pumpWidget(host(IssueCard(issue: issue(entry.key))));
        await tester.pumpAndSettle();
        expect(find.text(entry.value), findsOneWidget);
      }
    });

    testWidgets('labels each status in Arabic', (tester) async {
      for (final entry in {
        IssueStatus.pending: 'قيد الانتظار',
        IssueStatus.inProgress: 'قيد المعالجة',
        IssueStatus.done: 'تم',
      }.entries) {
        await tester.pumpWidget(
          host(IssueCard(issue: issue(entry.key)), locale: const Locale('ar')),
        );
        await tester.pumpAndSettle();
        expect(find.text(entry.value), findsOneWidget);
      }
    });

    testWidgets('shows title, description and date', (tester) async {
      await tester.pumpWidget(host(IssueCard(issue: issue(IssueStatus.done))));
      await tester.pumpAndSettle();

      expect(find.text('Appointment reminders not arriving'), findsOneWidget);
      expect(find.text('No push since Tuesday on two devices.'), findsOneWidget);
      expect(find.textContaining('22 Aug 2026'), findsOneWidget);
    });

    testWidgets('omits the date line when the server sent none',
        (tester) async {
      await tester.pumpWidget(
        host(
          const IssueCard(
            issue: IssueEntity(
              id: '2',
              title: 'No timestamp',
              description: 'Server omitted created_at.',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('No timestamp'), findsOneWidget);
      expect(find.textContaining('2026'), findsNothing);
    });
  });

  group('list states', () {
    testWidgets('empty state explains what will appear', (tester) async {
      await tester.pumpWidget(host(const IssuesEmptyState()));
      await tester.pumpAndSettle();

      expect(find.text('No reports yet'), findsOneWidget);
    });

    testWidgets('error state names the failure and offers retry',
        (tester) async {
      var retries = 0;
      await tester.pumpWidget(
        host(
          IssuesErrorState(
            message: 'No internet connection',
            onRetry: () => retries++,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Could not load your reports'), findsOneWidget);
      expect(find.text('No internet connection'), findsOneWidget);

      // Regression: the app's outlinedButtonTheme asks for 16px vertical
      // padding and a 56px minimum, so pinning this button to a shorter
      // fixed height collapsed the label to zero and it rendered blank.
      expect(tester.getSize(find.text('Retry')).height, greaterThan(0));

      await tester.tap(find.text('Retry'));
      await tester.pumpAndSettle();
      expect(retries, 1);
    });
  });

  group('IssueStatus.fromWire', () {
    test('maps the documented values and falls back to pending', () {
      expect(IssueStatus.fromWire('pending'), IssueStatus.pending);
      expect(IssueStatus.fromWire('in_progress'), IssueStatus.inProgress);
      expect(IssueStatus.fromWire('IN_PROGRESS'), IssueStatus.inProgress);
      expect(IssueStatus.fromWire('done'), IssueStatus.done);
      expect(IssueStatus.fromWire('resolved'), IssueStatus.done);
      // An unknown status must still show the report, not hide it.
      expect(IssueStatus.fromWire('escalated'), IssueStatus.pending);
      expect(IssueStatus.fromWire(null), IssueStatus.pending);
    });
  });
}
