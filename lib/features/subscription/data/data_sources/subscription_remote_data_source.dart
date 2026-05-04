import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/features/subscription/data/endpoints/subscription_endpoints.dart';
import 'package:dental_clinic_app/features/subscription/data/models/subscription_plan_model.dart';
import 'package:dental_clinic_app/features/subscription/data/models/subscription_status_model.dart';
import 'package:dental_clinic_app/features/subscription/data/models/subscription_usage_model.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_plan_entity.dart';
import 'package:injectable/injectable.dart';

abstract class SubscriptionRemoteDataSource {
  Future<List<SubscriptionPlanModel>> getPlans();
  Future<SubscriptionStatusModel> getStatus();
  Future<SubscriptionUsageModel> getUsage();
}

@Injectable(as: SubscriptionRemoteDataSource)
class SubscriptionRemoteDataSourceImpl implements SubscriptionRemoteDataSource {
  final ApiConsumer _apiConsumer;

  SubscriptionRemoteDataSourceImpl(this._apiConsumer);

  @override
  Future<List<SubscriptionPlanModel>> getPlans() async {
    // TODO: Replace with real API call
    await Future.delayed(const Duration(milliseconds: 800));
    return SubscriptionPlans.allPlans
        .map((e) => SubscriptionPlanModel.fromEntity(e))
        .toList();
  }

  @override
  Future<SubscriptionStatusModel> getStatus() async {
    final response = await _apiConsumer.get(SubscriptionEndpoints.status);
    final data = response['data'] as Map<String, dynamic>;
    return SubscriptionStatusModel.fromJson(data);
  }

  @override
  Future<SubscriptionUsageModel> getUsage() async {
    final response = await _apiConsumer.get(SubscriptionEndpoints.usage);
    final data = response['data'] as Map<String, dynamic>;
    return SubscriptionUsageModel.fromJson(data);
  }
}
