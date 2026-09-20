import 'package:dental_clinic_app/features/patients/data/models/treatment_plan_models.dart';
import 'package:dental_clinic_app/features/patients/presentation/pages/plan_treatment_page.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

/// The category tabs at the top of the treatment planner.
///
/// Their labels are whatever the server calls its categories, the row is split
/// evenly between however many come back, and the user's text scale stretches
/// them further - so the label has to give way rather than overflow. This
/// caught a 36px overflow on "Tooth-Level Treatments" at the 1.2 scale the app
/// clamps to.
void main() {
  Widget host(List<TreatmentCategoryGroup> categories, double textScale) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, _) => MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('ar')],
        builder: (context, child) => MediaQuery.withClampedTextScaling(
          minScaleFactor: textScale,
          maxScaleFactor: textScale,
          child: child!,
        ),
        home: PlanTreatmentPage(categories: categories),
      ),
    );
  }

  // The names the backend actually returns.
  const categories = [
    TreatmentCategoryGroup(
      id: 'general',
      slug: 'general-treatments',
      name: 'General Treatments',
      treatments: [],
    ),
    TreatmentCategoryGroup(
      id: 'tooth',
      slug: 'tooth-level-treatments',
      name: 'Tooth‑Level Treatments',
      treatments: [],
    ),
  ];

  for (final scale in <double>[1.0, 1.2]) {
    testWidgets('category tabs fit at text scale $scale', (tester) async {
      tester.view.physicalSize = const Size(375 * 3, 812 * 3);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(host(categories, scale));
      await tester.pump();

      // A RenderFlex overflow is reported through FlutterError, which the
      // test binding collects rather than throwing - so assert on that
      // directly instead of trusting the test to have failed on its own.
      expect(
        tester.takeException(),
        isNull,
        reason: 'the tab row overflowed at text scale $scale',
      );
      expect(find.text('Tooth‑Level Treatments'), findsOneWidget);
    });
  }
}
