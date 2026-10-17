import 'package:dental_clinic_app/features/clinic/data/own_clinic_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('POST /users/clinics sends the clinic and plan part of register',
      () {
    const params = OpenClinicParams(
      name: 'عيادة رنا',
      type: 'INDIVIDUAL',
      locationId: 'loc-1',
      detailedAddress: 'المزة، شارع الجلاء',
      planVersionId: 'ver-1',
    );

    expect(params.toJson(), {
      'clinic': {
        'name': 'عيادة رنا',
        'type': 'INDIVIDUAL',
        'location_id': 'loc-1',
        'detailed_address': 'المزة، شارع الجلاء',
      },
      // The plan's version, not the plan.
      'plan_version_id': 'ver-1',
    });
  });
}
