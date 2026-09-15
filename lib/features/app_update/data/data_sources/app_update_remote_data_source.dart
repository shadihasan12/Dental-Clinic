import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/app_update_info.dart';
import '../endpoints/app_update_endpoints.dart';
import '../models/app_update_model.dart';

abstract class AppUpdateRemoteDataSource {
  Future<AppUpdateInfo> checkForUpdate({
    required String platform,
    required String version,
    required String build,
  });
}

@Injectable(as: AppUpdateRemoteDataSource)
class AppUpdateRemoteDataSourceImpl implements AppUpdateRemoteDataSource {
  AppUpdateRemoteDataSourceImpl(this._apiConsumer);

  final ApiConsumer _apiConsumer;

  @override
  Future<AppUpdateInfo> checkForUpdate({
    required String platform,
    required String version,
    required String build,
  }) async {
    final response = await _apiConsumer.get(
      AppUpdateEndpoints.version,
      queryParameters: {
        'platform': platform,
        'version': version,
        'build': build,
      },
    );
    final data = response['data'];
    if (data is! Map<String, dynamic>) return const AppUpdateInfo.none();
    return AppUpdateModel.fromJson(data);
  }
}
