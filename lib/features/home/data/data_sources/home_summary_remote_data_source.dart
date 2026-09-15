import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/home_summary.dart';
import '../endpoints/home_summary_endpoints.dart';
import '../models/home_summary_model.dart';

abstract class HomeSummaryRemoteDataSource {
  Future<HomeSummary> getHomeSummary({
    required String startDate,
    required String endDate,
  });
}

@Injectable(as: HomeSummaryRemoteDataSource)
class HomeSummaryRemoteDataSourceImpl implements HomeSummaryRemoteDataSource {
  HomeSummaryRemoteDataSourceImpl(this._apiConsumer);

  final ApiConsumer _apiConsumer;

  @override
  Future<HomeSummary> getHomeSummary({
    required String startDate,
    required String endDate,
  }) async {
    final response = await _apiConsumer.get(
      HomeSummaryEndpoints.summary,
      queryParameters: {'start_date': startDate, 'end_date': endDate},
    );
    final data = response['data'];
    if (data is! Map<String, dynamic>) return const HomeSummary.empty();
    return HomeSummaryModel.fromJson(data);
  }
}
