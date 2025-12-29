// Basic Flutter widget test for Dental Clinic App

import 'package:flutter_test/flutter_test.dart';

import 'package:dental_clinic_app/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const DentalClinicApp());

    // Verify that app builds successfully
    expect(find.byType(DentalClinicApp), findsOneWidget);
  });
}
