import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/services/permissions/clinic_permissions_entity.dart';
import 'package:dental_clinic_app/services/permissions/clinic_permissions_model.dart';
import 'package:dental_clinic_app/services/subscription_guard/subscription_guard.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ClinicPermissionsService {
  final ApiConsumer _apiConsumer;
  final SubscriptionGuard _guard;

  ClinicPermissionsService(this._apiConsumer, this._guard);

  static const String _endpoint = '/features/clinic-permissions';

  /// The feature slugs the clinic has *after* its access mode was applied -
  /// a lapsed clinic's list shrinks on its own. `meta` carries the mode, and
  /// it goes straight into the [SubscriptionGuard].
  Future<Either<NetworkExceptions, ClinicPermissionsEntity>>
      getPermissions() async {
    try {
      final response = await _apiConsumer.get(_endpoint);
      final dataList = response['data'] as List;
      final model = ClinicPermissionsModel.fromList(dataList);

      final meta = response['meta'];
      if (meta is Map) {
        _guard.update(
          accessMode: meta['access_mode'] as String?,
          status: meta['subscription_status'] as String?,
        );
      }
      return Right(model.toEntity());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }
}
