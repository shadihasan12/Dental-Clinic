import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/app_update_info.dart';
import '../endpoints/app_update_endpoints.dart';
import '../models/app_update_model.dart';

abstract class AppUpdateRemoteDataSource {
  Future<AppUpdateInfo> checkForUpdate({
    required String platform,
    required String version,
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
  }) async {
    // Only these two. The route validates `version` against
    // `^\d+(\.\d+){0,3}$` and answers 400 for anything else, so the build
    // number is folded into the version string by the caller or left off -
    // it is not a parameter of its own any more.
    final response = await _apiConsumer.get(
      AppUpdateEndpoints.versionCheck,
      queryParameters: {'platform': platform, 'version': version},
    );
    final data = response['data'];
    if (data is! Map<String, dynamic>) return const AppUpdateInfo.none();
    return AppUpdateModel.fromJson(data);
  }
}
