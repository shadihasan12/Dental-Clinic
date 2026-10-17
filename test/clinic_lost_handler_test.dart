import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/storage/token_storage.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/use_cases/get_my_clinics_use_case.dart';
import 'package:dental_clinic_app/services/clinic_access/clinic_access_guard.dart';
import 'package:dental_clinic_app/services/clinic_access/clinic_lost_handler.dart';
import 'package:dental_clinic_app/services/subscription_guard/subscription_guard.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FakeClinics extends Fake implements GetMyClinicsUseCase {
  List<ClinicMembershipEntity> clinics = const [];
  int calls = 0;

  @override
  Future<Either<NetworkExceptions, List<ClinicMembershipEntity>>> call() async {
    calls++;
    return Right(clinics);
  }
}

ClinicMembershipEntity _member(String clinicId) => ClinicMembershipEntity(
      id: 'm-$clinicId',
      userId: 'u',
      clinicId: clinicId,
      clinicName: 'Clinic $clinicId',
      role: ClinicRole.dentist,
      status: MembershipStatus.active,
    );

Future<void> _settle() => Future<void>.delayed(const Duration(milliseconds: 10));

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late TokenStorage tokens;
  late UserStorage users;
  late ClinicAccessGuard guard;
  late _FakeClinics clinics;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    tokens = TokenStorage(prefs);
    users = UserStorage(prefs);
    await tokens.saveToken('t');
    await tokens.saveClinicId('A');
    await users.saveClinicName('Al Noor');
    guard = ClinicAccessGuard();
    clinics = _FakeClinics();
    ClinicLostHandler(guard, tokens, users, SubscriptionGuard(), clinics)
        .start();
  });

  test('a refusal for the open clinic takes the user out of it', () async {
    guard.reportRefusal('A');
    await _settle();

    expect(tokens.getClinicId(), isNull);
    expect(users.getClinicName(), isNull);
    expect(guard.leavingOpenClinic, isTrue);
  });

  test('a refusal for another clinic leaves the open one alone', () async {
    clinics.clinics = [_member('A')];
    guard.reportRefusal('B');
    await _settle();

    expect(tokens.getClinicId(), 'A');
    expect(guard.leavingOpenClinic, isFalse);
    // Only the stored count is brought up to date.
    expect(users.getClinicCount(), 1);
  });

  test('an old notice about a clinic the user is back in is ignored',
      () async {
    clinics.clinics = [_member('A')];
    guard.reportNotice(clinicId: 'A', closed: false);
    await _settle();

    expect(tokens.getClinicId(), 'A');
    // And forgotten, so a real loss later still starts the flow.
    guard.reportRefusal('A');
    await _settle();
    expect(tokens.getClinicId(), isNull);
  });

  test('a notice for the open clinic, confirmed gone, takes the user out',
      () async {
    clinics.clinics = [_member('B')];
    guard.reportNotice(clinicId: 'A', closed: true, title: 't', body: 'b');
    await _settle();

    expect(tokens.getClinicId(), isNull);
  });
}
