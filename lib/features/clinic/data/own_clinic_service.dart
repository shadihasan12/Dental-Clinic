import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/features/clinic/data/endpoints/clinic_endpoints.dart';
import 'package:injectable/injectable.dart';

/// The clinic part of a sign-up, for an account that is already signed in:
/// `POST /users/clinics`.
class OpenClinicParams {
  const OpenClinicParams({
    required this.name,
    required this.type,
    required this.locationId,
    required this.detailedAddress,
    required this.planVersionId,
  });

  final String name;

  /// `INDIVIDUAL` or `CENTER`.
  final String type;
  final String locationId;
  final String detailedAddress;

  /// The plan's `version_id`, not its `id`.
  final String planVersionId;

  /// The server's limits, checked on the device first: every call counts
  /// against five an hour, a refused one too.
  static const int maxNameLength = 255;
  static const int maxAddressLength = 1000;

  Map<String, dynamic> toJson() => {
        'clinic': {
          'name': name,
          'type': type,
          'location_id': locationId,
          'detailed_address': detailedAddress,
        },
        'plan_version_id': planVersionId,
      };
}

/// Opening a clinic of one's own once signed in, and knowing beforehand
/// whether it gets a free trial.
///
/// Neither call sends a clinic: the account may have none. The interceptor
/// adds the header only when one is selected, which on the "no clinic"
/// screen it is not.
@lazySingleton
class OwnClinicService {
  OwnClinicService(this._api, this._userStorage);

  final ApiConsumer _api;
  final UserStorage _userStorage;

  /// `trial_eligible`, read fresh from `GET /auth/profile`: it turns false
  /// for good once the account opens a clinic, so a value from an earlier
  /// login cannot be trusted on the form.
  Future<Either<NetworkExceptions, bool>> trialEligible() async {
    try {
      final response = await _api.get('/auth/profile');
      final data = response['data'];
      final eligible = data is Map && data['trial_eligible'] == true;
      await _userStorage.saveTrialEligible(eligible);
      return Right(eligible);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  /// Creates the clinic and returns its id. The user owns it, runs it and
  /// treats in it; its subscription starts on a trial or on billing only.
  Future<Either<NetworkExceptions, String>> openClinic(
    OpenClinicParams params,
  ) async {
    try {
      final response = await _api.post(
        ClinicEndpoints.myClinics,
        body: params.toJson(),
      );
      final data = response['data'];
      final clinic = data is Map ? data['clinic'] : null;
      final id = clinic is Map ? clinic['id']?.toString() : null;
      if (id == null || id.isEmpty) {
        return const Left(NetworkExceptions.unexpectedError());
      }
      // The account's half of the trial rule is spent now.
      await _userStorage.saveTrialEligible(false);
      return Right(id);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }
}
