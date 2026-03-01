import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/features/subscription/data/models/subscription_plan_model.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_plan_entity.dart';
import 'package:injectable/injectable.dart';

abstract class SubscriptionRemoteDataSource {
  Future<List<SubscriptionPlanModel>> getPlans();
}

@Injectable(as: SubscriptionRemoteDataSource)
class SubscriptionRemoteDataSourceImpl implements SubscriptionRemoteDataSource {
  // ignore: unused_field
  final ApiConsumer _apiConsumer;

  SubscriptionRemoteDataSourceImpl(this._apiConsumer);

  @override
  Future<List<SubscriptionPlanModel>> getPlans() async {
    // TODO: Replace with real API call
    // final response = await _apiConsumer.get(SubscriptionEndpoints.plans);
    // return (response as List)
    //     .map((e) => SubscriptionPlanModel.fromJson(e as Map<String, dynamic>))
    //     .toList();

    await Future.delayed(const Duration(milliseconds: 800));

    return SubscriptionPlans.allPlans
        .map((e) => SubscriptionPlanModel.fromEntity(e))
        .toList();
  }
}
