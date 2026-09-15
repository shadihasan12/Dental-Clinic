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
  /// A phone, not the 800x600 default. The compose form is laid out with
  /// ScreenUtil against 375x812, and the send button now sits below the fold
  /// of the default surface since the category field was added.
  void useHandsetSurface(WidgetTester tester) {
    tester.view.physicalSize = const Size(375 * 3, 812 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
  }

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
    // The categories the server would have supplied. The form cannot submit
    // without one, so every case that reaches the button has to pick.
    const categories = [
      IssueOptionEntity(value: 'BUG', label: 'Bug'),
      IssueOptionEntity(value: 'BILLING', label: 'Billing'),
    ];

    Widget form({
      bool isSubmitting = false,
      String? errorMessage,
      List<IssueOptionEntity> options = categories,
      bool isLoadingCategories = false,
      String? categoriesError,
      VoidCallback? onRetryCategories,
      void Function(String, String, String, List<String>)? onSubmit,
    }) => NewIssueForm(
      isSubmitting: isSubmitting,
      errorMessage: errorMessage,
      categories: options,
      isLoadingCategories: isLoadingCategories,
      categoriesError: categoriesError,
      onRetryCategories: onRetryCategories ?? () {},
      onSubmit: onSubmit ?? (_, _, _, _) {},
    );

    Future<void> pickCategory(WidgetTester tester, String label) async {
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text(label).last);
      await tester.pumpAndSettle();
    }

    FilledButton button(WidgetTester tester) =>
        tester.widget<FilledButton>(find.byType(FilledButton));

    testWidgets('send stays disabled until every required field is answered', (
      tester,
    ) async {
      useHandsetSurface(tester);
      await tester.pumpWidget(host(form()));
      await tester.pumpAndSettle();

      expect(button(tester).onPressed, isNull, reason: 'nothing answered');

      await pickCategory(tester, 'Bug');
      expect(button(tester).onPressed, isNull, reason: 'no title or body');

      await tester.enterText(find.byType(TextFormField).first, 'Cannot log in');
      await tester.pumpAndSettle();
      expect(button(tester).onPressed, isNull, reason: 'description empty');

      await tester.enterText(
        find.byType(TextFormField).last,
        'It returns invalid credentials every time.',
      );
      await tester.pumpAndSettle();
      expect(button(tester).onPressed, isNotNull, reason: 'all three filled');
    });

    testWidgets('whitespace-only input never reaches submit', (tester) async {
      useHandsetSurface(tester);
      var submissions = 0;
      await tester.pumpWidget(
        host(form(onSubmit: (_, _, _, _) => submissions++)),
      );
      await tester.pumpAndSettle();
      await pickCategory(tester, 'Bug');

      await tester.enterText(find.byType(TextFormField).first, '   ');
      await tester.enterText(find.byType(TextFormField).last, '   ');
      await tester.pumpAndSettle();

      // The enabled-check trims too, so blanks are caught before the
      // validators ever run — the button simply stays dead.
      expect(button(tester).onPressed, isNull);

      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();
      expect(submissions, 0);
    });

    testWidgets('submits the category wire value and the trimmed text', (
      tester,
    ) async {
      useHandsetSurface(tester);
      String? gotCategory;
      String? gotTitle;
      String? gotDescription;
      List<String>? gotMedia;

      await tester.pumpWidget(
        host(
          form(
            onSubmit: (category, title, description, mediaIds) {
              gotCategory = category;
              gotTitle = title;
              gotDescription = description;
              gotMedia = mediaIds;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      await pickCategory(tester, 'Billing');
      await tester.enterText(find.byType(TextFormField).first, '  Crash  ');
      await tester.enterText(
        find.byType(TextFormField).last,
        '  Happens on save.  ',
      );
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.byType(FilledButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      // The label is what the user picked; the wire value is what is sent.
      expect(gotCategory, 'BILLING');
      expect(gotTitle, 'Crash');
      expect(gotDescription, 'Happens on save.');
      expect(gotMedia, isEmpty);
    });

    testWidgets('shows a spinner and blocks input while submitting', (
      tester,
    ) async {
      useHandsetSurface(tester);
      await tester.pumpWidget(host(form(isSubmitting: true)));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(button(tester).onPressed, isNull);
    });

    testWidgets('the send label is actually visible', (tester) async {
      useHandsetSurface(tester);
      await tester.pumpWidget(host(form()));
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
      useHandsetSurface(tester);
      await tester.pumpWidget(
        host(form(errorMessage: 'Server refused the report')),
      );
      await tester.pumpAndSettle();

      expect(find.text('Server refused the report'), findsOneWidget);
    });

    testWidgets('a failed category load offers a retry, not a dead dropdown', (
      tester,
    ) async {
      useHandsetSurface(tester);
      var retries = 0;
      await tester.pumpWidget(
        host(
          form(
            options: const [],
            categoriesError: 'No internet connection',
            onRetryCategories: () => retries++,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // There is no valid category to send without that call, so the field
      // must not pretend to be answerable.
      expect(find.byType(DropdownButtonFormField<String>), findsNothing);
      expect(find.text('No internet connection'), findsOneWidget);

      await tester.tap(find.text('Retry'));
      await tester.pumpAndSettle();
      expect(retries, 1);
    });
  });

  group('IssueCard', () {
    IssueEntity issue(String wireStatus) => IssueEntity(
      id: '1',
      status: wireStatus,
      title: 'Appointment reminders not arriving',
      description: 'No push since Tuesday on two devices.',
      createdAt: DateTime(2026, 8, 22, 14, 3),
    );

    testWidgets('labels each status in English', (tester) async {
      useHandsetSurface(tester);
      for (final entry in {
        'OPEN': 'Open',
        'IN_PROGRESS': 'In progress',
        'RESOLVED': 'Resolved',
        'CLOSED': 'Closed',
      }.entries) {
        await tester.pumpWidget(host(IssueCard(issue: issue(entry.key))));
        await tester.pumpAndSettle();
        expect(find.text(entry.value), findsOneWidget);
      }
    });

    testWidgets('labels each status in Arabic', (tester) async {
      useHandsetSurface(tester);
      for (final entry in {
        'OPEN': 'مفتوحة',
        'IN_PROGRESS': 'قيد المعالجة',
        'RESOLVED': 'تم الحل',
        'CLOSED': 'مغلقة',
      }.entries) {
        await tester.pumpWidget(
          host(IssueCard(issue: issue(entry.key)), locale: const Locale('ar')),
        );
        await tester.pumpAndSettle();
        expect(find.text(entry.value), findsOneWidget);
      }
    });

    testWidgets('a status this build has never heard of still shows the '
        'report, labelled by the server', (tester) async {
      useHandsetSurface(tester);
      await tester.pumpWidget(
        host(IssueCard(issue: issue('ESCALATED'), statusLabel: 'Escalated')),
      );
      await tester.pumpAndSettle();

      expect(find.text('Appointment reminders not arriving'), findsOneWidget);
      expect(find.text('Escalated'), findsOneWidget);
    });

    testWidgets('shows title, description and date', (tester) async {
      useHandsetSurface(tester);
      await tester.pumpWidget(host(IssueCard(issue: issue('RESOLVED'))));
      await tester.pumpAndSettle();

      expect(find.text('Appointment reminders not arriving'), findsOneWidget);
      expect(
        find.text('No push since Tuesday on two devices.'),
        findsOneWidget,
      );
      expect(find.textContaining('Aug 22, 2026'), findsOneWidget);
    });

    testWidgets('omits the date line when the server sent none', (
      tester,
    ) async {
      useHandsetSurface(tester);
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
      useHandsetSurface(tester);
      await tester.pumpWidget(host(const IssuesEmptyState()));
      await tester.pumpAndSettle();

      expect(find.text('No reports yet'), findsOneWidget);
    });

    testWidgets('error state names the failure and offers retry', (
      tester,
    ) async {
      useHandsetSurface(tester);
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
    test('maps the documented values and never hides an unknown one', () {
      expect(IssueStatus.fromWire('OPEN'), IssueStatus.open);
      expect(IssueStatus.fromWire('open'), IssueStatus.open);
      expect(IssueStatus.fromWire('IN_PROGRESS'), IssueStatus.inProgress);
      expect(IssueStatus.fromWire('RESOLVED'), IssueStatus.resolved);
      expect(IssueStatus.fromWire('CLOSED'), IssueStatus.closed);
      // A status added server-side after this build shipped must still show
      // the report, in neutral grey, rather than drop it.
      expect(IssueStatus.fromWire('ESCALATED'), IssueStatus.unknown);
      expect(IssueStatus.fromWire(null), IssueStatus.unknown);
    });
  });
}
