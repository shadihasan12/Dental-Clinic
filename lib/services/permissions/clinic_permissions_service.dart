import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/services/permissions/clinic_permissions_entity.dart';
import 'package:dental_clinic_app/services/permissions/clinic_permissions_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ClinicPermissionsService {
  final ApiConsumer _apiConsumer;

  ClinicPermissionsService(this._apiConsumer);

  static const String _endpoint = '/features/clinic-permissions';

  Future<Either<NetworkExceptions, ClinicPermissionsEntity>>
      getPermissions() async {
    try {
      final response = await _apiConsumer.get(_endpoint);
      final dataList = response['data'] as List;
      final model = ClinicPermissionsModel.fromList(dataList);
      return Right(model.toEntity());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }
}
